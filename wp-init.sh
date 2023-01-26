#!/usr/bin/env bash

# Put this in the root of a WordPress site repository
echo Setting up new WordPress instance for repo khm-travel...

wp core download

# set up the config file
mv wp-config-sample.php wp-config.php
wp config set name value

echo Importing database...
wp db import db.sql

echo replacing hostnames
for str in ${POSSIBLE_HOSTNAMES[@]}; do
  echo replacing $str with $LOCALHOSTNAME
  echo
  wp search-replace "$str" "$LOCALHOSTNAME"
done

valet secure khm-travel

# create generic WP user
# wp user create admin development@khmtravel.com --role=administrator --user_pass='secret'