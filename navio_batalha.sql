/*
Classe(classe, tipo, pais, numero_armas, caliber, deslocamento)
Navio(nome, classe, ano_lancto)
Batalha(nome, data)
Resultado(nome_batalha, nome_navio, result)
*/

CREATE TABLE classe (
classe varchar(30) NOT NULL,
tipo char(10),
pais varchar(30),
numero_armas int,
calibre int,
deslocamento int,
CONSTRAINT pk_classe PRIMARY KEY (classe)
);

CREATE TABLE navio (
nome varchar(30) NOT NULL,
classe varchar(30),
ano_lancto int,
CONSTRAINT pk_navio PRIMARY KEY (nome)
);

CREATE TABLE batalha (
nome varchar(30) NOT NULL,
data int,
CONSTRAINT pk_batalha PRIMARY KEY (nome)
);

CREATE TABLE resultado (
nome_navio varchar(30) NOT NULL,
nome_batalha varchar(30) NOT NULL,
result char(10),
CONSTRAINT pk_resultado PRIMARY KEY (nome_navio, nome_batalha)
);

INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Bismarck', 'bb', 'Alemanha',
8, 15, 42000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Iowa', 'bb', 'USA', 9, 16,
46000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Kongo', 'bc', 'Japão', 8, 14,
32000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Carolina do Norte', 'bb',
'USA', 9, 16, 37000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Renown', 'bc', 'Grã
Bretanha', 6, 15, 32000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Revenge', 'bb', 'Grã
Bretanha', 8, 15, 29000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Tennessee', 'bb', 'USA', 12,
14, 32000);
INSERT INTO classe (classe, tipo, pais, numero_armas, calibre, deslocamento) VALUES ('Yamato', 'bb', 'Japão', 9, 18,
65000);

INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Califórnia','Tennessee',1921);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Haruna','Kongo',1915);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Hiei','Kongo',1914);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Iowa','Iowa',1943);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Kirishima','Kongo',1915);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Kongo','Kongo',1913);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Missouri','Iowa',1944);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Musashi','Yamato',1942);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Nova Jersey','Iowa',1943);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Carolina do Norte','Carolina do Norte',1941);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Ramillies','Revenge',1917);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Renown','Renown',1916);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Repulse','Renown',1916);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Resolution','Revenge',1916);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Revenge','Revenge',1916);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Royal Oak','Revenge',1916);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Royal Sovereign','Revenge',1916);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Tennessee','Tennessee',1920);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Washington','Carolina do Norte',1941);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Wisconsin','Iowa',1944);
INSERT INTO navio (nome, classe, ano_lancto) VALUES ('Yamato','Iamato',1941);

INSERT INTO batalha (nome, data) VALUES ('North Atlantic', 1941);
INSERT INTO batalha (nome, data) VALUES ('Guadalcanal', 1942);
INSERT INTO batalha (nome, data) VALUES ('North Cape', 1943);
INSERT INTO batalha (nome, data) VALUES ('Surigao Strait', 1944);

INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Bismarck','North Atlantic','Afundado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Califórnia','Surigao Strait','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Duke of York','North Cape','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Fuso','Surigao Strait','Afundado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Hood','North Atlantic','Afundado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('King George V','North Atlantic','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Kirishima','Guadalcanal','Afundado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Prince of Wales','North Atlantic','Danificado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Rodney','North Atlantic','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Scharnhorst','North Cape','Afundado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('South Dakota','Guadalcanal','Danificado');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Tennessee','Surigao Strait','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Washington','Guadalcanal','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('West Virginia','Surigao Strait','Ok');
INSERT INTO resultado (nome_navio, nome_batalha, result) VALUES ('Yamashiro','Surigao Strait','Afundado');
