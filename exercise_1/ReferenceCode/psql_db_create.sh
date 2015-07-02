#!/bin/sh
DB_NAME=$1
if [ "$#" -ne 1 ]; then
echo "provide 1 arg : database name : example -lab"  
exit 1
fi
if psql ${DB_NAME} -c '\q' 2>&1; then
   echo "database ${DB_NAME} exists"
else
psql postgres postgres << EOF
create database $DB_NAME;
EOF
fi


