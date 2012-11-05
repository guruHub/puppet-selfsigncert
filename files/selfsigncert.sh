#!/bin/bash
#
# Script to self sign certificate, inspired by http://www.codenes.com/blog/?p=300.
#
# This script will be stored on puppet nodes /usr/local/bin and will be restricted to root eyes/usage.
#

VALID_DAYS=$1
COUNTRY=$2
STATE="MY STATE"
CITY="MY CITY"
ORGANIZATION="MY ORGANIZATION"
SECTION="MY SECTION"
COMMONNAME="my.com"
EMAIL="guzman@guruhub.com.uy"
WORKPATH="/home/beep/openssltest"

# Generate certificate
openssl req -new -x509 -days ${VALID_DAYS} -nodes -out ${WORKPATH}/cert.pem -keyout ${WORKPATH}/cert.key <<EOF
${COUNTRY}
${STATE}
${CITY}
${ORGANIZATION}
${SECTION}
${COMMONNAME}
${EMAIL}
.
.
EOF
