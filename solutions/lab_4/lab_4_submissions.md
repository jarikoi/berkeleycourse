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

```
narcoticsCrimeTuples2.first()
(u'10184515', [u'HY372204', u'08/06/2015 11:55:00 PM', u'033XX W DIVERSEY AVE', u'2027', u'NARCOTICS', u'POSS: CRACK', u'STREET', u'true', u'false', u'1412', u'014', u'35', u'22', u'18', u'1153440', u'1918377', u'2015', u'08/13/2015 12:57:42 PM', u'41.931870591', u'-87.711546895', u'"(41.931870591', u' -87.711546895)"'])
```


## Submission 2

The python statement is:
```
results = sqlContext.sql('select count(*) from Web_Session_Log where refererurl= "http://www.ebay.com”')
```

The number of records should be: `3943`


## Submission 3
