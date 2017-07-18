# MIDS W205 : Lab 9      
|                      |        |                     |                                                  |
|----------------------|--------|---------------------|--------------------------------------------------|
| *Lab*                | 9      | *Lab Title*         | Working with Graphs   |
| *Related Modules(s)* | 11     | *Goal*              | Introduction to Graph Analysis |
| *Last Updated*       | 7/18/2017 | *Expected Duration* | 90 minutes                                    |

## Introduction

In this module, we talked about both the analysis of graphs and the challenges in storing and retrieving them.  
In this lab, we’ll use Neo4J, a Graph Database to efficiently store and retrieve graph data, 
and perform some interesting analysis around superheroes.

## Step 1. Download and install Neo4J

Download and install neo4j community edition from http://neo4j.com/download.  Neo4J has both a professional paid edition and the community edition.  For this lab, please use the community edition.

Neo4J can be downloaded and run locally on Windows or Mac. For Windows or Mac, an GUI based installer is available, and most students find this to be the easiest way to install. Once installed you will use the installed GUI application to run it.

Neo4J can also be run on AWS using the UCB AMIs.  However, please be aware that the latest edition will require an upgrade to Java, which may break the other installs.  If you want to use AWS, you may want to consider launching a fresh instance just for Neo4J.  You will also need to open port 7474 in inbound firewall rules the AWS Security Profile (similar to what we did in lab 2). The Linux installation does not have a GUI based installer.  You must download a tarball, uncompress, and untar it, using the following commands or similar (note that the version number in the tarball file name will probably change): 
```
tar xvzf neo4j-community-3.1.2-unix.tar.gz
cd neo4j-community-3.1.2
bin/neo4j start
```

Neo4J can also be run locally on Linux.  The steps would be similar to the AWS instructions given above.

Once you get Neo4J installed, you will access it using a Web Browser.  Browse to http://localhost:7474/.  If you are running on AWS, then use http://ec2hostname:7474.  

The initial username will be neo4j and the initial password will be neo4j.  On the first login, it will prompt for a password change, and require you to change the password before you can use it.

If you have never used neo4J before, it is recommended that you follow:

Online Training: Introduction to Graph Databases with Neo4j 
https://neo4j.com/graphacademy/online-training/introduction-graph-databases/

## Step 2. Exploring Marvel Character Relationships

Now that you’re comfortable with neo4j, we’re going to use it to answer questions about the Marvel Comics Universe.  
First, we need to clean up our database and load the new data. 

1. Clear the graph 

  ```
  MATCH (n)
  OPTIONAL MATCH (n)-[r]-()
  DELETE n,r
  ```

2. Load the nodes 

    (note: as some students have pointed out, the dataset contains both heros and villians.  For the purposes of this lab, please assume all of them are heros and continue the lab.)

  ```
  LOAD CSV FROM "https://s3.amazonaws.com/ucbw205data/hero_nodes.csv" AS line
  MERGE (:Hero {name:line[0] , degree: toInt(line[1])})
  ```

3. Create an Index on Hero Names

  ```
  CREATE INDEX ON :Hero(name)
  ```

4. Load the edges

    (note: you may see a warning message that the CREATE UNIQUE is unsupported by the current version and that an older version has been used. For the purposes of this lab, please ignore this warning and continue the lab.)

  ```
  LOAD CSV FROM 
  " https://s3.amazonaws.com/ucbw205data/hero_edges.csv" AS line
  MATCH (u:Hero {name:line[0]})
  MATCH (v:Hero {name:line[1]})
  CREATE UNIQUE (u) -[:APPEARED { w: toInt(line[2])}]-> (v)
  ```

## Step 3. Query Patterns
1. Finding Characters By Name

    In this example, we find characters whose names start with "SPIDER"
  ```
  MATCH (spiderman:Hero)
  WHERE spiderman.name STARTS WITH "SPIDER"
  RETURN spiderman
  ```

2. Finding the shortest path between 2 characters

    In this example, we are finding the shortest path between "SPIDER_MAN/PETER PAR" and "WOLVERINE/LOGAN"
    
  ```
  MATCH p=(peter:Hero {name: 'SPIDER-MAN/PETER PAR'})-[:APPEARED*0..2]-(logan:Hero {name: 'WOLVERINE/LOGAN'})
  RETURN p, length(p)
  ORDER BY length(p)
  LIMIT 1
  ```

3. Finding and Counting Friends of Friends 

    In this example, we are finding friends of friends of "SPIDER-MAN/PETER PAR"
 
 (note: as some students have pointed out, the edges in this dataset are actually appearances rather than frienship links, and that heros and villians appear together. For the purposes of this lab, appearance links should be regarded as friends links.)
  ```
  MATCH (peter:Hero { name: 'SPIDER-MAN/PETER PAR' })-[:APPEARED*2..2]-(friend_of_friend)
  WHERE NOT (peter)-[:APPEARED]-(friend_of_friend)
  AND friend_of_friend.name <> 'SPIDER-MAN/PETER PAR'
  RETURN friend_of_friend.name, COUNT(*)
  ORDER BY COUNT(*) DESC , friend_of_friend.name
  ```

4. Finding Visualizing Connections Between Friends of Friends

    In this example, we are visualizing friends of friends of "SPIDER-MAN/PETER PAR" and limiting it to 20 results
  ```
  MATCH (peter:Hero { name: 'SPIDER-MAN/PETER PAR' })-[:APPEARED*2..2]-(friend_of_friend)
  WHERE NOT (peter)-[:APPEARED]-(friend_of_friend)
  AND friend_of_friend.name <> 'SPIDER-MAN/PETER PAR'
  RETURN friend_of_friend
  LIMIT 20
  ```

5. Finding Teammates 

    In this example, we are finding teammates of "IRON MAN/TONY STARK" and "THOR/DR. DONALD BLAK" and limiting it to 5 results
 
    (note: as some students have pointed out, the edges in this dataset are actually appearances rather than teammate links, and that heros and villians appear together.  For the purposes of this lab, appearance links should be regarded as teammate links.)
  ```
  MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
  RETURN other
  ORDER BY e.w DESC, f.w DESC
  LIMIT 5
  ```

## Step 4. Answering Questions
Modify the above templates to find answers to the following questions.  Submit these answers to your instructor as the deliverable for this assignment. 

1.	What is the shortest path between "DR. STRANGE/STEPHEN" and "DR. DOOM/VICTOR VON"?

    Please provide: the query, the Text side tab results of running the query, and the answer. 

2.	List the 5 shortest paths between "DR. STRANGE/STEPHEN" and "DR. DOOM/VICTOR VON".  

    Please provide: the query and the Text side tab results of running the query.  Only provide 5 even if there are ties 
    (hint: use the LIMIT 5 clause in the query).

3.	List 5 Friends of Friends of "COLOSSUS II/PETER RA" with the most connections.

    Please provide: the query and the Text side tab results of running the query.  Only provide 5 even if there are ties 
    (hint: use the LIMIT 5 clause in the query)

4.	Visualize 10 Friends of friends for "IRON MAN/TONY STARK".

    Please provide: the query and an image of the visualization. 
    (hint: use the LIMIT 10 clause in the query)

5.	Discover how the Avengers grew over time from 5 to 10.  (work in progress)



Find team members starting with 5 and incrementing to 10.  Who was added to the team?  Is the resulting graph ever not fully connected?



