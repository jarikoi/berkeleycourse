from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql.types import *
sc = SparkContext("local", "weblog app")
sqlContext = SQLContext(sc)
lines = sc.textFile('/tmp/weblog_lab.csv')
parts = lines.map(lambda l: l.split('\t'))
Web_Session_Log = parts.map(lambda p: (p[0], p[1],p[2], p[3],p[4]))
schemaString = 'DATETIME USERID SESSIONID PRODUCTID REFERERURL'
fields = [StructField(field_name, StringType(), True)
          for field_name in schemaString.split()]
schema = StructType(fields)
schemaWebData = sqlContext.createDataFrame(Web_Session_Log, schema)
schemaWebData.registerTempTable('web_session_log')
results = sqlContext.sql('SELECT * FROM web_session_log')
results.show()from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql.types import *
sc = SparkContext("local", "weblog app")
sqlContext = SQLContext(sc)
lines = sc.textFile('/tmp/weblog_lab.csv')
parts = lines.map(lambda l: l.split('\t'))
Web_Session_Log = parts.map(lambda p: (p[0], p[1],p[2], p[3],p[4]))
schemaString = 'DATETIME USERID SESSIONID PRODUCTID REFERERURL'
fields = [StructField(field_name, StringType(), True) 
          for field_name in schemaString.split()]
schema = StructType(fields)
schemaWebData = sqlContext.createDataFrame(Web_Session_Log, schema)
schemaWebData.registerTempTable('web_session_log')
results = sqlContext.sql('SELECT * FROM web_session_log')
results.show()
