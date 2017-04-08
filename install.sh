#!/bin/sh

unzip OnlineRetail.txt.zip
su - admin -c "hdfs dfs -mkdir -p /user/admin/retail/retailsalesraw"
cp OnlineRetail.txt /tmp
chmod 777 /tmp/OnlineRetail.txt
su - admin -c "hdfs dfs -put /tmp/OnlineRetail.txt /user/admin/retail/retailsalesraw/"
cp *.pig /tmp
cp *.ddl /tmp
chmod 777 /tmp/*.pig
chmod 777 /tmp/*.ddl
su - admin -c "pig /tmp/RetailSalesIngestion.pig"
su - admin -c "pig /tmp/MBADataPrep.pig"
su - admin -c "hive -f /tmp/RetailSalesRaw.ddl"
su - admin -c "hive -f /tmp/RetailSales.ddl"

# Import following notebook in Zeppelin 
# URL = https://raw.githubusercontent.com/sainib/RetailAnalytics/master/RetailSalesAnalytics.json

