#!/bin/bash
# LGSM monitor_gsquery.sh function
#
#
lgsm_version="210516"

# Description: uses gsquery.py to query the server port.
# Detects if the server has frozen with the proccess still running.

local modulename="Monitor"

# Forces legecy servers to use gsquery
if [ -z "${gsquery}" ]; then
	gsquery="yes"
fi	 

if [ "${gsquery}" == "yes" ]; then

	# Downloads gsquery.py if missing
	if [ ! -f "${functionsdir}/gsquery.py" ]; then
		fn_fetch_file_github "lgsm/functions" "gsquery.py" "${functionsdir}" "executecmd" "norun" "noforce" "nomd5"
	fi	

	info_config.sh

	if [ "${engine}" == "unreal" ]||[ "${engine}" == "unreal2" ]; then
		port=$((port + 1))
	elif [ "${engine}" == "spark" ]; then
		port=$((port + 1))
	fi

	if [ -n "${queryport}" ]; then
		port="${queryport}"
	fi

	fn_print_info "Querying port: gsquery.py enabled"
	fn_scriptlog "Querying port: gsquery.py enabled"
	sleep 1

	# Will query up to 4 times every 15 seconds.
	# Servers changing map can return a failure.
	# Will Wait up to 60 seconds to confirm server is down giving server time to change map.
	totalseconds=0
	for queryattempt in {1..5}; do
		fn_print_dots "Querying port: ${ip}:${port} : ${totalseconds}/${queryattempt} : "
		fn_print_querying_eol
		fn_scriptlog "Querying port: ${ip}:${port} : ${queryattempt} : QUERYING"
		
		gsquerycmd=$("${functionsdir}"/gsquery.py -a "${ip}" -p "${port}" -e "${engine}" 2>&1)
		exitcode=$?

		sleep 1
		if [ "${exitcode}" == "0" ]; then
			# Server OK
			fn_print_ok "Querying port: ${ip}:${port} : ${queryattempt} : "
			fn_print_ok_eol_nl
			fn_scriptlog "Querying port: ${ip}:${port} : ${queryattempt} : OK"
			sleep 1
			exit
		else
			# Server failed query
			fn_scriptlog "Querying port: ${ip}:${port} : ${queryattempt} : ${gsquerycmd}"

			if [ "${queryattempt}" == "5" ]; then
				# Server failed query 4 times confirmed failure
				fn_print_fail "Querying port: ${ip}:${port} : ${totalseconds}/${queryattempt} : "
				fn_print_fail_eol_nl
				fn_scriptlog "Querying port: ${ip}:${port} : ${queryattempt} : FAIL"
				sleep 1

				# Send alert if enabled
				alert="restartquery"
				alert.sh
				fn_restart
				break
			fi

			# Seconds counter
			for seconds in {1..15}; do
				fn_print_fail "Querying port: ${ip}:${port} : ${totalseconds}/${queryattempt} : \e[0;31m${gsquerycmd}\e[0m"
				totalseconds=$((totalseconds + 1))
				sleep 1
				if [ "${seconds}" == "15" ]; then
					break
				fi
			done
		fi
	done
fi