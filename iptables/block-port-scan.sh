#!/bin/bash
iptables -N port-scan
iptables -A port-scan -p tcp --syn -m limit --limit 2000/hour -j RETURN
iptables -A port-scan -m limit --limit 200/hour -j LOG --log-prefix "DROPPED Port scan: "
iptables -A port-scan -j DROP
iptables -A INPUT -p tcp --syn -j port-scan
