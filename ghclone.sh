#!/bin/bash

OWNER=$1
REPO=$2

NORMAL="\033[0;0m"
SUCCESS="\033[0;32m"
ERROR="\033[0;31m"

if [ $# != 2 ]
then
	echo -e "${ERROR}ERROR${NORMAL}: You need to specify a repository & repository owner."
	echo -e "${ERROR}ERROR${NORMAL}: Try 'ghclone {owner} {repo}'"
fi

git clone git@github.com:$OWNER/$REPO.git
