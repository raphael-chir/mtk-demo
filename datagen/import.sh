#!/bin/bash
sqlplus -s demo/demo@localhost/XEPDB1 <<EOF
@demo-schema.ddl.sql
@customers.sql
@products.sql
@ratings.sql
@orders.sql
EXIT;
EOF
