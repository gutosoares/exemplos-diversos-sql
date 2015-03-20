/* Banco de Dados 
   Nota Fiscal de uma Empresa
   Augusto Soares Pereira
*/

CREATE TABLE Cliente (
	Id_Cliente		VARCHAR(30)		NOT NULL,
	NomeCliente		VARCHAR(30)		NOT NULL,
	EnderecoCli		VARCHAR(50)		NOT NULL,
	FoneCli			VARCHAR(20)		NOT NULL,
	CONSTRAINT pk_idcli PRIMARY KEY	(Id_Cliente),
	CONSTANT uk_nomeCli UNIQUE (NomeCliente),
);

CREATE TABLE Vendedor (
	Id_Vendedor		int		        NOT NULL,
	NomeVendedor	VARCHAR(30)		NOT NULL,
	PercComissao	Numeric(8,2)	NOT NULL,
	CONSTRAINT pk_vend PRIMARY KEY (Id_Vendeor),
	CONSTRAINT uk_nomeVend UNIQUE (NomeVendedor),
);

CREATE TABLE Produto (
	codProd		int		        NO NULL,
	Descricao	VARCHAR(20)		NULL,
	qtdeEstoque	int		        NOT NULL,
	precoVenda	Numeric(8,2),
	CONSTRAINT pk_codP PRIMARY KEY (codProd),
);

CREATE TABLE NotaFiscal (
	numNF		    int		NOT NULL,
	DataEmissao		DATA	NOT NULL,
	Id_Cliente		int		NOT NULL,
	Id_Vendedor		int		NOT NULL,
	CONSTRAINT pk_NUMNF PRIMARY KEY (numNF),
	CONSTRAINT fk_IDCli FOREIGN KEY (Id_Cliente)
	REFERENCES Cliente (Id_Cliente)
	ON DELETE BLOBLOCK,
	CONSTRAINT fk_IDVend FOREIGN KEY (Id_Vendedor)
	REFERENCES Vendedor (Id_Vendedor)
	ON DELETE BLOBLOCK
);
	
CREATE TABLE ItensVenda (
	numItem			int 	NOT NULL,
	numNF			int		NOT NULL,
	codProd			int		NOT NULL,
	qtdeEstoque 	int		NOT NULL,
	precoVendido	Numeric(8.2)	NOT NULL,
	CONSTRAINT pk_NUMItem PRIMARY KEY (numItem),
	CONSTRAINT fk_codProd FOREIGN KEY (codProd) 
	REFERENCES Produto (codProd)
	ON DELETE BLOBLOCK,
 	CONSTRAINT fk_numNF FOREIGN KEY (numNF)
	REFERENCES NotaFiscal (numNF)
	ON DELETE
);

