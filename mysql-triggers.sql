/* TRIGGERS */

/*
Trigger (gatilho) é um tipo especial de procedimento, associado a uma tabela, que é disparado automaticamente
por um evento de modificação de dados (INSERT, UPDATE, DELETE) na tabela associada.
Usos comuns de triggers:
-- Manter regras de integridade além de uma simples integridade referencial.
-- Implementar regras de negócio complexas no banco de dados.
-- Aplicar regras de segurança.
-- Manter registros de auditoria.
*/

/* 
A principal diferença entre um trigger e um store procedure é que um trigger é chamado automaticamente
quando um evento de modificação de dados ocorre em uma tabela, enquanto um stored procedure deve ser
chamado explicitamente.
*/

/*
Para um trigger, deve-se definir o evento e o sincronismo:
-- Evento: define a operação de manipulação de dados que causa o disparo.
   Valores possíveis: INSERT, UPDATE e DELETE.
-- Sincronismo: define o momento de disparo em relação ao evento.
   Valores possíveis: BEFORE (disparado antes do evento) e AFTER (disparado depois do evento).

Uma combinação de sincronismo e evento permite 6 tipos diferentes de triggers associados a uma mesma tabela:
BEFORE INSERT, AFTER INSERT, BEFORE UPDATE, AFTER UPDATE, BEFORE DELETE e AFTER DELETE.
*/

/*
Criação de Triggers:

CREATE TRIGGER nome_do_trigger trigger_sincronismo trigger_evento
 ON nome_da_tabela
 FOR EACH ROW
 BEGIN
 ...
 END
*/

/*
Exclusão de Triggers:
DROP TRIGGER nome_do_trigger;
*/

/*
Qualificadores OLD e NEW:
-- Permitem acesso aos valores das colunas que estão sendo manipuladas, indicando os valores anteriores e 
   posteriores à modificação, respectivamente.
-- Para o comando INSERT, NEW contém o valor que está sendo inserido e OLD não se aplica.
-- Para o comando DELETE, OLD contém o valor anterior à exclusão e NEW não se aplica.
-- Para o comando UPDATE, OLD contém o valor anterior à alteração e NEW, o valor após a alteração.
*/

/* Exemplos */

/*
Criar um trigger de auditoria de alterações de salários de funcionários.

Primeiro, crie a tabela de registros de auditoria:
*/

CREATE TABLE auditoriaSalario (
idAuditoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
idFunc INT NOT NULL,
nomeFunc VARCHAR(50) NOT NULL,
salarioAnterior DECIMAL(8,2) NOT NULL,
salarioNovo     DECIMAL(8,2) NOT NULL,
user VARCHAR(20) NOT NULL,
dataHora datetime NOT NULL
);

/*
Depois, crie um trigger que registra mudanças de salário na tabela Funcionario
*/

DROP TRIGGER after_Funcionario_update;

DELIMITER $$
CREATE TRIGGER after_Funcionario_update
AFTER UPDATE ON Funcionario
FOR EACH ROW
BEGIN
  IF OLD.Salario != NEW.Salario THEN
    INSERT INTO auditoriaSalario (idFunc, nomeFunc, salarioAnterior, salarioNovo, user, dataHora)
    VALUE (NEW.ID_Func, NEW.NomeFunc, OLD.Salario, NEW.Salario, USER(), NOW());
  END IF;
END $$
DELIMITER ;

/*
Agora, teste o trigger emitindo alterações (ou não) de salários
*/

SELECT ID_Func, NomeFunc, Salario
FROM Funcionario;

UPDATE Funcionario
SET Salario = 700
WHERE ID_Func = 1;

SELECT ID_Func, NomeFunc, Salario
FROM Funcionario;

SELECT * FROM auditoriaSalario;

-- -----------

UPDATE Funcionario
SET Salario = 700
WHERE ID_Func = 1;

SELECT ID_Func, NomeFunc, Salario
FROM Funcionario;

SELECT * FROM auditoriaSalario;

-- -----------

UPDATE Funcionario
SET Salario = Salario * 1.10;

SELECT ID_Func, NomeFunc, Salario
FROM Funcionario;

SELECT * FROM auditoriaSalario;

----------------------------------------------

/*
Criar um trigger que controla os salários dos funcionários novos, considerando que eles não podem começar ganhando mais de R$2.000,00.
*/

DELIMITER $$
CREATE TRIGGER before_Funcionario_insert
BEFORE INSERT ON Funcionario
FOR EACH ROW
BEGIN
   IF NEW.Salario > 2000 THEN  /* SIGNAL retorna um erro. Código 45000 é uma exceção genérica definida pelo usuário. */
      SIGNAL SQLSTATE '45000' SET message_text = 'Salário não pode ultrapassar R$2.000,00. Por favor, entre com um novo salário!';  
   END IF;
END $$
DELIMITER ;

/*
Teste o trigger inserindo novos funcionários na tabela
*/

SELECT * FROM Funcionario;

INSERT INTO Funcionario VALUES (10, 'Osvaldo Magalhães', 'R. Francisco Sales, 105', '1980-05-10', 'M', 3000.00, 4, 1);

SELECT * FROM Funcionario;

INSERT INTO Funcionario VALUES (10, 'Osvaldo Magalhães', 'R. Francisco Sales, 105', '1980-05-10', 'M', 1000.00, 4, 1);

SELECT * FROM Funcionario;

----------------------------------------------

/*
Trigger que verifica o caracter a ser informado no atributo Sexo da tabela Funcionario.
São permitidos os valores M, F, 1 ou 2. Se for inserido o valor 1, ele é convertido para
M (Masculino) e se for inserido o valor 2, ele é convertido para F (Feminino).
*/

DROP TRIGGER before_Funcionario_insert;

DELIMITER $$
CREATE TRIGGER before_Funcionario_insert
BEFORE INSERT ON Funcionario FOR EACH ROW
BEGIN
   IF (new.Sexo = 1) THEN
      SET new.Sexo = 'M';
   ELSEIF (new.Sexo = 2) THEN
      SET new.Sexo = 'F';
   ELSEIF (new.Sexo NOT IN ('M','F')) THEN
      SIGNAL SQLSTATE '45000' SET message_text = 'Caracter invalido para o atributo Sexo, informe M, F, 1 (=M) ou 2 (=F).';
   END IF;
END;
$$
DELIMITER ;

/*
Teste o trigger inserindo novos funcionários
*/

INSERT INTO Funcionario (ID_Func, NomeFunc, Endereco, DataNasc, Sexo, Salario, ID_Superv, ID_Depto)
VALUES (11, 'Manuel Silva', 'R. Francisco Sales, 105', '1980-05-10', '1', 2000.00, 4, 2);	

INSERT INTO Funcionario (ID_Func, NomeFunc, Endereco, DataNasc, Sexo, Salario, ID_Superv, ID_Depto)
VALUES (12, 'Joaquim Silva', 'R. Francisco Sales, 105', '1981-05-10', 'M', 2000.00, 4, 2);	

INSERT INTO Funcionario (ID_Func, NomeFunc, Endereco, DataNasc, Sexo, Salario, ID_Superv, ID_Depto)
VALUES (13, 'Marina Silva', 'R. Francisco Sales, 105', '1982-05-10', 'F', 2000.00, 4, 2);	

INSERT INTO Funcionario (ID_Func, NomeFunc, Endereco, DataNasc, Sexo, Salario, ID_Superv, ID_Depto)
VALUES (14, 'Jozinha Silva', 'R. Francisco Sales, 105', '1983-05-10', '3', 2000.00, 4, 2);	

SELECT * FROM Funcionario;

----------------------------------------------

/*
Trigger que controla o numero de dependentes que cada funcionario pode ter.
Neste exemplo, vamos definir o número máximo = 5 dependentes.
*/

DELIMITER $$
CREATE TRIGGER before_insert_Dependente
BEFORE INSERT ON Dependente FOR EACH ROW
BEGIN
   DECLARE vNumDeps INT;

   SELECT COUNT(ID_Func)
   FROM Dependente
   WHERE ID_Func = new.ID_Func INTO vNumDeps;	
	
   IF (vNumDeps = 5) THEN
      SIGNAL SQLSTATE '45000' SET message_text = 'Funcionário excede o número máximo de dependentes.';
   END IF;
END;
$$
DELIMITER ;

/*
Testa o trigger
*/

SELECT * FROM Dependente;

INSERT INTO Dependente (ID_Dep, ID_Func, NomeDep, DataNasc, Sexo, Parentesco) 
VALUES (8,2,'Jose Carlos','1995/10/18','M','Filho');

INSERT INTO Dependente (ID_Dep, ID_Func, NomeDep, DataNasc, Sexo, Parentesco) 
VALUES (9,2,'Joao Carlos','1996/10/18','M','Filho');

INSERT INTO Dependente (ID_Dep, ID_Func, NomeDep, DataNasc, Sexo, Parentesco) 
VALUES (10,2,'Maria Carla','1997/10/18','F','Filha');

SELECT * FROM Dependente;

----------------------------------------------

/*
Mais informações: http://www.mysqltutorial.org/mysql-triggers.aspx
				  http://dev.mysql.com/doc/refman/5.5/en/
*/

