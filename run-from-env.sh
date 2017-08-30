#!/bin/bash
set -e
set -o pipefail

LOG_PREFIX=">>> run-from-env.sh:"
echo "${LOG_PREFIX} Starting"

if [[ -z "${USER_SCRIPT_FORMAT// }" ]]; then
	echo "USER_SCRIPT_FORMAT environment variable not provided or is empty"
	exit 1
fi

if [[ -z "${USER_SCRIPT// }" ]]; then
	echo "USER_SCRIPT environment variable not provided or is empty"
	exit 1
fi

TMP_BIN=$(mktemp)

case "${USER_SCRIPT_FORMAT}" in
zip)
	# funzip should be installed with the unzip package
	echo "${LOG_PREFIX} Extracting ZIP archive ..."
	echo "${USER_SCRIPT}" | base64 -d | funzip > "${TMP_BIN}"
	;;
gzip)
	echo "${LOG_PREFIX} Extracting GZIP archive ..."
	echo "${USER_SCRIPT}" | base64 -d | gunzip > "${TMP_BIN}"
	;;
*)
	echo "${LOG_PREFIX} Unhandled USER_SCRIPT_FORMAT: ${USER_SCRIPT_FORMAT}"
	exit 1
	;;
esac

chmod +x "${TMP_BIN}"

echo "${LOG_PREFIX} Running: ${TMP_BIN} ..."
source "${TMP_BIN}"

echo "${LOG_PREFIX} Done"
