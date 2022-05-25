#!/bin/bash
# Default Policies
iptables --table filter -P INPUT DROP
iptables --table filter -P FORWARD DROP
iptables --table filter -P OUTPUT ACCEPT
	
# Name Chains
iptables --table filter -N user-input
iptables --table filter -N user-limit
iptables --table filter -N user-limit-accept
iptables --table filter -N user-output

# Add rules to chains

# Chain user-input
iptables --table filter -A user-input -p tcp -m tcp --dport 6881 -j DROP
iptables --table filter -A user-input -p udp -m udp --dport 6881 -j DROP
iptables --table filter -A user-input -p udp -m udp --dport 4444 -j DROP
iptables --table filter -A user-input -p tcp -m multiport --dports 2234:2239 -j DROP
iptables --table filter -A user-input -p tcp -m tcp --dport 2242 -j DROP
iptables --table filter -A user-input -p tcp -m tcp --dport 2240 -j DROP
iptables --table filter -A user-input -p tcp -m multiport --dports 6881:6891 -j DROP
iptables --table filter -A user-input -p udp -m multiport --dports 6881:6891 -j DROP
iptables --table filter -A user-input -p tcp -m tcp --dport 4662 -j DROP
iptables --table filter -A user-input -p udp -m udp --dport 4672 -j DROP

# FTP 
iptables --table filter -A user-input -p tcp -m tcp --dport 20 -j DROP
iptables --table filter -A user-input -p tcp -m tcp --dport 21 -j DROP

# SSH
iptables --table filter -A user-input -p tcp -m tcp --dport 22 -j DROP

# TELNET
iptables --table filter -A user-input -p tcp -m tcp --dport 23 -j DROP

# SMTP
iptables --table filter -A user-input -p tcp -m tcp --dport 25 -j DROP

# VNC
iptables --table filter -A user-input -p tcp -m tcp --dport 5900 -j DROP
iptables --table filter -A user-input -p udp -m udp --dport 5900 -j DROP

# APP Discovery and Access Protocol
iptables --table filter -A user-input -p tcp -m tcp --dport 6350 -j DROP
iptables --table filter -A user-input -p udp -m udp --dport 6350 -j DROP

# Apache Webserver
iptables --table filter -A user-input -p tcp -m tcp --dport 80 -j ACCEPT
iptables --table filter -A user-input -p udp -m udp --dport 80 -j ACCEPT
iptables --table filter -A user-input -p tcp -m tcp --dport 443 -j ACCEPT
iptables --table filter -A user-input -p udp -m udp --dport 443 -j ACCEPT


# Chain user-limit
iptables --table filter -A user-limit -m limit --limit 3/min -j LOG --log-prefix "[LIMIT BLOCK] "
iptables --table filter -A user-limit -j REJECT --reject-with icmp-port-unreachable
iptables --table filter -A user-limit-accept -j ACCEPT

	# Chain user-output
# Torrent programs
iptables --table filter -A user-output -p tcp -m tcp --dport 6881 -j DROP
iptables --table filter -A user-output -p udp -m udp --dport 6881 -j DROP
iptables --table filter -A user-output -p udp -m udp --dport 4444 -j DROP
iptables --table filter -A user-output -p tcp -m tcp --dport 4662 -j DROP
iptables --table filter -A user-output -p udp -m udp --dport 4672 -j DROP
iptables --table filter -A user-output -p tcp -m multiport --dports 6881:6891 -j DROP
iptables --table filter -A user-output -p udp -m multiport --dports 6881:6891 -j DROP

iptables --table filter -A user-output -p tcp -m tcp --dport 443 -j ACCEPT