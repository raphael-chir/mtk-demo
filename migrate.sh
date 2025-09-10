#!/bin/bash
set -e

MTK="/usr/edb/migrationtoolkit/bin/runMTK.sh"

start_time=$(date +%s)

sudo "$MTK" -dropSchema true -loaderCount 4 -parallelLoadRowLimit 5000 -tableLoaderLimit 2 -cpBatchSize 4 -fetchSize 1000 -tables "CUSTOMERS,PRODUCTS,RATINGS" -constraints -indexes -triggers  DEMO

sudo "$MTK" -dropSchema false -loaderCount 4 -parallelLoadRowLimit 20000 -tableLoaderLimit 4 -batchSize 8 -lobBatchSize 1000  -tables "ORDERS" -constraints -indexes -triggers DEMO

sudo "$MTK" -dropSchema false -loaderCount 4 -parallelLoadRowLimit 30000 -tableLoaderLimit 2 -cpBatchSize 16 -fetchSize 40000 -tables "ORDER_LINES" -constraints -indexes -triggers DEMO

sudo "$MTK" -dropSchema false -allSequences -allProcs -allFuncs DEMO

end_time=$(date +%s)
duration=$(( end_time - start_time ))

echo "Migration succeeded in ${duration} seconds"