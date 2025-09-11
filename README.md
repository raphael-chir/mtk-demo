[![Generic badge](https://img.shields.io/badge/Version-1.0-<COLOR>.svg)](https://shields.io/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
![Maintainer](https://img.shields.io/badge/maintainer-raphael.chir@gmail.com-blue)
# Migrate from Oracle to Enterprise Postgres Advanced Server
## Sommaire

- [Components](#components)
- [Goal](#goal)
- [EDB Repository Token](#edb-repository-token)
- [Start](#start)
- [Migration assessment](#migration-assessment)
- [Migration Toolkit (MTK)](#migration-toolkit-mtk)
  - [A - Offline migration tests](#a---offline-migration-tests)
    - [1 - Test environment](#1---test-environment)
    - [2 - Test offline migration with compatible schema and data generation](#2---test-offline-migration-with-compatible-schema-and-data-generation)
    - [3 - Test schema and data import into EPAS](#3---test-schema-and-data-import-into-epas)
    - [4 - Test sequences and triggers](#4---test-sequences-and-triggers)
    - [5 - Test indexes](#5---test-indexes)
    - [6 - Test functions](#6---test-functions)
    - [7 - Test quick procedure rewriting](#7---test-quick-procedure-rewriting)
  - [B - Online migration tests](#b---online-migration-tests)
    - [1 - Migration at once without optimization](#1---migration-at-once-without-optimization)
    - [2 - Test Parallelism Migration optimization](#2---test-parallelism-migration-optimization)
    - [3 - Test Migration Strategy optimization](#3---test-migration-strategy-optimization)
      - [Group 1 - CUSTOMERS,PRODUCTS,RATINGS table creation and data copy](#group-1---customersproductsratings-table-creation-and-data-copy)
      - [Group 2 - ORDERS : contain CLOB so INSERT mode](#group-2---orders--contain-clob-so-insert-mode)
      - [Group 3 - ORDER_LINES : table creation and data copy](#group-3---order_lines--table-creation-and-data-copy)
      - [Group 4 - Migrate remaining DDL objects](#group-4---migrate-remaining-ddl-objects)
      - [Script creation](#script-creation)

## Components
- Source database : **Oracle XE 21** (https://www.oracle.com/database/technologies/xe-downloads.html) (copy the RPM into the project root)
- Destination database : **EPAS 17**
- Migration Toolkit
- Data model :

```text
        +-----------+                                +-----------+
        | CUSTOMERS |------------------------------->|  RATINGS  |
        +-----------+                                +-----------+
              |                                         ^
              v                                         |
        +-----------+        +--------------+        +-----------+
        |  ORDERS   |------->| ORDER_LINES  |<-------| PRODUCTS  |
        +-----------+        +--------------+        +-----------+
```

## Goal
In this demo, we will show the EPAS compatibilities with Oracle.  
This means that **you can copy directly into EPAS** : 
- PL/SQL procedures using **compatible DBMS packages**
- Table with **compatible Oracle native column types**
- Compatible functions
- Sequences and triggers Oracle syntax
- View and Synonyms
- Oracle Roles, Password profiles and Privileges
- Index, constraints Oracle syntax
- Advanced Oracle like (audit, partitions, request hints, ...)

> Because it avoids to rewrite code, **this reduce significantly** 
> - the cost of a migration
> - the risk of a failed migration

## EDB Repository Token
To install EPAS you need an access to EDB Repository.   
It is free, you can go to https://www.enterprisedb.com/docs/repos/ to read how to do.  
Create a file named .edbtoken and past your key into it  

## Start
We use vagrant to set up 2 VMs : 
- One including Oracle XEM and 
- Another including Postgres Advanced 17 with MTK.
```
vagrant up
```
## Migration assessment

Different tools exist to assess a migration : 
- Migration Portal (GUI that help you to fix compatibilities issues)
- MTK report in log section incompatibilities
- **EDB Professional Services** are specialized in Oracle migration to EPAS for 20 years and have internal performant tools to help you accelerate and finalize a migration with success. 

## Migration Toolkit (MTK)
MTK is a java program which comes with a lot of options to implement the design of your migration.  
### A - Offline migration tests
In this tests section we will demonstrate :  
- Automatic column type conversion
- Automatic triggers and sequences conversion
- Automatic indexes conversion
- Compatible Functions and Procedures portability
- Handling an incompatibility identified in Migration Portal
---
#### 1 - Test environment
We can install MTK on a separate server but for the demo purpose it is installed on the target EPAS VM. 
SSH into the EPAS VM.
Source and target connexion strings are configured in toolkit.properties
```
[vagrant@mtk-epas /]$ ll /usr/edb/migrationtoolkit/
total 28
drwxr-xr-x. 2 root         root            84 Sep  9 16:21 bin
-r--r--r--. 1 enterprisedb enterprisedb 10242 Aug  5 12:44 edb-migrationtoolkit_3rd_party_licenses.txt
-rwxr-xr-x. 1 root         root         15272 Aug  5 12:44 edb-migrationtoolkit_license.txt
drwxr-xr-x. 2 root         root            32 Sep  9 16:21 etc
drwxr-xr-x. 2 root         root           158 Sep  9 16:21 lib
[vagrant@mtk-epas /]$ ll /usr/edb/migrationtoolkit/etc/
total 4
-rw-------. 1 enterprisedb enterprisedb 180 Sep  9 16:21 toolkit.properties
```
```
[vagrant@mtk-epas /]$ sudo cat /usr/edb/migrationtoolkit/etc/toolkit.properties 
SRC_DB_URL=jdbc:oracle:thin:@192.168.56.10:1521/XEPDB1
SRC_DB_USER=demo
SRC_DB_PASSWORD=demo

TARGET_DB_URL=jdbc:edb://localhost:5444/edb
TARGET_DB_USER=dba
TARGET_DB_PASSWORD=dba
[vagrant@mtk-epas /]$ 
```
---
#### 2 - Test offline migration with compatible schema and data generation
Perform an offline migration, go to /usr/edb/migration-toolkit/bin directory
```
sudo ./runMTK.sh -offlineMigration /vagrant/mtk-generated/  DEMO
```
MTK has automatically generated a schema with compatible data types. Let's import the schema and the data.

---
#### 3 - Test schema and data import into EPAS
```
psql -h localhost -p 5444 -U dba -d edb
```
Set demo schema in search_path on database level.
```
alter database edb set search_path='demo';
```
Then :
```
\i /vagrant/mtk-generated/mtk_demo_ddl.sql;
```
```
\copy customers FROM '/vagrant/mtk-generated/mtk_demo_customers_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
```
\copy products FROM '/vagrant/mtk-generated/mtk_demo_products_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```

**WARN** : *Data related with a table containing a CLOB column type can't be migrate with COPY.*
```
\i /vagrant/mtk-generated/mtk_demo_orders_data.sql; 
```
```
\copy order_lines FROM '/vagrant/mtk-generated/mtk_demo_order_lines_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
```
\copy ratings FROM '/vagrant/mtk-generated/mtk_demo_ratings_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
---
#### 4 - Test sequences and triggers
```
INSERT INTO customers (last_name, first_name, email, signup_date) VALUES ('Chir', 'Raphael', 'raphael.chir@example.com', DATE '2025-01-15');
INSERT 0 1
```
```
select * from customers where last_name = 'Chir';
```
---
#### 5 - Test indexes
```
\di
```
---
#### 6 - Test functions 
Check functions (func & proc types)
```
\df
```
**Important** : At this stage we have noticed that an incompatibility had been raised by migration portal, but MTK hasn't log it !
Let's test
```
select get_customer_total(4755);
```
```
call report_orders_summary();
```
And ... 
```
postgres=# CALL get_all_orders_activity_log(4755);
ERROR:  procedure dbms_lob.createtemporary(clob, boolean) does not exist
LINE 1: EXEC DBMS_LOB.CREATETEMPORARY(v_notes, TRUE)
        ^
HINT:  No procedure matches the given name and argument types. You might need to add explicit type casts.
QUERY:  EXEC DBMS_LOB.CREATETEMPORARY(v_notes, TRUE)
CONTEXT:  edb-spl function get_all_orders_activity_log(numeric) line 4 at procedure/function invocation statement
```
Remember this incompatibility had been raised by Migration Portal.
No magic system here we must rewrite it a little ...  

---
#### 7 - Test quick procedure rewriting
```sql
CREATE OR REPLACE PROCEDURE get_all_orders_activity_log(p_customer_id NUMBER) IS
  v_notes CLOB := EMPTY_CLOB();
BEGIN
  -- Loop through orders with activity logs
  FOR rec IN (
    SELECT o.activity_log AS c
    FROM orders o
    WHERE o.customer_id = p_customer_id
      AND o.activity_log IS NOT NULL
  ) LOOP
    v_notes := v_notes || rec.c || CHR(10);
  END LOOP;

  -- Output the aggregated result
  DBMS_OUTPUT.PUT_LINE('All orders activity_log for customer ' || p_customer_id || ' :');
  DBMS_OUTPUT.PUT_LINE(DBMS_LOB.SUBSTR(v_notes, 4000, 1)); -- EPAS-friendly way
END;
/
```
Check that it works now.

---
### B - Online migration tests

#### 1 - Migration at once without optimization
We can make the migration at once with this command :
```
sudo ./runMTK.sh -dropSchema true DEMO
``` 
See the report log in /root/.enterprisedb/migration-toolkit/logs/ folder

---
#### 2 - Test Parallelism Migration optimization

Table migrable with COPY and INSERT mode can take benefit of multi threads parallelism :
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 5000 -tableLoaderLimit 4 DEMO
``` 
**-loaderCount** : The number of parallel threads (1 thread -> 1 core). *For the demo I use a 2CPU for a total of 4 cores so 4 threads*  
**-parallelLoadRowLimit** : The number of rows fetched from Oracle that trigger parallelism load ito EPAS. *Default is 100000, so adjust it to take benefit of parallelism*  
**-tableLoaderLimit** adjust the max number of threads use on a table to equilibrate the load

Notes :   
**-fastCopy** is an option that deactivate wal to accelerate migration. But you can't used PITR if migration failed at a certain point

---
#### 3 - Test Migration Strategy optimization
A best practice is to create a script to separate migration 
using INSERT mode and using COPY mode because specific options are available :

| **Context / Options MTK**                                 | **Mode**               | **Description**                                                                           |
| --------------------------------------------------------- | ---------------------- | ----------------------------------------------------------------------------------------- |
| `-offlineMigration -dataOnly` without `-safeMode`         | **COPY**               | Default mode for `.cpy` bloc insertion.              |
| `-offlineMigration -dataOnly -safeMode`                   | **INSERT** (plain SQL) | Each line is commited      |
| Automatic check when interuption occured | **COPY**               | When ok COPY from failed row insertion restart ([EDB][1]) |
| `-fastCopy`               | **COPY**      | COPY optimization without WAL writing.       |
| `-cpBatchSize`| **COPY**               | Specify the batch size in MB to use in the COPY command. Any value greater than 0 is valid. The default batch size is 8MB.
| `-batchSize`              | **INSERT**             | Specify the batch size of bulk inserts. Valid values are 1 to 1000. The default batch size is 1000. Reduce the value of -batchSize if Out of Memory exceptions occur.                                        |
| `-lobBatchSize`           | **INSERT** (Oracle)    | Optimize the batch size to load. Specify the number of rows to load in a batch for LOB data types. The data migration for a table containing a large object type (LOB) column, such as BYTEA, BLOB, or CLOB, is performed one row at a time by default. This is to avoid an out-of-heap-space error in case an individual LOB column holds hundreds of megabytes of data. In case the LOB column average data size is at a lower end, you can customize the LOB batch size by specifying the number of rows in each batch with any value greater than 0.d’inserts).                                          |

[1]: https://www.enterprisedb.com/docs/migration_toolkit/latest/07_invoking_mtk/08_mtk_command_options/ "Migration Toolkit command options v55 - EnterpriseDB"

**-fetchSize** :  
- Read, extract from source database
- Control how many rows JDBC driver are extracted for each call
- Run before MTK starts to load data 
- Warning : If the value is too high an OutOfMemory error could occur.  

We choose to create 3 groups of data migration, and we add a 4th for migrate remaining schema object

##### Group 1 - CUSTOMERS,PRODUCTS,RATINGS table creation and data copy.
```
sudo ./runMTK.sh -dropSchema true -tables "CUSTOMERS,PRODUCTS,RATINGS" DEMO
```
and
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 5000 -tableLoaderLimit 2 -cpBatchSize 4 -fetchSize 1000 -tables "CUSTOMERS,PRODUCTS,RATINGS" DEMO
``` 
Note that nothing else except the related TABLES DDL are created.
```
psql -h localhost -p 5444 -U dba -d edb -c "\dt"
```

##### Group 2 - ORDERS : contain CLOB so INSERT mode
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 20000 -tableLoaderLimit 4 -batchSize 8 -fetchSize 20000 -tables "ORDERS" DEMO
```
and
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 20000 -tableLoaderLimit 4 -batchSize 8 -lobBatchSize 1000  -tables "ORDERS" DEMO
```

##### Group 3 - ORDER_LINES : table creation and data copy.
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 30000 -tableLoaderLimit 2 -cpBatchSize 16 -fetchSize 40000 -tables "ORDER_LINES" DEMO
```

##### Group 4 - Migrate remaining DDL objects

Don't run it here because it depends on all previous ddl objects creation (as we run mtk with -dropSchema true).
```
sudo ./runMTK.sh -dropSchema false -allSequences -allProcs -allFuncs DEMO
```

##### Script creation

Take the best performance command for each group and add options for constraints, indexes and triggers. Then complete the script with sequences, proc and functions.  
See the final script : See [migrate.sh](migrate.sh)

```
. /vagrant/migrate.sh
``` 

Important : The execution time has been reduced to 64% !

Check that everything's alright
```
psql -h localhost -p 5444 -U dba -d edb -c "call report_orders_summary();"
```

Enjoy your Oracle to EPAS migration ...