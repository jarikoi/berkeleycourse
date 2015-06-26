#!/bin/sh
#create database 
create database if not exists labs;
#use database
use labs;
#create weblog_lab table in labs database
CREATE TABLE if not exists labs.weblog_lab(date TIMESTAMP,USERID VARCHAR(255),SESSIONID VARCHAR(255),PRODUCTID VARCHAR(255),REFERERURL VARCHAR(255));

#create userdata_lab table in labs database
CREATE TABLE if not exits labs.userdata_lab(date TIMESTAMP,userid VARCHAR(255),firstname VARCHAR(255),lastname VARCHAR(255),location varchar(255));