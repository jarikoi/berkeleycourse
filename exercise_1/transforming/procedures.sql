CREATE TABLE max_effective_care
  STORED AS PARQUET
  AS
    select measureid, MAX(CAST(score AS FLOAT)) as max_score
    from effective_care
    where score RLIKE '^[0-9]+\.*[0-9]*'
    group by measureid


CREATE TABLE procedures
  STORED AS PARQUET
  AS
  select
  m.measureid, m.providerid, m.measurename, CAST(m.score AS FLOAT) raw_score,
  CAST(m.score AS FLOAT)/x.max_score relative_score
  from effective_care m
  join max_effective_care x
  on m.measureid=x.measureid
  where score RLIKE '^[0-9]+\.*[0-9]*'
union all
select
  m.measureid, m.providerid, m.measurename, CAST(m.score AS FLOAT) raw_score,  1.0 - (CAST(m.score AS FLOAT)/x.max_score) relative_score
  from readmissions m
  join readmissions_max x
  on m.measureid=x.measureid
  where score RLIKE '^[0-9]+\.*[0-9]*'
