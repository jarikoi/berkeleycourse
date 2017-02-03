#Answers to submissions Lab 10
This is not to be shared with students, rather it is a help for instructors.

## Submission 1
 Print only words with a length > 5 characters. Submit the pyspark code.

Example solution:
```
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
ssc = StreamingContext(sc, 1)
lines= ssc.textFileStream("file:///tmp/datastreams")
uclines = lines.filter(lambda x : len(x) > 5)
uclines.pprint()
ssc.start()
```
