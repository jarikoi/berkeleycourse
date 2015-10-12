CREATE TABLE procedures
  STORED AS PARQUET
  AS
  select
  measureid, providerid, measurename, CAST(score AS FLOAT)
  from effective_care
  where score RLIKE '^[0-9]+\.*[0-9]*'
union all
  select measureid, providerid, measurename, CAST(score AS FLOAT)
  from readmissions
  where score RLIKE '^[0-9]+\.*[0-9]*'
