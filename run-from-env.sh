#!/bin/bash
set -e

LOG_PREFIX=">>> run-from-env.sh:"
echo "${LOG_PREFIX} Starting"

if [[ -z "${USER_SCRIPT// }" ]]; then
	echo "USER_SCRIPT environment variable not provided or is empty"
	exit 1
fi

TMP_BIN=$(mktemp)
echo "${USER_SCRIPT}" | base64 -d | gunzip > "${TMP_BIN}"
chmod +x "${TMP_BIN}"

echo "${LOG_PREFIX} Running: ${TMP_BIN} ..."
source "${TMP_BIN}"

echo "${LOG_PREFIX} Done"
