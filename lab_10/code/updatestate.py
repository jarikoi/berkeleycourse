from pyspark import SparkContext
from pyspark.streaming import StreamingContext
sc = SparkContext(appName="PythonStreamingStatefulNetworkWordCount")
ssc = StreamingContext(sc, 1)
ssc.checkpoint("checkpoint")
def updateFunc(new_values, last_sum):
        return sum(new_values) + (last_sum or 0)
lines = ssc.socketTextStream("localhost", 9999)
#running_counts = lines.flatMap(lambda line: line.split(" "))\
#                          .map(lambda word: (word, 1))\
#                          .updateStateByKey(updateFunc)

# Splitting it up to make it easier to follow.
# running_counts get a special status.

l2 =lines.flatMap(lambda line: line.split(" "))
l3=l2.map(lambda word: (word, 1))
running_counts=l3.updateStateByKey(updateFunc)
running_counts.pprint()
ssc.start()
ssc.awaitTermination()
