#!/bin/bash
# To install obsidian settings, run this script specifying the
# full path of the notes directory as the first argument

# establish the base directory that I'm working out of
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Cleaning old .obsidian directory"
rm -rf ${1}/.obsidian
mkdir ${1}/.obsidian
mkdir ${1}/.obsidian/snippets

echo "Updating notes in $1"
ln -sf ${BASEDIR}/obsidian/obsidian.vimrc ${1}/.obsidian/obsidian.vimrc
ln -sf ${BASEDIR}/obsidian/app.json ${1}/.obsidian/app.json
ln -sf ${BASEDIR}/obsidian/appearance.json ${1}/.obsidian/appearance.json
ln -sf ${BASEDIR}/obsidian/hotkeys.json ${1}/.obsidian/hotkeys.json
ln -sf ${BASEDIR}/obsidian/obsidian.css ${1}/.obsidian/snippets/obsidian.css
ln -sf ${BASEDIR}/obsidian/community-plugins.json ${1}/.obsidian/community-plugins.json


