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