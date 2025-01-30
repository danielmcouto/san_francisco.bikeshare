# san_francisco.bikeshare
**Otimização de investimentos em aluguéis de bicicleta em SF (EUA)**
_A partir dos dados públicos de aluguéis de bicicleta em São Francisco foi possível indicar novos investimentos para a melhoria do sistema_

![Gemini_Generated_Image_uoj1druoj1druoj1](https://github.com/user-attachments/assets/43e68a06-2ac1-4df2-8f6a-309c26b866e8)

_Nome do Dataset:
- bigquery-public-data.san_francisco.bikeshare_trips

Outros Dataset relacionados:
- bigquery-public-data.san_francisco.bikeshare_stations_info
- bigquery-public-data.san_francisco.bikeshare_station_status
- bigquery-public-data.san_francisco.bikeshare_regions
- bigquery-public-data.san_francisco.bikeshare_trips_

**Ferramentas:** Looker Studio; SQL; Google Cloud; Google BigQuery.

**Dashboard:** https://lookerstudio.google.com/s/noS0cargGz0


**Limpeza e tratamento dos datasets**

- stations_info: Alguns dados do dataset stations_info continham dados nulos dos IDs de região mas que puderam ser recuperados a partir da coluna short_name que continham as iniciais das respectivas regiões (código ao lado);
- station_status (descartado): campo station_id estava codificado e seus valores não estavam compatíveis com os Ids das outras tabelas, impossibilitando suas conexões, e, portanto, foi excluída da análise. Nesta tabela há informações sobre a quantidade de bikes e docas disponíveis e desativadas. A conexão do campo station_id permitiria uma análise mais detalhada sobre quais investimentos fazer nas estações.
- regions: dataset sem erros, importado integralmente;
- trips: Foram importadas somente as colunas de interesse e somente linhas com viagens tiveram de duração maior do que 60 segundos. Muitas linhas haviam variáveis à respeito dos clientes (gênero, data de nascimento) com valores nulos, dados que foram inseridos somente a partir de determinado período.

Os datasets foram então únificados com a função JOIN no SQL, dentro do próprio Google BigQuery e então os dados foram analisados no Looker Studio.


**Análise temporal**

Ao todo foram realizadas quase 2 milhões de viagens e a quantidade de viagens oscilou em 3 períodos distintos:
- Ago/2013 a Set/2016: quantidade de viagens relativamente constante (média de 26.500 viagens);
- Out/2016 a Mar/2018: Período sem registros de viagens (inativo);
- Jun/2017 a Abr/2018: Período com crescimento de viagens (215%; média de 83.500 viagens) e que coincide também com uma melhor qualidade na coleta de dados, quando foram adicionadas informações como gênero e idade dos clientes.
- 
![Captura de tela 2025-01-27 153805](https://github.com/user-attachments/assets/c2a4aebc-dc5d-4504-a980-bd2931fa332f)


- Fórmulas utilizadas para os gráficos utilizando a dimensão start_date: COUNT(trip_id)/COUNT_DISTINCT(start_station_id); COUNT(trip_id)/COUNT_DISTINCT(bike_number);
- Nota-se que o crescimento de viagens esta associado ao aumento na quantidade de estações e bicicletas disponíveis. E na verdade ao avaliar o investimento em quantidade de estações e as viagens realizadas, houve um leve decréscimo de 12% nas viagens por estações disponíveis no último período (a partir de junho de 2017).
- Nos períodos ativos, há uma queda nas viagens nos meses de dezembro e pode ser um período interessante para realização de manutenções no sistema, diminuindo eventuais perdas.

![Captura de tela 2025-01-27 154540](https://github.com/user-attachments/assets/dc737643-7ce5-4c9a-ac37-43f9a3fcb113)


**Perfil do público**
- O publico que mais utilizou a bicicleta esteve entre 36 e 50 anos, essa faixa representa 50% das viagens. A distância média percorrido pelos clientes foi de 1639 metros, com desvio padrão de 981 metros;
- Não há uma relação entre a distância percorrida e a idade dos usuários.
- 
![Captura de tela 2025-01-27 160039](https://github.com/user-attachments/assets/8759e14e-f35c-47fa-8c2f-afcb2132d3bf)


- O uso entre os homens foi consideravelmente maior que entre as mulheres;
- A diferença entre a idade média de uso por homens e mulheres variou em apenas 2 anos;
- A faixa de idade que mais usa as bicicletas não parece alterar de acordo com o gênero.
- 
![Captura de tela 2025-01-27 160628](https://github.com/user-attachments/assets/b4af1c85-f460-4331-8e5d-adf274ade62e)


- A região com maior quantidade de viagens foi São Francisco, com mais de 600 mil viagens;
- A estação de maior uso por capacidade foi San Francisco Caltrain;
- O mapa abaixo mostra o uso das estações, de acordo com a quantidade de viagens e suas capacidades na região de São Francisco. Percebe-se que a região próxima da ponte localizada a Nordeste é a de maior uso e pode ser o alvo de novos investimentos para otimizar o sistema;
- A tabela na parte inferior esquerda permite a ordenação entre as estações de menor e maior uso, facilitando em maior detalhes decisões de investimentos nas estações.
- 
![Captura de tela 2025-01-27 162139](https://github.com/user-attachments/assets/fb1c9a3a-2a74-4733-a14a-8abf68f06d07)
