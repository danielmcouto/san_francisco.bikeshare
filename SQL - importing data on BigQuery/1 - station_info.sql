SELECT 
station_id,
name,
short_name,
region_id,
capacity,
has_kiosk,
lat,
lon,
station_geom

FROM `bigquery-public-data.san_francisco_bikeshare.bikeshare_station_info` 

ORDER BY CAST(trip_id AS int64)