#!/bin/sh

# IP address range (either single address or network subnet, see below examples),
# used by your management server for outgoing connections. Multiple IP ranges are
# not supported.
#
# Can be eg.:
#   1.2.3.4
#   1.2.3.4/32
#   1.2.3.0/24
#
# It is used mostly for SNMP monitoring, done by sf-monitoring-snmpd extension.
# As for SNMP monitoring:
#
# 1. This IP is the public one, for SNMP communication between servers with public
#    IPs. Within LAN, ranges 10.0.0.0/8, 172.16.0.0/12 and 192.168.0.0/16 also work.
#
# 2. SNMPv2 is used - which means NO ENCRYPTION. Because of that, you shouldn't
#    use sf-monitoring-snmpd extension outside your trusted networks, since SNMP
#    calls pull many sensitive data from each monitored server, eg. full process
#    list, including full list of command line arguments for each process,
#    including possible passwords etc.
#
# 3. This setting can be overwritten using /etc/local/.config/snmp.range file
#    (separately for each server).
#
# 4. Associated SNMP "community string" (SNMP password) can be set using
#    /etc/local/.config/snmp.community file (also separately for each server).
#    Note that this community string is stored in unencrypted form in this file
#    and /etc/snmp/snmpd.conf, and also sent unencrypted over the network.
#    It is recommended to use different community string for each monitored server.
#
#
# For several existing users, this setting is also being used by other extensions:
#    - private firewall extensions (dedicated to particular deployments/networks)
#    - custom MySQL monitoring solutions
#    - other custom-built solutions (eg. for managing network equipment)


echo "88.99.100.17"
