select NomeFunc, Endereco
from funcionario f, departamento d
where NomeDepto = 'Pesquisa' and f.id_depto = d.id_depto;

select id_proj
from projeto
where id_proj in (select id_proj
				  from funcionario f, departamento d, projeto p
				  where f.nomefunc = 'Frank T. Santos' and f.ID_Func = d.id_gerente and d.id_depto = p.ID_Depto)
				  or id_proj in	
				  (select id_proj
				   from funcionario f, trabalha t
				   where f.nomefunc = 'Frank T. Santos' and f.id_func = t.id_func);

select ID_Func
from trabalha
where (id_proj, numhoras) in (select id_proj, numhoras
							  from trabalha
							  where id_func = 4);

select nomefunc, Salario
from funcionario
where salario > all (select Salario
					 from funcionario
					 where id_depto = 3);

select f.nomefunc
from funcionario f
where exists (select *
			  from dependente d
			  where f.nomefunc = d.nomedep and f.sexo = d.sexo and f.ID_Func = d.ID_Func);
-- ou
select NomeFunc
from funcionario f
where f.id_func in (select d.ID_Func
				  from dependente d
				  where f.id_func = d.id_func and f.nomefunc = d.nomedep and f.sexo = d.sexo);

select NomeFunc
from funcionario f
where not exists (select *
				  from dependente d
				  where f.id_func = d.id_func);
-- ou
select NomeFunc
from funcionario f
where ID_Func not in (select id_func from dependente);

select distinct NomeFunc
from funcionario f, dependente d
where f.id_func = d.id_func;
-- ou
select nomefunc
from funcionario f
where f.id_func in (select d.ID_Func
			  from dependente d
			  where f.id_func = d.ID_func);
-- ou
select f.nomefunc
from funcionario f
where exists (select *
			  from dependente d
			  where f.id_func = d.id_func);

select NomeFunc
from funcionario f, departamento d
where f.id_func = d.id_gerente;
-- ou
select NomeFunc
from funcionario f
where exists (select *
			  from departamento d
			  where f.id_func = d.id_gerente);
-- ou 
select NomeFunc
from funcionario f
where ID_Func in (select ID_Func
				  from departamento d
				  where f.id_func = d.id_gerente);

select nomefunc
from funcionario f
where not exists (select *
			  from dependente d
			  where f.id_func = d.id_func);	
-- ou
select NomeFunc
from funcionario f
where f.id_func not in (select d.ID_Func
					  from dependente d
					  where d.id_func = f.id_func);

select nomefunc, Endereco
from funcionario f, departamento d
where d.NomeDepto = 'Pesquisa' and f.id_depto = d.id_depto;

select nomefunc, Endereco
from (funcionario f join departamento d on f.id_depto = d.ID_Depto)
where d.NomeDepto = 'Pesquisa';

select nomefunc, endereco
from funcionario natural join departamento
where NomeDepto = 'Pesquisa';

select f.NomeFunc as Nome_Func, s.nomefunc as Nome_Superv
from funcionario f left outer join funcionario s on f.ID_Superv = s.ID_Func;

select ID_Func, NomeFunc
from funcionario
where ID_Superv is not null;

select *
from funcionario
where id_superv != 8;

select *
from funcionario
where ID_Superv = 8 or id_superv is null;

select distinct nomefunc, NomeDep
from funcionario f inner join dependente d on f.id_func = d.id_func;

select nomefunc, NomeDep
from funcionario f left outer join dependente d on f.id_func = d.id_func
order by NomeFunc, nomedep;

select nomefunc, NomeDep
from funcionario f join dependente d on f.id_func = d.id_func;

select nomefunc, NomeDep
from funcionario f right outer join dependente d on f.id_func = d.id_func
order by nomefunc, nomedep;

select nomefunc, nomedep
from funcionario f left outer join dependente d on f.id_func = d.ID_Func
where nomedep is null;

-- Número total de gerentes
select count(id_superv) as Total_Gerentes
from funcionario;

select count(*) as qtde_func, sum(salario), avg(salario), min(salario), max(salario)
from funcionario
where ID_Depto = 1;

select id_depto, count(*) as QTDE_Func, sum(salario) as soma, avg(salario) as media
from funcionario
group by id_depto;

select id_depto, NomeDepto, count(*) as Num_Func, sum(salario) as Soma_Salario
from funcionario natural join departamento
group by id_depto
having count(*) > 1;

-- Nome e salario de algum funcionario com o salario maior que algum funcionario do departamento Construção
select nomefunc, salario
from funcionario
where Salario > some (select Salario
				     from funcionario natural join departamento
 				     where NomeDepto = 'Construção');

(select NomeFunc
from funcionario natural join departamento
where NomeDepto = 'Pesquisa')
union
(select nomefunc
from funcionario f, trabalha t, projeto p
where nomeproj = 'N. Benefícios' and f.id_func = t.id_func and t.id_proj = p.id_proj);

select f.NomeFunc
from funcionario f, funcionario g, trabalha t, projeto p, departamento d
where f.id_func = t.ID_Func and t.ID_Proj = p.id_proj and p.id_depto = d.id_depto and d.id_gerente = g.id_func and g.nomefunc = 'Frank T. Santos';

select NomeFunc, NomeDep
from funcionario f left outer join dependente d on f.id_func = d.ID_Func;

select count(*) as Qtde_Func
from funcionario natural join projeto
where nomeproj = 'ProdZ';

select id_func, nomefunc, count(*)
from funcionario natural join trabalha
where numhoras > 10
group by id_func, nomefunc;

select NomeFunc, count(*) as Qtde_Projetos
from funcionario natural join trabalha
group by ID_Func, nomefunc
having count(*) > 1;

-- 
select id_func, nomefunc
from funcionario natural join departamento
where NomeDepto = 'Pesquisa' and id_func in (select id_func
											 from funcionario
											 where sexo = 'M');

select nomefunc, nomedepto, salario
from funcionario natural join departamento
where NomeDepto = 'Construção';

select nomefunc, Salario
from funcionario
where salario > all (select salario
					 from funcionario natural join departamento
					 where nomedepto = 'Pesquisa');
                     
select nomefunc, salario
from funcionario
where salario > (select max(salario)
                 from funcionario natural join departamento
                 where nomedepto = 'Pesquisa');
        
select distinct nomefunc
from funcionario f join dependente d on f.id_func = d.id_func;

select nomefunc
from funcionario f
where exists (select *
              from dependente d
              where f.id_func = d.id_func);
              
select distinct nomefunc
from funcionario f left outer join dependente d on f.id_func = d.id_func
where nomedep is not null;

select distinct nomefunc, nomedep
from funcionario f left outer join dependente d on f.id_func = d.id_func
where nomedep is null;

select nomefunc, nomedep
from funcionario f left outer join dependente d on f.id_func = d.id_func;

select count(*) as qtde_func
from funcionario natural join projeto
where nomeproj = 'ProdZ';

-- 13
select id_func, nomefunc, count(*) as qtde_proj
from funcionario natural join trabalha
where numhoras > 10
group by id_func, nomefunc;

-- 14
select nomefunc, count(*) as qtde_proj
from funcionario natural join trabalha
group by id_func, nomefunc
having count(*) > 1;

-- 15
select id_depto, sum(salario)
from funcionario
where id_depto in (select id_depto
                   from departamento natural join projeto
                   group by id_depto
                   having count(*) > 1)
group by id_depto;

-- 18
select id_func, nomefunc, salario
from funcionario
where salario > all (select salario
                 from funcionario natural join departamento
                 where nomedepto = 'Construção');
                 
select id_func, nomefunc, salario
from funcionario
where salario > (select max(salario)
                 from funcionario natural join departamento
                 where nomedepto = 'Construção');
-- 19
select nomefunc, salario
from funcionario
where id_superv is null
order by nomefunc;

-- 20
update funcionario
set salario = salario * 1.10
where id_func in (select id_func
                  from trabalha
                  group by id_func
                  having count(*) > 1);
