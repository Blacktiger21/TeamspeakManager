#!/bin/bash
# LGSM check_ip.sh function
#
#
lgsm_version="210516"

# Description: Automatically identifies the server interface IP.
# If multiple interfaces are detected the user will need to manualy set using ip="0.0.0.0".

if [ "${gamename}" != "Teamspeak 3" ]; then
	if [ ! -f "/bin/ip" ]; then
		ipcommand="/sbin/ip"
	else
		ipcommand="ip"
	fi
	getip=$(${ipcommand} -o -4 addr|awk '{print $4}'|grep -oe '\([0-9]\{1,3\}\.\?\)\{4\}'|grep -v 127.0.0)
	getipwc=$(${ipcommand} -o -4 addr|awk '{print $4}'|grep -oe '\([0-9]\{1,3\}\.\?\)\{4\}'|grep -vc 127.0.0)

	if [ "${ip}" == "0.0.0.0" ]||[ "${ip}" == "" ]; then
		if [ "${getipwc}" -ge "2" ]; then
			fn_print_warn "Multiple active network interfaces found.\n\n"
			echo -en "Manually specify the IP you want to use within the ${selfname} script.\n"
			echo -en "Set ip=\"0.0.0.0\" to one of the following:\n"
			echo -en "${getip}\n"
			echo -en ""
			echo -en "https://gameservermanagers.com/network-interfaces\n"
			echo -en ""
			exit 1
		else
			ip=${getip}
		fi
	fi
fi
