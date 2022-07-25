#!/bin/bash

OWNER=$1
REPO=$2

NORMAL="\033[0;0m"
SUCCESS="\033[1;32m"
ERROR="\033[1;31m"

# Check for right amount of arguments
if [ $# -ne 2 ]
then
	echo -e "${ERROR}ERROR:${NORMAL} You need to specify an owner and their repository!"
	echo "       Try \"ghclone [OWNER] [REPOSITORY]\"."
	exit 1
fi

# Try cloning
if git clone "git@github.com:${OWNER}/${REPO}.git"
then
	echo -e "${SUCCESS}SUCCESS:${NORMAL} Cloned repository to ./${REPO}."
	exit 0
else
	echo -e "${ERROR}ERROR:${NORMAL} Could not clone repository."
	exit 1
fi
