#!/bin/bash
cd "$(dirname "$0")"
cp Gemfile /app/
cd /app
bundle install
rails new --force --skip-bundle -d postgresql .