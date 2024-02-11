#!/usr/bin/env sh

org_directory="$HOME/workspace/org/roam/"

# Check if directory is provided
if [ -z "$org_directory" ]; then
	echo "No directory specified"
	exit 1
fi

# Iterate through .org files in the specified directory
files=$(ls "$org_directory"/*.org)

process_org_file() {
	# Iterate through .org files in the specified directory
	if [ -f "$1" ]; then
		org2blog "$1"
	fi
}

export -f process_org_file
readarray -t files < <(ls "$org_directory"/*.org)
parallel process_org_file ::: "${files[@]}"
