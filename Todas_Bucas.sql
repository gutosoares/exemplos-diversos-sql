-- Consulta com valores nulos
-- Funcionarios sem supervisor
select NomeFunc
from Funcionario
where ID_Superv is null;

select DataNasc, Endereco
from Funcionario
where NomeFunc = 'João B. Silva';

select NomeFunc, Endereco
from Funcionario F, Departamento D
where NomeDepto = 'Pesquisa' AND D.ID_Depto = F.ID_Depto;

select id_proj
from projeto
where id_proj in 
    (select id_proj
    from funcionario f, departamento d, projeto p
    where f.nomefunc = 'Frank T. Santos' and d.id_gerente = f.id_func and d.id_depto = p.id_depto)
    or id_proj in 
    (select id_proj
    from funcionario f, trabalha t
    where f.nomefunc = 'Frank T. Santos' and f.id_func = t.id_func);
    
select distinct id_func
from trabalha
where (id_proj, numhoras) in
    (select id_proj, numhoras
    from trabalha
    where id_func = '6');

select nomefunc, salario
from funcionario
where salario > all (select salario
                     from funcionario
                     where id_depto = '5');
                     
select F.nomefunc
from funcionario F
where exists (select *
               from dependente D
               where F.id_func = D.id_func and F.nomefunc = D.nomedep and F.sexo = D.sexo);
               
-- Nome dos funcionarios sem dependentes     
select nomefunc
from funcionario f
where not exists (select *
                  from dependente d
                  where f.id_func = d.id_func);
-- ou                  
select NomeFunc
from funcionario
where ID_Func not in (select id_func from dependente);

-- Nome de todos os funcionarios com dependentes
select f.nomefunc
from funcionario f
where exists (select *
              from dependente d
              where d.id_func = f.id_func);
              
-- ou
select distinct f.nomefunc
from funcionario f, dependente d
where f.id_func = d.id_func;

-- Nome de funcionarios que são gerente
select f.nomefunc
from funcionario f
where exists (select *
              from departamento d
              where f.id_func = d.id_gerente);
-- ou
select distinct f.nomefunc
from funcionario f, departamento d
where f.id_func = d.id_gerente;

-- Nome dos funcionarios quem tem dependentes e são gerentes
select f.nomefunc
from funcionario f
where exists (select *
              from dependente d
              where d.id_func = f.id_func) 
              and exists
              (select *
              from departamento E
              where e.id_gerente = f.id_func);
              
-- Id dos funcionarios que trabalham nos projetos de id igual a 1, 2 e 3
select distinct id_func as ID_FUNCIONARIO
from trabalha
where id_proj in (1, 2, 3);

-- Nome e endereço de todos os funcionarios que pertence ao departamento de nome Pesquisa
select f.nomefunc, f.endereco
from funcionario f, departamento d
where d.nomedepto = 'Pesquisa' and f.id_depto = d.id_depto;
-- ou
select f.nomefunc, f.endereco
from (funcionario f join departamento d on f.id_depto = d.id_depto)
where d.nomedepto = 'Pesquisa';

-- Selecionar apenas os funcionarios que possuem apenas um supervisor
select f.nomefunc as Nome_Funcionario, s.nomefunc as Nome_Supervisor
from (funcionario f left outer join funcionario s on f.id_superv = s.id_func);

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
set salario = salario * 1.10;

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

-- Todos os funcionarios com o maior salario dos funcionarios do departamento Pesquisa
select NomeFunc, Salario
from funcionario
where salario > all
    (select salario
    from funcionario natural join departamento
    where nomeDepto = 'Pesquisa');    

-- Todos os funcionarios com salario maior de todos que trabalham no departamento Pesquisa.
select NomeFunc, Salario
from funcionario
where salario > (select MAX(salario)    -- Maior salário de todos os funcionarios
    from funcionario natural join departamento
    where nomeDepto = 'Pesquisa');

-- Nome dos funcionarios que possuem dependentes (Consulta aninhadas é utilizada em último caso)
select nomefunc
from funcionario f
where exists (select 1 from dependente d where f.id_func = d.id_func);  -- consulta aninhada dependente do mais interno. Consulta muito ineficiente
-- ou --
select distinct nomefunc    -- Melhor maneira de realizar a consulta
from funcionario f join dependente d on f.id_func = d.id_func;

-- Nome dos funcionarios que NÃO possuem dependentes
select nomefunc
from funcionario f
where not exists (select 1 from dependente d where f.id_func = d.id_func);  -- consulta aninhada dependente do mais interno. Consulta muito ineficiente

-- Buscar o nome dos funcionarios e o nome dos projetos onde eles trabalham
select nomefunc, NomeProj
from funcionario f, trabalha t, projeto p
where f.id_func = t.id_func and t.id_proj = p.id_proj;

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
 from dependente D join funcionario F on  D.ID_Func = F.ID_Func
 where F.NomeFunc = "Frank T. Santos";
 
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




-- 18
select NomeFunc
from funcionario f
where salario > all
(select Salario
from funcionario f, departamento d
where f.id_depto = d.id_depto and  nomedepto = "Construção");

-- 12
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

select nomeFunc
from funcionario f, trabalha t, projeto p
where f.id_depto = 1 and t.id_proj = p.id_proj and f.id_func = t.id_func and numHoras > 10 and nomeProj = 'ProdX'; 

select nomefunc
from funcionario, dependente
where nomefunc = nomedep;

select f.nomefunc
from funcionario f, funcionario g
where g.nomefunc = 'Frank T. Santos' and g.id_func = f.id_superv;

-- 1 Listar todos os atributos da tabela Cliente.
SELECT *
FROM Cliente;

-- 2 Listar todos os atributos da tabela Veiculo.
SELECT *
FROM Veiculo;

-- 3 Listar todos os atributos da tabela Ordem de Serviço(OS).
SELECT *
FROM OS;
 
-- 4 Listar todos os atributos da tabela referente aos tipos de serviços.
SELECT *
FROM Servico;

-- 5 Listar todos os atributos da tabela referente aos tipos de produtos.
SELECT *
FROM Produto;

-- 6 Listar todos os atributos da tabela dos fornecedores.
SELECT *
FROM Fornecedor;

-- 7 Selecionar a marca e modelo de veiculos, cujo o numero de chassi seja igual a NULL.
SELECT Marca, Modelo
FROM Veiculo
WHERE Numero_Chassi IS NULL;

-- 8 Selecionar a marca e modelo de veiculos, cujo o numero de chassi seja diferente de NULL.
SELECT Marca, Modelo
FROM Veiculo
WHERE Numero_Chassi IS NOT NULL;

-- 9 Selecionar o nome e o CPF do cliente com a marca e modelo dos seus veiculos, ordenados por modelo.
SELECT Nome_Cliente, CPF, Marca, Modelo
FROM Cliente, Veiculo 
WHERE CPF = CPF_Cliente
ORDER BY Modelo;

-- 10 Buscar o nome do serviço que tenha o mair custo para o cliente.
SELECT Descricao_Servico, Valor_Servico
FROM Servico
WHERE Valor_Servico = (SELECT MAX(Valor_Servico) FROM Servico);

-- 11 Buscar o nome de todos os serviços e a quatidade de solicitações(ERRO).
SELECT Descricao_Servico, id_Servico, COUNT(*) AS Solicitações
FROM Determina NATURAL JOIN Servico
WHERE id_Servico = id_Servico
GROUP BY id_Servico;

-- 12 Listar o id da ordem de serviço que foi solicitada antes de 01/01/2013 ou com um valor total entre 500 a 800 reais.
(SELECT id_OS
 FROM OS
 WHERE Data < '2014')
UNION
(SELECT id_OS
 FROM OS
 WHERE (Valor_Total BETWEEN 500 AND 800));

-- 13 Liste o nome dos clientes com carros cadastrados da marca "Honda".
SELECT Nome_Cliente
FROM Cliente
WHERE EXISTS (SELECT *
              FROM Veiculo
			  WHERE CPF = CPF_Cliente and Marca = 'Honda');

-- 14 Liste o nome dos clientes que começam com a letra "J", o modelo do seu veiculo, ano de sua fabricação e a descrição da ordem de serviço emitida para o veiculo.
SELECT Nome_Cliente, Modelo, Ano_Fab, Info_Complementar
FROM Cliente AS C, OS AS O, Veiculo AS V
WHERE Nome_Cliente LIKE 'J%' AND C.CPF = V.CPF_Cliente AND C.CPF = O.CPF_Cliente;

-- 15 Listar os 3 primeiros nomes dos clientes da oficina.
SELECT Nome_Cliente
FROM Cliente
ORDER BY Nome_Cliente ASC LIMIT 3 OFFSET 0;

-- 16 Liste o modelo dos veiculos fabricados antes de 2010 e marca diferente de Honda.
SELECT Modelo
FROM Veiculo
WHERE Ano_Fab < '2010' AND Marca != 'Honda';

-- 17 Liste o nome do cliente que solicitou a ordem de serviço de número 3 e seu valor.
SELECT Nome_Cliente, Valor_Total
FROM Cliente, OS
where id_OS = 3 AND CPF = CPF_Cliente;

-- 18 Liste o nome do fornecedor das peças do veículo de placa "DUQ-6219".
SELECT Nome_Fornecedor
FROM Fornecedor AS F1, Fornecido AS F2, Produto AS P, OS AS O, OP AS OP
WHERE Placa = 'DUQ-6219' AND F1.id_Fornecedor = F2.id_Fornecedor AND F2.id_Produto = P.id_Produto AND P.id_Produto = OP.id_Produto AND OP.id_OS = O.id_OS;

-- 19 Qual o valor total dos produtos instalados no veículo de placa "NIY-0045"? E quem é o proprietario? E seu contato?
SELECT Valor_Total, Nome_Cliente, Contato
FROM Cliente AS C, OS AS O
WHERE O.Placa = 'NIY-0045' AND O.CPF_Cliente = C.CPF; 

-- 20 Liste o nome dos clientes e modelo do veiculo, de donos de veiculos fabricados entre 2000 e 2010 e marca Ford.
SELECT Nome_Cliente, Modelo
FROM Cliente, Veiculo
WHERE NOT (Ano_Fab < '2000' OR Ano_Fab > '2010') AND Marca = 'Ford' AND CPF = CPF_Cliente;

-- 21 Liste os dados do(s) fornecedore(s) que tenham a letra "u" na segunda posição da palavra.
SELECT *
FROM Fornecedor
WHERE Nome_Fornecedor LIKE '_u%';

-- 22 Liste o CPF dos clientes que estão cadastrados, mas não tem nenhum veículo cadastrado.
/*(SELECT CPF
FROM Cliente)
EXCEPT ou MINUS
(SELECT CPF_Cliente
FROM Veiculo);*/
SELECT CPF
FROM Cliente
WHERE (CPF) NOT IN (SELECT CPF_Cliente FROM Veiculo);

-- 23 Liste o custo médio em cada ordem de serviço
SELECT id_OS, AVG(Valor_Total) AS Custo_Medio
FROM OS
GROUP BY id_OS;

-- 24 Liste a placa do veículo, no qual o seu seu dono tem a letra "M" como primeira letra do seu nome. 
SELECT Placa
FROM Veiculo
WHERE CPF_Cliente IN (SELECT CPF 
                     FROM Cliente
                     WHERE Nome_Cliente LIKE 'M%');
                     
-- 25 Encontre todos os clientes que possuem no máximo um veiculo de marca Honda.
SELECT Nome_Cliente
FROM Cliente
WHERE Nome_Cliente IN (SELECT Nome_Cliente
              FROM Cliente, Veiculo
              WHERE CPF = CPF_Cliente AND Marca = 'Honda');

-- 26 Liste o número de ordens de serviço emitidadas entre 2014/01/04 e 2014/04/04.
SELECT COUNT(id_OS) AS Número_de_OS
FROM OS
WHERE Data BETWEEN '2014/01/04' AND '2014/04/04';


-- 27 Liste todos os valores dos fornecedores, inclusive aqueles que não forneceram produtos para a oficina.
SELECT *
FROM Fornecedor AS F1 LEFT OUTER JOIN Fornecido AS F2 ON F1.id_Fornecedor = F2.id_Fornecedor;

