#!/bin/sh
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 Profiling.sql Output.txt" 
  exit 1
fi
"Data Profiling Counts of Web_Session_Log,User_Data,DISTINCT Users in web_session_log and DISTINCT Users in User_Data">> $2
hive -f $1 >> $2
