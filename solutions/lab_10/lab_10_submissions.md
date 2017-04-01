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



## Submission 3
 *In a previous module in this class you learnt about streams, bustiness and kafka. Describe how you would solve a situation where (1) you have a very busty stream where you spark streaming process may not always be able to keep up with the data it receives, meaning it the time it takes to process takes longer than the batch interval. (2) Like other programs stream processing programs need to be updated. Describe the implications of updating this simple processing program. What side effects can it have? How could you potentially handle them?.*

 For a 100% grade the students have to show the understand the following:
 (1) If the processing time takes longer than the batch time jobs will be queued up and the queue will grow, we may even loose data. We can either add processing power so that the job time goes down. 

 (2) If you shut the program down for an update you will loose the data being streamed while the program is down. You could have Kafka recieve and buffer the data and have Spark Streaming retrieve it from a kafka topic. That way the Spark streaming program can catch up once is get restarted. If there are latency requirements this will not work. In that case you need to start the update program in parallel and then shutdown the old program. It comes down to what requirements you have on for example latency, loss of data.