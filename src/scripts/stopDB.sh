#!/bin/bash

DB_PATH=/usr/db
LOG="$DB_PATH"/db.log

echo 'Shutting down DB...' >> "$LOG"

proshut "$DB_PATH"/felixdb.db -by >> "$LOG"
