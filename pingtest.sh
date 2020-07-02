#!/bin/bash
# Parker Swierzewski
# NSSA221 Scripting Assignment 01
# Ping Test

RED=`tput setaf 1`
BLUE=`tput setaf 4`
NC=`tput sgr0`

# Gets the default gateway from the ip route command and stores it in a variable.
gateway_address=$(ip route | grep default | awk '{print $3}')

clear
echo "*** The Ping Test is beginning now! ***"
echo ""

if [ "$gateway_address" == ''  ]
then
	echo "Connection to the default gateway ${RED}FAILED${NC}!"
	exit 1
else
	echo "The default gateway is ${RED}$gateway_address${NC}!"
fi

echo ""

# Checks connection to the default gateway.
ping -c 1 -t 2 $gateway_address > /dev/null
if [ "$?" -eq 0 ]
then
	echo "Connection to the default gateway ${BLUE}SUCCEDED${NC}!"
else
	echo "Connection to the default gateway ${RED}FAILED${NC}!"
	exit 1
fi

echo ""

# Checks the connection to a remote IP address.
ping -c 1 8.8.8.8 > /dev/null
if [ "$?" -eq 1 ]
then
	echo "Remote Connection ${RED}FAILED${NC}!"
	exit 1
else
	echo "Remote Connection ${BLUE}SUCCEDED${NC}!"
fi

echo ""

# Checks to see if the DNS resolution is working (In this case Google as well).
ping -c 1 google.com > /dev/null
if [ "$?" -eq 2 ]
then
	echo "DNS Connection ${RED}FAILED${NC}!"
	exit 1
else
	echo "DNS Connection ${BLUE}SUCCEDED${NC}!"
fi

echo ""
echo "*** Test Completed ***"
