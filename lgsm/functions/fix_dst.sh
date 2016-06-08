#!/bin/bash
# LGSM fix_dst.sh function
#
#
lgsm_version="210516"

# Description: Resolves various issues with Dont Starve together.

# Fixes: ./dontstarve_dedicated_server_nullrenderer: ./lib32/libcurl-gnutls.so.4: no version information available (required by ./dontstarve_dedicated_server_nullrenderer)
# Issue only occures on CentOS as libcurl-gnutls.so.4 is called libcurl.so.4 on CentOS.
if [ -f "/etc/redhat-release" ] && [ ! -f "${filesdir}/bin/lib32/libcurl-gnutls.so.4" ]; then
	fixname="libcurl-gnutls.so.4 missing"
	fn_fix_msg_start
	ln -s "/usr/lib/libcurl.so.4" "${filesdir}/bin/lib32/libcurl-gnutls.so.4"
	fn_fix_msg_end
fi