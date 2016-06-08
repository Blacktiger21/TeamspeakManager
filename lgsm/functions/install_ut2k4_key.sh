#!/bin/bash
# LGSM install_ut2k4_key.sh function
#
#
lgsm_version="210516"

local modulename="Install"

echo ""
echo "Enter ${gamename} CD Key"
echo "================================="
sleep 1
echo "To get your server listed on the Master Server list"
echo "you must get a free CD key. Get a key here:"
echo "https://forums.unrealtournament.com/utserver/cdkey.php?2004"
echo ""
if [ -z "${autoinstall}" ]; then
	echo "Once you have the key enter it below"
	echo -n "KEY: "
	read CODE
	echo ""\""CDKey"\""="\""${CODE}"\""" > "${systemdir}/cdkey"
	if [ -f "${systemdir}/cdkey" ]; then
		fn_scriptlog "UT2K4 Server CD Key created"
	fi	
else
	echo "You can add your key using the following command"
	echo "./${selfname} server-cd-key"
fi	
echo ""