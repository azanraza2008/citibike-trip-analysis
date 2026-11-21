-- Citi Bike Trip Analysis
-- Replace table names below with the actual BigQuery public dataset path,
-- e.g. `bigquery-public-data.new_york_citibike.citibike_trips`

-- 1. JOIN example: trip counts by start station, with station coordinates
SELECT
  t.start_station_name,
  s.latitude,
  s.longitude,
  COUNT(*) AS trip_count
FROM `project.dataset.citibike_trips` AS t
JOIN `project.dataset.citibike_stations` AS s
  ON t.start_station_id = s.station_id
GROUP BY t.start_station_name, s.latitude, s.longitude
ORDER BY trip_count DESC;

-- 2. Subquery example: stations with above-average trip volume
SELECT station_name, trip_count
FROM (
  SELECT start_station_name AS station_name, COUNT(*) AS trip_count
  FROM `project.dataset.citibike_trips`
  GROUP BY start_station_name
)
WHERE trip_count > (
  SELECT AVG(trip_count)
  FROM (
    SELECT COUNT(*) AS trip_count
    FROM `project.dataset.citibike_trips`
    GROUP BY start_station_name
  )
);

-- TODO: swap in your own queries from the course exercises,
-- and add a comment above each explaining what question it answers.
