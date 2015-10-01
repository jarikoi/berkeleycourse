#! /bin/bash

#get the data
wget -O ./hospital.zip https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

#unzip the data
mkdir hospital_raw_data
mv hospital.zip hospital_raw_data
cd hospital_raw_data
unzip hospital.zip

#rename the files
tail -n +2 Hospital\ General\ Information.csv > hospitals.csv
tail -n +2 Timely\ and\ Effective\ Care\ -\ Hospital.csv > effective_care.csv
tail -n +2 Readmissions\ and\ Deaths\ -\ Hospital.csv > readmissions.csv
tail -n +2 hvbp_hcahps_05_28_2015.csv > surveys_responses.csv

#make the hdfs directory
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/surveys_responses
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses

#generate headers for ddl
head -n 1 Hospital\ General\ Information.csv > hospital_header.csv
head -n 1  Timely\ and\ Effective\ Care\ -\ Hospital.csv > effective_care_header.csv
head -n 1  Readmissions\ and\ Deaths\ -\ Hospital.csv > readmissions_header.csv
head -n 1  hvbp_hcahps_05_28_2015.csv > surveys_responses_header.csv
