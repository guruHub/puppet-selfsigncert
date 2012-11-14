#!/bin/bash
#
# Script to self sign certificate, inspired by http://www.codenes.com/blog/?p=300.
#
# This script will be stored on puppet nodes /usr/local/bin and will be restricted to root eyes/usage.
#

VALID_DAYS=$1
COUNTRY=$2
STATE=$3
CITY=$4
ORGANIZATION=$5
SECTION=$6
COMMONNAME=$7
EMAIL=$8
KEY_FILENAME=$9
PEM_FILENAME=${10}

# Generate certificate
openssl req -new -x509 -days ${VALID_DAYS} -nodes -out ${PEM_FILENAME} -keyout ${KEY_FILENAME} <<EOF
${COUNTRY}
${STATE}
${CITY}
${ORGANIZATION}
${SECTION}
${COMMONNAME}
${EMAIL}
.
.
EOF 2> /dev/null # else puppet will complain returned 1 instead of one of [0] 
