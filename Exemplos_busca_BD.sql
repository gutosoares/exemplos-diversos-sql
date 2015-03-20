select nomeFunc, salario
from Funcionario
where salario between 500 and 1000;

-- Listar todos os funcionarios com nome igual a Silva
select NomeFunc, salario
from Funcionario
where NomeFunc like '%Silva%';

-- Exemplo de união
(select NomeFunc
from Funcionario NATURAL JOIN Departamento
where nomeDepto = 'Pesquisa')
union
(select nomeFunc
from Funcionario NATURAL JOIN Trabalha
where numHoras > 20);

-- MySQL não executa INTERSEÇÃO
(select NomeFunc
from Funcionario NATURAL JOIN Departamento
where nomeDepto = 'Pesquisa')
int
(select nomeFunc
from Funcionario NATURAL JOIN Trabalha
where numHoras > 20);

-- então no MySQL reescreve usando o operador insert
select NomeFunc
from Funcionario NATURAL JOIN Departamento
where nomeDepto = 'Pesquisa' and NomeFunc IN (
    select nomeFunc
    from Funcionario NATURAL JOIN Trabalha
    where numHoras > 20);
    
select F.NomeFunc
from Funcionario E, Funcionario F
where E.NomeFunc = 'João B. Silva' and E.id_depto = F.id_depto;

select E.NomeFunc, E.Salario
from funcionario E, funcionario F, Departamento D
where E.Salario > F.Salario and F.id_depto = D.id_depto and nomeDepto = 'Pesquisa';

-- Algum funcionario com salario maior que 500 que trabalha no departamento Pesquisa
select NomeFunc, Salario
from funcionario
where salario > some
    (select salario
    from funcionario natural join departamento
    where nomeDepto = 'Pesquisa');


-- Todos os funcionarios com salario maior que 500
select NomeFunc, Salario
from funcionario
where salario > all
    (select salario
    from funcionario natural join departamento
    where nomeDepto = 'Pesquisa');    

-- Todos os funcionarios com salario maior que 500
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
