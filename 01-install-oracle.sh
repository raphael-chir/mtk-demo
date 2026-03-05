#!/bin/bash
set -e

dnf -y update
dnf -y install oracle-database-preinstall-21c wget unzip

if [ ! -f /vagrant/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm ]; then
  echo "oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm not found in /vagrant ! Please download it from Oracle and place it in the project folder"
  exit 1
fi

dnf -y localinstall /vagrant/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

echo "hostname configuration"
HN="$(hostname)"
IP_VM="$(ip -4 addr show | awk '/192\.168\.56\./ {print $2}' | cut -d/ -f1 | head -n1)"
if [ -z "$IP_VM" ]; then
  echo "ERROR: could not find 192.168.56.x IP (network not ready?)"
  ip -4 a
  exit 1
fi
sed -i -E "/\s${HN}(\s|$)/d" /etc/hosts
echo "$IP_VM $HN" >> /etc/hosts

echo "SYS and SYSTEM password for Oracle (oracle/oracle)"
( echo "oracle"; echo "oracle" ) | /etc/init.d/oracle-xe-21c configure

echo "Oracle env vars"
cat >> /home/vagrant/.bashrc <<EOF

# Oracle XE 21c
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export ORACLE_SID=XE
export PATH=\$ORACLE_HOME/bin:\$PATH
EOF