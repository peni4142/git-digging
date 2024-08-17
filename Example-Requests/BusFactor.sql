WITH folder_commits_by_author AS (SELECT folder_commits.folder, commit_author.name as author, count(*) as commits
FROM (SELECT authors.name, commits.id as commit_id
	FROM authors
	RIGHT JOIN commits ON commits.author = authors.id) commit_author
RIGHT JOIN
	(SELECT files_and_folders.folder as folder, files_commits.commit_id as commit_id
	FROM files_commits
	RIGHT JOIN
	    (SELECT filename, folders.folder as folder, files.id as file_id
		FROM files
		LEFT JOIN
			(SELECT folder
			FROM
				(SELECT substring (filename, '.*(?=\/[^\/]*)') as folder, count(*) as counted
				FROM files
				WHERE filename NOT LIKE '%.git%'
				AND filename NOT LIKE '%images%'
				AND filename NOT LIKE '%docs%'
				AND filename NOT LIKE '%assets%'
				GROUP BY folder)
			WHERE counted > 5) folders
		ON files.filename LIKE CONCAT(folders.folder, '%')
		WHERE folder NOT LIKE '.') files_and_folders ON files_and_folders.file_id = files_commits.file_id) folder_commits
ON folder_commits.commit_id = commit_author.commit_id
GROUP BY folder, author)

SELECT folder_commits_by_author.folder, substring(folder_commits_by_author.folder from '[^\/]+$') as folder_short, count(*) as bus_factor, ARRAY_AGG(author) as authots
FROM folder_commits_by_author
LEFT JOIN
	(SELECT folder, SUM(commits) as commits_on_folder
	FROM folder_commits_by_author
	GROUP BY folder) folder_commits ON folder_commits.folder = folder_commits_by_author.folder
WHERE commits/folder_commits.commits_on_folder > 0.1
OR commits > 5
GROUP BY folder_commits_by_author.folder
ORDER BY bus_factor