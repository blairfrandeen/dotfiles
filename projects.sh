#!/bin/bash

# Git projects projects to install

GITBASE="git@github.com:blairfrandeen"
WORKSPACE="/home/blair/workspace"

function gitclone {
    ls -d ${WORKSPACE}/${1} &> /dev/null
   if [ $? -ne 0 ]; then
        echo "Cloning: ${GITBASE}/${1}..."
	git clone ${GITBASE}/${1} ${WORKSPACE}/${1}
    else
        echo "Already Cloned: ${1}"
    fi
}

gitclone titr
gitclone blog
gitclone momobox
gitclone 2022-AoC
gitclone 2021-AoC
gitclone racoonmoon
