#!/bin/bash
echo "#################################"
echo "Table Filter Rules "
iptables --table filter -S
echo "#################################"
echo "Table nat Rules "
iptables --table nat -S
echo "#################################"
echo "Table mangle Rules "
iptables --table mangle -S
echo "#################################"
echo "Table raw Rules "
iptables --table raw -S
echo "#################################"
echo "Table security Rules "
iptables --table security -S
echo "#################################"