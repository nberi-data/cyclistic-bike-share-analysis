-- Combine all 2025 monthly tables into a single master table, containing data from 2025-01 to 2025-12
CREATE OR REPLACE TABLE `cyclistic-project-482009.trips_data_2025.combined_trips_2025` AS
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_01`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_02`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_03`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_04`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_05`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_06`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_07`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_08`
UNION ALL 
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_09`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_10`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_11`
UNION ALL
SELECT * FROM `cyclistic-project-482009.trips_data_2025.trips_2025_12`;

