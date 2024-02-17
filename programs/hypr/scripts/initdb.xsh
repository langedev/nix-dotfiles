#!/usr/bin/env xonsh
import shelve

# Usage:
# ./initdb.xsh
# initialize a db for use hypr workspace scripts

with shelve.open($HYPR_WORK_DB) as db:
  db["primary"] = "home"
  db["secondary"] = "chat"
  db["secondaries"] = ["chat", "web", "med"]
  db["secondary_extras"] = 1
  db["primary_extras"] = 1
