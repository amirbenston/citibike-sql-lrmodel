select usaf
FROM `bigquery-public-data.noaa_gsod.stations`
WHERE name like "%LA GUARDIA%"