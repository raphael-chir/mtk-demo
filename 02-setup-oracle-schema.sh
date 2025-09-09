#!/bin/bash
# =======================================================
# Setup Oracle XE schema "demo" and prepare Data Pump
# Works with Vagrant user on Oracle XE 21c
# =======================================================

# -----------------------------
# Variables
# -----------------------------
PDB="XEPDB1"
SYS_USER="sys"
SYS_PASS="oracle"
SCHEMA_USER="demo"
SCHEMA_PASS="demo"
DPUMP_DIR="/dpdump"
DDL_DIR="/vagrant"
DUMP_SRC="$DDL_DIR/demo_schema.dmp"
DIR_NAME="dpump_dir"

# Set Oracle environment
export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

# -----------------------------
# Prepare dump directory
# -----------------------------
echo "==> Creating dump directory: $DPUMP_DIR"
mkdir -p $DPUMP_DIR
chown vagrant:oinstall $DPUMP_DIR
chmod 770 $DPUMP_DIR

echo "==> Copying dump file to $DPUMP_DIR"
cp -u $DUMP_SRC $DPUMP_DIR/
chown vagrant:oinstall $DPUMP_DIR/demo_schema.dmp
chmod 660 $DPUMP_DIR/demo_schema.dmp

# -----------------------------
# Create schema and Data Pump directory
# -----------------------------
echo "==> Creating user/schema and Data Pump directory in Oracle"
sqlplus -s "$SYS_USER/$SYS_PASS@localhost/$PDB as sysdba" <<SQL
ALTER SESSION SET CONTAINER = $PDB;

-- Drop user if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP USER $SCHEMA_USER CASCADE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -01918 THEN RAISE; END IF; -- ignore "user does not exist"
END;
/

-- Create user/schema
CREATE USER $SCHEMA_USER IDENTIFIED BY $SCHEMA_PASS;
GRANT CONNECT, RESOURCE, SELECT_CATALOG_ROLE, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE TO $SCHEMA_USER;
ALTER USER $SCHEMA_USER QUOTA UNLIMITED ON USERS;

-- Drop directory if exists
BEGIN
   FOR dir IN (SELECT directory_name FROM dba_directories WHERE directory_name = UPPER('$DIR_NAME')) LOOP
      EXECUTE IMMEDIATE 'DROP DIRECTORY $DIR_NAME';
   END LOOP;
END;
/

-- Create Data Pump directory
CREATE OR REPLACE DIRECTORY $DIR_NAME AS '$DPUMP_DIR';
GRANT READ, WRITE ON DIRECTORY $DIR_NAME TO $SCHEMA_USER;

EXIT;
SQL

echo "==> Schema and directory ready"

# Launch the import
impdp $SCHEMA_USER/$SCHEMA_PASS@localhost/$PDB \
    DIRECTORY=dpump_dir \
    DUMPFILE=demo_schema.dmp \
    LOGFILE=demo_schema_import.log \
    SCHEMAS=$SCHEMA_USER \
    TABLE_EXISTS_ACTION=REPLACE

echo "==> Import completed!"

