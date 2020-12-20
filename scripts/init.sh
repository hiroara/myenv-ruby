#!/bin/sh

set -e

if [ -n "$OVERRIDE_RUBY_VERSION" ]; then
  /usr/share/rvm/bin/rvm install $OVERRIDE_RUBY_VERSION
  /usr/share/rvm/bin/rvm alias create default $OVERRIDE_RUBY_VERSION
fi

exec /tmp/init.sh "$@"
