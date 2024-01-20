#!/usr/bin/env xonsh
import shelve

# Usage:
# ./changeprimary.xsh workspace
# changes to that workspace
# if workspace is "etc" then changes to etcN where N is a number

workspace=$ARG1
monitor=$HYPR_MON_PRIMARY

current_workspace = "home"

with shelve.open($HYPR_WORK_DB) as db:
  current_workspace = db.get("primary")
  if workspace == "etc":
    if current_workspace.startswith("etc"):
      current = current_workspace[3:] % db.get("primary_extras")
      current_workspace = "etc" + str(current)
    else:
      current_workspace = "etc0"
  else:
    current_workspace = workspace
  db["primary"] = current_workspace

hyprctl dispatch moveworkspacetomonitor name:@(current_workspace) $HYPR_MON_PRIMARY >> /dev/null
hyprctl dispatch workspace name:@(current_workspace) >> /dev/null
