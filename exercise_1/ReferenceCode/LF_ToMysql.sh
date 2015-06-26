#!/bin/bash

if [ $# -ne 2 ]
  then
    echo "Please provide 2 args: <inputdir> <tablename>"
	exit 2
fi
# show commands being executed, per debug
set -x

# define database connectivity
_db="labs"
_db_user="root"
_db_password="password"

# define directory containing CSV files
_csv_directory=$1

# go into directory
cd $_csv_directory

# get a list of CSV files in directory
_csv_files=`ls -1 *.csv`

# loop through csv files
for _csv_file in ${_csv_files[@]}
do

  # remove file extension
  _csv_file_extensionless=`echo $_csv_file | sed 's/\(.*\)\..*/\1/'`

  # define table name
  _table_name=$2

  # get header columns from CSV file
  _header_columns=`head -1 $_csv_directory/$_csv_file | tr ',' '\n' | sed 's/^"//' | sed 's/"$//' | sed 's/ /_/g'`
  _header_columns_string=`head -1 $_csv_directory/$_csv_file | sed 's/ /_/g' | sed 's/"//g'`


  # import csv into mysql
  mysqlimport --ignore-lines=1 --fields-terminated-by=',' --lines-terminated-by="\n" --columns=$_header_columns_string --local -u $_db_user -p$_db_password $_db $_csv_directory/$_csv_file

done
exit