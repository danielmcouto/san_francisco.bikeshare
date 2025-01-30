WITH join_trips_stations AS (
  SELECT
    *
  
  FROM
    `Clean.trips` AS t
  
  LEFT JOIN
    `Clean.station_info` AS si
  
  ## mesclando tabelas de viagens e de informações das estações baseada no id das estações
  ON  
    TRIM(CAST(t.start_station_id AS STRING)) = TRIM(CAST(si.station_id AS STRING)) 

  ## só considera os dados do último período que possui mais informações para análises
  WHERE
    member_gender = 'Male' OR member_gender = 'Female'
)

SELECT
  subscriber_type,
  member_birth_year,
  member_gender,
  duration_sec,
  duration_min,
  start_date,
  start_station_name,
  start_station_id,
  capacity,
  has_kiosk,
  end_station_name,
  ST_DISTANCE(start_station_geom, end_station_geom) AS distance_trip, --distância de cada viagem em linha reta entre as estações
  ts.region_id AS tsregionid,
  r.region_id AS rregionid,
  r.name

FROM
  join_trips_stations AS ts

LEFT JOIN
  `Clean.regions` AS r

ON
  TRIM(CAST(ts.region_id AS STRING)) = TRIM(CAST(r.region_id AS STRING))
WHERE
  # Retira os dados em que a viagem retornou a mesma estação
  ST_DISTANCE(start_station_geom, end_station_geom) > 0
  # Retira os dados sem informações de região
  AND r.region_id IS NOT NULL  -- Adicionando a verificação para garantir que o region_id da tabela 'regions' não seja nulo;