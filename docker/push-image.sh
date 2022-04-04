#!/usr/bin/env bash

usage() { echo "Usage: $0 -c <country>" 1>&2; exit 1; }

set -e

printf "\n\nPushing Project Docker Image...\n\n"

declare country=""

# Initialize parameters specified from command line
while getopts ":c:" arg; do
	case "${arg}" in
		c)
			country=${OPTARG}
			;;

		esac
done
shift $((OPTIND-1))

if [[ -z "$country" ]]; then

    echo "country is required"
    usage
    exit 1
fi

set +x

CWD=`pwd`

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -x

cd "${SCRIPT_DIR}"

set +x

source ../../../paga-infrastructure-azure/common/${country}/.env

source ../lib-common.sh

echo "Pushing PAGA_PARTNER_PORTAL \${PAGA_PARTNER_PORTAL_VERSION} Image to ACR..."

set -x

pushDockerImageToACR "${PAGA_PARTNER_PORTAL_ACR_REPOSITORY_NAME}" "${PAGA_PARTNER_PORTAL_VERSION}"

cd "${CWD}"
