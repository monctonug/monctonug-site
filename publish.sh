#!/bin/bash

set -e
git pull origin master

./sync.rb

git add .

set +x
git diff --cached --exit-code
STATUS=$?
set -x

if [[ $STATUS != 0 ]]; then
    git commit -a -m "Sync."
    git push origin master
fi

bundle install
bundle exec middleman build
