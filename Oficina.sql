/*                      Banco de Dados - Oficina

    Banco de dados referente ao trabalho da Disciplina de Banco de Dados I

    Banco de dados de uma Oficina Mecânica, que presta serviços de manutenção
    e venda de produtos automotivos.

*/
create schema Oficina;
use oficina;

CREATE TABLE Cliente (
    CPF             VARCHAR(14)     NOT NULL,
    Nome_Cliente    VARCHAR(30)     NOT NULL,
    Endereco        VARCHAR(30)     NOT NULL,
    Contato         VARCHAR(13)     NOT NULL,

    CONSTRAINT pk_CPF PRIMARY KEY (CPF),      -- CONSTRAINT seria o nome da restrição. Que tem como finalidade facilitar identificação da restrição para que possa ser removida ou subtituida.
    CONSTRAINT uk_nome UNIQUE (Nome_Cliente)
);

CREATE TABLE Veiculo (
    Placa           VARCHAR(8)      NOT NULL,
    Numero_Chassi   VARCHAR(17)     NOT NULL,
    Marca           VARCHAR(20)     NULL,
    Modelo          VARCHAR(20)     NOT NULL,
    Ano_Fab         DATE            NULL,
    CPF_Cliente     VARCHAR(14)     NOT NULL,

    CONSTRAINT pk_placa PRIMARY KEY (Placa),
    CONSTRAINT uk_chassi UNIQUE (Numero_Chassi),
    CONSTRAINT fk_cpf FOREIGN KEY (CPF_Cliente) REFERENCES Cliente (CPF) ON UPDATE RESTRICT
);

CREATE TABLE OS (
    id_OS                   int             NOT NULL,
    Valor_Total             DECIMAL(8,2)    NOT NULL,
    Data                    DATE            NOT NULL,
    CPF_Cliente             VARCHAR(14)     NOT NULL,
    Placa                   VARCHAR(8)      NOT NULL,
    Info_Complementar       VARCHAR(20)     NULL,

    CONSTRAINT pk_idOS PRIMARY KEY (id_OS),
    CONSTRAINT fk_cpfCli FOREIGN KEY (CPF_Cliente) REFERENCES Cliente (CPF) ON UPDATE RESTRICT,
    CONSTRAINT fk_placa FOREIGN KEY (Placa) REFERENCES Veiculo (Placa) ON UPDATE RESTRICT
);

CREATE TABLE Servico (
    id_Servico          INT             NOT NULL,
    Valor_Servico       DECIMAL(8,2)    NOT NULL,
    Descricao_Servico   VARCHAR(20)     NULL,

    CONSTRAINT pk_id_serv PRIMARY KEY (id_Servico)
);

CREATE TABLE Determina (
    id_OS           INT             NOT NULL,
    id_Servico      INT             NOT NULL,

    CONSTRAINT pk_determina PRIMARY KEY (id_OS, id_Servico),
    CONSTRAINT fk_determina_os FOREIGN KEY (id_OS) REFERENCES OS (id_OS) ON UPDATE CASCADE,
    CONSTRAINT fk_determina_serv FOREIGN KEY (id_Servico) REFERENCES Servico (id_Servico) ON UPDATE CASCADE
);

CREATE TABLE Produto (
    id_Produto         INT              NOT NULL,
    Valor_Produto      DECIMAL(8.2)     NOT NULL,
    Custo              DECIMAL(8.2)     NOT NULL,
    Quantidade         INT              NOT NULL,
    Descricao_Produto  VARCHAR(45)      NULL,

    CONSTRAINT pk_idprod PRIMARY KEY (id_Produto)
);

CREATE TABLE OP (
    id_OS           INT             NOT NULL,
    id_Produto      INT             NOT NULL,
    Quantidade      INT             NOT NULL,

    CONSTRAINT pk_op PRIMARY KEY (id_OS, id_Produto),
    CONSTRAINT fk_op_idos FOREIGN KEY (id_OS) REFERENCES OS (id_OS) ON UPDATE CASCADE,
    CONSTRAINT fk_op_idprod FOREIGN KEY (id_Produto) REFERENCES Produto (id_Produto) ON UPDATE CASCADE
);

CREATE TABLE Fornecedor (
    id_Fornecedor           INT             NOT NULL,
    Nome_Fornecedor         VARCHAR(45)     NOT NULL,

    CONSTRAINT pk_idforn PRIMARY KEY (id_Fornecedor)
);

CREATE TABLE Fornecido (
    id_Fornecedor         INT          NOT NULL,
    id_Produto            INT          NOT NULL,

    CONSTRAINT pk_fornecido PRIMARY KEY (id_Fornecedor, id_Produto),
    CONSTRAINT fk_fornecido_for FOREIGN KEY (id_Fornecedor) REFERENCES Fornecedor (id_Fornecedor) ON UPDATE CASCADE,
    CONSTRAINT fk_fornecido_pro FOREIGN KEY (id_Produto) REFERENCES Produto (id_Produto) ON UPDATE CASCADE
);

-- Cadastro de clientes
INSERT INTO Cliente
VALUES ('101.111.121-01','João B. Silva','R. Guaicui, 175','(35)3821-0921');
INSERT INTO Cliente
VALUES ('102.222.121-02','Frank T. Santos','R. Gentios, 22','(35)3822-0671');
INSERT INTO Cliente
VALUES ('103.333.121-03','Alice N. Pereira','R. Curitiba, 11','(35)3821-0515');
INSERT INTO Cliente
VALUES ('104.444.121-04','Júnia B. Mendes','R. E. Santos, 123','(35)3822-0706');
INSERT INTO Cliente
VALUES ('105.555.121-05','José S. Tavares','R. Iraí, 153','(35)3821-1012');
INSERT INTO Cliente
VALUES ('106.666.121-06','Luciana S. Santos','R. Iraí, 175','(35)3822-6010');
INSERT INTO Cliente
VALUES ('107.777.121-07','Maria P. Ramos','R. C. Linhares, 10','(35)3821-1105');
INSERT INTO Cliente
VALUES ('108.888.121-08','Jaime A. Mendes','R. Bahia, 111','(35)3821-1125');

-- Cadastro de veiculos
INSERT INTO Veiculo
VALUES ('HKP-3880','RD08X0.4123423567','Ford','Focus Sedan','2005/02/01','101.111.121-01');
INSERT INTO Veiculo
VALUES ('GHP-2301','OU87X8.4562523546','Volkswagen','Polo','2008/06/03','102.222.121-02');
INSERT INTO Veiculo
VALUES ('CQC-1232','AU32X8.7747538538','FIAT','Strada','2010/04/12','103.333.121-03');
INSERT INTO Veiculo
VALUES ('PEF-0337','AU08X8.8248124817','FIAT','Ideia','2013/12/09','104.444.121-04');
INSERT INTO Veiculo
VALUES ('NIY-0045','ER20X8.3875668138','Volkswagen','Gol','2010/11/20','105.555.121-05');
INSERT INTO Veiculo
VALUES ('PER-2012','BN12X8.1835672357','Citroen','C4 Lounge','2014/02/20','106.666.121-06');
INSERT INTO Veiculo
VALUES ('DUQ-6219','CV09X8.1763652673','Honda','Civic','2012/08/20','107.777.121-07');
INSERT INTO Veiculo
VALUES ('HHF-7713','AK47X8.9876341362','Volkswagen','Fusca','1967/02/20','108.888.121-08');

-- Cadastro de ordem de servço
INSERT INTO OS
VALUES (1,550,'2014/07/04','101.111.121-01','HKP-3880','Pneu + Oleo.');
INSERT INTO OS
VALUES (2,100,'2014/01/04','108.888.121-08','HHF-7713','Rev. eletrica');
INSERT INTO OS
VALUES (3,450,'2013/07/04','105.555.121-05','NIY-0045','Pneus');
INSERT INTO OS
VALUES (4,500,'2014/07/04','103.333.121-03','CQC-1232','Troca Freio');
INSERT INTO OS
VALUES (5,300,'2014/07/04','102.222.121-02','GHP-2301','Rev. Ar Bag');
INSERT INTO OS
VALUES (6,1000,'2014/07/08','104.444.121-04','PEF-0337','Rev. Completa');
INSERT INTO OS
VALUES (7,50,'2013/07/04','106.666.121-06','PER-2012','Filtro ar');
INSERT INTO OS
VALUES (8,100,'2014/01/04','107.777.121-07','DUQ-6219','Troca oleo');

-- Cadastro dos tipos de serviço
INSERT INTO Servico
VALUES (10,450,'Troca de pneus');   -- Total = 50(serviço) + 400(4 pneus novos)
INSERT INTO Servico
VALUES (20,100,'Troca de oleo');    -- Total = 50(oleo) + 50(serviço)
INSERT INTO Servico
VALUES (30,1000,'Revisão completa');
INSERT INTO Servico
VALUES (40,500,'Pastilhas de freio');   -- Total = 100(serviço) + 400(4 pastilhas novas)
INSERT INTO Servico
VALUES (50,300,'Revisão Ar Bag');
INSERT INTO Servico
VALUES (60,100,'Revisão eletrica');
INSERT INTO Servico
VALUES (70,300,'Manut. Ar-cond.');
INSERT INTO Servico
VALUES (80,50,'Filtro de ar');     -- Total = 20(serviço) = 30(filtro)

-- Tabela Determina
INSERT INTO Determina
VALUES (1,10);
INSERT INTO Determina
VALUES (1,20);
INSERT INTO Determina
VALUES (2,60);
INSERT INTO Determina
VALUES (3,10);
INSERT INTO Determina
VALUES (4,40);
INSERT INTO Determina
VALUES (5,50);
INSERT INTO Determina
VALUES (6,30);
INSERT INTO Determina
VALUES (7,80);
INSERT INTO Determina
VALUES (8,20);

-- Cadastro dos tipos de produtos
INSERT INTO Produto
VALUES (100,100,50,300,'Pneu novo');
INSERT INTO Produto
VALUES (200,50,30,80,'Filtro de Oleo');
INSERT INTO Produto
VALUES (300,400,80,25,'Pastilhas freio');
INSERT INTO Produto
VALUES (400,30,15,10,'Filtro de ar');

-- Tabela OP
INSERT INTO OP
VALUES (1,100);
INSERT INTO OP
VALUES (1,200);
INSERT INTO OP
VALUES (3,100);
INSERT INTO OP
VALUES (7,400);
INSERT INTO OP
VALUES (8,200);

-- Cadastro de fornecedores
INSERT INTO Fornecedor
VALUES (1,'ABC Produtos');
INSERT INTO Fornecedor
VALUES (15,'SK Automotive');
INSERT INTO Fornecedor
VALUES (5,'Lubrax Oil');

-- Tabela Fornecido
INSERT INTO Fornecido
VALUES (1,100);
INSERT INTO Fornecido
VALUES (1,300);
INSERT INTO Fornecido
VALUES (15,100);
INSERT INTO Fornecido
VALUES (15,400);
INSERT INTO Fornecido
VALUES (5,200);

-- Exemplos de ALTER TABLE
ALTER TABLE Cliente 