#!/usr/bin/env bash
################################################################
# copy this script to /etc/snmp/ and make it executable:       #
# chmod +x /etc/snmp/plex.sh                                   #
# ------------------------------------------------------------ #
# edit your snmpd.conf and include:                            #
# extend plex /etc/snmp/plex.sh                                #
#--------------------------------------------------------------#
# restart snmpd and activate the app for desired host          #
#--------------------------------------------------------------#
# please make sure you have the path/binaries below            #
################################################################
BIN_CURL='/usr/bin/curl'
BIN_TR='/usr/bin/tr'
ENV_FILE='/etc/snmp/plex.env'
HOST_PORT_PLEX='localhost:32400'
PROTO_PLEX='http' # or https
PLEX_TOKEN=''
################################################################
# Don't change anything unless you know what are you doing     #
################################################################

if [ ! -f "$ENV_FILE" ]; then
    echo "ERROR: $ENV_FILE not found"
    exit 1
fi

source "$ENV_FILE"

# plex availability

availability=$(curl -s -m 5 -X GET "$PROTO_PLEX://$HOST_PORT_PLEX/status/sessions?X-Plex-Token=$PLEX_TOKEN" | grep -c "MediaContainer")
