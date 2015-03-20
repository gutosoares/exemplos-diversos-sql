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

