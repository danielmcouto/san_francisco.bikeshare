SELECT 
  trip_id,
  bike_number,
  subscriber_type,
  member_birth_year,
  member_gender,
  duration_sec,
  ROUND(duration_sec/60, 2) as duration_min,
  start_date,
  start_station_name,
  start_station_id,
  start_station_geom,
  start_station_latitude,
  start_station_longitude, 
  end_station_name,
  end_station_id,
  end_station_geom,
  end_station_latitude,
  end_station_longitude

FROM 
`bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`