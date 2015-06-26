#!/bin/sh
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 summaryquery.sql LogFile.txt" 
  exit 1
fi

hive -f $1 >> $2 