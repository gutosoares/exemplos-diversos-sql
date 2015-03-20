create table contato (
id          INT             NOT NULL,
nome        VARCHAR(20)     NOT NULL,
sobrenome   VARCHAR(20)     NOT NULL,
nascimento  DATE            NULL,
peso        DECIMAL(10,2)   NOT NULL,

PRIMARY KEY(id)
);

CREATE TABLE email (
id          INT             NOT NULL,
email       VARCHAR(60)     NOT NULL,
contato     INT             NOT NULL,

PRIMARY     KEY(id),
FOREIGN     KEY(contato) REFERENCES contato(id)
);

CREATE TABLE telefone (
id_tel        INT               NOT NULL,
telefone      VARCHAR(20)       NOT NULL,
contato_tel   INT               NOT NULL,

PRIMARY KEY(id_tel),
FOREIGN KEY(contato_tel) REFERENCES contato(id)
);

create table grupo (
id_grupo        int             not null,
nome_grupo      varchar(30)     not null
);

CREATE TABLE afiliacao (
grupo_fk            INT         NOT NULL,
contato_fk          INT         NOT NULL
);

insert into contato
values (1, 'Augusto', 'Soares', '1992/03/07', 86);
insert into contato
values (2, 'Thais', 'Ribeiro', '1993/08/23', 70);
insert into contato
values (3, 'Roberto', 'Silva', '1992/04/22', 90);

