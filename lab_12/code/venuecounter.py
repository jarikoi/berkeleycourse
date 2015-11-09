from pyspark import SparkContext
from pyspark.streaming import StreamingContext
import json
sc = SparkContext("local[2]", "MyApp")
ssc = StreamingContext(sc, 10)
lines = ssc.socketTextStream("localhost", 9999)
jslines = lines.flatMap(lambda x: [ j['venue'] for j in json.loads('['+x+']') if 'venue' in j] )
lcnt=lines.count()
lcnt.pprint()
c=jslines.count()
c.pprint()
jslines.pprint()
ssc.start()
ssc.awaitTermination()
