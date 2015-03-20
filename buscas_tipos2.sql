-- Consulta com valores nulos
-- Funcionarios sem supervisor
select NomeFunc
from Funcionario
where ID_Superv is null;

-- Funcionarios com supervisor
select NomeFunc
from Funcionario
where ID_Superv is not null;

-- Todos os funcionarios
select ID_Func, NomeFunc, ID_Superv
from funcionario;

-- Funcionarios com o 8 de supervisor
select ID_Func, NomeFunc, ID_Superv
from funcionario
where ID_Superv = 8;

-- Funcionarios com supervisor de id diferente de 8
select ID_Func, NomeFunc, ID_Superv
from funcionario
where ID_Superv != 8;

-- Funcionarios com supervisor de id diferente de 8 e com valores nulos
select ID_Func, NomeFunc, ID_Superv
from funcionario
where ID_Superv != 8 or id_superv is null;

-- Todos os funcionarios com dependentes
select NomeFunc, NomeDep
from Funcionario F INNER JOIN dependente D ON F.ID_Func = D.ID_Func;

-- Todos os funcionarios com os seus dependentes, mesmo aqueles que não tem dependentes
select NomeFunc, NomeDep
from Funcionario F LEFT OUTER JOIN dependente D ON F.ID_Func = D.ID_Func;

-- Todos os dependentes com os seus funcionarios
select NomeFunc, NomeDep
from Funcionario F RIGHT OUTER JOIN dependente D ON F.ID_Func = D.ID_Func;

-- Funcionarios que não tem dependentes
select NomeFunc
from funcionario
where ID_Func not in (select id_func from dependente);

-- Funcionarios que não tem dependentes com OUTER JOIN
select NomeFunc, NomeDep
from Funcionario F LEFT OUTER JOIN dependente D ON F.ID_Func = D.ID_Func
where NomeDep is null;

-- Buscas com funções agregadas
-- Qunatos funcionarios eu tenho na minha tabela funcionario
select count(*) as Numero_Funcionarios		-- Conta todas as tuplas, incluindo aquelas com valores nulos
from funcionario;

select count(id_func) as Numero_Funcionarios	-- Conta quantos id de funcionarios tem na tabela, só conta valores diferntes de nulo 
from funcionario;								-- count(coluna) conta somente valores não nulos	

-- Somar todos os salarios, calcular a media, achar o valor minimo e maximo do Departamento 1
select sum(salario), avg(salario), min(salario), max(salario)
from funcionario
where id_depto = 1;

-- Soma de salarios, o numero de funcionarios agrupados por departamento e a soma de salarios
select ID_Depto,count(*), sum(salario)
from funcionario
group by ID_Depto;

-- Soma de salarios, o numero de funcionarios agrupados por departamento e a soma de salarios. Com nome do departamento
-- VAI CAIR NA PROVA! TESTE LOGICO NO GRUPO, E NÃO EM UMA LINHA
select ID_Depto, NomeDepto, count(*) as Num_Funcionario , sum(salario) as Soma_Salario
from funcionario natural join departamento
group by ID_Depto, NomeDepto
having count(*) > 1;

-- Exemplo de ORDER BY - Ordem crescente por nome
select NomeFunc, Salario
from funcionario
order by NomeFunc ASC;

-- Exemplo de ORDER BY - Ordem decrescente por nome
select NomeFunc, Salario
from funcionario
order by NomeFunc DESC;

-- Exemplo de ORDER BY - Ordem crescente por salario
select NomeFunc, Salario
from funcionario
order by Salario ASC;

-- Exemplo de ORDER BY - Ordem decrescente por salario
select NomeFunc, Salario
from funcionario
order by salario DESC;

-- Exemplo de ORDER BY - Ordem crescente por salario e por nome como criterio de desempate
select NomeFunc, Salario
from funcionario
order by Salario ASC, NomeFunc ASC;

-- Exemplo de UPDATE de dados
update funcionario
set salario = 700
where ID_Func = 1;

-- Aumentar o salario dos funcionarios do departamento de Pesquisa
update funcionario
set salario = salario * 1,10

SELECT nomefunc, salario
FROM FUNCIONARIO;

-- Seleciona todos os atributos da tabela funcionário
SELECT *
FROM FUNCIONARIO;

-- Seleciona as tuplas distintas, eliminando as repetidas
SELECT DISTINCT sexo
FROM FUNCIONARIO;

-- Seleciona todas as tuplas, incluindo as repetidas
SELECT ALL sexo
FROM FUNCIONARIO;

SELECT nomefunc, salario
FROM FUNCIONARIO
WHERE salario > 1200;

SELECT nomeproj
FROM PROJETO;

SELECT nomefunc, nomedepto
FROM FUNCIONARIO, DEPARTAMENTO
WHERE Funcionario.ID_Depto = Departamento.ID_Depto;

-- Criação de um apelido
SELECT nomefunc, nomedepto
FROM FUNCIONARIO AS f, DEPARTAMENTO AS d
WHERE f.ID_Depto = d.ID_Depto;

-- Criação de um apelido sem o AS
SELECT nomefunc, nomedepto
FROM FUNCIONARIO f, DEPARTAMENTO d
WHERE f.ID_Depto = d.ID_Depto;

-- Seleção utilizando junção - JOIN
SELECT nomefunc, nomedepto
FROM FUNCIONARIO AS f JOIN DEPARTAMENTO AS d ON f.ID_Depto = d.ID_Depto;

-- Seleção utilizando junção natural - NATURAL JOIN
SELECT nomefunc, nomedepto
FROM FUNCIONARIO NATURAL JOIN DEPARTAMENTO;

SELECT nomefunc, salario
FROM FUNCIONARIO
WHERE salario >= 500 AND salario <= 1000;

SELECT nomefunc, salario
FROM FUNCIONARIO
WHERE salario BETWEEN 500 AND 1000;

SELECT *
FROM FUNCIONARIO
WHERE nomefunc = 'João B. Silva';

-- Busca um valor aproximado
SELECT *
FROM FUNCIONARIO
WHERE nomefunc LIKE '%Santo';

-- Busca um valor aproximado
SELECT *
FROM FUNCIONARIO
WHERE nomefunc LIKE '%B.%';

-- Opereção de união
SELECT id_func, nomefunc
FROM FUNCIONARIO NATURAL JOIN DEPARTAMENTO
WHERE nomeDepto = 'Pesquisa'
UNION
SELECT id_func, nomefunc
FROM FUNCIONARIO
WHERE sexo = 'M';

-- Opereção de intercessão
SELECT id_func, nomefunc
FROM FUNCIONARIO NATURAL JOIN DEPARTAMENTO
WHERE nomeDepto = 'Pesquisa' AND id_func IN ( SELECT id_func
                                              FROM FUNCIONARIO
                                              WHERE sexo = 'M' );

select NomeFunc
from funcionario f, departamento d, trabalha t, projeto p
where d.id_depto = p.id_depto and t.id_proj = p.id_proj and f.id_func = t.id_func and f.nomefunc = 'Frank T. Santos';

select NomeFunc, NomeDepto, salario
from funcionario f, departamento d
where f.id_depto = d.id_depto and nomedepto = 'construção';

-- 1
 select NomeFunc, Endereco
 from funcionario
 where NomeFunc = "Luciana S. Santos";
 
-- 2
 select NomeFunc, Salario
 from funcionario
 where DataNasc BETWEEN "1961/01/01" AND "1970/12/31"
                 AND Sexo = "F" AND Salario < 1000;
 -- 3
 select nomefunc,NomeDep
 from dependente D natural join funcionario F
 where F.NomeFunc = "Frank T. Santos" and D.ID_Func = F.ID_Func;
 
-- 4
 select NomeProj,nomefunc
 from funcionario F, trabalha T, projeto P
 where NomeFunc = "Frank T. Santos" AND F.ID_Func = T.ID_Func AND
 T.ID_Proj = P.ID_Proj;
 

-- 5
 select NomeFunc,nomedepto
 from funcionario F, trabalha T, projeto P, departamento D
 where F.ID_Func = T.ID_Func AND T.ID_Proj = P.ID_Proj AND P.ID_Depto =
 D.ID_Depto AND D.NomeDepto = "Construcao";
 
-- 6
 select F.NomeFunc, f.id_superv
 from funcionario F, funcionario E
 where F.ID_Superv = E.ID_Func
 AND E.NomeFunc = "Frank T. Santos";
 
-- 7
 select NomeFunc, Endereco
 from funcionario F
 where not exists
 (select *
 from dependente D
 where F.ID_Func = D.ID_Func);
 
-- 8
 (select NomeFunc,d.nomedepto -- verificar o resultado da pesquisa abaixo
 from funcionario F natural join departamento D
 where D.NomeDepto = "Pesquisa")
 union
 (select NomeFunc, p.nomeproj
 from funcionario E, trabalha T natural join projeto P
 where P.NomeProj = "N. Beneficios" AND E.ID_Func = T.ID_Func);
 
-- 9
 (select NomeFunc
 from funcionario F natural join departamento D
 where D.NomeDepto = "Pesquisa")
 union
 (select NomeFunc
 from funcionario E, trabalha T natural join projeto P
 where P.NomeProj = "N. Beneficios" AND E.ID_Func = T.ID_Func);

INSERT INTO Funcionario
VALUES (9,'Sergio M. Matos','R. Cosme, 180','1964/02/10','M',2000,NULL,2);




-- 12
select NomeFunc
from funcionario f
where salario > all
(select Salario
from funcionario f, departamento d
where f.id_depto = d.id_depto and  nomedepto = "Construção");

-- 13
select nomefunc,Salario
from funcionario f
where f.id_superv is null order by nomefunc;

-- (select *
-- from funcionario f
-- where f.id_superv is null order by nomefunc);

-- 14
select nomefunc, NomeDep
from funcionario f left outer join dependente d
where f.id_func = d.id_func;

-- 15
select count(*)
from funcionario f natural join projeto p 
where nomeproj="ProdZ";


-- 16
select id_depto, sum(salario)
from funcionario
where id_depto in
(select id_depto -- , count(*)
from departamento natural join projeto
group by id_depto
having count(*) >1)
group by id_depto;

-- 17 

select f.id_func, NomeFunc -- as quantidade projeto -- id_proj, numhoras--  
from funcionario f natural join trabalha
where numhoras >10
group by f.id_func, NomeFunc;

-- 18

select f.id_func, NomeFunc, count(*) as qdadeproj  
from funcionario f natural join trabalha
group by f.id_func, NomeFunc
having qdadeprojs >1;


-- 19
update funcionario
set salario = salario * 1.10
where id_func in
(select id_func 
from trabalha
group by id_func
having count(*) > 1);

-- 20

delete from projeto
where id_proj not in 
(select ID_Proj
from trabalha);

-- 21 

create view  Deptogerente as
select d.id_depto, nomedepto, nomefunc, salario
from departamento d join funcionario f on id_gerente = id_func;

select * from Deptogerente;

select * from Deptogerente
where salario > 2000;
