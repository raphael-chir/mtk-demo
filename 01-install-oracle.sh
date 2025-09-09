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
sed -i '/oracle-xe/d' /etc/hosts
IP_VM=$(hostname -I | awk '{print $1}')
echo "$IP_VM oracle-xe" >> /etc/hosts

echo "SYS and SYSTEM password for Oracle (oracle/oracle)"
( echo "oracle"; echo "oracle" ) | /etc/init.d/oracle-xe-21c configure

echo "Oracle env vars"
cat >> /home/vagrant/.bashrc <<EOF

# Oracle XE 21c
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export ORACLE_SID=XE
export PATH=\$ORACLE_HOME/bin:\$PATH
EOF
