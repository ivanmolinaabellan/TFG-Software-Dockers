#!/bin/bash

service syslog-ng start
service frr start

vtysh << EOF
conf t
log file /shared-volume/frr/frr2.log
router ospf
network 10.1.0.0/30 area 0
network 10.2.0.0/29 area 0
network 10.100.10.0/24 area 0
network 10.3.0.0/29 area 0
network 10.4.0.0/29 area 0
network 10.100.0.0/24 area 0
end
EOF

tshark -i any -f "tcp[tcpflags] & (tcp-syn) != 0 and (tcp[tcpflags] & (tcp-ack) = 0)" -T fields -e frame.time -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport -e tcp.flags.syn -e tcp.flags.ack -e tcp.flags.res -E header=y -E separator=, -E quote=d -E occurrence=f >> /shared-volume/pruebaD.csv
# Keep the container running
/bin/sleep infinity
