#!/usr/bin/env bash
# exit on error
set -o errexit

export RUBY_VERSION=3.2.2
gem install bundler
gem update --system
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
