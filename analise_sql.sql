 ---TESTE CIENTISTA DE DADOS JUNIOR | NAYARA VALEVSKII --- 
---RESPOSTAS DE 01 A 05 | TABELA DE CHAMADOS 1746 E A TABELA DE BAIRROS RJ ---

 ---1) Quantos chamados foram abertos NO dia 01/04/2023?--- 
 
 ---QUERY RESPOSTA---
SELECT
  COUNT(*) AS total_chamados
FROM
  `datario.administracao_servicos_publicos.chamado_1746`
WHERE
  data_inicio >= '2023-04-01'
  AND data_inicio < '2023-04-02'; 
  ---Resposta: Foram aberto 73 chamados em 01/04/2023--- 
  

---2) Qual o tipo de chamado que teve mais reclamações no dia 01/04/2023?--- 
  
---QUERY RESPOSTA---
SELECT
  tipo,
  COUNT(id_chamado) AS numero_de_reclamacoes
FROM
  `datario.administracao_servicos_publicos.chamado_1746`
WHERE
  data_inicio >= '2023-04-01'
  AND data_inicio < '2023-04-02'
GROUP BY
  tipo
ORDER BY
  numero_de_reclamacoes DESC
LIMIT
  1; 
---Resposta: Tipo Poluição Sonora com 24 ocorrências de chamados--- 


---3) Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?--- 

---QUERY RESPOSTA---
SELECT
  b.nome AS nome_bairro,
  COUNT(c.id_chamado) AS numero_de_chamados
FROM
  `datario.administracao_servicos_publicos.chamado_1746` c
JOIN
  `datario.dados_mestres.bairro` b
ON
  c.id_bairro = b.id_bairro
WHERE
  c.data_inicio >= '2023-04-01'
  AND c.data_inicio < '2023-04-02'
GROUP BY
  nome_bairro
ORDER BY
  numero_de_chamados DESC
LIMIT
  3; 
---Resposta: Bairros Engenho de Dentro com 8 chamados, Leblon com 6 chamados e Campo Grande com 6 chamados--- 


---4) Qual o nome da subprefeitura com mais chamados abertos nesse dia??--- 

---QUERY RESPOSTA---
SELECT
  b.subprefeitura,
  COUNT(c.id_chamado) AS numero_de_chamados
FROM
  `datario.administracao_servicos_publicos.chamado_1746` c
JOIN
  `datario.dados_mestres.bairro` b
ON
  c.id_bairro = b.id_bairro
WHERE
  c.data_inicio >= '2023-04-01'
  AND c.data_inicio < '2023-04-02'
GROUP BY
  b.subprefeitura
ORDER BY
  numero_de_chamados DESC
LIMIT
  1; 
---Resposta: Subprefeitura Zona Norte com 25 chamados--- 


---5) Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim,por que isso acontece??--- 
  
---QUERY RESPOSTA---
SELECT
  c.id_chamado,
  c.data_inicio,
  c.id_bairro,
  b.subprefeitura
FROM
  `datario.administracao_servicos_publicos.chamado_1746` c
LEFT JOIN
  `datario.dados_mestres.bairro` b
ON
  c.id_bairro = b.id_bairro
WHERE
  c.data_inicio >= '2023-04-01'
  AND c.data_inicio < '2023-04-02'
  AND (c.id_bairro IS NULL
    OR b.subprefeitura IS NULL); 
  ---Resposta: Alguns tipos de chamados,como os relacionados a ônibus,táxis ou BRT,podem ser associados a serviços que operam em múltiplas localidades ou em rotas específicas que não estão restritas a um único bairro. Portanto, pode não ser necessário associá-los a um bairro específico. 
  

---RESPOSTAS DE 06 A 10 | TABELA DE CHAMADOS 1746 E A TABELA DE OCUPAÇÃO HOTELEIRA G. EVENTOS RIO |PERTUBAÇÃO E SOSSEGO|--- 


---6) Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 ATÉ 31/12/2023 (incluindo extremidades)?--- 

---QUERY RESPOSTA---
SELECT
  COUNT(id_chamado) AS numero_de_chamados
FROM
  `datario.administracao_servicos_publicos.chamado_1746`
WHERE
  subtipo = 'Perturbação do sossego'
  AND data_inicio >= '2022-01-01'
  AND data_inicio < '2024-01-01'; 
---Resposta: Total de 42408 chamados com subtipo Pertubação e Sossego--- 


---7) Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon,Carnaval e Rock in Rio).--- 

---QUERY RESPOSTA---
SELECT
  c.*, e.evento
FROM
  `datario.administracao_servicos_publicos.chamado_1746` c
INNER JOIN
  `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` e
ON
  c.data_inicio >= e.data_inicial
  AND c.data_inicio < DATE_ADD(e.data_final, INTERVAL 1 DAY)
WHERE
  c.subtipo = 'Perturbação do sossego'
  AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio');

---Resposta: Total de 1212 chamados com subtipo Pertubação e Sossego,nos períodos do Reveillon,Carnaval e Rock in Rio, conforme as datas da tabela de eventos--- 


---8) Quantos chamados desse subtipo foram abertos em cada evento?--- 

---QUERY RESPOSTA---
SELECT
  e.evento,
  COUNT(c.data_inicio) AS total_chamados
FROM
  datario.administracao_servicos_publicos.chamado_1746 c
INNER JOIN
  datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos e
ON
  c.data_inicio >= e.data_inicial
  AND c.data_inicio < DATE_ADD(e.data_final, INTERVAL 1 DAY)
WHERE
  c.subtipo = 'Perturbação do sossego'
  AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
GROUP BY
  e.evento
ORDER BY
  total_chamados ASC;
---Resposta: Total de 834 chamados no evento Rock in Rio; Total de 241 chamados no evento Carnaval; Total de 137 chamados no evento Reveillon.

 
---9) Qual evento teve a maior média diária de chamados abertos desse subtipo?--- 

---QUERY RESPOSTA---  
SELECT 
    evento, 
    SUM(total_chamados) AS total_chamados,
    SUM(duracao_evento) AS total_dias_evento,
    ROUND(AVG(duracao_evento), 2) AS media_duracao_evento,
    ROUND(SUM(total_chamados) / SUM(duracao_evento), 2) AS media_diaria_chamados
FROM (
    SELECT 
        e.evento, 
        COUNT(c.id_chamado) AS total_chamados,
        DATE_DIFF(DATE_ADD(e.data_final, INTERVAL 1 DAY), e.data_inicial, DAY) AS duracao_evento
    FROM datario.administracao_servicos_publicos.chamado_1746 AS c
    INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS e
        ON c.data_inicio >= e.data_inicial
        AND c.data_inicio < DATE_ADD(e.data_final, INTERVAL 1 DAY)
    WHERE c.subtipo = 'Perturbação do sossego'
    GROUP BY e.evento, e.data_inicial, e.data_final
) AS eventos_chamados
GROUP BY evento
ORDER BY media_diaria_chamados DESC;
---Resposta: O evento com maior média diária foi o Rock in Rio, com uma média de 119,14 chamados.

  
---10) Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon,Carnaval e Rock IN Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 ATÉ 31/12/2023.--- 
  
---QUERY RESPOSTA---
WITH ChamadosPorEvento AS (
  SELECT
    e.evento,
    COUNT(c.id_chamado) AS total_chamados,
    DATE_DIFF(DATE_ADD(e.data_final, INTERVAL 1 DAY), e.data_inicial, DAY) AS duracao_evento
  FROM
    datario.administracao_servicos_publicos.chamado_1746 c
  JOIN
    datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos e
  ON
    c.data_inicio >= e.data_inicial
    AND c.data_inicio < DATE_ADD(e.data_final, INTERVAL 1 DAY)
  WHERE
    c.subtipo = 'Perturbação do sossego'
    AND e.evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
  GROUP BY
    e.evento, e.data_inicial, e.data_final
),
ChamadosTotal AS (
  SELECT
    COUNT(c.id_chamado) AS total_chamados,
    DATE_DIFF(DATE_ADD('2023-12-31', INTERVAL 1 DAY), '2022-01-01', DAY) AS duracao_periodo
  FROM
    datario.administracao_servicos_publicos.chamado_1746 c
  WHERE
    c.subtipo = 'Perturbação do sossego'
    AND c.data_inicio >= '2022-01-01'
    AND c.data_inicio < DATE_ADD('2023-12-31', INTERVAL 1 DAY)
)

SELECT
  evento,
  SUM(total_chamados) AS total_chamados,
  SUM(duracao_evento) AS total_dias_evento,
  ROUND(AVG(duracao_evento), 2) AS media_duracao_evento,
  ROUND(SUM(total_chamados) / SUM(duracao_evento), 2) AS media_diaria_chamados,
  (SELECT ROUND(SUM(total_chamados) / SUM(duracao_periodo), 2) FROM ChamadosTotal) AS media_diaria_periodo
FROM
  ChamadosPorEvento
GROUP BY
  evento
ORDER BY
  media_diaria_chamados;
---Resposta: A média diária de chamados por Pertubação e Sossego no período de 01/01/2022 a 31/12/2023 foi de 58,09 chamados; No evento Reveillon a média de chamados foi de 45,67, 21,38% menor que a média do período; No evento Carnaval a média de chamados foi de 60,25, 3,72% maior que a média do período; No evento Rock in Rio a média de chamados foi de 119,14, 105,09% maior que a média do período.