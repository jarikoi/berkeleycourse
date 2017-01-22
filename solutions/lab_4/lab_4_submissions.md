#Answers to submissions Lab 4
This is not to be shared with students, rather it is a help for instructors.

## Submission 1
When you create the tuple remove the key from the value.

```
def retTuple(x):
  y=x.split(",")
  return (y[0], y[1:])
```

```
narcoticsCrimeTuples2 = narcoticsCrimes.map(retTuple)
```


## Submission 2

The python statement is:
```
results = sqlContext.sql('select count(*) from Web_Session_Log where refererurl= "http://www.ebay.com”')
```

The number of records should be: '3943'


## Submission 3
