INSERT INTO
  authors (name)
VALUES
  ('Paul Scherer'),
  ('Peer Nissen'),
  ('Frank Ullman'),
  ('Oliver Geercke'),
  ('Florian');

INSERT INTO
  commits (hash, author, datetime)
VALUES
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
    1,
    NOW() - INTERVAL '30 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB',
    2,
    NOW() - INTERVAL '60 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABB',
    2,
    NOW() - INTERVAL '90 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBB',
    1,
    NOW() - INTERVAL '120 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBB',
    3,
    NOW() - INTERVAL '150 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBB',
    2,
    NOW() - INTERVAL '180 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBB',
    1,
    NOW() - INTERVAL '210 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBB',
    2,
    NOW() - INTERVAL '240 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBB',
    4,
    NOW() - INTERVAL '270 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBB',
    5,
    NOW() - INTERVAL '300 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBB',
    2,
    NOW() - INTERVAL '330 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBB',
    3,
    NOW() - INTERVAL '360 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBB',
    3,
    NOW() - INTERVAL '390 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBB',
    2,
    NOW() - INTERVAL '420 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBB',
    2,
    NOW() - INTERVAL '450 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBB',
    1,
    NOW() - INTERVAL '480 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB',
    1,
    NOW() - INTERVAL '510 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBB',
    4,
    NOW() - INTERVAL '540 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBB',
    1,
    NOW() - INTERVAL '570 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBB',
    3,
    NOW() - INTERVAL '600 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBB',
    3,
    NOW() - INTERVAL '630 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBB',
    1,
    NOW() - INTERVAL '660 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBB',
    2,
    NOW() - INTERVAL '690 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBB',
    2,
    NOW() - INTERVAL '720 seconds'
  ),
  (
    'AAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBBBBBBBB',
    1,
    NOW() - INTERVAL '750 seconds'
  );

INSERT INTO
  files(filename)
VALUES
  ('./hidden/files/code_snippet_1.cs'),
  ('./hidden/files/code_snippet_2.cs'),
  ('./hidden/files/code_snippet_3.cs'),
  ('./hidden/files/ReadMe.md'),
  ('./hidden/files/ci/jobs/all_in_one'),
  ('./files/geheim'),
  ('./files/secrets'),
  ('./files/psst...'),
  ('./files/passwörter.txt');

INSERT INTO
  files_commits
VALUES
  (9, 1),
  (8, 2),
  (5, 3),
  (4, 4),
  (3, 5),
  (2, 6),
  (1, 7),
  (1, 8),
  (1, 9),
  (1, 10),
  (3, 11),
  (3, 12),
  (4, 13),
  (5, 14),
  (1, 15),
  (7, 16),
  (6, 17),
  (3, 18),
  (2, 19),
  (2, 20),
  (1, 21),
  (2, 22),
  (3, 23),
  (4, 24),
  (3, 1),
  (6, 2),
  (2, 3),
  (1, 4),
  (4, 8),
  (5, 9),
  (6, 10),
  (1, 11),
  (1, 12),
  (3, 13),
  (9, 24);
