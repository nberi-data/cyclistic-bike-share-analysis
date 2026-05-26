# Cyclistic Bike-Share Analysis
## Project Overview
This case study analyzes Cyclistic rider behavior using real-world data from Divvy, Chicago's bike-share program. Using SQL and Tableau, the analysis compares casual riders and annual members to uncover insights that can support membership conversion strategies. This project was completed as part of the Google Data Analytics Professional Certificate. 
- **Tableau Public Dashboard:** [View Interactive Dashboard](https://public.tableau.com/app/profile/nicole.beri/viz/Cyclistic_Bike_Share_Analysis_17792397883410/MainDashboard)

## Business Task
Analyze historical trip data to identify key behavioral differences between casual riders and annual members. The objective is to provide actionable, data-driven insights and strategic recommendations that can be utilized to convert casual riders into annual members to maximize future growth and recurring revenue.

## Data
- **Data Source:** [Divvy Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)
- **Data Range:** 01/2025 - 12/2025
- The data has been made available by Motivate International Inc, under this [license](https://divvybikes.com/data-license-agreement)
  
## Tools & Skills Used
- **SQL:** Data Aggregation, Data Cleaning, Feature Engineering, Subqueries
- **Tableau:** Interactive Dashboard Design, Data Visualization, Calculated Fields, Geospatial Mapping, Dynamic Filtering

## Data Preparation
The 12 monthly CSV files were uploaded to Google BigQuery SQL and merged into a single master table using `UNION ALL` to create a complete trip dataset covering a full year of trip history for 2025.

View the data merging query here: [sql/01_data_merging.sql](sql/01_data_merging.sql).

## Data Validation 
Before cleaning the dataset, exploratory SQL queries were used to assess overall data quality and identify inconsistencies within the raw trip data. 

Validation checks included:
- Detecting null and missing values
- Checking for duplicate ride IDs
- Identifying ride duration outliers
- Detecting potential maintenance or test stations
- Evaluating incomplete coordinate records

View the exploratory analysis and quality check queries here: [sql/02_data_validation.sql](sql/02_data_validation.sql)

## Data Cleaning
A cleaned dataset table was created in BigQuery to prepare the dataset for visualization and analysis. 

Cleaning and transformation steps included:
- Removing rides with missing end coordinates
- Excluding rides with duration outliers (shorter than 1 minute and longer than 24 hours).
- Generating time-based analytical features:
    - Ride duration (minutes)
    - Day of week
    - Month
    - Hour
   
View the data cleaning and transformation queries here: [sql/03_data_cleaning.sql](sql/03_data_cleaning.sql)
