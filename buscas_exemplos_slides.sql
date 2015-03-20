-- Buscas Exemplos dos Slides --

select NomeFunc
from Funcionario;

select nomefunc, salario
from funcionario
where salario > 500;

select *
from funcionario
where datanasc < '1960';

select distinct nomefunc
from funcionario;

select *
from funcionario
where salario between 500 and 1000;

select *
from funcionario
where salario >= 500 and salario <= 1000;

select nomefunc, id_func, datanasc, salario
from Funcionario
where datanasc <= '1970' or salario >= 500;

SELECT NomeFunc
FROM Funcionario
WHERE NomeFunc LIKE '%Silva%';

(select F.NomeFunc
from Funcionario F, Departamento D
where D.NomeDepto = 'Pesquisa' and F.ID_Depto = D.ID_Depto)
UNION
(select F.NomeFunc
from Funcionario F, Projeto P, Trabalha T
where P.Nomeproj = 'Computação' and F.ID_Func = T.ID_Func and T.ID_Proj = P.ID_Proj);
-- ou --
(select NomeFunc
from Funcionario natural join Departamento
where NomeDepto = 'Pesquisa')
UNION 
(select NomeFunc
from Funcionario as F natural join Trabalha as T, Projeto as P
where P.NomeProj = 'Computação' and T.ID_Proj = P.ID_Proj);

select NomeFunc
from Funcionario as F, Departamento as D
where F.ID_Depto = D.ID_Depto and D.NomeDepto = 'Construção';

select F.NomeFunc
from Funcionario as F, Funcionario as E
where F.ID_Depto = E.ID_Depto and E.NomeFunc = 'João B. Silva';

select F.NomeFunc, P.NomeProj
from Funcionario F, Trabalha T, Projeto P
where F.ID_Func = T.ID_Func and T.ID_Proj = P.ID_Proj;

select nomedepto, count(*)
from funcionario f, departamento d
where f.id_depto = d.id_depto and salario > 40.000
group by nomedepto
having count(*) > 3;
