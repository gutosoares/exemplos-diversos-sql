/* Usuários e permissões de acesso */

/* 
Criação de Usuários 
*/

/*
CREATE USER especificação_de_usuario [, especificação_de_usuario] ...

especificação_de_usuario:
   user [IDENTIFIED BY [PASSWORD] 'senha']

user:
   'nome_do_usuario'@'nome_do_servidor'
*/

CREATE USER 'denilson'@'localhost' IDENTIFIED BY '0192';

/* 
Exclusão de usuários
*/

DROP USER 'denilson'@'localhost';

/*
Permissões de acesso
*/

/* 
Concessão de permissão
*/
/*
GRANT
    priv_type [(column_list)]
      [, priv_type [(column_list)]] ...
    ON [object_type] priv_level
    TO user_specification [, user_specification] ...
    [REQUIRE {NONE | ssl_option [[AND] ssl_option] ...}]
    [WITH with_option ...]

object_type:
    TABLE
  | FUNCTION
  | PROCEDURE

priv_level:
    *
  | *.*
  | db_name.*
  | db_name.tbl_name
  | tbl_name
  | db_name.routine_name

user_specification:
    user [IDENTIFIED BY [PASSWORD] 'password']

ssl_option:
    SSL
  | X509
  | CIPHER 'cipher'
  | ISSUER 'issuer'
  | SUBJECT 'subject'

with_option:
    GRANT OPTION
  | MAX_QUERIES_PER_HOUR count
  | MAX_UPDATES_PER_HOUR count
  | MAX_CONNECTIONS_PER_HOUR count
  | MAX_USER_CONNECTIONS count
*/

-- Concede ao usuário 'denilson' em 'localhost' todos os privilégios à tabela Funcionario
GRANT ALL ON Empresa.Funcionario TO 'denilson'@'localhost';

-- Concede ao usuário 'denilson' em 'localhost' o direito de executar SELECT e INSERT na tabela Departamento
GRANT SELECT, INSERT ON Empresa.Departamento TO 'denilson'@'localhost';

-- Concede ao usuário 'denilson' em 'localhost' o direito de alterar a coluna 'NomeDepto' na table Departamento
GRANT UPDATE (NomeDepto) ON Empresa.Departamento TO 'denilson'@'localhost';


/*
Revogação de permissão
*/
/*
REVOKE
    priv_type [(column_list)]
      [, priv_type [(column_list)]] ...
    ON [object_type] priv_level
    FROM user [, user] ...

REVOKE ALL PRIVILEGES, GRANT OPTION
    FROM user [, user] ...
*/

-- Revoga, do usuário 'denilson' em 'localhost', o direito de alterar a coluna 'NomeDepto' na table Departamento.
REVOKE UPDATE (NomeDepto) ON Empresa.Departamento FROM 'denilson'@'localhost';

-- Revoga, do usuário 'denilson' em 'localhost', todos os privilégios sobre tabela Funcionario
REVOKE ALL ON Empresa.Funcionario FROM 'denilson'@'localhost';

/* Mais informações: http://dev.mysql.com/doc/refman/5.0/en/grant.html#grant-privileges

