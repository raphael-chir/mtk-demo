
#!/bin/bash

# Install Migration Toolkit
dnf -y install edb-migrationtoolkit edb-jdbc
cp /vagrant/ojdbc8.jar /usr/edb/migrationtoolkit/lib
cp /usr/edb/jdbc/edb-jdbc18.jar /usr/edb/migrationtoolkit/lib

# Config Migration Toolkit
tee /usr/edb/migrationtoolkit/etc/toolkit.properties > /dev/null <<EOF
SRC_DB_URL=jdbc:oracle:thin:@192.168.56.10:1521/XEPDB1
SRC_DB_USER=demo
SRC_DB_PASSWORD=demo

TARGET_DB_URL=jdbc:edb://localhost:5444/edb
TARGET_DB_USER=dba
TARGET_DB_PASSWORD=dba
EOF