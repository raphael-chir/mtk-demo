# Appendix
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
```xpdp demo/demo@localhost/XEPDB1   DIRECTORY=dpump_dir   DUMPFILE=demo_schema.dmp   LOGFILE=demo_schema.log   SCHEMAS=demo

Export: Release 21.0.0.0.0 - Production on Mon Sep 8 16:13:27 2025
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
. . exported "DEMO"."CUSTOMERS"                          12.02 KB     101 rows
. . exported "DEMO"."ORDERS"                             148.9 KB     295 rows
. . exported "DEMO"."ORDER_LINES"                        25.71 KB     883 rows
. . exported "DEMO"."PRODUCTS"                           32.96 KB      65 rows
Master table "DEMO"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded
******************************************************************************
Dump file set for DEMO.SYS_EXPORT_SCHEMA_01 is:
  /dpdump/demo_schema.dmp
Job "DEMO"."SYS_EXPORT_SCHEMA_01" successfully completed at Mon Sep 8 16:13:54 2025 elapsed 0 00:00:26
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


@/vagrant/datagen/customers.sql
@/vagrant/datagen/customers.sql
@/vagrant/datagen/orders.sql
@/vagrant/datagen/order_lines.sql