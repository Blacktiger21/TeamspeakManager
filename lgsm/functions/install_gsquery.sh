#!/bin/bash
# LGSM install_gsquery.sh function
#
#
lgsm_version="210516"

fn_dlgsquery(){
	cd "${functionsdir}"
	echo -e "downloading gsquery.py...\c"
	wget -N /dev/null "https://gameservermanagers.com/dl/gsquery.py" 2>&1 | grep -F "HTTP" | grep -v "Moved Permanently" | cut -c45- | uniq
	chmod +x gsquery.py
}

if [ "${engine}" == "avalanche" ]||[ "${engine}" == "goldsource" ]||[ "${engine}" == "idtech3" ]||[ "${engine}" == "realvirtuality" ]||[ "${engine}" == "source" ]||[ "${engine}" == "spark" ]||[ "${engine}" == "unity3d" ]||[ "${gamename}" == "Hurtworld" ]||[ "${engine}" == "unreal" ]||[ "${engine}" == "unreal2" ]; then
	echo ""
	echo "GameServerQuery"
	echo "================================="
	if [ -z ${autoinstall} ]; then
		while true; do
			read -e -i "y" -p "Do you want to install GameServerQuery? [Y/n]" yn
			case $yn in
			[Yy]* ) fn_dlgsquery;break;;
			[Nn]* ) echo ""; echo "Not installing GameServerQuery.";break;;
			* ) echo "Please answer yes or no.";;
		esac
		done
	else
		fn_dlgsquery
	fi
fi
