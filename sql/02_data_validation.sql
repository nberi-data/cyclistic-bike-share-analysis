-- 01. Check total number of rows in the combined table for data accuracy

SELECT COUNT(*) AS total_rows
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`;

/*
FINDINGS: The combined trips table contains a total of 5,552,994 rows.
This matches the sum of all the individual monthly tables from 2025-01 to 2025-12.
*/


-- 02. Check for NULL values across all columns to identify missing data

SELECT 
  COUNTIF(ride_id IS NULL) AS null_ride_id,
  COUNTIF(rideable_type IS NULL) AS null_rideable_type,
  COUNTIF(started_at IS NULL) AS null_started_at,
  COUNTIF(ended_at IS NULL) AS null_ended_at,
  COUNTIF(start_station_name IS NULL) AS null_start_station,
  COUNTIF(start_station_id IS NULL) AS null_start_station_id,
  COUNTIF(end_station_name IS NULL) AS null_end_station,
  COUNTIF(end_station_id IS NULL) AS null_end_station_id,
  COUNTIF(start_lat IS NULL) AS null_start_lat,
  COUNTIF(start_lng IS NULL) AS null_start_lng,
  COUNTIF(end_lat IS NULL) AS null_end_lat,
  COUNTIF(end_lng IS NULL) AS null_end_lng,
  COUNTIF(member_casual IS NULL) AS null_member_type
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`;

/* 
FINDINGS: No NULL values found in the following columns: ride_id, rideable_type, started_at, ended_at, and member_casual.
1,184,673 NULL values found in start_station_name and 1,243,305 NULL values in end_station_name. These NULL values likely represent
dockless e-bike trips and they will be retained for analysis based on rider type and trip duration.
5,535 NULL values found in end_lat and end_lng. These NULLS represent incomplete trip data and will be removed to ensure mapping accuracy.
*/


-- 03. Check for duplicate ride_id values

SELECT
  ride_id,
  COUNT(*) AS count
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`
GROUP BY ride_id
HAVING COUNT(*) > 1;

/* 
FINDINGS: No duplicate ride_id values were found. This confirms that each ride represnts a unique trip.
ride_id is the primary key for this dataset.
*/


-- 04. Identify distinct values in the rideable_type column

SELECT
  DISTINCT rideable_type
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`;

/*
FINDINGS: Two distinct bike types identified, 'electric_bike' and 'classic_bike'.
This confirms that rideable_type values are consistent and standardized across the dataset. 
 */


-- 05. Detect ride duration outliers

SELECT
  COUNTIF(TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1) AS invalid_short_trips,
  COUNTIF(TIMESTAMP_DIFF(ended_at, started_at, MINUTE) > 1440) AS invalid_long_trips
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`;

/*
FINDINGS: 147,401 rides have a duration of less than 1 minute. 
5,585 rides have a duration longer than 24 hours. These outliers likely represent system error, stolen bikes, or maintenance issues.
These rides will be excluded from the analysis to prevent skewed trip duration averages.
*/


-- 06. Identify potential maintenance or test stations

SELECT 
  start_station_name,
  COUNT(*) AS trip_count
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`
WHERE LOWER(start_station_name) LIKE '%test%'
  OR LOWER(start_station_name) LIKE '%repair%'
  OR LOWER(start_station_name) LIKE '%base%'
  OR LOWER(start_station_name) LIKE '%divvy%'
GROUP BY start_station_name
ORDER BY trip_count DESC;

/*
FINDINGS: No results returned.
*/


-- 07. Identify distinct values in the member_casual column

SELECT
  DISTINCT member_casual
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`;

/*
FINDINGS: Two distinct member types identified, 'member' and 'casual'.
This confirms that member type data is consistent and standardized across the dataset.
*/

