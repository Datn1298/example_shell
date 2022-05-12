#!/bin/bash
echo "Reset iptables rules to default"
iptables --table filter -F
iptables --table filter -X
iptables --table nat -F
iptables --table nat -X
iptables --table mangle -F
iptables --table mangle -X
iptables --table raw -F
iptables --table raw -X
iptables --table security -F
iptables --table security -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
echo "Default rules set"