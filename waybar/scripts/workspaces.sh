#!/bin/bash
# Show workspaces with windows, PLUS the current one (even if empty)

active=$(hyprctl monitors -j | jq -r '.[0].activeWorkspace.id')

# Collect workspaces that have windows
workspaces=$(hyprctl workspaces -j | jq -r '.[] | select(.windows > 0) | .id')

# Add the active one, then deduplicate + sort
workspaces=$(echo -e "$workspaces\n$active" | sort -n | uniq)

for ws in $workspaces; do
  if [ "$ws" -eq "$active" ]; then
    echo -n " "   # filled circle for active
  else
    echo -n " "   # hollow circle for others
  fi
done

echo ""   # newline so Waybar prints it cleanly

