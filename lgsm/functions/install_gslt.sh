#!/bin/bash
# LGSM install_gslt.sh function
#
#
lgsm_version="210516"

# Description: Configures GSLT.

local modulename="Install"

echo ""
echo "Game Server Login Token"
echo "================================="
sleep 1
if [ "${gamename}" == "Counter Strike: Global Offensive" ]; then
	echo "GSLT is required to run a public ${gamename} server"
	fn_scriptlog "GSLT is required to run a public ${gamename} server"
else
	echo "GSLT is an optional feature for ${gamename} server"
	fn_scriptlog "GSLT is an optional feature for ${gamename} server"
fi

echo "Get more info and a token here:"
echo "https://gameservermanagers.com/gslt"
fn_scriptlog "Get more info and a token here:"
fn_scriptlog "https://gameservermanagers.com/gslt"
echo ""
if [ -z "${autoinstall}" ]; then
	echo "Enter token below (Can be blank)."
	echo -n "GSLT TOKEN: "
	read token
	sed -i -e "s/gslt=\"\"/gslt=\"${token}\"/g" "${rootdir}/${selfname}"
fi
sleep 1
echo "The GSLT can be changed by editing ${selfname}."
fn_scriptlog "The GSLT can be changed by editing ${selfname}."
echo ""