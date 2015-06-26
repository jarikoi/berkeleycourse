import subprocess
import sys
#Collecting arguments
total = len(sys.argv)
#Checking with Arguments
if total < 5:
#Printing Error if Arguments are wrong
	print ("Usage: MysqlDBURL MysqlUserName MysqlPassword MysqlTableName")
else:
#Executing Sqoop Commands if all arguments are correct
	print ("The total numbers of args passed to the script: %d " % total)
	subprocess.call(["sqoop", "import", "--connect",sys.argv[1],"--username",sys.argv[2],"--password",sys.argv[3],"--table",sys.argv[4],"--m","1"])
	#sqoop import --connect jdbc:mysql://localhost/databasename --username $USER_NAME --password $PASSWORD$ --table tablename --m 1
