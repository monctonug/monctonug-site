#!/bin/bash

set -e
git pull origin master

./sync.rb

git add .

set +e
git diff --cached --exit-code
STATUS=$?
set -e

if [[ $STATUS != 0 ]]; then
    git commit -a -m "Sync."
    git push origin master
fi

bundle install
bundle exec middleman build
