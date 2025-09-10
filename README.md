[![Generic badge](https://img.shields.io/badge/Version-1.0-<COLOR>.svg)](https://shields.io/)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
![Maintainer](https://img.shields.io/badge/maintainer-raphael.chir@gmail.com-blue)
# Migrate from Oracle to Enterprise Postgres Advanced Server
## Components
- Oracle XE 21 (https://www.oracle.com/database/technologies/xe-downloads.html) (copy the RPM into the project root)
- EPAS 17
- Migration Toolkit

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

Because it avoids to rewrite code, **this reduce significantly** 
- the cost of a migration
- the risk of a failed migration

## EDB Repository Token
To install EPAS you need an access to EDB Repository.   
It is free, you can go to https://www.enterprisedb.com/docs/repos/ to read how to do.  
Create a file named .edbtoken and past your key into it  

## Start
We use vagrant to set up 2 VMs, one including Oracle XEM and another including Postgres Advanced 17 with MTK.
```
vagrant up
```
## Migration assessment

The first step is to analyze the ddl of oracle database. Go to to https://www.enterprisedb.com  
Then click on Accounts/Migration Portal to access to the assessment tool.
You need to provide your ddl : 
- Download edb_extractor_ddl.sql and run it 
- Or extract with your own oracle script or tool
Then choose the source Oracle version, the target EPAS version, fill required infos and perform assessment.

Migration Portal is an analyzer tool to help you fix compatibilities issues.  
You can also perform an dry run with Migration Toolkit (MTK), and see a report in the logs as we will see below.  
But Migration Portal is a more strict analyzer so it is recommended to use it before ! 

## Migration Toolkit (MTK)
MTK is a java program whick comes with a lot of options to implement the design of your migration.  

### A - Offline migration tests
In this tests section we will demonstrate :  
- Automatic column type conversion
- Automatic triggers and sequences conversion
- Automatic indexes conversion
- Compatible Functions and Procedures portability
- Handling an incompatibility identified in Migration Portal

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
#### 2 - Test offline migration with compatible schema and data generation
Perform an offline migration, go to /usr/edb/migration-toolkit/bin directory
```
sudo ./runMTK.sh -offlineMigration /vagrant/mtk-generated/  DEMO
```
MTK has automatically generated a schema with compatible data types. Let's import the schema and the data.

### 3 - Test schema and data import into EPAS
```
psql -h localhost -p 5444 -U dba -d postgres
```
Then :
```
\i /vagrant/mtk-generated/mtk_demo_ddl.sql;
```
```
\copy demo.customers FROM '/vagrant/mtk-generated/mtk_demo_customers_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
```
\copy demo.products FROM '/vagrant/mtk-generated/mtk_demo_products_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
Data related with a table containing a CLOB column type can't be migrate with COPY.
```
\i /vagrant/mtk-generated/mtk_demo_orders_data.sql; 
```
```
\copy demo.order_lines FROM '/vagrant/mtk-generated/mtk_demo_order_lines_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
```
\copy demo.ratings FROM '/vagrant/mtk-generated/mtk_demo_ratings_data.cpy' WITH (FORMAT text, DELIMITER E'\t', NULL '\N');
```
Explore the different table structure and associate data

#### 4 - Test sequences and triggers
```
postgres=# INSERT INTO customers (last_name, first_name, email, signup_date) VALUES ('Chir', 'Raphael', 'raphael.chir@example.com', DATE '2025-01-15');
INSERT 0 1
```
```
postgres=# select * from customers where last_name = 'Chir';
 customer_id | last_name | first_name |          email           |    signup_date     
-------------+-----------+------------+--------------------------+--------------------
         102 | Chir      | Raphael    | raphael.chir@example.com | 15-JAN-25 00:00:00
(1 row)

```
#### 5 - Test indexes
```
postgres=# \di
```

#### 6 - Test functions 
Check functions (func & proc types)
```
postgres=# \df
```
Important ! At this stage we have noticed that an incompatibility had been raised by migration portal, but MTK hasn't log it !
Let's test
```
postgres=# select get_customer_total(6);
 get_customer_total 
--------------------
            1204.36
(1 row)
```
```
postgres=# CALL demo.report_orders_summary();
```
And ... 
```
postgres=# CALL demo.get_all_orders_activity_log(123);
ERROR:  procedure dbms_lob.createtemporary(clob, boolean) does not exist
LINE 1: EXEC DBMS_LOB.CREATETEMPORARY(v_notes, TRUE)
        ^
HINT:  No procedure matches the given name and argument types. You might need to add explicit type casts.
QUERY:  EXEC DBMS_LOB.CREATETEMPORARY(v_notes, TRUE)
CONTEXT:  edb-spl function get_all_orders_activity_log(numeric) line 4 at procedure/function invocation statement
```
Remember this incompatibility had been raised by Migration Portal.
No magic system here we must rewrite it a little ... 

#### 7 - Test quick procedure rewriting
```sql
postgres=# CREATE OR REPLACE PROCEDURE get_all_orders_activity_log(p_customer_id NUMBER) IS
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
Then
```
postgres=# CALL demo.get_all_orders_activity_log(4);
All orders activity_log for customer 4 :
2025-09-06 11:51:19 - Added product 62 x1
2025-09-04 14:08:21 - Added product 51 x1
2025-09-04 11:19:22 - Added product 47 x3
2025-09-01 08:03:44 - Added product 9 x1
2025-09-08 02:17:53 - Order processed
2025-09-08 01:02:22 - Shipped via UPS
2025-09-08 13:22:23 - Delivered

2025-09-04 10:32:03 - Added product 49 x3
2025-09-07 14:45:12 - Added product 33 x3
2025-09-05 17:15:43 - Added product 44 x3
2025-08-31 20:07:51 - Added product 59 x1
2025-09-08 08:22:56 - Order processed
2025-09-08 02:51:34 - Shipped via UPS
2025-09-08 13:22:23 - Delivered
```

### B - Online migration tests

#### 1 - Migration at once without optimization
We can make the migration at once with this command :
```
sudo ./runMTK.sh -dropSchema true DEMO
``` 
See the report log, i.e:
```
sudo less /root/.enterprisedb/migration-toolkit/logs/mtk_DEMO_20250910100903.log
```

#### 2 - Test Parallelism Migration optimization

Table migrable with COPY and INSERT mode can take benefit of multi threads parallelism :
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 5000 -tableLoaderLimit 4 DEMO
``` 
-loaderCount : is the number of parallel threads (1 thread -> 1 core). For the demo I use a 2CPU for a total of 4 cores  so I set 4 threads  
-parallelLoadRowLimit : Is the number of rows handled by a thread. Default is 100000, so adjust it to take benefit of parallelism  
-tableLoaderLimit adjust the max number of threads use on a table, can equilibrate the load

TIPS : 
-fastCopy is an option that deactivate wal to accelerate migration. But you can't used PITR if migration failed at a certain point

#### 3 - Test Migration Strategy optimization
You can create a script to separate migration from tables containing CLOB and table migrable with COPY mode with the specific options described above

| **Context / Options MTK**                                 | **Mode**               | **Description**                                                                           |
| --------------------------------------------------------- | ---------------------- | ----------------------------------------------------------------------------------------- |
| `-offlineMigration -dataOnly` without `-safeMode`         | **COPY**               | Utilisation de fichiers `.cpy`, insertion en bloc. C'est le mode par défaut.              |
| `-offlineMigration -dataOnly -safeMode`                   | **INSERT** (plain SQL) | Fichiers SQL générés avec INSERT, ligne par ligne, chaque ligne est commitée à part.      |
| Vérification automatique du mode suite à une interruption | **COPY**               | En cas de reprise après interruption, continue le COPY depuis la ligne échouée ([EDB][1]) |
| `-fastCopy` utilisé (option complémentaire)               | Toujours **COPY**      | Optimise le COPY en contournant le WAL, mais nécessite un environnement compatible.       |
| `-cpBatchSize` utilisé (option complémentaire)            | **COPY**               | Specify the batch size in MB to use in the COPY command. Any value greater than 0 is valid. The default batch size is 8MB.
| `-batchSize` utilisé (option complémentaire)              | **INSERT**             | Specify the batch size of bulk inserts. Valid values are 1 to 1000. The default batch size is 1000. Reduce the value of -batchSize if Out of Memory exceptions occur.                                        |
| `-lobBatchSize` utilisé (option complémentaire)           | **INSERT** (Oracle)    | Specify the number of rows to load in a batch for LOB data types. The data migration for a table containing a large object type (LOB) column, such as BYTEA, BLOB, or CLOB, is performed one row at a time by default. This is to avoid an out-of-heap-space error in case an individual LOB column holds hundreds of megabytes of data. In case the LOB column average data size is at a lower end, you can customize the LOB batch size by specifying the number of rows in each batch with any value greater than 0.d’inserts).                                          |

[1]: https://www.enterprisedb.com/docs/migration_toolkit/latest/07_invoking_mtk/08_mtk_command_options/ "Migration Toolkit command options v55 - EnterpriseDB"

-cpBatchSize optimise la taille du lot à ecrire

-parallelLoadRowLimit décide si la table peut être chargée en plusieurs threads en parallèle  

Note -fetchSize : lecture depuis la source

Objectif : contrôle combien de lignes le driver JDBC récupère depuis la base source à chaque appel.

Fonctionne avant même que MTK commence à charger les données dans PostgreSQL/EDB.

Si trop grand : MTK charge trop de lignes en mémoire à la fois → OutOfMemory.  

#### Group 1 - CUSTOMERS,PRODUCTS,RATINGS table creation and data copy. Try to optimize
```
sudo ./runMTK.sh -dropSchema true -tables "CUSTOMERS,PRODUCTS,RATINGS" DEMO
```
or
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 5000 -tableLoaderLimit 2 -cpBatchSize 4 -fetchSize 1000 -tables "CUSTOMERS,PRODUCTS,RATINGS" DEMO
``` 
Note that nothing else except TABLES DDL are created.
```
[vagrant@mtk-epas bin]$ psql -h localhost -p 5444 -U dba -d edb -c "\dt demo.*"
Password for user dba: 
         List of relations
 Schema |   Name    | Type  | Owner 
--------+-----------+-------+-------
 demo   | customers | table | dba
 demo   | products  | table | dba
 demo   | ratings   | table | dba
(3 rows)

```

#### Group 2 - ORDERS : contain CLOB so INSERT mode
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 20000 -tableLoaderLimit 4 -batchSize 8 -fetchSize 20000 -tables "ORDERS" DEMO
```
and
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 20000 -tableLoaderLimit 4 -batchSize 8 -lobBatchSize 1000  -tables "ORDERS" DEMO
```

#### Group 3 - ORDER_LINES : table creation and data copy.
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 30000 -tableLoaderLimit 2 -cpBatchSize 16 -fetchSize 40000 -tables "ORDER_LINES" DEMO
```

#### Script creation

Take the best performance command for each group and add options for constraints, indexes and triggers. Then complete the script with sequences, proc and functions
```
sudo ./runMTK.sh -dropSchema true -loaderCount 4 -parallelLoadRowLimit 5000 -tableLoaderLimit 2 -cpBatchSize 4 -fetchSize 1000 -tables "CUSTOMERS,PRODUCTS,RATINGS" -constraints -indexes -triggers  DEMO


sudo ./runMTK.sh -dropSchema false -loaderCount 4 -parallelLoadRowLimit 20000 -tableLoaderLimit 4 -batchSize 8 -lobBatchSize 1000  -tables "ORDERS" -constraints -indexes -triggers DEMO

sudo ./runMTK.sh -dropSchema false -loaderCount 4 -parallelLoadRowLimit 30000 -tableLoaderLimit 2 -cpBatchSize 16 -fetchSize 40000 -tables "ORDER_LINES" -constraints -indexes -triggers DEMO

sudo ./runMTK.sh -dropSchema false -allSequences -allProcs -allFuncs DEMO
```
Execute the script that includes the command above, it is naned "migration.sh" : 
```
. /vagrant/migrate.sh
``` 
The execution time has been reduced to 64%

Check that everything's alright
```
psql -h localhost -p 5444 -U dba -d edb -c "set search_path=demo;CALL demo.report_orders_summary();"
```

Enjoy your Oracle to EPAS migration ...