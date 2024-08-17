import pg from "pg";
import format from "pg-format";
import { execSync } from "child_process";

const { Client } = pg;

const pgOptions = {
  user: "user",
  password: "ASkj2410dkAL",
  host: "localhost",
  port: 5440,
  database: "git_reflection",
};

// the key used in git commands and link the authors to their commits in the database commands.
const authorKey = "%an";

async function truncateAll() {
  console.log("delete actual entries");
  const client = new Client(pgOptions);
  await client.connect();
  await client.query("TRUNCATE files_commits CASCADE", []);
  await client.query("TRUNCATE commits CASCADE", []);
  await client.query("TRUNCATE files CASCADE", []);
  await client.query("TRUNCATE authors CASCADE", []);
  await client.end();
  console.log("actual entries are deleted");
}

async function transferAuthorsToDatabase() {
  console.log("transfer authors to database");
  const output = execSync(`git log --format=format:${authorKey}`, {
    encoding: "utf-8",
  });
  const names = [...new Set(output.split("\n"))];
  const pgValues = names.map((name) => [name]);

  const client = new Client(pgOptions);
  await client.connect();
  await client.query(
    format("INSERT INTO authors (name) VALUES %L;", pgValues),
    []
  );
  await client.end();
  console.log(`${pgValues.length} authors are transfered to database`);
}

async function transferFilesToDatabase() {
  console.log("transfer files to database");

  const client = new Client(pgOptions);
  const output = execSync("find . -type f", { encoding: "utf-8" });
  const filenames = [...new Set(output.split("\n"))].filter(
    (f) => !/^\s*$/.test(f)
  );

  const pgValues = filenames.map((filename) => [filename]);

  await client.connect();
  await client.query(
    format("INSERT INTO files (filename) VALUES %L;", pgValues),
    []
  );
  await client.end();

  console.log(`${pgValues.length} files transfered to database`);
}

async function transferCommits() {
  console.log("transfer commits to database");
  const output = execSync(`git log --format='format:%H;${authorKey};%aI'`, {
    encoding: "utf-8",
  });

  const entries = output.split("\n");

  const authorsByName = {};
  const client = new Client(pgOptions);
  await client.connect();
  const res = await client.query("SELECT id, name FROM authors", []);
  res.rows.forEach((e) => (authorsByName[e.name] = e.id));

  const pgValues = entries.map((entry) => {
    const split = entry.split(";");
    return [split[0], authorsByName[split[1]], split[2]];
  });
  await client.query(
    format("INSERT INTO commits (hash, author, datetime) VALUES %L;", pgValues),
    []
  );
  await client.end();
  console.log(`${pgValues.length} commits transfered to database`);
}

async function combineFilesWithCommits() {
  console.log("link files, respecting their history, to their commits");
  const commitsByHash = {};
  const client = new Client(pgOptions);
  await client.connect();
  const resCommits = await client.query("SELECT id, hash FROM commits", []);
  resCommits.rows.forEach((e) => (commitsByHash[e.hash] = e.id));

  const resFiles = (await client.query("SELECT id, filename FROM files", []))
    .rows;

  for (let i = 0, l = resFiles.length; i < l; i++) {
    let e = resFiles[i];
    let output = execSync(
      `git log --follow --format='format:%H' -- '${e.filename}'`,
      {
        encoding: "utf-8",
      }
    );
    let pgValues = output
      .split("\n")
      .map((hashes) => [e.id, commitsByHash[hashes]]);

    let hasValues = pgValues.every((values) =>
      values.every((v) => v !== null && v !== undefined)
    );

    if (hasValues) {
      await client.query(
        format(
          "INSERT INTO files_commits (file_id, commit_id) VALUES %L;",
          pgValues
        ),
        []
      );
    }
    if ((i + 1) % 50 == 0) {
      console.log(`${i + 1}/${l + 1} files linked to their commits`);
    }
  }
  await client.end();
  console.log(`${resFiles.length} linked files to their commits`);
}

async function call() {
  await truncateAll();
  await transferAuthorsToDatabase();
  await transferFilesToDatabase();
  await transferCommits();
  await combineFilesWithCommits();
}
call();
