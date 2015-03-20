/* 
A ideia de visão é criar uma tabela virtual. Serve para criar tabela para
cada tipo de usuário.
Pode envolver mais de uma tabela.
*/

-- Criar uma visão
create view FuncProj as
select f.id_func, nomefunc, p.id_proj, nomeproj, numhoras
from funcionario f, trabalha t, projeto p
where f.id_func = t.id_func and t.id_proj = p.id_proj;

-- Busca em uma visão
select *
from FuncProj;

select nomefunc, nomeproj, numhoras
from funcproj
where numhoras > 10;

