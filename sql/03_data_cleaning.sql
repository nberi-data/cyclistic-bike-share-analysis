-- 01. Create a new table with cleaned data and new time-based features

CREATE OR REPLACE TABLE `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025` AS
SELECT 
  ride_id,
  rideable_type,
  started_at,
  ended_at,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_minutes,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week,
  FORMAT_TIMESTAMP('%A', started_at) AS day_name,
  EXTRACT(MONTH FROM started_at) AS month,
  FORMAT_TIMESTAMP('%B', started_at) AS month_name,
  EXTRACT(HOUR FROM started_at) AS hour,
  start_station_name,
  start_station_id,
  end_station_name,
  end_station_id,
  start_lat,
  start_lng,
  end_lat,
  end_lng,
  member_casual
FROM `cyclistic-project-482009.trips_data_2025.combined_trips_2025`
WHERE 
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1
  AND TIMESTAMP_DIFF(ended_at, started_at, MINUTE) < 1440
  AND end_lat IS NOT NULL
  AND end_lng IS NOT NULL;


-- 02. Verify the total row count for the cleaned trips table

SELECT COUNT(*) AS total_rows_cleaned
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`;

/*
FINDINGS: The cleaned trips table contains a total of 5,399,849 rows.
A total of 153,145 rows were removed, filtering out trip duration outliers and missing GPS coordinates. 
*/


-- 03. Verify ride_length_minutes range after cleaning

SELECT
  MIN(ride_length_minutes) AS min_ride,
  MAX(ride_length_minutes) AS max_ride
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`;

/*
FINDINGS: All rides fall within the expected range after cleaning.
Minimum ride duration is 1 minute, maximum ride duration is 1439 minutes.
*/


-- 04. Verify that ride_id remains without duplicates

SELECT 
  COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_ride_id
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`;

/*
FINDINGS: No duplicates.
Each row represents a unique trip.
*/


-- 05. Check the character length of ride_id

SELECT
  LENGTH(ride_id) AS id_length,
  COUNT(*) AS id_count
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY id_length;

/*
FINDINGS: All ride_id values are 16 characters long. 
*/
