#!/bin/bash

service syslog-ng start
service frr start

vtysh << EOF
conf t
log file /shared-volume/frr/frr1.log
router ospf
network 10.100.0.0/24 area 0
network 10.200.0.0/30 area 0
network 10.1.0.0/30 area 0
network 10.100.10.0/24 area 0

end
EOF


#NAT para la conectividad a internet en: Servidor y Profesor.
update-alternatives --set iptables /usr/sbin/iptables-legacy
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE


#Wireshark logs del router.
tshark -i any > /shared-volume/"$(hostname)"Log.txt &

# Keep the container running
/bin/sleep infinity
