#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 add|delete username password"
    exit 1
fi

action=$1
username=$2
password=$3

case "$action" in
    add)
        # Append the username and password to /etc/ipsec.secrets
        echo "${username} : EAP \"${password}\"" | sudo tee -a /etc/ipsec.secrets
        ;;
    delete)
        # Delete the entry from /etc/ipsec.secrets
        sudo sed -i "/^${username} :/d" /etc/ipsec.secrets
        ;;
    *)
        echo "Invalid action: $action"
        echo "Usage: $0 add|delete username password"
        exit 1
        ;;
esac

sudo ipsec secrets

