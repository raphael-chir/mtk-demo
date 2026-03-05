# Appendix
## Data generation
1 - Run the ddl script based on demo-schema.ddl.sql  
2 - Generate plain sql script with datagen.py program   
3 - From your Oracle instance, run the SQL data scripts separately to verify that each table dataset are correctly inserted, or you can execute directly import.sh script

### DDL Schema setup
Use datagen/demo-schema.ddl.sql. SSH into your Oracle instance and run :
```
sqlplus -s demo/demo@localhost/XEPDB1 @demo-schema.ddl.sql
```
### Generate data
datagen.py is a Python script using Faker library.  
First prepare your Python environment (Python3 must be installed).
```
python3 -m venv ~/oracle_data_env
```
```
source ~/oracle_data_env/bin/activate
```
```
pip install --upgrade pip
```
```
pip install faker
```
cd into datagen directory, then execute
```
python3 datagen.py
```
This command generate 4 plain SQL files, ready to be executed on your Oracle instance. By default the number of rows for each table is defined in the beginning of the program.

### SQL scripts execution
You must respect the order of execution for each script : 
1 - customers.sql
2 - products.sql
3 - ratings.sql
4 - orders.sql (contains order_lines dataset)

```
sqlplus demo/demo@localhost/XEPDB1 @customers.sql 
---
```

## Oracle User/Schema and data creation

Oracle XE uses Multitenant container database (CDB). We must determine in which Pluggable database (PDB) we will create the user/schema
```
sqlplus sys/oracle as sysdba
```
```
SQL> SELECT PDB_NAME, STATUS FROM DBA_PDBS;
```
User/schema creation
```
SQL> ALTER SESSION SET CONTAINER = XEPDB1;

Session altered.

SQL> SHOW CON_NAME;                    

CON_NAME
------------------------------
XEPDB1
SQL> CREATE USER demo IDENTIFIED BY demo;

User created.

SQL> GRANT CONNECT, RESOURCE, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE TO demo;

Grant succeeded.

ALTER USER demo QUOTA UNLIMITED ON USERS;
SQL> EXIT;

```
Then, connect to PDB with your user/schema
```
[vagrant@oracle-xe ~]$ sqlplus demo/demo@localhost/XEPDB1

SQL*Plus: Release 21.0.0.0.0 - Production on Sun Sep 7 15:07:40 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.


Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> 
```
Create the database
```
SQL> @/vagrant/02-oracle-ddl.sql;
```
Populate the database
```
SQL> @/vagrant/04-oracle-customers-data.sql
SQL> @/vagrant/05-oracle-products-data.sql
SQL> @/vagrant/06-oracle-gen-orders.sql
```
To configure a directory in which a dump can be written
```
sqlplus sys/oracle@localhost/XEPDB1 as sysdba

SQL*Plus: Release 21.0.0.0.0 - Production on Mon Sep 8 16:13:09 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.


Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> CREATE OR REPLACE DIRECTORY dpump_dir AS '/dpdump';
GRANT READ, WRITE ON DIRECTORY dpump_dir TO demo;

Directory created.

SQL> 
Grant succeeded.

SQL> exit
```
Then dump your data
```
expdp demo/demo@localhost/XEPDB1   DIRECTORY=dpump_dir   DUMPFILE=demo_schema.dmp   LOGFILE=demo_schema.log   SCHEMAS=demo
```
```
Export: Release 21.0.0.0.0 - Production on Tue Sep 9 23:27:03 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle and/or its affiliates.  All rights reserved.

Connected to: Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Starting "DEMO"."SYS_EXPORT_SCHEMA_01":  demo/********@localhost/XEPDB1 DIRECTORY=dpump_dir DUMPFILE=demo_schema.dmp LOGFILE=demo_schema.log SCHEMAS=demo 
Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA
Processing object type SCHEMA_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
Processing object type SCHEMA_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
Processing object type SCHEMA_EXPORT/STATISTICS/MARKER
Processing object type SCHEMA_EXPORT/PRE_SCHEMA/PROCACT_SCHEMA
Processing object type SCHEMA_EXPORT/SEQUENCE/SEQUENCE
Processing object type SCHEMA_EXPORT/TABLE/TABLE
Processing object type SCHEMA_EXPORT/TABLE/COMMENT
Processing object type SCHEMA_EXPORT/FUNCTION/FUNCTION
Processing object type SCHEMA_EXPORT/PROCEDURE/PROCEDURE
Processing object type SCHEMA_EXPORT/FUNCTION/ALTER_FUNCTION
Processing object type SCHEMA_EXPORT/PROCEDURE/ALTER_PROCEDURE
Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX
Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
Processing object type SCHEMA_EXPORT/TABLE/TRIGGER
. . exported "DEMO"."ORDERS"                             13.51 MB   28716 rows
. . exported "DEMO"."PRODUCTS"                           2.979 MB    7000 rows
. . exported "DEMO"."ORDER_LINES"                        2.022 MB   81591 rows
. . exported "DEMO"."CUSTOMERS"                          1.336 MB   25437 rows
. . exported "DEMO"."RATINGS"                            9.436 MB   97142 rows
Master table "DEMO"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded
******************************************************************************
Dump file set for DEMO.SYS_EXPORT_SCHEMA_01 is:
  /dpdump/demo_schema.dmp
Job "DEMO"."SYS_EXPORT_SCHEMA_01" successfully completed at Tue Sep 9 23:27:31 2025 elapsed 0 00:00:26
```
## Oracle vs PostgreSQL tools 

| Action / Objectif                       | Oracle SQL\*Plus                                                                     | PostgreSQL / EPAS `psql`                                                          |
| --------------------------------------- | ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------- |
| **Connexion à la DB**                   | `sqlplus sys/oracle as sysdba` <br>`sqlplus system/oracle`                           | `psql -U enterprisedb -d postgres` <br>`psql -U youruser -d yourdb`               |
| **Lister les utilisateurs**             | `SELECT username FROM dba_users;`                                                    | `\du`                                                                             |
| **Lister les bases / instances**        | `SELECT name FROM v$database;`                                                       | `\l`                                                                              |
| **Lister les tables de l’utilisateur**  | `SELECT table_name FROM user_tables;`                                                | `\dt`                                                                             |
| **Lister toutes les tables (DBA)**      | `SELECT table_name FROM dba_tables;`                                                 | `\dt *.*`                                                                         |
| **Décrire une table (colonnes, types)** | `DESCRIBE table_name;` ou `DESC table_name;`                                         | `\d table_name`                                                                   |
| **Lister les schémas / tablespaces**    | `SELECT tablespace_name FROM dba_tablespaces;` <br>`SELECT username FROM all_users;` | `\db` (tablespaces) <br>`\dn` (schémas)                                           |
| **Exécuter une requête avec limite**    | `SELECT * FROM table_name WHERE ROWNUM <= 10;`                                       | `SELECT * FROM table_name LIMIT 10;`                                              |
| **Exécuter un script SQL**              | `@script.sql`                                                                        | `\i script.sql`                                                                   |
| **Voir les objets dans un schéma**      | `SELECT object_name, object_type FROM all_objects WHERE owner='SCHEMA';`             | `\dt schema.*` (tables) <br>`\dv schema.*` (views) <br>`\df schema.*` (functions) |
| **Quitter l’outil**                     | `EXIT;`                                                                              | `\q`                                                                              |


## DBLinks
Firstly, install oracle-instant-package in EPAS machine 

```
[vagrant@mtk-epas vagrant]$ sudo dnf -y localinstall /vagrant/oracle-instantclient-basic-21.12.0.0.0-1.el9.x86_64.rpm
enterprisedb-enterprise                      696  B/s | 659  B     00:00    
enterprisedb-enterprise-noarch               326  B/s | 659  B     00:02    
enterprisedb-enterprise-source               723  B/s | 659  B     00:00    
Extra Packages for Enterprise Linux 9 - x86_  67 kB/s |  12 kB     00:00    
Dependencies resolved.
=============================================================================
 Package                      Arch     Version          Repository      Size
=============================================================================
Installing:
 oracle-instantclient-basic   x86_64   21.12.0.0.0-1    @commandline    53 M

Transaction Summary
=============================================================================
Install  1 Package

Total size: 53 M
Installed size: 238 M
Downloading Packages:
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                     1/1 
  Installing       : oracle-instantclient-basic-21.12.0.0.0-1.x86_64     1/1 
  Running scriptlet: oracle-instantclient-basic-21.12.0.0.0-1.x86_64     1/1 
  Verifying        : oracle-instantclient-basic-21.12.0.0.0-1.x86_64     1/1 

Installed:
  oracle-instantclient-basic-21.12.0.0.0-1.x86_64                            

Complete!
```

Then config ld.so

```
[vagrant@mtk-epas vagrant]$ echo "/usr/lib/oracle/21/client64/lib" | sudo tee /etc/ld.so.conf.d/oracle-instantclient.conf
/usr/lib/oracle/21/client64/lib
[vagrant@mtk-epas vagrant]$ sudo ldconfig
[vagrant@mtk-epas vagrant]$ ldconfig -p | grep libclntsh
	libclntshcore.so.21.1 (libc6,x86-64) => /usr/lib/oracle/21/client64/lib/libclntshcore.so.21.1
	libclntshcore.so (libc6,x86-64) => /usr/lib/oracle/21/client64/lib/libclntshcore.so
	libclntsh.so.21.1 (libc6,x86-64) => /usr/lib/oracle/21/client64/lib/libclntsh.so.21.1
	libclntsh.so (libc6,x86-64) => /usr/lib/oracle/21/client64/lib/libclntsh.so
```
Restart EPAS
```
[vagrant@mtk-epas vagrant]$ sudo -u enterprisedb /usr/edb/as17/bin/pg_ctl -D "/var/lib/edb/as17/data" -w restart
waiting for server to shut down.... done
server stopped
waiting for server to start....2026-02-18 20:51:10 UTC LOG:  directory "edb_wait_states" already exists
2026-02-18 20:51:10 UTC LOG:  edb_pg_tuner: total memory is set as 2050637824
2026-02-18 20:51:10 UTC LOG:  redirecting log output to logging collector process
2026-02-18 20:51:10 UTC HINT:  Future log output will appear in directory "log".
 done
server started
```

Create a DBLinks on EPAS referencing Oracle source table

```
[vagrant@mtk-epas vagrant]$ psql -h localhost -U dba -d edb
Password for user dba: 
psql (17.8.0)
Type "help" for help.

edb=# \dt
          List of relations
 Schema |    Name     | Type  | Owner 
--------+-------------+-------+-------
 demo   | customers   | table | dba
 demo   | order_lines | table | dba
 demo   | orders      | table | dba
 demo   | products    | table | dba
 demo   | ratings     | table | dba
(5 rows)

edb=# CREATE DATABASE LINK oralink
  CONNECT TO demo IDENTIFIED BY 'demo'
  USING '//192.168.56.14:1521/XEPDB1';
CREATE DATABASE LINK
edb=# SELECT * FROM ref_status@oralink;
 status_code |   label    | is_active |     created_at     
-------------+------------+-----------+--------------------
 NEW         | New Order  | Y         | 18-FEB-26 20:29:20
 PROC        | Processing | Y         | 18-FEB-26 20:29:20
 SHIP        | Shipped    | Y         | 18-FEB-26 20:29:20
 CANCEL      | Cancelled  | Y         | 18-FEB-26 20:29:20
(4 rows)
```
 Create a synonym
```
edb=# CREATE SYNONYM ref_status FOR ref_status@oralink;
CREATE SYNONYM


edb=# select * from ref_status;
 status_code |   label    | is_active |     created_at     
-------------+------------+-----------+--------------------
 NEW         | New Order  | Y         | 18-FEB-26 20:29:20
 PROC        | Processing | Y         | 18-FEB-26 20:29:20
 SHIP        | Shipped    | Y         | 18-FEB-26 20:29:20
 CANCEL      | Cancelled  | Y         | 18-FEB-26 20:29:20
(4 rows)

edb=# 

```

Enjoy
