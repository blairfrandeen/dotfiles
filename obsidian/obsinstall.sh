#!/bin/bash
# To install obsidian settings, run this script specifying the
# full path of the notes directory as the first argument

# establish the base directory that I'm working out of
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Updating notes in $1"
touch "$1/hello.txt"
ln -sf ${BASEDIR}/obsidian.vimrc ${1}/.obsidian/obsidian.vimrc
ln -sf ${BASEDIR}/app.json ${1}/.obsidian/app.json
ln -sf ${BASEDIR}/appearance.json ${1}/.obsidian/appearance.json
ln -sf ${BASEDIR}/hotkeys.json ${1}/.obsidian/hotkeys.json
ln -sf ${BASEDIR}/obsidian.css ${1}/.obsidian/snippets/obsidian.css
ln -sf ${BASEDIR}/community-plugins.json ${1}/.obsidian/community-plugins.json


