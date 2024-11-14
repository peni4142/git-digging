WITH files_commits_with_filename AS (
    SELECT no_bot_commits.commit_id, no_bot_commits.hash, files_commits.file_id, files_commits.filename, files_commits.counted_commits AS counted_commits
	FROM (
		SELECT commits.id AS commit_id, commits.hash
		FROM commits
		WHERE author NOT IN (SELECT id FROM authors WHERE authors.name LIKE '%[bot]%')
		AND commits.datetime < NOW ()
		AND commits.datetime > NOW() - INTERVAL '6 months'
	) no_bot_commits
	INNER JOIN
		(SELECT commit_id, files_with_commits_counter.file_id, filename, files_with_commits_counter.counted_commits
		FROM files_commits
		INNER JOIN (
			SELECT count(*) AS counted_commits, files.id AS file_id, filename
			FROM files_commits
			LEFT JOIN files ON files_commits.file_id = files.id
			GROUP BY files.id, filename
		) files_with_commits_counter ON files_commits.file_id = files_with_commits_counter.file_id
	WHERE filename NOT LIKE '%docs%'
	AND filename NOT LIKE '%.adoc'
	AND files_with_commits_counter.counted_commits > 5
	) files_commits
	ON files_commits.commit_id = no_bot_commits.commit_id
)

SELECT * FROM
(SELECT lefti.filename AS fullfilename_left, substring(lefti.filename from '[^\/]*$') as filename_left, lefti.counted_commits AS commits_left, count(*) AS common_commits, righti.counted_commits AS commits_right, substring(righti.filename from '[^\/]*$') as filename_right, righti.filename AS fullfilename_right, ARRAY_AGG(lefti.hash) AS commits
	FROM files_commits_with_filename AS lefti
LEFT JOIN files_commits_with_filename AS righti ON lefti.commit_id = righti.commit_id
WHERE lefti.file_id < righti.file_id
GROUP BY lefti.file_id, righti.file_id, lefti.filename, righti.filename, lefti.counted_commits, righti.counted_commits
ORDER BY common_commits DESC)
WHERE common_commits > 5
AND ((CAST (common_commits AS float))/ (CAST (commits_left AS FLOAT)) > 0.3
	OR (CAST (common_commits AS float))/ (CAST (commits_right AS FLOAT)) > 0.3)
