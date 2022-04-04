#!/usr/bin/env bash

usage() { echo "Usage: $0 -c <country>" 1>&2; exit 1; }

set -e

printf "\n\nMaking Project Docker Image...\n\n"

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
set -e

CWD=`pwd`

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

set -x

cd "${SCRIPT_DIR}"

set +x

source ../../../paga-infrastructure-azure/common/${country}/.env

source ../lib-common.sh

echo "Making PAGA_PARTNER_PORTAL \${PAGA_PARTNER_PORTAL_VERSION} Image..."

PAGA_PARTNER_PORTAL_JAR_BUILD_PATH=../../build/libs/paga-partner-portal.jar

if [[ ! -f "${PAGA_PARTNER_PORTAL_JAR_BUILD_PATH}" ]]; then
    echo "Error: Unable to find PAGA_PARTNER_PORTAL JAR File ${PAGA_PARTNER_PORTAL_JAR_BUILD_PATH}. Did you forget to build the project?"
    exit 1
fi

if [[ "$(docker images -q ${PAGA_PARTNER_PORTAL_ACR_REPOSITORY_NAME}:${PAGA_PARTNER_PORTAL_VERSION})" == "" ]]; then

    if [ -d target ] ; then
        rm -fr target
    fi

    set -x

    mkdir target

    cp "${PAGA_PARTNER_PORTAL_JAR_BUILD_PATH}" target/.

    cd "${SCRIPT_DIR}"

    docker build --build-arg CONTAINER_REGISTRY_DNS=${CONTAINER_REGISTRY_DNS} --tag ${PAGA_PARTNER_PORTAL_ACR_REPOSITORY_NAME}:${PAGA_PARTNER_PORTAL_VERSION} .

    cd "${CWD}"

else

    echo "Info: Image ${PAGA_PARTNER_PORTAL_ACR_REPOSITORY_NAME}:${PAGA_PARTNER_PORTAL_VERSION} already exists - will NOT re-build it."

fi
