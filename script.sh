#!/bin/bash

# This script use directly the database of passbolt you have configured.
# 
# Open a mysql connection
#  > mysql -uYOURUSER -p
#  > use YOURDB;
# First step identify your "master" group ID, is the group you want to have all passwords as owner
#  > select * from groups
# Get your group UID is a string like "66q6416-6xs6-4qs-bf2c-d0d5674h0ad3"
#
# Execute the fucking usefull request:
# Replace with your group needed ID
#  > select resources.name,resources.username,resources.description,resources.deleted,resources.created_by,profiles.first_name,profiles.last_name from permissions AS perm INNER JOIN resources ON (perm.aco_foreign_key = resources.id) INNER JOIN profiles ON (profiles.user_id=resources.created_by) WHERE type=15 AND aro_foreign_key!='66q6416-6xs6-4qs-bf2c-d0d5674h0ad3' AND (SELECT COUNT(*) from permissions WHERE type=15 AND aro_foreign_key='66q6416-6xs6-4qs-bf2c-d0d5674h0ad3' AND permissions.aco_foreign_key=perm.aco_foreign_key) = 0
#
# If return is good you script is ready to be execute. Copy your sql query at the bottom
#

EXPORT MYSQL_PWD="YOURPASSWORD"
MYSQL_USER="YOURUSER3"
MYSQL_DB="YOURDB"

# DISPLAY RESULT WITH MYSQL FORMAT TABLE
mysql -u ${MYSQL_USER} ${MYSQL_DB} -e "select resources.name,resources.username,resources.description,resources.deleted,resources.created_by,profiles.first_name,profiles.last_name from permissions AS perm INNER JOIN resources ON (perm.aco_foreign_key = resources.id) INNER JOIN profiles ON (profiles.user_id=resources.created_by) WHERE type=15 AND aro_foreign_key!='66q6416-6xs6-4qs-bf2c-d0d5674h0ad3' AND (SELECT COUNT(*) from permissions WHERE type=15 AND aro_foreign_key='66q6416-6xs6-4qs-bf2c-d0d5674h0ad3' AND permissions.aco_foreign_key=perm.aco_foreign_key) = 0"

# EXPORT .CSV to current directory
mysql -u ${MYSQL_USER} ${MYSQL_DB} -e "select resources.name,resources.username,resources.description,resources.deleted,resources.created_by,profiles.first_name,profiles.last_name from permissions AS perm INNER JOIN resources ON (perm.aco_foreign_key = resources.id) INNER JOIN profiles ON (profiles.user_id=resources.created_by) WHERE type=15 AND aro_foreign_key!='66q6416-6xs6-4qs-bf2c-d0d5674h0ad3' AND (SELECT COUNT(*) from permissions WHERE type=15 AND aro_foreign_key='66q6416-6xs6-4qs-bf2c-d0d5674h0ad3' AND permissions.aco_foreign_key=perm.aco_foreign_key) = 0" -B | tr '\t' ',' > output.csv
