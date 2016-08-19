#!/usr/bin/env bash
 
# Prefix `bundle` with `exec` so unicorn shuts down gracefully on SIGTERM (i.e. `docker stop`)
mkdir -p $RAILS_ROOT/tmp/pids
chmod -R 755 $RAILS_ROOT/tmp
exec bundle exec unicorn -c config/containers/unicorn.rb -E $RAILS_ENV;
exec 3>&1 4>&2
trap ‘exec 2>&4 1>&3’ 0 1 2 3
exec 1>rails.log 2>&1
