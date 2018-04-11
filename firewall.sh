#!/bin/bash

echo -n "Starting firewall: "
IPTABLES="/sbin/iptables" # path to iptables
$IPTABLES --flush

# the network interface you want to protect
# NOTE: This may not be eth0 on all nodes -- use ifconfig to
# find the WAN network interface and adjust this
# variable accordingly. Use the variable by putting a $ in
# front of it like so: $ETH . It can go in any command line
# and will be expanded by the shell.

# For example: iptables -t filter -i $ETH etc... 

ETH="eth0"


# all traffic on the loopback device (127.0.0.1 -- localhost) is OK.
# Don't touch this!
$IPTABLES -A INPUT -i lo -j ACCEPT
$IPTABLES -A OUTPUT -o lo -j ACCEPT

# Your changes go below this line:
# ---8<---------------------------

# Allow all inbound and outbound traffic; all protocols, states,
# addresses, interfaces, and ports (it's like no firewall at all!):
#$IPTABLES -t filter -A INPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT
#$IPTABLES -t filter -A OUTPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT



# Put NEW firewall rules here:
# (Each "instruction" may represent multiple iptables rules)


# Prem: Here are some rules to get you started. 
# Prevent SPOOFING of the SERVER
# --------------------
$IPTABLES -A INPUT -s server -j DROP

#Prem: Put your NAT/FORWARD rules here so your network doesn't break


# helpful divisions:
# EXISTING CONNECTIONS
# --------------------
# Rules here specifically allow inbound traffic and outbound traffic for ALL previously
# accepted connections.

# Internal Network Traffic is still allowed!
$IPTABLES -A INPUT -i $ETH -m state --state ESTABLISHED -j ACCEPT
$IPTABLES -A OUTPUT -o $ETH -m state --state ESTABLISHED -j ACCEPT

# start writing your rules here... 



# No changes below this line:
# ---8<---------------------------
echo "done."

