DROP TABLE IF EXISTS hospital_base;
DROP TABLE IF EXISTS effective_care;
DROP TABLE IF EXISTS readmissions;
DROP TABLE IF EXISTS surveys_responses;

CREATE EXTERNAL TABLE hospital_base (
  ProviderID String,
  HospitalName String,
  Address String,
  City String,
  State String,
  ZIPCode String,
  CountyName String,
  PhoneNumber String,
  HospitalType String,
  HospitalOwnership String,
  EmergencyServices String
  )
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

-- sample query
SELECT STATE, COUNT(*) FROM hospital_base GROUP BY STATE;

CREATE EXTERNAL TABLE effective_care (
  ProviderID String,
  HospitalName String,
  Address String,
  City String,
  State String,
  ZIPCode String,
  CountyName String,
  PhoneNumber String,
  Condition String,
  MeasureID String,
  MeasureName String,
  Score Int,
  Sample Int,
  Footnote String,
  MeasureStartDate String,
  MeasureEndDate String
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

select STATE, SUM(SCORE) FROM effective_care group by state;

CREATE EXTERNAL TABLE readmissions (
  ProviderID String,
  HospitalName String,
  Address String,
  City String,
  State String,
  ZIPCode String,
  CountyName String,
  PhoneNumber String,
  MeasureName String,
  MeasureID String,
  ComparedtoNational String,
  Denominator Int,
  Score Float,
  LowerEstimate Float,
  HigherEstimate Float,
  Footnote String,
  MeasureStartDate String,
  MeasureEndDate String
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

select STATE, SUM(SCORE) FROM readmissions group by state;


CREATE EXTERNAL TABLE surveys_responses (
  ProviderNumber String,
  HospitalName String,
  Address String,
  City String,
  State String,
  ZIPCode String,
  CountyName String,
  CommunicationwithNursesAchievementPoints String,
  CommunicationwithNursesImprovementPoints String,
  CommunicationwithNursesDimensionScore String,
  CommunicationwithDoctorsAchievementPoints String,
  CommunicationwithDoctorsImprovementPoints String,
  CommunicationwithDoctorsDimensionScore String,
  ResponsivenessofHospitalStaffAchievementPoints String,
  ResponsivenessofHospitalStaffImprovementPoints String,
  ResponsivenessofHospitalStaffDimensionScore String,
  PainManagementAchievementPoints String,
  PainManagementImprovementPoints String,
  PainManagementDimensionScore String,
  CommunicationaboutMedicinesAchievementPoints String,
  CommunicationaboutMedicinesImprovementPoints String,
  CommunicationaboutMedicinesDimensionScore String,
  CleanlinessandQuietnessofHospitalEnvironmentAchievementPoints String,
  CleanlinessandQuietnessofHospitalEnvironmentImprovementPoints String,
  CleanlinessandQuietnessofHospitalEnvironmentDimensionScore String,
  DischargeInformationAchievementPoints String,
  DischargeInformationImprovementPoints String,
  DischargeInformationDimensionScore String,
  OverallRatingofHospitalAchievementPoints String,
  OverallRatingofHospitalImprovementPoints String,
  OverallRatingofHospitalDimensionScore String,
  HCAHPSBaseScore Int,
  HCAHPSConsistencyScore Int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/surveys_responses';

select stddev(HCAHPSBaseScore) from surveys_responses;
