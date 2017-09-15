#!/bin/bash

file="/var/alertlogic/etc/host_crt.pem"
ACTION=$1
HOST=$2
ALERTLOGIC_KEY=$3

case "$ACTION" in
'start')
    #Check for the host_crt file to indicate if AL Agent has been provisioned previously (i.e container stop and restarted)
    #If the file exist, start the agent directly, otherwise will attempt to provision
    if [ -f "$file" ]
    then
            echo "`date` - AL Agent provisioned - starting AL Agent now"
            /etc/init.d/al-agent start
    else
            if [ ! -z "$ALERTLOGIC_KEY" ] && [ ! -z "$HOST" ]
            then
                    echo "`date` - AL Agent not provisioned - will attempt to provision with the given key and set host destination"
                    /etc/init.d/al-agent provision --key $ALERTLOGIC_KEY --host $HOST
                    /etc/init.d/al-agent start
            elif [ ! -z "$ALERTLOGIC_KEY" ]
            then
                    echo "`date` - AL Agent not provisioned - will attempt to provision with the given key"
                    /etc/init.d/al-agent provision --key $ALERTLOGIC_KEY
                    /etc/init.d/al-agent start
            elif [ ! -z "$HOST" ]
            then
                    echo "`date` - AL Agent not provisioned - will attempt auto claim and set host destination"
                    /etc/init.d/al-agent provision --host $HOST
                    /etc/init.d/al-agent start
            else
                    echo "`date` - AL Agent not provisioned - will attempt auto claim"
                    /etc/init.d/al-agent start
            fi
    fi
;;

'provision')
    echo "`date` - Provision AL Agent with the given key and set host destination"
    /etc/init.d/al-agent provision --key $ALERTLOGIC_KEY --host $HOST

;;

'configure')
    echo "`date` - Configure AL Agent with the given key and set host destination"
    /etc/init.d/al-agent configure --key $ALERTLOGIC_KEY --host $HOST

;;

*)
    echo "`date` - Invalid input, use [start/provision/configure] [host ip] [REG_KEY] as parameters"
;;

esac

tail -f /dev/null & wait ${!}