#!/usr/local/bin/bash

#If we don't get the --confirm flag exit
if [ "$1" != "--confirm" ]
then
    echo "This script is for automation. Don't run it unless you know what you are doing"
    exit 1
fi

#get the branch name from branch.txt and add it to the BRANCH variable
BRANCH=$(cat branch.txt)

#if branch is main, echo MAIN
if [ "$BRANCH" == "main" ]
then
    GITCMD="git clone https://github.com/rogerb831/runpod-dreambooth-easy.git"
else
    GITCMD="git clone --branch $BRANCH https://github.com/rogerb831/runpod-dreambooth-easy.git"
fi

# Automatically escaping special characters in VARIABLE
ESCAPED_GITCMD=$(sed 's/[\/&]/\\&/g' <<< "$GITCMD")

sed -i '' "s/^git clone.*/$ESCAPED_GITCMD/" README.md