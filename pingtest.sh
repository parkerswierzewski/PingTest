#!/bin/bash
# 
# Ping Test v2.0
#
# author: Parker Swierzewski
# language: Bash Script
# desc: This script will determine the cause of connection issues. 
# 

RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
NC=`tput sgr0`

# Obtains the default gateway
gateway=$(ip route | grep default | awk '{print $3}')

clear
echo "*** The Ping Test is beginning now! ***"
echo ""

if [ "$gateway" == ''  ]
then
	echo "Connection to the default gateway ${RED}FAILED${NC}!"
	echo "You do not have a default gateway (router) configured!"
	exit 1
else
	echo "The default gateway is ${BLUE}$gateway${NC}!"
fi

echo ""

# Verifies connection to the default gateway.
ping -c 1 -t 2 $gateway > /dev/null
if [ "$?" -eq 0 ]
then
	echo "Connection to the default gateway ${GREEN}SUCCEEDED${NC}!"
else
	echo "Connection to the default gateway ${RED}FAILED${NC}!"
	echo "The default gateway (router) isn't correct!"
	echo "Make sure it's configured properly."
	exit 1
fi

echo ""

# Verifies remote connection is working properly.
ping -c 1 8.8.8.8 > /dev/null
if [ "$?" -eq 1 ]
then
	echo "Remote Connection ${RED}FAILED${NC}!"
	exit 1
else
	echo "Remote Connection ${GREEN}SUCCEEDED${NC}!"
fi

echo ""

# Verifies DNS resolution is working properly.
ping -c 1 google.com > /dev/null
if [ "$?" -eq 2 ]
then
	echo "DNS Connection ${RED}FAILED${NC}!"
	echo "It's always DNS :)"
	exit 1
else
	echo "DNS Connection ${GREEN}SUCCEEDED${NC}!"
fi

echo ""
echo "${GREEN}Everything should be working properly${NC}!"
echo""
echo "*** Test Completed ***"
