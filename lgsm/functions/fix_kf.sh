#!/bin/bash
# LGSM fix_kf.sh function
#
#
lgsm_version="210516"

echo "Applying WebAdmin ROOst.css fix."
echo "http://forums.tripwireinteractive.com/showpost.php?p=585435&postcount=13"
sed -i 's/none}/none;/g' "${filesdir}/Web/ServerAdmin/ROOst.css"
sed -i 's/underline}/underline;/g' "${filesdir}/Web/ServerAdmin/ROOst.css"
sleep 1
echo "Applying WebAdmin CharSet fix."
echo "http://forums.tripwireinteractive.com/showpost.php?p=442340&postcount=1"
sed -i 's/CharSet="iso-8859-1"/CharSet="utf-8"/g' "${systemdir}/UWeb.int"
sleep 1
echo "applying server name fix."
sleep 1
echo "forcing server restart..."
sleep 1
command_start.sh
sleep 5
command_stop.sh
command_start.sh
sleep 5
command_stop.sh