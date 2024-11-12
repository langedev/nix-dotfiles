#!/usr/bin/env python3
import shelve
import os
import sys
import subprocess

# Usage:
# ./changeprimary.xsh workspace
# changes to that workspace
# if workspace is "etc" then changes to etcN where N is a number

def changeprimary(workspace, pmonitor, smonitor, dbpath):
    current_primary = ""
    current_secondary = ""

    with shelve.open(dbpath) as db:
        current_primary = db.get("primary")
        current_secondary = db.get("secondary")
        
        old_primary = current_primary
        current_primary = workspace

        if current_primary == current_secondary:
            workspaces = db.get("secondaries").copy()
            if old_primary in workspaces:
                current_secondary = old_primary
            else:
                current_secondary = workspaces[
                    (workspaces.index(current_secondary)+1) % len(workspaces)
                ]

        db["primary"] = current_primary
        db["secondary"] = current_secondary

    subprocess.run([
        "hyprctl", "dispatch", "moveworkspacetomonitor",
        "name:" + current_secondary, smonitor
    ])
    subprocess.run([
        "hyprctl", "dispatch", "workspace",
        "name:" + current_secondary
    ])
    subprocess.run([
        "hyprctl", "dispatch", "moveworkspacetomonitor",
        "name:" + current_primary, pmonitor
    ])
    subprocess.run([
        "hyprctl", "dispatch", "workspace",
        "name:" + current_primary
    ])

if __name__ == "__main__":
    try:
        workspace=sys.argv[1]
        primary_monitor=os.environ["HYPR_MON_PRIMARY"]
        secondary_monitor=os.environ["HYPR_MON_SECONDARY"]
        db=os.environ["HYPR_WORK_DB"]
        changeprimary(workspace, primary_monitor, secondary_monitor, db)
    except KeyError:
        print("Please set HYPR_MON_PRIMARY and HYPR_WORK_DB")
        sys.exit(1)
