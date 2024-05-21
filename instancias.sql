-- SCRIPT FEITO NO POSTGRESQL (TESTADO NO PGADMIN4 COMO TAMBÉM NO DBFIDDLE.COM)

DROP TABLE IF EXISTS VENDE_TICKET;
DROP TABLE IF EXISTS VENDE_EQUIPAMENTO;
DROP TABLE IF EXISTS EQUIPA_PERSONAGEM;
DROP TABLE IF EXISTS INVOCAÇÃO;
DROP TABLE IF EXISTS GASTA_MOEDA;
DROP TABLE IF EXISTS CRISTAL_BANNER;
DROP TABLE IF EXISTS EMITE_CRISTAL;
DROP TABLE IF EXISTS EMITE_MOEDA;
DROP TABLE IF EXISTS MISSÃO_PVP;
DROP TABLE IF EXISTS COMPLETA_MISSÃO;
DROP TABLE IF EXISTS PERSONAGEM_TIME;
DROP TABLE IF EXISTS ZENKAI;
DROP TABLE IF EXISTS TICKET;
DROP TABLE IF EXISTS MOEDA;
DROP TABLE IF EXISTS PERSONAGENS_BANNER;
DROP TABLE IF EXISTS CRISTAL;
DROP TABLE IF EXISTS PVP;
DROP TABLE IF EXISTS TIME;
DROP TABLE IF EXISTS MISSÃO;
DROP TABLE IF EXISTS EVENTO;
DROP TABLE IF EXISTS BANNER;
DROP TABLE IF EXISTS CATEGORIA;
DROP TABLE IF EXISTS EQUIPAMENTO;
DROP TABLE IF EXISTS PERSONAGEM;
DROP TABLE IF EXISTS LOJA;
DROP TABLE IF EXISTS JOGADOR;

-- Tabela: JOGADOR
CREATE TABLE JOGADOR (
    id_conta VARCHAR(25) NOT NULL,
    nome VARCHAR(100),
    nivel INT,
    dias_jogados INT,
    vitórias_pvp INT,
    personagens_obtidos INT,
    maior_pontuação INT,
    maior_ranque INT,
  
    PRIMARY KEY (id_conta)
);



-- Tabela: LOJA
CREATE TABLE LOJA (
    id_loja VARCHAR(25) NOT NULL,
    nome VARCHAR(100),
    preço_ticket INT,
    preço_equip INT,
    tipo VARCHAR(50),
  
    PRIMARY KEY (id_loja)

  
);  

-- Tabela: PERSONAGEM
CREATE TABLE PERSONAGEM (
    id_personagem VARCHAR(25) NOT NULL,
    id_conta VARCHAR(25) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    categoria_evento BOOLEAN DEFAULT FALSE,
    raridade VARCHAR(50) NOT NULL,
    estrela INT NOT NULL,
    saga VARCHAR(50) NOT NULL,
    cor VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    equipamento_1 VARCHAR(100),
    equipamento_2 VARCHAR(100),
    equipamento_3 VARCHAR(100),
    
    PRIMARY KEY (id_personagem),
    FOREIGN KEY (id_conta) REFERENCES JOGADOR              
);

-- Tabela: EQUIPAMENTO
CREATE TABLE EQUIPAMENTO (
    id_equipamento VARCHAR(25) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    requisito_categoria VARCHAR(100),
    requisito_saga VARCHAR(100),
    status VARCHAR(100),
  
    PRIMARY KEY (id_equipamento)
  
);


-- Tabela: CATEGORIA
CREATE TABLE CATEGORIA (
    id_personagem VARCHAR(25) NOT NULL,
    nome VARCHAR(100),
  
    PRIMARY KEY (id_personagem,nome),
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM
  
);
  
-- Tabela: BANNER
CREATE TABLE BANNER (
    id_banner VARCHAR(50) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    custo INT NOT NULL,
    ultra VARCHAR(50),
    LegendsLimited VARCHAR(50),
    sparking VARCHAR(50),
    extreme VARCHAR(50),
    hero VARCHAR(50),
    data_limite DATE NOT NULL,
    hora_limite TIME NOT NULL,
  
    PRIMARY KEY (id_banner)
    
);  

-- Tabela: EVENTO
CREATE TABLE EVENTO (
    id_evento VARCHAR(25) NOT NULL,
    id_personagem VARCHAR(25) NOT NULL,
    inimigo VARCHAR(100) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    recompensa VARCHAR(100) NOT NULL,
  
    PRIMARY KEY (id_evento),
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM
);



-- Tabela: MISSÃO
CREATE TABLE MISSÃO (
    id_missão VARCHAR(25),
    recompensa VARCHAR(100),
    ação VARCHAR(100),
    
    PRIMARY KEY (id_missão)
  
  
);
  
-- Tabela: TIME
CREATE TABLE TIME (
    id_time VARCHAR(25) NOT NULL,
    nome VARCHAR(100),
  
    PRIMARY KEY (id_time)
  	
);

-- Tabela: PVP
CREATE TABLE PVP (
    id_partida VARCHAR(25) NOT NULL,
    id_time VARCHAR(25) NOT NULL,
    resultado VARCHAR(50),
    data DATE,
    oponente VARCHAR(100),
    time_jogador VARCHAR(100),
    time_oponente VARCHAR(100),
    pontuação INT,
    ranque INT,
    
    PRIMARY KEY (id_partida),
    FOREIGN KEY (id_time) REFERENCES TIME
    
);

-- Tabela: CRISTAL
CREATE TABLE CRISTAL (
    id_cristal VARCHAR(50) NOT NULL,
    id_conta VARCHAR(50) NOT NULL,
    quantidade INT,
  
    PRIMARY KEY (id_cristal),
    FOREIGN KEY (id_conta) REFERENCES JOGADOR
  
);  

-- Tabela: PERSONAGENS_BANNER
CREATE TABLE PERSONAGENS_BANNER (
    id_banner VARCHAR(50) NOT NULL,
    id_personagem VARCHAR(50) NOT NULL,
    nome VARCHAR(100),
    raridade VARCHAR(50),
  
    PRIMARY KEY (id_banner, id_personagem),
    FOREIGN KEY (id_banner) REFERENCES BANNER,
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM
);




-- Tabela: MOEDA
CREATE TABLE MOEDA (
    id_moeda VARCHAR(25) NOT NULL,
    nome VARCHAR(100),
    quantidade INT,
  
    PRIMARY KEY (id_moeda)
    
);

-- Tabela: TICKET
CREATE TABLE TICKET (
    id_ticket VARCHAR(50) NOT NULL,
    id_banner VARCHAR(50) NOT NULL,
    nome VARCHAR(100),
    banner VARCHAR(100),
  
  	PRIMARY KEY (id_ticket),
    FOREIGN KEY (id_banner) REFERENCES BANNER
);



-- Tabela: ZENKAI
CREATE TABLE ZENKAI (
    id_zenkai VARCHAR(25) NOT NULL,
    id_personagem VARCHAR(25) NOT NULL,
    id_evento VARCHAR(25) NOT NULL,
    habilidade VARCHAR(100),
    nível INT,
    personagem_evento BOOLEAN DEFAULT FALSE,
  
    PRIMARY KEY (id_zenkai),
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM,
    FOREIGN KEY (id_evento) REFERENCES EVENTO
);

-- Tabela: PERSONAGEM_TIME
CREATE TABLE PERSONAGEM_TIME (
    id_time VARCHAR(25) NOT NULL,
    id_personagem VARCHAR(25) NOT NULL,
    nome VARCHAR(100),
    cor VARCHAR(50),
  
    PRIMARY KEY (id_time, id_personagem),
    FOREIGN KEY (id_time) REFERENCES TIME,
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM
);

-- Tabela: COMPLETA_MISSÃO
CREATE TABLE COMPLETA_MISSÃO (
    id_evento VARCHAR(25) NOT NULL,
    id_missão VARCHAR(25) NOT NULL,
    data DATE,
  
    PRIMARY KEY (id_evento, id_missão),
    FOREIGN KEY (id_evento) REFERENCES EVENTO,
    FOREIGN KEY (id_missão) REFERENCES MISSÃO
);

-- Tabela: MISSÃO_PVP
CREATE TABLE MISSÃO_PVP (
    id_missão VARCHAR(25) NOT NULL,
    id_partida VARCHAR(25) NOT NULL,
    data DATE,
  
    PRIMARY KEY (id_missão, id_partida),
    FOREIGN KEY (id_partida) REFERENCES PVP,
    FOREIGN KEY (id_missão) REFERENCES MISSÃO
    
);

-- Tabela: EMITE_MOEDA
CREATE TABLE EMITE_MOEDA (
    id_moeda VARCHAR(25) NOT NULL,
    id_missão VARCHAR(25) NOT NULL,
    quantidade INT,
  
    PRIMARY KEY (id_moeda, id_missão),
    FOREIGN KEY (id_moeda) REFERENCES MOEDA,
    FOREIGN KEY (id_missão) REFERENCES MISSÃO
);

-- Tabela: EMITE_CRISTAL
CREATE TABLE EMITE_CRISTAL (
    id_cristal VARCHAR(25) NOT NULL,
    id_missão VARCHAR(25) NOT NULL,
    quantidade INT,
  
    PRIMARY KEY (id_cristal, id_missão),
    FOREIGN KEY (id_cristal) REFERENCES CRISTAL,
    FOREIGN KEY (id_missão) REFERENCES MISSÃO
);

-- Tabela: CRISTAL_BANNER
CREATE TABLE CRISTAL_BANNER (
    id_cristal VARCHAR(25) NOT NULL,
    id_banner VARCHAR(25) NOT NULL,
    cristal_gasto INT,
  
    PRIMARY KEY (id_cristal, id_banner),
    FOREIGN KEY (id_cristal) REFERENCES CRISTAL,
    FOREIGN KEY (id_banner) REFERENCES BANNER
);

-- Tabela: GASTA_MOEDA
CREATE TABLE GASTA_MOEDA (
    id_moeda VARCHAR(25) NOT NULL,
    id_loja VARCHAR(25) NOT NULL,
    quantidade_usada INT,
    PRIMARY KEY (id_moeda, id_loja),
    FOREIGN KEY (id_moeda) REFERENCES MOEDA,
    FOREIGN KEY (id_loja) REFERENCES LOJA
);

-- Tabela: INVOCAÇÃO
CREATE TABLE INVOCAÇÃO (
    id_banner VARCHAR(25) NOT NULL,
    id_personagem VARCHAR(25) NOT NULL,
    data DATE,
    hora TIME,
    personagem VARCHAR(100),
    cristal_gasto INT,
    PRIMARY KEY (id_banner, id_personagem),
    FOREIGN KEY (id_banner) REFERENCES BANNER,
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM
);

-- Tabela: EQUIPA_PERSONAGEM
CREATE TABLE EQUIPA_PERSONAGEM (
    id_equipamento VARCHAR(25) NOT NULL,
    id_personagem VARCHAR(25) NOT NULL,
    quantidade_equipada INT,
    PRIMARY KEY (id_equipamento, id_personagem),
    FOREIGN KEY (id_equipamento) REFERENCES EQUIPAMENTO,
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM
);

-- Tabela: VENDE_EQUIPAMENTO
CREATE TABLE VENDE_EQUIPAMENTO (
    id_loja VARCHAR(25) NOT NULL,
    id_equipamento VARCHAR(25) NOT NULL,
    quantidade_vendida INT,
    PRIMARY KEY (id_loja, id_equipamento),
    FOREIGN KEY (id_loja) REFERENCES LOJA,
    FOREIGN KEY (id_equipamento) REFERENCES EQUIPAMENTO
);

-- Tabela: VENDE_TICKET
CREATE TABLE VENDE_TICKET (
    id_loja VARCHAR(25) NOT NULL,
    id_ticket VARCHAR(25) NOT NULL,
    quantidade_vendida INT,
    PRIMARY KEY (id_loja, id_ticket),
    FOREIGN KEY (id_loja) REFERENCES LOJA,
    FOREIGN KEY (id_ticket) REFERENCES TICKET
);


-- TABELA JOGADOR
INSERT INTO JOGADOR (id_conta, nome, nivel, dias_jogados, vitórias_pvp, personagens_obtidos, maior_pontuação, maior_ranque)
VALUES ('08518588700', 'Fbl', 568, 1607, 11818, 532, 24072, 70),
       ('08186327796', 'Pudim_123', 25, 10, 30, 12, 658, 15),
       ('09876543210', 'OvoFrito', 450, 1300, 9875, 20423, 1000, 70),
       ('02568741369', 'Boogs', 240, 50, 300, 6410, 12465, 62),
       ('04898762168', 'Dejayydant', 100, 30, 865, 100, 6124, 55);


-- TABELA LOJA
INSERT INTO LOJA (id_loja, nome, preço_ticket, preço_equip, tipo)
VALUES ('1234', 'Saiyajin orgulhoso', 50, NULL, 'Ticket'),
       ('3456', 'Eu Sou o Super Saiyajin Son Goku', 50, NULL, 'Ticket'),
       ('2568', 'Duelo de inverno', NULL, 100, 'Equipamento'),
       ('7956', 'Loja de equipamento', NULL, 100, 'Equipamento'),
       ('2578', 'Um Novo Poder', 50, NULL, 'Ticket');


-- TABELA PERSONAGEM
INSERT INTO PERSONAGEM (id_personagem, id_conta, nome, tipo, categoria_evento, raridade, estrela, saga, cor, status, equipamento_1, equipamento_2, equipamento_3)
VALUES ('DBL62-04S', '08518588700', 'Goku (Super Saiyajin)', 'Corpo a Corpo', FALSE, 'Legends Limited', 6, 'Saga Freeza (Z)', 'Azul', 'Vida: 2052863', NULL, NULL, NULL),
       ('DBL65-02S', '08518588700', 'Gohan (Ultimate)', 'Corpo a Corpo', FALSE, 'Legends Limited', 6, 'Saga de filmes', 'Vermelho', 'Vida: 2218771', NULL, NULL, NULL),
       ('DBL-EVT-76S', '08186327796', 'Piccolo (Exército Red Ribbon)', 'Suporte', TRUE, 'Sparking', 14, 'Saga de filmes', 'Roxo', 'Vida: 2075972', 'No Way', 'Frenzied Power', 'Irrepressible Power'),
       ('DBL-EVT-07S', '08186327796', 'Vegito', 'Defensivo', TRUE, 'Sparking', 14, 'Saga Majin Buu (Z)', 'Vermelho', 'Vida: 2747020', 'i Will Show You', 'Blast It', NULL),
       ('DBL49-01U', '09876543210', 'Super Vegito', 'Defensivo', FALSE, 'Ultra', 10, 'Saga Majin Buu  (Z)', 'Amarelo', 'Vida: 2253656', NULL, NULL, NULL),
       ('DBL42-01U', '09876543210', 'Super Gogeta', 'Corpo a Corpo', FALSE, 'Ultra', 5, 'Saga de filmes', 'Azul', 'Vida: 2166538', 'Haa!', NULL, NULL),
       ('DBL03-08E', '02568741369', 'Cell (Primeira Forma)', 'Suporte', FALSE, 'Extreme', 14, 'Saga Cell (Z)', 'Amarelo', 'Vida: 1854411', NULL, NULL, NULL),
       ('DBL07-02E', '02568741369', 'Vegeta (Super Saiyajin)', 'Longa Distância', FALSE, 'Extreme', 14, 'Saga Majin Buu (Z)', 'Roxo', 'Vida: 356879', 'Blast It', 'You Cant Win', 'Start of the Battle'),
       ('DBL01-24H', '04898762168', 'Freeza (Primeira Forma)', 'Defensivo', FALSE, 'Hero', 7, 'Saga Freeza (Z)', 'Verde', 'Vida: 300426', NULL, NULL, NULL),
       ('DBL01-23H', '04898762168', 'Saibamen', 'Suporte', FALSE, 'Hero', 7, 'Saga Saiyajin (Z)', 'Amarelo', 'Vida: 30585 ', NULL, NULL, NULL),
       ('DBL-EVT-24U', '02568741369', 'Vegeta', 'Longa Distância', TRUE, 'Ultra', 12, 'Saga Freeza (Z)', 'Roxo', 'Vida: 24100', 'Haa!', NULL, NULL),
       ('DBL-EVT-01U', '08518588700', 'Androide 18', 'Corpo a Corpo', TRUE, 'Sparking', 14, 'Saga Androide (Z)', 'Verde', 'Vida: 23659', NULL, NULL, NULL),
       ('DBL44-02S', '08518588700', 'Bills', 'Corpo a Corpo', FALSE, 'Sparking', 4, 'Saga da Sobrevivência dos Universos (S)', 'Azul', 'Vida: 1756368', 'Irrepressible Power', NULL, NULL),
       ('DBL47-01S', '08518588700', 'Goku (Instinto Superior)', 'Corpo a Corpo', FALSE, 'Legends Limited', 11, 'Saga da Sobrevivência dos Universos (S)', 'Vermelho', 'Vida: 1756368', 'Irrepressible Power', 'A New Instinct', NULL);

-- TABELA CATEGORIA
INSERT INTO CATEGORIA (id_personagem, nome)
VALUES ('DBL62-04S', 'Saiyajin'),
 	   ('DBL62-04S', 'Super Saiyajin'),
       ('DBL62-04S', 'Família do Goku'),
       ('DBL49-01U', 'Saiyajin'),
       ('DBL49-01U', 'Super Saiyajin'),
       ('DBL49-01U', 'Guerreiro de Fusão'),
       ('DBL03-08E', 'Regeneração'),
       ('DBL03-08E', 'Androide'),
       ('DBL01-24H', 'Linhagem do Mal'),
       ('DBL01-24H', 'Forças do Freeza'),
       ('DBL-EVT-07S', 'Guerreiro de Fusão'),
       ('DBL-EVT-07S', 'Saiyajin'),
       ('DBL65-02S', 'Saiyajin Híbrido'),
       ('DBL65-02S', 'Família do Goku'),
       ('DBL-EVT-01U', 'Androide'),
       ('DBL07-02E', 'Saiyajin'),
       ('DBL07-02E', 'Super Saiyajin'),
       ('DBL07-02E', 'Família do Vegeta'),
       ('DBL42-01U', 'Guerreiro de Fusão'),
       ('DBL42-01U', 'Saiyajin'),
       ('DBL42-01U', 'Super Saiyajin'),
       ('DBL-EVT-76S', 'Regeneração'),
       ('DBL44-02S', 'Energia Divina'),
       ('DBL47-01S', 'Saiyajin'),
       ('DBL47-01S', 'Família do Goku'),
       ('DBL47-01S', 'Energia Divina'),
       ('DBL01-23H', 'Regeneração');

-- TABELA EQUIPAMENTO
INSERT INTO EQUIPAMENTO (id_equipamento, nome, requisito_categoria, requisito_saga, status)
VALUES ('ABC123', 'A New Instinct', 'Universe Rep', NULL, 'Ataque Energia +33.45%'),
       ('LER467', 'You Cant Win', 'Saiyajin', NULL, 'Ataque Corpo a Corpo +32.99%'),
       ('FOR567', 'A Frenzied Power', NULL, 'Saga de Filmes', 'Vida +8.30%'),
 	   ('IDA789', 'Finally Time to Go Wild', 'Saiyajin', 'Saga de Filmes', 'Defesa de Energia +18.25$'),
	   ('LOL365', 'No Way', NULL, 'Saga de Filmes', 'Vida +9.80%'),
       ('GOL789', 'i Will Show You', 'Guerreiro de Fusão', NULL, 'Ataque Corpo a Corpo + 10.00%'),
       ('FAZ896', 'Haa!', NULL, 'Saga de Filmes', 'Defesa Corpo a Corpo + 15.35%'),
       ('VIP168', 'Start of the Battle', 'Saiyajin', NULL, 'Defesa de Energia + 23.45%'),
       ('CAI519', 'Blast It', 'Saiyajin', NULL, 'Ataque Corpo a Corpo + 20.00%'),
 	   ('ZXC589', 'Irrepressible Power', 'Energia Divina', NULL, 'Vida +8.00%');

-- TABELA BANNER
INSERT INTO BANNER (id_banner, nome, custo, ultra, LegendsLimited, sparking, extreme, hero, data_limite, hora_limite)
VALUES ('12345678', 'Um Novo Poder', 500, NULL , '0.5%', '1%', '0.5%', '1%', '2024-01-17', '15:00:00'),
       ('87654321', 'Eu Sou o Super Saiyajin Son Goku', 500, NULL, '0.5%', '1%', '0.5%', '1%', '2023-09-27', '15:00:00'),
       ('45638792', 'Me Chame de Super Vegito', 1000, '0.35%', '0.5%', '1%',  '0.5%', '1%', '2023-01-18', '15:00:00'),
       ('36874105', 'Fusão Renascida', 1000, '0.35%', '0.5%', '1%', '0.5%','1%', '2022-12-30', '15:00:00'),
       ('96876325', 'Saiyajin Orgulhoso', 500, NULL, '0.5%', '1%', '0.5%', '1%', '2024-03-06', '15:00:00');
  

-- TABELA EVENTO
INSERT INTO EVENTO (id_evento, id_personagem, inimigo, nome, tipo, recompensa)
VALUES ('A123', 'DBL-EVT-76S', 'Cell', 'Batalha Feroz Piccolo (Exército Red Ribbon)', 'Recomendado', 'Piccolo (Exército Red Ribbon)'),
       ('B321', 'DBL-EVT-07S', 'Majin Buu', 'Batalha Feroz Vegito', 'Recomendado', 'Vegito'),
       ('B368', 'DBL-EVT-07S', 'Majin Buu (Gohan Absorvido)', 'ZENKAI Vegito', 'Recomendado', 'Vegito ZENKAI'),
       ('Z568', 'DBL-EVT-24U', 'Freeza', 'Vegeta Príncipe dos Saiyajins', 'Especial', 'Vegeta'),
       ('W698', 'DBL-EVT-01U', 'Vegeta', 'Batalha Feroz Androide 18', 'Recomendado', 'Androide 18'),
       ('A589', 'DBL03-08E', 'Piccolo', 'ZENKAI Cell (Primeira Forma)', 'Recomendado', 'Cell (Primeira Forma) ZENKAI'),
       ('B698', 'DBL07-02E', 'Janemba', 'ZENKAI Vegeta (Super Saiyajin)', 'Recomendado', 'Vegeta (Super Saiyajin) ZENKAI');


-- TABELA MISSÃO
INSERT INTO MISSÃO (id_missão, recompensa, ação)
VALUES ('1234', '100 Cristais', 'Derrotar 10 Gokus'),
       ('4321', '100 Moedas Episódio Saga Cell (Z)', 'Jogar um Evento Recomendado'),
       ('5987', '1000 Cristais', 'Ganhar 15 vezes no PVP'),
       ('4696', '100 Moedas Saiyajin Orgulhoso', 'Jogar com um personagem da Saga Freeza (Z)');

-- TABELA TIME
INSERT INTO TIME (id_time, nome)
VALUES ('ABC', 'Time Família Goku'),
       ('CDE', 'Time Androides'),
       ('FGR', 'Time Guerreiros de Fusão');


-- TABELA PVP
INSERT INTO PVP (id_partida, id_time, resultado, data, oponente, time_jogador, time_oponente, pontuação, ranque)
VALUES ('LA205', 'ABC', 'Vitória', '2024-01-02', 'Omelete', 'Time Saiyajin', 'Time Regeneração', 71, 52),
       ('FP987', 'ABC', 'Derrota', '2024-01-01', 'OvoCozido', 'Time Saiyajin', 'Time Regeneração', -63, 65),
       ('FR365', 'CDE', 'Vitória', '2023-12-31', 'PudimNinja', 'Time Androides', 'Time Guerreiro de Fusão', 62, 60),
       ('FR366', 'FGR', 'Derrota', '2024-02-10', 'OvoMexido', 'Time Família Goku', 'Time  Família Goku', -68, 70),
       ('FR367', 'FGR', 'Vitória', '2024-02-18', 'SuperPudim', 'Time Família Goku', 'Time Saiyajin', 70, 70);

-- TABELA CRISTAL
INSERT INTO CRISTAL (id_cristal, id_conta, quantidade)
VALUES ('568965', '08518588700', 7207),
       ('112569', '08186327796', 22342),
       ('226845', '09876543210', 3658),
       ('789546', '02568741369', 1000),
       ('896325', '04898762168', 2899);

-- TABELA PERSONAGENS_BANNER
INSERT INTO PERSONAGENS_BANNER (id_banner, id_personagem, nome, raridade)
VALUES ('87654321', 'DBL62-04S', 'Goku (Super Saiyajin)', 'Legends Limited'),
	   ('87654321', 'DBL47-01S', 'Goku (Instinto Superior)', 'Legends Limited'),
	   ('87654321', 'DBL44-02S', 'Bills', 'Sparking'),
       ('87654321', 'DBL03-08E', 'Cell (Primeira Forma)', 'Extreme'),
       ('87654321', 'DBL07-02E', 'Vegeta (Super Saiyajin)', 'Extreme'),
       ('45638792', 'DBL49-01U', 'Super Vegito', 'Ultra'),
       ('45638792', 'DBL65-02S', 'Gohan (Ultimate)', 'Legends Limited'),
       ('45638792', 'DBL01-23H', 'Saibamen', 'Hero'),
       ('45638792', 'DBL01-24H', 'Freeza (Primeira Forma)', 'Hero');
       

-- TABELA MOEDA
INSERT INTO MOEDA (id_moeda, nome, quantidade)
VALUES ('566546', 'Moeda Episódio Saga Cell (Z)', 684),
       ('669852', 'Moeda Saiyajin Orgulhoso', 30),
       ('562139', 'Moeda Um Novo Poder', 25),
       ('789354', 'Moeda Eu Sou o Super Saiyajin Son Goku', 14);

-- TABELA TICKET
INSERT INTO TICKET (id_ticket, id_banner, nome, banner)
VALUES ('A6D4', '12345678', 'Ticket Um Novo Poder', 'Um Novo Poder'),
       ('B5D2', '87654321', 'Ticket Eu Sou o Super Saiyajin Son Goku', 'Eu Sou o Super Saiyajin Son Goku'),
       ('C4F5', '96876325', 'Ticket Um Saiyajin Orgulhoso', 'Um Saiyajin Orgulhoso');


-- TABELA ZENKAI
INSERT INTO ZENKAI (id_zenkai, id_personagem, id_evento, habilidade, nível, personagem_evento)
VALUES ('5436', 'DBL-EVT-07S', 'B368', 'Categoria "Guerreiro de Fusão" + 40% no Ataque Corpo a Corpo e de Energia', 7, TRUE),
       ('5865', 'DBL03-08E', 'A589', 'Categoria "Regeneração" + 20% na Defesa Corpo a Corpo e de Energia', 3, FALSE),
       ('1236', 'DBL07-02E', 'B698', NULL, 1, FALSE);

-- TABELA PERSONAGEM_TIME
INSERT INTO PERSONAGEM_TIME (id_time, id_personagem, nome, cor)
VALUES ('ABC', 'DBL62-04S', 'Goku (Super Saiyajin)', 'Azul'),
       ('ABC', 'DBL65-02S', 'Gohan (Ultimate)', 'Vermelho'),
	   ('ABC', 'DBL47-01S', 'Goku (Instinto Superior)', 'Vermelho'),
       ('CDE', 'DBL-EVT-01U', 'Androide 18', 'Verde'),
       ('CDE', 'DBL03-08E', 'Cell (Primeira Forma)', 'Amarelo'),
       ('FGR', 'DBL49-01U', 'Super Vegito', 'Amarelo'),
       ('FGR', 'DBL42-01U', 'Super Gogeta', 'Azul'),
	   ('FGR', 'DBL-EVT-07S', 'Vegito', 'Vermelho');


-- TABELA COMPLETA_MISSÃO
INSERT INTO COMPLETA_MISSÃO (id_evento, id_missão, data)
VALUES ('B321', '4321', '2024-02-05'),
       ('A123', '4321', '2024-01-10'),
       ('B368', '5987', '2024-01-12'),
       ('B368', '4321', '2024-02-15'),
       ('W698', '4696', '2023-12-01'),
       ('Z568', '4696', '2023-12-24'),
       ('Z568', '4321', '2024-01-05'),
       ('B698', '4321', '2023-12-05'),
       ('A589', '1234', '2024-02-06');


-- TABELA MISSÃO_PVP
INSERT INTO MISSÃO_PVP (id_missão, id_partida, data)
VALUES ('5987', 'FR365', '2024-02-09'),
       ('5987', 'FR366', '2024-02-15'),
       ('5987', 'FR367', '2024-02-10');

-- TABELA EMITE_MOEDA
INSERT INTO EMITE_MOEDA (id_moeda, id_missão, quantidade)
VALUES ('566546', '4321', 100),
       ('669852', '4696', 100);

-- TABELA EMITE_CRISTAL
INSERT INTO EMITE_CRISTAL (id_cristal, id_missão, quantidade)
VALUES ('226845', '5987', 1000),
       ('896325', '1234', 100);

-- TABELA CRISTAL_BANNER
INSERT INTO CRISTAL_BANNER (id_cristal, id_banner, cristal_gasto)
VALUES ('226845', '12345678', 10000),
       ('896325', '87654321', 3000),
       ('112569', '36874105', 20000);

-- TABELA GASTA_MOEDA
INSERT INTO GASTA_MOEDA (id_moeda, id_loja, quantidade_usada)
VALUES ('669852', '1234', 35),
       ('562139', '2578', 15),
       ('789354', '3456', 5);

-- TABELA INVOCAÇÃO
INSERT INTO INVOCAÇÃO (id_banner, id_personagem, data, hora, personagem, cristal_gasto)
VALUES ('87654321', 'DBL62-04S', '2024-01-02', '15:00:00', 'Goku (Super Saiyajin)', 10000),
       ('12345678', 'DBL65-02S', '2023-08-28', '15:00:00', 'Gohan (Ultimate)', 3000),
       ('36874105', 'DBL42-01U', '2022-12-16', '15:00:00', 'Super Gogeta', 20000);

-- TABELA EQUIPA_PERSONAGEM
INSERT INTO EQUIPA_PERSONAGEM (id_equipamento, id_personagem, quantidade_equipada)
VALUES ('FOR567', 'DBL-EVT-76S', 1),
       ('LOL365', 'DBL-EVT-07S', 1),
       ('VIP168', 'DBL07-02E', 1),
       ('CAI519', 'DBL07-02E', 1),
       ('LER467', 'DBL07-02E', 1),
       ('ABC123', 'DBL47-01S', 1),
       ('ZXC589', 'DBL47-01S', 1),
       ('ZXC589', 'DBL44-02S', 1),
       ('ZXC589', 'DBL-EVT-76S', 1);
       
  
-- TABELA VENDE_EQUIPAMENTO
INSERT INTO VENDE_EQUIPAMENTO (id_loja, id_equipamento, quantidade_vendida)
VALUES ('7956', 'LOL365', 10),
       ('7956', 'ZXC589', 5),
       ('2568', 'ABC123', 15);

-- TABELA VENDE_TICKET
INSERT INTO VENDE_TICKET (id_loja, id_ticket, quantidade_vendida)
VALUES ('2578', 'A6D4', 5),
       ('3456', 'B5D2', 1),
       ('1234', 'C4F5', 14);
