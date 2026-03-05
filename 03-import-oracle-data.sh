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

# Launch the import
impdp $SCHEMA_USER/$SCHEMA_PASS@localhost/$PDB \
    DIRECTORY=dpump_dir \
    DUMPFILE=demo_schema.dmp \
    LOGFILE=demo_schema_import.log \
    SCHEMAS=$SCHEMA_USER \
    TABLE_EXISTS_ACTION=REPLACE

echo "==> Import completed!"

