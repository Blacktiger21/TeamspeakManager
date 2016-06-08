#!/bin/bash
# LGSM dev_debug.sh function
#
#
lgsm_version="210516"

# Description: Dev only: enables debuging log to be saved to dev-debug.log.

function_selfname="$(basename $(readlink -f "${BASH_SOURCE[0]}"))"

if [ -f ".dev-debug" ]; then
	rm .dev-debug
	fn_print_ok_nl "Disabled dev-debug"
else
	date > .dev-debug
	fn_print_ok_nl "Enabled dev-debug"
fi