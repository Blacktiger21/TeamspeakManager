#!/bin/bash
# LGSM check_config.sh function
#
#
lgsm_version="210516"

# Description: If server config missing warn user.

if [ ! -e "${servercfgfullpath}" ]; then
	if [ "${gamename}" != "Hurtworld" ]; then
		fn_print_warn_nl "Config file missing!"
		echo "${servercfgfullpath}"
		fn_scriptlog "Configuration file missing!"
		fn_scriptlog "${servercfgfullpath}"
		sleep 2
	fi
fi