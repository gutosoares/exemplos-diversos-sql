/* Banco de Dados de uma empresa */

CREATE TABLE Funcionario (
    CPF             VARCHAR(11)     NOT NULL,
    NomeFunc        VARCHAR(50)     NOT NULL,
    Endereco        VARCHAR(80)     NOT NULL,
    DataNasc        DATE            NOT NULL,
    Sexo            CHAR(1)         NOT NULL,
    Salario         DECIMAL(8,2)    NOT NULL,
    CPF_Superv      VARCHAR(11)     NULL,
    Dnr             int             NOT NULL,
    
    PRIMARY KEY(CPF),
    FOREIGN KEY (CPF_Superv) REFERENCES Funcionario (CPF)
);

CREATE TABLE Departamento (
    DnumeRo                 INT             NOT NULL,
    Dnome                   VARCHAR(30)     NOT NULL,
    CPF_Gerente             VARCHAR(11)     NOT NULL,
    Data_inicio_gerente     DATE            NULL,
    
    PRIMARY KEY(Dnumero),
    UNIQUE(Dnome),
    FOREIGN KEY (CPF_Gerente) REFERENCES Funcionario (CPF)
);

CREATE TABLE Localizacao_dep (
    Dnumero         INT             NOT NULL,
    Dlocal          VARCHAR(15)     NOT NULL,
    
    PRIMARY KEY(Dnumero, Dlocal),
    FOREIGN KEY(Dnumero) REFERENCES Departamento (Dnumero)
);

create table Projeto (
    Projnome        varchar(30)     not null,
    Projnumero      INT             not null,
    Projlical       varchar(30)     not null,
    Dnum            int             not null,
    
    primary key(Projnumero),
    foreign key(Dnum) references Departamento(Dnumero),
    unique(Projnome)
);

create table Dependente (
    Fcpf                    varchar(11)     not null,
    Nome_Dependente         varchar(50)     not null,
    DataNasc                date            not null,
    Sexo                    char(1)         not null,
    Parentesco              char(15)        null,
    
    primary key (Fcpf, Nome_Dependente),
    foreign key (Fcpf) references Funcionario (CPF)
);

create table Trabalha_em (
    Fcpf            varchar(11)     not null,
    Pnr             int             not null,
    Horas           decimal(6,1)    not null,
    
   primary key (Fcpf, Pnr),
   foreign key (Fcpf) references Funcionario (CPF),
   foreign key (Pnr) references Projeto (Projnumero)
);

ALTER TABLE Funcionario
ADD FOREIGN KEY (Dnr)
        REFERENCES Departamento (Dnumero);
    
/* Inserção de Dados */

INSERT INTO Departamento
VALUES (1,'Pesquisa',2);
INSERT INTO Departamento
VALUES (2,'Administração',8);
INSERT INTO Departamento
VALUES (3,'Construção',4);

INSERT INTO Dependente
VALUES (1,2,'Luciana','1990/11/05','F','Filha');
INSERT INTO Dependente
VALUES (2,2,'Paulo','1992/11/11','M','Filho');
INSERT INTO Dependente
VALUES (3,2,'Sandra','1996/12/14','F','Filha');
INSERT INTO Dependente
VALUES (4,4,'Mike','1997/11/05','M','Filho');
INSERT INTO Dependente
VALUES (5,1,'Max','1979/05/11','M','Filho');
INSERT INTO Dependente
VALUES (6,1,'Rita','1985/11/07','F','Filha');
INSERT INTO Dependente
VALUES (7,1,'Bety','1960/12/17','F','Esposa');

INSERT INTO Projeto
VALUES (1,'ProdX','Savassi',1);
INSERT INTO Projeto
VALUES (2,'ProdY','Luxemburgo',1);
INSERT INTO Projeto
VALUES (3,'ProdZ','Centro',1);
INSERT INTO Projeto
VALUES (10,'Computação','C. Nova',3);
INSERT INTO Projeto
VALUES (20,'Organização','Luxemburgo',2);
INSERT INTO Projeto
VALUES (30,'N. Benefícios','C. Nova',1);

INSERT INTO Trabalha
VALUES (1,1,32.5);
INSERT INTO Trabalha
VALUES (1,2,7.5);
INSERT INTO Trabalha
VALUES (5,3,40.0);
INSERT INTO Trabalha
VALUES (6,1,20.0);
INSERT INTO Trabalha
VALUES (6,2,20.0);
INSERT INTO Trabalha
VALUES (2,2,10.0);
INSERT INTO Trabalha
VALUES (2,3,10.0);
INSERT INTO Trabalha
VALUES (2,10,10.0);
INSERT INTO Trabalha
VALUES (2,20,10.0);
INSERT INTO Trabalha
VALUES (3,30,30.0);
INSERT INTO Trabalha
VALUES (3,10,10.0);
INSERT INTO Trabalha
VALUES (7,10,35.0);
INSERT INTO Trabalha
VALUES (7,30,5.0);
INSERT INTO Trabalha
VALUES (4,20,15.0);
INSERT INTO Trabalha
VALUES (8,20,NULL);

commit;