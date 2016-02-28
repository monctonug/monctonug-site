#!/bin/bash

git pull origin master

./sync.rb

git add .
git diff --cached --exit-code
if [[ $? != 0 ]]; then
    git commit -a -m "Sync."
    git push origin master
fi

bundle install
bundle exec middleman build
