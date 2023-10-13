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

/bin/sleep infinity
