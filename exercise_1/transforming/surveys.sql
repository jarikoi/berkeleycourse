CREATE TABLE surveys
  STORED AS PARQUET
  AS
  SELECT
    providernumber AS providerid,
    CAST(hcahpsbasescore AS INT) AS base_score,
    CAST(hcahpsconsistencyscore AS INT)
  FROM surveys_responses
