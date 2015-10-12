CREATE TABLE hospital
  STORED AS PARQUET
  AS
  SELECT providerid, hospitalname, state, hospitaltype, hospitalownership
  FROM hospital_base
