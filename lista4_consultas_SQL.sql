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

