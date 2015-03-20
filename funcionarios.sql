-- Autor: André Milani
-- Site: http://www.novateceditora.com.br
--
-- Atenção: Criar um banco de dados e conectá-lo antes de executar este arquivo,
-- visando não misturar este conteúdo com outros bancos de dados.

CREATE TABLE TB_FUNCIONARIOS
(
  ID int PRIMARY KEY,
  NOME VARCHAR(64) NOT NULL,
  ESCOLARIDADE VARCHAR(32) NOT NULL,
  CARGO VARCHAR(48) NOT NULL,
  SALARIO FLOAT8 NOT NULL 
);

INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (1, 'André', 'Pós-Graduado', 'Analista de Negócios', 1000);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (2, 'Cláudio', 'Mestre', 'Analista de Sistemas', 2000);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (3, 'Luis', 'Graduado', 'Analista de Sistemas', 700);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (4, 'Alfredo', 'Pós-Graduado', 'Analista de BI', 2300);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (5, 'Augusto', 'Doutor', 'Administrador de Banco de Dados', 2600);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (6, 'Ricardo', 'Graduado', 'Analista de Sistemas', 1000);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (7, 'Thais', 'Graduado', 'Analista de Marketing', 1100);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (8, 'Pedro', 'Graduado', 'Programador', 900);
INSERT INTO TB_FUNCIONARIOS (ID, NOME, ESCOLARIDADE, CARGO, SALARIO) VALUES (9, 'Flávia', 'Mestre', 'Analista de Sistemas', 2300);

CREATE TABLE TB_CARGOS
(
  ID int PRIMARY KEY,
  CARGO VARCHAR(48) NOT NULL,
  DEPARTAMENTO VARCHAR(48) NOT NULL 
);

INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (1, 'Analista de Negócios', 'Tecnologia da Informação');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (2, 'Analista de Sistemas', 'Tecnologia da Informação');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (3, 'Analista de BI', 'Tecnologia da Informação');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (4, 'Administrador de Banco de Dados', 'Tecnologia da Informação');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (5, 'Analista de Marketing', 'Marketing');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (6, 'Programador', 'Tecnologia da Informação');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (7, 'Contador', 'Contabilidade');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (8, 'Administrador', 'Contabilidade');
INSERT INTO TB_CARGOS (ID, CARGO, DEPARTAMENTO) VALUES (9, 'Designer', 'Marketing');