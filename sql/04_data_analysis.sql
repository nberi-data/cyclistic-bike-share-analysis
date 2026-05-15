-- 01. Compare total number of rides and avarage ride duration between members and casual riders

SELECT
  member_casual,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY member_casual;


-- 02. Identify weekly trends to see which days have the most traffic for each group

SELECT 
  member_casual,
  day_of_week,
  day_name,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY member_casual, day_of_week, day_name
ORDER BY member_casual, day_of_week;


-- 03. Compare hourly ride patterns, pinpoint the rush hours for both groups

SELECT
  member_casual,
  hour,
  COUNT(*) AS total_rides
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY member_casual, hour
ORDER BY member_casual, hour;


-- 04. Compare seasonal ride patterns, determine how weather and holidays impact members vs. casual riders

SELECT
  member_casual,
  month,
  month_name,
  COUNT(*) AS total_rides
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY member_casual, month, month_name
ORDER BY member_casual, month;


-- 05. Identify bike type preference to check if one group has a stronger preference, which may influence marketing decisions

SELECT
  member_casual,
  rideable_type,
  COUNT(*) AS total_rides
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY member_casual, rideable_type;


-- 06. Average ride duration by hour and day of week, identifying when casual riders are most active

SELECT 
  member_casual,
  day_of_week,
  day_name,
  hour,
  COUNT(*) AS total_rides,
  ROUND(AVG(ride_length_minutes), 2) AS average_duration
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
GROUP BY member_casual, day_of_week, day_name, hour
ORDER BY member_casual, day_of_week, hour;


-- 07. Aggregating rides by start station location, which identifies high-traffic areas 

SELECT 
  start_station_name,
  member_casual,
  AVG(start_lat) AS lat, 
  AVG(start_lng) AS lng,
  COUNT(*) AS total_rides
FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name, member_casual;


-- 08. Compare round trip patterns between member types

WITH trip_coords AS (
  SELECT
    member_casual,
    ROUND(start_lat, 3) AS rounded_start_lat, -- rounding coordinates ensures no round trips are missed if coordinates differ slightly
    ROUND(start_lng, 3) AS rounded_start_lng,
    ROUND(end_lat, 3) AS rounded_end_lat,
    ROUND(end_lng, 3) AS rounded_end_lng
  FROM `cyclistic-project-482009.trips_data_2025.cleaned_trips_2025`
),
calculations AS (
  SELECT
    member_casual,
    COUNT(*) AS total_trips,
    COUNTIF(
      rounded_start_lat = rounded_end_lat AND
      rounded_start_lng = rounded_end_lng
    ) AS round_trips
  FROM trip_coords
  GROUP BY member_casual
)
SELECT
  member_casual,
  total_trips,
  round_trips,
  ROUND((round_trips/total_trips) * 100, 2) AS percent_round_trip
FROM calculations;