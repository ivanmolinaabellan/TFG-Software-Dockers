#!/bin/bash

service syslog-ng start
service frr start

vtysh << EOF
conf t
log file /shared-volume/frr/frr4.log
router ospf
network 10.3.0.0/29 area 0
network 10.0.3.0/24 area 0
network 10.0.4.0/24 area 0
network 10.100.10.0/24 area 0
network 10.100.0.0/24 area 0

end
EOF

#NAT para la conectividad a internet en: Cliente 3 y Cliente 4
update-alternatives --set iptables /usr/sbin/iptables-legacy
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


#Wireshark logs del router.
tshark -i any > /shared-volume/"$(hostname)"Log.txt &

# Keep the container running
/bin/sleep infinity