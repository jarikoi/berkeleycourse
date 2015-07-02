#!/bin/sh

echo "export data from hive to mysql using sqoop"
sqoop export --connect jdbc:postgresql://localhost:5432/labs --table summarytable  --export-dir /user/hive/warehouse/labs.db/summarytable --username root --password password -m 1 --input-fields-terminated-by ','  ;
echo " sqoop export job is done"

