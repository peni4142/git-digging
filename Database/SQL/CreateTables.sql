CREATE TABLE
  files (id SERIAL PRIMARY KEY, filename VARCHAR(1023) NOT NULL);

CREATE TABLE
  authors (id SERIAL PRIMARY KEY, name VARCHAR(1023) NOT NULL);

CREATE TABLE
  commits (
    id SERIAL PRIMARY KEY,
    hash CHAR(40) NOT NULL,
    author Integer NOT NULL,
    datetime TIMESTAMP NOT NULL,
    CONSTRAINT fk_author FOREIGN KEY(author) REFERENCES authors(id)
  );

CREATE TABLE
  files_commits (
    file_id Integer,
    commit_id Integer,
    CONSTRAINT fk_file FOREIGN KEY(file_id) REFERENCES files(id),
    CONSTRAINT fk_commits FOREIGN KEY(commit_id) REFERENCES commits(id),
    PRIMARY KEY (file_id, commit_id)
  );
