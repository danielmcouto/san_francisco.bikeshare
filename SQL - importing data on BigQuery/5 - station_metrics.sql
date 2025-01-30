WITH 
# Contando as viagens válidas em cada estação
trips AS (
  SELECT
    start_station_id,  --Seleciona o ID da estação
    AVG(idade) as mean_age_trip, -- média de idade nas estações (variável não utilizada)
    AVG(distance_trip) as mean_distance_trip, -- distância média das viagens em cada estação
    AVG(duration_min) as mean_duration_trip, -- duração média das viagens em cada estação
    COUNT(*) AS trip_count  -- Contando as viagens por estação
  FROM
    `Clean.join_table`
  WHERE
    member_gender IN ('Male', 'Female') -- Filtra a análise das estações apenas para o último período com maior quantidade de informações
  GROUP BY
    start_station_id -- Separando os valores por estação
),

## Adicionando a contagem de viagens nas informações das estações
join_trips_stations AS (
  SELECT
    si.station_id, 
    si.name,
    si.region_id,
    si.capacity,
    si.has_kiosk,
    si.lat,
    si.lon,
    si.station_geom,
    jt.mean_age_trip,
    jt.mean_distance_trip,
    jt.mean_duration_trip,
    jt.trip_count  -- Adicionando a contagem das viagens
  FROM
    `Clean.station_info` AS si
  LEFT JOIN
    trips AS jt
  ON
    CAST(jt.start_station_id AS INT64) = CAST(si.station_id AS INT64)
)

## Selecionando esta última tabela e adicionando a informação de região a partir da tabela 'regions'
SELECT
  ts.*,
  r.name  -- nome da região
FROM
  join_trips_stations AS ts
LEFT JOIN
  `Clean.regions` AS r
ON
  CAST(ts.region_id AS INT64) = CAST(r.region_id AS INT64) --Cruzando as informações de region_id entre as tabelas
WHERE
  trip_count is NOT NULL -- Retirando as estações sem viagens realizadas da análise;