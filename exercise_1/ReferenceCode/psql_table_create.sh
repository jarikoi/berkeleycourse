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


[root@ip-10-234-15-202 scripts]# cat psql_table_create.sh 
#!/bin/sh
username=$1
db_name=$2
if [ "$#" -ne 2 ]; then
  echo "provide 2 args --username and database name : example - root lab"
  exit 1
fi

psql $db_name $username << EOF
CREATE TABLE weblog_lab(date VARCHAR(255),USERID VARCHAR(255),SESSIONID VARCHAR(255),PRODUCTID VARCHAR(255),REFERERURL VARCHAR(255));
CREATE TABLE userdata_lab(date VARCHAR(255),userid VARCHAR(255),firstname VARCHAR(255),lastname VARCHAR(255),location varchar(255));
CREATE TABLE summarytable(userid VARCHAR(255),firstname VARCHAR(255),location varchar(255),REFERERURL VARCHAR(255));
EOF

