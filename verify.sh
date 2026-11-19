#!/bin/bash

verify-IP() {
    name=$1

    nslookup $name | grep "$expected_ip" > /dev/null

    if [ "$?" -eq "0" ]; then
        return 0
    else
        echo "Bogus IP for $name in $HOME/etc/hosts !"
        return 1
    fi
}

while read ip name
do
    case "$ip" in
        "" | \#* | *:*)
            ;;
        *)
            expected_ip=$ip
            verify-IP "$name"
            ;;
    esac
done < $HOME/etc/hosts

exit 0
