#!/usr/bin/env python3
import shelve
import copy

# Usage:
# ./changesecondary.xsh
# cycles through the secondary workspaces

def cyclesecondary(monitor, dbpath):
    current_secondary = ""

    with shelve.open(dbpath) as db:
      workspaces = db.get("secondaries").copy()
      current_primary = db.get("primary")
      current_secondary = db.get("secondary")

      if current_primary in workspaces:
        workspaces.remove(current_primary)

      current_secondary = workspaces[
          (workspaces.index(current_secondary)+1) % len(workspaces)
        ]
      db["secondary"] = current_secondary

    # Change primary to bind
    hyprctl dispatch moveworkspacetomonitor name:@(current_secondary) $HYPR_MON_SECONDARY
    hyprctl dispatch workspace name:@(current_secondary)

if __name__ == "__main__":
    try:
        monitor=os.environ["HYPR_MON_SECONDARY"]
        db=os.environ["HYPR_WORK_DB"]
        cyclesecondary(monitor, db)
    except KeyError:
        print("Please set HYPR_MON_PRIMARY and HYPR_WORK_DB")
        sys.exit(1)
