#!/bin/bash

set -e

bundle install

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

bundle exec middleman build --verbose
