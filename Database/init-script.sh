#!/bin/sh

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /SQL/CreateDatabase.sql
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "git_reflection" -f /SQL/CreateTables.sql
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "git_reflection" -f /SQL/CreateSampleData.sql
