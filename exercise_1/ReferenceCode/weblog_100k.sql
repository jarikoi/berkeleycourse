create database if not exists exercise;
use exercise;
create table if not exists weblog_100k (date timestamp,userid string,sessionid string,productid string,refererurl string) row format delimited fields terminated by ',' location '/exercise' tblproperties ("skip.header.line.count"="1");