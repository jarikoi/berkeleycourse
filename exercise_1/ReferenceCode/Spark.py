from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
Running SQL Queries Programmatically :
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
df = sqlContext.sql(“SELECT * FROM Web_Session_Log limit 10”)
Programmatically Specifying the Schema :
from pyspark.sql import *
sqlContext = SQLContext(sc)
lines = sc.textFile(“/mnt/weblog.csv”)
parts = lines.map(lambda l: l.split(“\t”))
Web_Session_Log = parts.map(lambda p: (p[0], p[1],p[2], p[3],p[4]))
schemaString = “DATETIME USERID SESSIONID PRODUCTID REFERERURL”
fields = [StructField(field_name, StringType(), True) for field_name in schemaString.split()]
schema = StructType(fields)
schemaPeople = sqlContext.createDataFrame(Web_Session_Log, schema)
schemaPeople.registerTempTable(“Web_Session_Log”)
results = sqlContext.sql(“SELECT USERID FROM Web_Session_Log”)
names = results.map(lambda p: “Name: ” + p.USERID)
for name in names.collect():
print name
