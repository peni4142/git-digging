#!/bin/bash

POSTGRES_PASSWORD=ASkj2410dkAL
IFS=';' read -ra authors <<< "$(git log --format='format:%an' | sort | uniq | tr '\n' ';')"

for i in "${authors[*]}"; do
	printf "${i}\n"
done

echo ${authos}

#psql -h "localhost" -p 5440 -v ON_ERROR_STOP=1 --username "user" --dbname "git_reflection" -c 
