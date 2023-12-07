#!/bin/bash


# Start syslog-ng and FRR
service syslog-ng start
service frr start

# Configure FRR using vtysh
vtysh << EOF
conf t
log file /shared-volume/frr/frr2.log
router ospf 
network 10.2.0.0/29 area 0
network 10.0.1.0/24 area 0
network 10.0.2.0/24 area 0
network 10.0.3.0/24 area 0
network 10.0.4.0/24 area 0
network 10.3.0.0/29 area 0
network 10.100.0.0/24 area 0

end
EOF


tshark -i any > /shared-volume/"$(hostname)"Log.txt &

# Keep the container running
/bin/sleep infinity
