CREATE TABLE Web_Session_Log(DATETIME varchar(500), USERID varchar(500), SESSIONID varchar(500), PRODUCTID varchar(500), REFERERURL varchar(500)) 
row format delimited 
fields terminated by '\t' 
stored as textfile;

LOAD  DATA  INPATH  '/mnt/weblog.csv' OVERWRITE INTO             TABLE Web_Session_Log;

 INSERT OVERWRITE TABLE Web_Session_Log_ORC select * from                    Web_Session_Log;

SELECT DISTINCT SESSIONID,count(*) as count from Web_Session_Log_ORC GROUP BY SESSIONID ORDER BY count;

CREATE TABLE Web_Session_Log_Managed(DATETIME varchar(500), USERID varchar(500), SESSIONID varchar(500), PRODUCTID varchar(500), REFERERURL varchar(500)) 
row format delimited 
fields terminated by '\t' 
stored as textfile;

CREATE EXTERNAL TABLE IF NOT EXIST Web_Session_Log_External(DATETIME varchar(500), USERID varchar(500), SESSIONID varchar(500), PRODUCTID varchar(500), REFERERURL varchar(500)) 
row format delimited 
fields terminated by '\t' 
stored as textfile;

CREATE TABLE ORCFileFormatExample(
        DATETIME varchar(500), USERID varchar(500), SESSIONID varchar(500), PRODUCTID varchar(500), REFERERURL varchar(500))
    COMMENT 'This is the Web Session Log data'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY '\t'
    STORED AS ORC tblproperties ("orc.compress"="GLIB");

CREATE TABLE Web_Session_Log_Partitioned(
        DATETIME varchar(500), USERID varchar(500), SESSIONID varchar(500), PRODUCTID varchar(500), REFERERURL varchar(500))
    COMMENT 'This is the Twitter streaming data'
    PARTITIONED BY(DATETIME STRING)
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY '\t'
    STORED AS TEXTFILE;

    FROM Web_Session_Log
    INSERT OVERWRITE TABLE Web_Session_Log_Partitioned PARTITION                           (DATETIME="2014-01-02 00:00:06 GMT") SELECT * where                PRODUCTID='/product/MT65XF2YA' limit 100;

CREATE TABLE Web_Session_Log_Bucketing(ATETIME varchar(500), USERID varchar(500), SESSIONID varchar(500), PRODUCTID varchar(500), REFERERURL varchar(500))
    COMMENT 'This is the Web Session Log data'
    PARTITIONED BY( PRODUCTID STRING)
    CLUSTERED BY(USERID) INTO 2 BUCKETS
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY '\t'
    STORED AS TEXTFILE;

  set hive.enforce.bucketing = true; 

    FROM Web_Session_Log
    INSERT OVERWRITE TABLE Web_Session_Log_Bucketing PARTITION (PRODUCTID="/product/MT65XF2YA")    SELECT *       where PRODUCTID='/product/MT65XF2YA' limit 100;

