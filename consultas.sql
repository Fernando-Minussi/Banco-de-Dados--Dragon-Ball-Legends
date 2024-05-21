-- SCRIPTS TESTADOS NO POSTGRESQL (TANTO NO PGADMIN4 QUANTO NO DBFIDDLE.COM)
-- VISÕES FORAM FEITAS COM O OBJETIVO DE JUNTAR TABELAS E FACILITAR AS CONSULTAS

-- VISÃO TABELAS LOJA, VENDE_TICKET, VENDE_EQUIPAMENTO:

CREATE OR REPLACE VIEW LOJA_VENDA AS 
SELECT LOJA.*, 
VENDE_TICKET.id_ticket, VENDE_TICKET.quantidade_vendida,
VENDE_EQUIPAMENTO.id_equipamento, VENDE_EQUIPAMENTO.quantidade_vendida AS equipamento_vendido_quantidade 
FROM LOJA 
FULL JOIN VENDE_TICKET ON VENDE_TICKET.id_loja = LOJA.id_loja
FULL JOIN VENDE_EQUIPAMENTO ON VENDE_EQUIPAMENTO.id_loja = LOJA.id_loja

-- VISÃO TABELAS MISSÃO, EMITE_CRISTAL, EMITE_MOEDA: 

CREATE OR REPLACE VIEW MISSÃO_RECOMPENSAS AS
SELECT MISSÃO.*,
EMITE_CRISTAL.id_cristal, EMITE_CRISTAL.quantidade AS quantidade_cristal,
EMITE_MOEDA.id_moeda, EMITE_MOEDA.quantidade AS quantidade_moeda
FROM MISSÃO
FULL JOIN EMITE_CRISTAL ON EMITE_CRISTAL.id_missão = MISSÃO.id_missão
FULL JOIN EMITE_MOEDA ON EMITE_MOEDA.id_missão = MISSÃO.id_missão

-- VISÃO TABELAS BANNER, GASTA_CRISTAL, INVOCAÇÃO: 


CREATE OR REPLACE VIEW BANNER_GASTO_INVOCADO AS
SELECT BANNER.*,
CRISTAL_BANNER.id_cristal, CRISTAL_BANNER.cristal_gasto,
INVOCAÇÃO.id_personagem, INVOCAÇÃO.cristal_gasto AS quantidade_gasta_banner, INVOCAÇÃO.personagem, INVOCAÇÃO.data,INVOCAÇÃO.hora
FROM BANNER 
FULL JOIN CRISTAL_BANNER ON CRISTAL_BANNER.id_banner = BANNER.id_banner
FULL JOIN INVOCAÇÃO ON INVOCAÇÃO.id_banner = BANNER.id_banner


-- VISÃO TABELAS TIME, PERSONAGEM_TIME, PVP::

CREATE OR REPLACE VIEW TIME_PERSONAGENS_PVP AS
SELECT TIME.*,
PERSONAGEM_TIME.id_personagem, PERSONAGEM_TIME.nome AS nome_personagem, PERSONAGEM_TIME.cor,
PVP.id_partida, PVP.resultado, PVP.data, PVP.oponente, PVP.time_jogador, PVP.time_oponente, PVP.pontuação,  PVP.ranque
FROM TIME
FULL JOIN PERSONAGEM_TIME ON PERSONAGEM_TIME.id_time = TIME.id_time
FULL JOIN PVP ON PVP.id_time = TIME.id_time


-- JOGADORES QUE GASTARAM NO MÍNIMO 8 MIL CRISTAIS EM UM BANNER:


SELECT jogador.nome AS nome_jogador, JOGADOR.id_conta, BANNER_GASTO_INVOCADO.id_personagem, BANNER_GASTO_INVOCADO.id_banner, CRISTAL.id_cristal, CRISTAL.quantidade AS quantidade_cristal, BANNER_GASTO_INVOCADO.nome AS nome_banner,BANNER_GASTO_INVOCADO.personagem, BANNER_GASTO_INVOCADO.data, BANNER_GASTO_INVOCADO.hora, BANNER_GASTO_INVOCADO.cristal_gasto
FROM BANNER_GASTO_INVOCADO 
FULL JOIN CRISTAL ON BANNER_GASTO_INVOCADO.id_cristal = CRISTAL.id_cristal
FULL JOIN JOGADOR ON CRISTAl.id_conta = JOGADOR.id_conta
GROUP BY JOGADOR.id_conta, BANNER_GASTO_INVOCADO.id_personagem, CRISTAL.id_cristal, BANNER_GASTO_INVOCADO.id_banner, BANNER_GASTO_INVOCADO.nome, BANNER_GASTO_INVOCADO.personagem, BANNER_GASTO_INVOCADO.data, BANNER_GASTO_INVOCADO.hora,  BANNER_GASTO_INVOCADO.cristal_gasto
HAVING MIN(cristal_gasto) > 8000



-- PERSONAGENS DOS JOGADORES QUE POSSUEM UM NÍVEL MAIOR QUE 400

SELECT JOGADOR.id_conta, PERSONAGEM.id_personagem, JOGADOR.nome AS nome_jogador, PERSONAGEM.nome AS nome_personagem, CATEGORIA.nome AS categoria
FROM JOGADOR 
FULL JOIN PERSONAGEM ON PERSONAGEM.id_conta = JOGADOR.id_conta
FULL JOIN CATEGORIA ON CATEGORIA.id_personagem = PERSONAGEM.id_personagem
GROUP BY JOGADOR.id_conta, JOGADOR.nome, PERSONAGEM.id_personagem, JOGADOR.nome, PERSONAGEM.nome , CATEGORIA.nome 
HAVING MIN(JOGADOR.nivel) > 400
ORDER BY nome_jogador


-- PERSONAGENS QUE POSSUEM  3 EQUIPAMENTOS EQUIPADOS

SELECT PERSONAGEM.id_personagem, EQUIPAMENTO.id_equipamento, PERSONAGEM.nome AS nome_personagem, EQUIPAMENTO.nome AS nome, PERSONAGEM.equipamento_1, PERSONAGEM.equipamento_2, PERSONAGEM.equipamento_3
FROM PERSONAGEM 
FULL JOIN EQUIPA_PERSONAGEM ON EQUIPA_PERSONAGEM.id_personagem = PERSONAGEM.id_personagem
FULL JOIN EQUIPAMENTO ON EQUIPAMENTO.id_equipamento = EQUIPA_PERSONAGEM.id_equipamento
WHERE PERSONAGEM.id_personagem IN (SELECT PERSONAGEM.id_personagem
			 
			 FROM PERSONAGEM
			 
			 WHERE PERSONAGEM.equipamento_1 IS NOT NULL AND PERSONAGEM.equipamento_2 IS NOT NULL AND PERSONAGEM.equipamento_3 IS NOT NULL		  
			 )
ORDER BY PERSONAGEM.id_personagem


-- CATEGORIAS DOS PERSONAGENS QUE SÃO DA RARIDADE EXTREME, QUE NÃO SÃO DE EVENTO E QUE POSSUEM ZENKAI

SELECT PERSONAGEM.id_personagem, PERSONAGEM.nome AS personagem, CATEGORIA.nome AS categoria, ZENKAI.nível AS nível_zenkai
FROM PERSONAGEM 
JOIN CATEGORIA ON CATEGORIA.id_personagem = PERSONAGEM.id_personagem
JOIN ZENKAI ON ZENKAI.id_personagem = PERSONAGEM.id_personagem
WHERE EXISTS (SELECT PERSONAGEM.id_personagem, PERSONAGEM.categoria_evento
			 FROM PERSONAGEM
			 WHERE PERSONAGEM.categoria_evento = 'False' AND PERSONAGEM.raridade = 'Extreme')



-- EVENTOS QUE POSSUEM UM INIMIGO MAJIN BUU E QUE PODEM OU NÃO TER UMA MISSÃO ASSOCIADA E SUAS RECOMPENSAS.

SELECT EVENTO.id_personagem, EVENTO.id_evento, COMPLETA_MISSÃO.id_missão, EVENTO.inimigo, MISSÃO_RECOMPENSAS.ação, EVENTO.tipo, MISSÃO_RECOMPENSAS.quantidade_moeda, MISSÃO_RECOMPENSAS.quantidade_cristal
FROM MISSÃO_RECOMPENSAS
FULL JOIN COMPLETA_MISSÃO ON COMPLETA_MISSÃO.id_missão = MISSÃO_RECOMPENSAS.id_missão
FULL JOIN EVENTO ON EVENTO.id_evento = COMPLETA_MISSÃO.id_evento
WHERE EVENTO.inimigo = 'Majin Buu' OR EVENTO.inimigo = 'Majin Buu (Gohan Absorvido)'

-- PERSONAGENS QUE PARTICIPARAM DE UM TIME, QUE POSSUEM ZENKAI E QUE VENCERAM, ALÉM DE POSSUIREM UMA CATEGORIA “ANDROIDE’

SELECT time_personagens_pvp.id_time, time_personagens_pvp.id_personagem, time_personagens_pvp.id_partida, ZENKAI.id_zenkai, time_personagens_pvp.resultado, time_personagens_pvp.nome_personagem, time_personagens_pvp.time_jogador, CATEGORIA.nome AS categoria, ZENKAI.nível
FROM time_personagens_pvp
JOIN ZENKAI ON ZENKAI.id_personagem = time_personagens_pvp.id_personagem
JOIN CATEGORIA ON CATEGORIA.id_personagem = time_personagens_pvp.id_personagem
WHERE time_personagens_pvp.resultado = 'Vitória' AND CATEGORIA.nome = 'Androide'

-- BANNERS QUE TIVERAM UMA QUANTIDADE VENDIDA DE TICKETS MENOR QUE 10, ALÉM DAS INFORMAÇÕES SOBRE NOME DO TICKET, NOME DO BANNER E O NÚMERO DE QUANTIDADE VENDIDA.

SELECT loja_venda.id_ticket, BANNER.id_banner, BANNER.nome AS banner, TICKET.nome AS ticket, loja_venda.quantidade_vendida
FROM loja_venda
JOIN TICKET ON TICKET.id_ticket = loja_venda.id_ticket
JOIN BANNER ON TICKET.id_banner = BANNER.id_banner
GROUP BY loja_venda.id_ticket, BANNER.id_banner, BANNER.nome, TICKET.nome, loja_venda.quantidade_vendida
HAVING  MAX(loja_venda.quantidade_vendida) < 10

-- Tickes que tiveram um número de vendas maior que 5

SELECT MOEDA.id_moeda, LOJA.id_loja, TICKET.id_ticket, TICKET.nome AS ticket, MOEDA.nome AS moeda, vende_ticket.quantidade_vendida, GASTA_MOEDA.quantidade_usada
FROM MOEDA 
JOIN GASTA_MOEDA ON MOEDA.id_moeda = GASTA_MOEDA.id_moeda
JOIN LOJA ON LOJA.id_loja = GASTA_MOEDA.id_loja
JOIN vende_ticket ON vende_ticket.id_loja = loja.id_loja
JOIN TICKET ON vende_ticket.id_ticket = TICKET.id_ticket
WHERE vende_ticket.quantidade_vendida >= 5


-- Times que possuem personagens que usam o equipamento 'Irrepressible Power'
SELECT PERSONAGEM.id_personagem, PERSONAGEM.nome AS personagem, CATEGORIA.nome AS categoria, time_personagens_pvp.nome AS time, time_personagens_pvp.id_partida
FROM PERSONAGEM 
JOIN CATEGORIA ON CATEGORIA.id_personagem = PERSONAGEM.id_personagem
JOIN time_personagens_pvp ON PERSONAGEM.id_personagem = time_personagens_pvp.id_personagem
WHERE PERSONAGEM.id_personagem IN (SELECT PERSONAGEM.id_personagem 
									  FROM PERSONAGEM JOIN EQUIPA_PERSONAGEM USING(id_personagem)
									  WHERE EQUIPA_PERSONAGEM.id_equipamento = 'ZXC589' )


-- Times que jogaram uma partida PVP e que possuem um persongem zenkai

SELECT  PERSONAGEM.id_personagem, PERSONAGEM.nome AS personagem, CATEGORIA.nome AS categoria, time_personagens_pvp.nome AS time, time_personagens_pvp.time_oponente, time_personagens_pvp.resultado,time_personagens_pvp.id_partida
FROM PERSONAGEM 
JOIN CATEGORIA ON CATEGORIA.id_personagem = PERSONAGEM.id_personagem
JOIN time_personagens_pvp ON PERSONAGEM.id_personagem = time_personagens_pvp.id_personagem
WHERE time_personagens_pvp.id_time IN (SELECT time_personagens_pvp.id_time 
									  FROM time_personagens_pvp JOIN ZENKAI USING(id_personagem)
									  WHERE ZENKAI.id_zenkai = '5436' OR ZENKAI.id_zenkai = '5865' OR ZENKAI.id_zenkai = '1236')
									  
ORDER BY time_personagens_pvp.nome