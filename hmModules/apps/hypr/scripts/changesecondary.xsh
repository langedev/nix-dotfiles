#!/usr/bin/env xonsh
import shelve
import copy

# Usage:
# ./changesecondary.xsh
# cycles through the secondary workspaces

current_secondary = "chat"

with shelve.open($HYPR_WORK_DB) as db:
  workspaces = db.get("secondaries").copy()
  current_primary = db.get("primary")
  current_secondary = db.get("secondary")
  #extras = db.get("secondary_extras")

  if current_primary in workspaces:
    workspaces.remove(current_primary)

  current_secondary = workspaces[
      (workspaces.index(current_secondary)+1) % len(workspaces)
    ]
  db["secondary"] = current_secondary

# Change primary to bind
hyprctl dispatch moveworkspacetomonitor name:@(current_secondary) $HYPR_MON_SECONDARY
hyprctl dispatch workspace name:@(current_secondary)
