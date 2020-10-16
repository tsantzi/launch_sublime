#!/bin/bash


# Constants
readonly TITLE="subl.Subl"


# Returns the current desktop's index
function get_current_desktop() {
	current_desktop=$(wmctrl -d | grep "*" | cut -f1 -d " ")
	# echo "current_desktop = $current_desktop" >> /tmp/temp.log
}


# Returns the window ID of the current sublime instance (if any)
function get_current_instance() {
	current_instance=$({ wmctrl -lx | grep " $current_desktop $TITLE"; } | cut -f1 -d " ")
	# echo "current_instance = $current_instance" >> /tmp/temp.log
}


# Wrap filenames in double quotes.
# This is required in order to support spaces in filenames rather than opening them as separate files.
# We will also need to wrap the subl command and this file list into an 'eval'
file_list=$(printf '"%s" ' "$@")

# Get current desktop ID
get_current_desktop

# Get current instance ID
get_current_instance

# No open windows present in CURRENT desktop, start a new one (to avoid jumping to ANOTHER desktop)
if [ -z $current_instance ]
then

	# echo "starting new instance..." >> /tmp/temp.log

	# Start new sublime instance
	eval "subl -n"

	# Wait for window to appear
	# Also, timeout after a while to make sure we don't get stuck here on failure etc
	timeout=0
	while [ -z $current_instance ] && [ $timeout -lt 1000 ]
	do
		get_current_instance
		timeout=$((timeout+1))
	done

	# Window appeared OK
	if [ $timeout -lt 1000 ]
	then
		# Maximise it
		wmctrl -i -r $current_instance -b add,maximized_vert,maximized_horz
	fi

fi

# Select our window
wmctrl -i -a $current_instance

# Load up files
eval "subl -a $file_list"
