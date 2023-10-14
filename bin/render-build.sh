#!/usr/bin/env bash
# exit on error
set -o errexit

export RUBY_VERSION=3.2.2
export BUNDLE_GEMFILE=$RENDER_SRC_ROOT/Gemfile
set_ruby_env $(fetch_or_build "$RUBY_VERSION")
gem install bundler
bundle install
