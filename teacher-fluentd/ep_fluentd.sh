#!/bin/sh

fluentd -c fluentd/etc/fluent.conf &

ip route del default via 10.200.0.1 dev eth0 && ip route add default via 10.200.0.2

sleep infinity