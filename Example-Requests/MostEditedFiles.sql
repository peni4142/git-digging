SELECT files.filename as fullfilename, substring(files.filename from '[^\/]*$') as filename, filecount.counted as commits
FROM files
INNER JOIN (
	SELECT files_commits.file_id, COUNT(*) as counted
	FROM files_commits
	INNER JOIN (
		SELECT commits.id AS commit_id
		FROM commits
		INNER JOIN (
			SELECT id, name
			FROM authors
			WHERE name NOT LIKE '%[bot]%'
		) no_bots ON commits.author = no_bots.id 
		WHERE commits.datetime < NOW ()
		AND commits.datetime > NOW() - INTERVAL '1 year'
	) relevant_commits on relevant_commits.commit_id = files_commits.commit_id
	GROUP BY files_commits.file_id
	ORDER BY counted DESC
) filecount ON filecount.file_id = files.id
WHERE files.filename NOT LIKE '%.adoc' AND files.filename NOT LIKE '%.md'
ORDER BY counted DESC
LIMIT 10