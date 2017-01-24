#!/bin/bash

# this script is runned when the docker container is built
# it imports the base database structure and create the database for the tests

psql -U postgres whrsthat_production -w < /schema.sql

echo "*** DATABASE CREATED! ***"