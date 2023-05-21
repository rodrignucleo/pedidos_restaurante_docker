CREATE DATABASE IF NOT EXISTS `DbRestaurante` DEFAULT CHARACTER SET utf8;
USE DbRestaurante;

CREATE TABLE Mesa (
	MesaId INT NOT NULL AUTO_INCREMENT,
	Numero INT NOT NULL,
	Status INT NOT NULL,
	HoraAbertura TEXT NULL,
	PRIMARY KEY (MesaId)
);

CREATE INDEX MesaId ON Mesa(MesaId);

CREATE TABLE Garcon (
	GarconId INT NOT NULL AUTO_INCREMENT,
	Nome TEXT NOT NULL,
	Sobrenome TEXT NOT NULL,
	Cpf TEXT NOT NULL,
	Telefone TEXT NOT NULL,
	PRIMARY KEY (GarconId)
);

CREATE INDEX GarconId ON Garcon(GarconId);

CREATE TABLE Categoria (
CategoriaId INT NOT NULL AUTO_INCREMENT,
Nome TEXT NOT NULL,
Descricao TEXT NOT NULL,
PRIMARY KEY (CategoriaId)
);

CREATE INDEX CategoriaId ON Categoria(CategoriaId);

CREATE TABLE Produto (
	ProdutoId INT NOT NULL AUTO_INCREMENT,
	Nome TEXT NOT NULL,
	Descricao TEXT NOT NULL,
	Preco FLOAT NOT NULL,
	CategoriaId INT NOT NULL,
	PRIMARY KEY (ProdutoId),
	FOREIGN KEY (CategoriaId) REFERENCES Categoria (CategoriaId) ON DELETE CASCADE
);

CREATE INDEX IX_Produto_CategoriaId ON Produto (CategoriaId);
CREATE INDEX ProdutoId ON Produto (ProdutoId);

CREATE TABLE Atendimento (
	AtendimentoId INT NOT NULL AUTO_INCREMENT,
	MesaId INT NOT NULL,
	AtendimentoFechado INT NOT NULL,
	DataCriacao TEXT NULL,
	DataSaida TEXT NULL,
	PRIMARY KEY (AtendimentoId),
	FOREIGN KEY (MesaId) REFERENCES Mesa (MesaId) ON DELETE CASCADE
);

CREATE INDEX IX_Atendimento_MesaId ON Atendimento (MesaId);
CREATE INDEX AtendimentoId ON Atendimento (AtendimentoId);

CREATE TABLE Pedido (
PedidoId INT NOT NULL AUTO_INCREMENT,
AtendimentoId INT NOT NULL,
GarconId INT NOT NULL,
HorarioPedido TEXT NOT NULL,
PRIMARY KEY (PedidoId),
FOREIGN KEY (AtendimentoId) REFERENCES Atendimento (AtendimentoId) ON DELETE CASCADE,
FOREIGN KEY (GarconId) REFERENCES Garcon (GarconId) ON DELETE CASCADE
);

CREATE INDEX IX_Pedido_AtendimentoId ON Pedido (AtendimentoId);
CREATE INDEX IX_Pedido_GarconId ON Pedido (GarconId);
CREATE INDEX PedidoId ON Pedido (PedidoId);

CREATE TABLE Pedido_Produto (
PedidoProdutoId INT NOT NULL AUTO_INCREMENT,
PedidoId INT NOT NULL,
ProdutoId INT NOT NULL,
Quantidade FLOAT NOT NULL,
PRIMARY KEY (PedidoProdutoId),
FOREIGN KEY (PedidoId) REFERENCES Pedido (PedidoId) ON DELETE CASCADE,
FOREIGN KEY (ProdutoId) REFERENCES Produto (ProdutoId) ON DELETE CASCADE
);

CREATE INDEX IX_Pedido_Produto_PedidoId ON Pedido_Produto (PedidoId);
CREATE INDEX IX_Pedido_Produto_ProdutoId ON Pedido_Produto (ProdutoId);
CREATE INDEX PedidoProdutoId ON Pedido_Produto (PedidoProdutoId);


#############################################
#####		INSERIR DADOS NO BANCO		#####
#############################################
/*
	Inserir Dados Garçom 
*/

INSERT into Garcon(
	GarconId,
	Nome,
	Sobrenome,
	Cpf,
	Telefone
)
SELECT 
	(SELECT COALESCE(MAX(GarconId),0) + 1 FROM Garcon) as GarconId,
	'Rodrigo' as Nome,
	'Ribeiro' as Sobrenome,
	'217419' as Cpf,
	'11992668225' as Telefone
;

INSERT into Garcon(
	GarconId,
	Nome,
	Sobrenome,
	Cpf,
	Telefone
)
SELECT 
	(SELECT COALESCE(MAX(GarconId),0) + 1 FROM Garcon) as GarconId,
	'Larissa' as Nome,
	'Valentina Helena Cardoso' as Sobrenome,
	'74177530352' as Cpf,
	'51987200752' as Telefone
;

INSERT into Garcon(
	GarconId,
	Nome,
	Sobrenome,
	Cpf,
	Telefone
)
SELECT 
	(SELECT COALESCE(MAX(GarconId),0) + 1 FROM Garcon) as GarconId,
	'Maitê' as Nome,
	'Carolina Rosa Lopes' as Sobrenome,
	'96732792849' as Cpf,
	'21986728543' as Telefone
;

INSERT into Garcon(
	GarconId,
	Nome,
	Sobrenome,
	Cpf,
	Telefone
)
SELECT 
	(SELECT COALESCE(MAX(GarconId),0) + 1 FROM Garcon) as GarconId,
	'Tomás' as Nome,
	'Marcelo Baptista' as Sobrenome,
	'21751034046' as Cpf,
	'91996068774' as Telefone
;

/*
	Inserir Dados Categoria 
*/

insert into Categoria(
	CategoriaId,
	Nome,
	Descricao
)
SELECT 
	(SELECT COALESCE(MAX(CategoriaId),0) + 1 FROM Categoria) as CategoriaId,
	'Bebidas Alcoólica' as Nome,
	'+18' as Descricao
;

insert into Categoria(
	CategoriaId,
	Nome,
	Descricao
)
SELECT 
	(SELECT COALESCE(MAX(CategoriaId),0) + 1 FROM Categoria) as CategoriaId,
	'Bebidas' as Nome,
	'Todas as idades' as Descricao
;

insert into Categoria(
	CategoriaId,
	Nome,
	Descricao
)
SELECT 
	(SELECT COALESCE(MAX(CategoriaId),0) + 1 FROM Categoria) as CategoriaId,
	'Frutos do Mar' as Nome,
	'Verificar Alergias' as Descricao
;

insert into Categoria(
	CategoriaId,
	Nome,
	Descricao
)
SELECT 
	(SELECT COALESCE(MAX(CategoriaId),0) + 1 FROM Categoria) as CategoriaId,
	'Pizza' as Nome,
	'8 Pedaços' as Descricao
;

/*
	Inserir Dados Produto 
*/

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Pizza de Calabresa' as Nome,
	'Uma pizza de calabresa é um prato típico da culinária italiana, composta por uma base de massa de pizza coberta com molho de tomate, queijo muçarela e fatias de calabresa, que é uma linguiça defumada picante. Alguns ingredientes opcionais, como cebola, azeitonas e pimentão, podem ser adicionados para dar um sabor extra à pizza. A pizza de calabresa é uma opção popular em pizzarias em todo o mundo, sendo um prato muito apreciado por quem gosta de alimentos saborosos e picantes.' as Descricao,
	37.66 as Preco,
	4 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Pizza de Calabresa' as Nome,
	'Uma pizza de calabresa é um prato típico da culinária italiana, composta por uma base de massa de pizza coberta com molho de tomate, queijo muçarela e fatias de calabresa, que é uma linguiça defumada picante. Alguns ingredientes opcionais, como cebola, azeitonas e pimentão, podem ser adicionados para dar um sabor extra à pizza. A pizza de calabresa é uma opção popular em pizzarias em todo o mundo, sendo um prato muito apreciado por quem gosta de alimentos saborosos e picantes.' as Descricao,
	36.96 as Preco,
	4 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Pizza 4 Queijos ' as Nome,
	'Uma pizza 4 queijos é um prato típico da culinária italiana, composta por uma base de massa de pizza coberta com molho de tomate e uma mistura de quatro tipos diferentes de queijos, que geralmente são: muçarela, parmesão, gorgonzola e provolone.' as Descricao,
	38.50 as Preco,
	4 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Caipirinha ' as Nome,
	'Limão' as Descricao,
	25.50 as Preco,
	1 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Vodka com Energetico ' as Nome,
	'Askov com RedBull' as Descricao,
	20.00 as Preco,
	1 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Sushi' as Nome,
	'Contém 4 peças' as Descricao,
	50.00 as Preco,
	3 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Sashimi' as Nome,
	'Contém 6 peças' as Descricao,
	55.00 as Preco,
	3 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Coca-Cola' as Nome,
	'600 ml' as Descricao,
	7.99 as Preco,
	2 as CategoriaId
;

insert into Produto(
	ProdutoId,
	Nome,
	Descricao,
	Preco,
	CategoriaId
)
SELECT 
	(SELECT COALESCE(MAX(ProdutoId),0) + 1 FROM Produto) as ProdutoId,
	'Sprite' as Nome,
	'450 ml' as Descricao,
	5.00 as Preco,
	2 as CategoriaId
;

/*
	Inserir Dados Mesa 
*/

insert into Mesa(
	MesaId,
	Numero,
	Status,
	HoraAbertura
)
SELECT 
	(SELECT COALESCE(MAX(MesaId),0) + 1 FROM Mesa)as MesaId,
	205 as Numero,
	true as Status,
	time('22:00') as HoraAbertura
;

insert into Mesa(
	MesaId,
	Numero,
	Status,
	HoraAbertura
)
SELECT 
	(SELECT COALESCE(MAX(MesaId),0) + 1 FROM Mesa)as MesaId,
	210 as Numero,
	true as Status,
	time('20:00') as HoraAbertura
;

insert into Mesa(
	MesaId,
	Numero,
	Status,
	HoraAbertura
)
SELECT 
	(SELECT COALESCE(MAX(MesaId),0) + 1 FROM Mesa)as MesaId,
	240 as Numero,
	false as Status,
	null as HoraAbertura
;

insert into Mesa(
	MesaId,
	Numero,
	Status,
	HoraAbertura
)
SELECT 
	(SELECT COALESCE(MAX(MesaId),0) + 1 FROM Mesa)as MesaId,
	280 as Numero,
	true as Status,
	time('20:30') as HoraAbertura
;

insert into Mesa(
	MesaId,
	Numero,
	Status,
	HoraAbertura
)
SELECT 
	(SELECT COALESCE(MAX(MesaId),0) + 1 FROM Mesa)as MesaId,
	360 as Numero,
	false as Status,
	null as HoraAbertura
;

insert into Mesa(
	MesaId,
	Numero,
	Status,
	HoraAbertura
)
SELECT 
	(SELECT COALESCE(MAX(MesaId),0) + 1 FROM Mesa)as MesaId,
	420 as Numero,
	false as Status,
	null as HoraAbertura
;

/*
	Inserir Dados Atendimento 
*/

insert into Atendimento(
	AtendimentoId,
	MesaId,
	AtendimentoFechado,
	DataCriacao
)
SELECT 
	(SELECT COALESCE(MAX(AtendimentoId),0) + 1 FROM Atendimento)as AtendimentoId,
	1 as MesaId,
	0 as AtendimentoFechado,
	current_timestamp() as DataCriacao
;

insert into Atendimento(
	AtendimentoId,
	MesaId,
	AtendimentoFechado,
	DataCriacao
)
SELECT 
	(SELECT COALESCE(MAX(AtendimentoId),0) + 1 FROM Atendimento)as AtendimentoId,
	2 as MesaId,
	0 as AtendimentoFechado,
	current_timestamp() as DataCriacao
;

insert into Atendimento(
	AtendimentoId,
	MesaId,
	AtendimentoFechado,
	DataCriacao
)
SELECT 
	(SELECT COALESCE(MAX(AtendimentoId),0) + 1 FROM Atendimento)as AtendimentoId,
	4 as MesaId,
	0 as AtendimentoFechado,
	current_timestamp() as DataCriacao
;

/*
	Inserir Dados Atendimento 
*/

insert into Pedido(
	PedidoId,
	AtendimentoId,
	GarconId,
	HorarioPedido
)
SELECT 
	(SELECT COALESCE(MAX(PedidoId),0) + 1 FROM Pedido)as PedidoId,
	2 as AtendimentoId,
	3 as GarconId,
	time('20:34:57') as HorarioPedido
;

insert into Pedido(
	PedidoId,
	AtendimentoId,
	GarconId,
	HorarioPedido
)
SELECT 
	(SELECT COALESCE(MAX(PedidoId),0) + 1 FROM Pedido)as PedidoId,
	2 as AtendimentoId,
	1 as GarconId,
	time('21:35:57') as HorarioPedido
;

insert into Pedido(
	PedidoId,
	AtendimentoId,
	GarconId,
	HorarioPedido
)
SELECT 
	(SELECT COALESCE(MAX(PedidoId),0) + 1 FROM Pedido)as PedidoId,
	1 as AtendimentoId,
	3 as GarconId,
	time('21:35:57') as HorarioPedido
;

insert into Pedido(
	PedidoId,
	AtendimentoId,
	GarconId,
	HorarioPedido
)
SELECT 
	(SELECT COALESCE(MAX(PedidoId),0) + 1 FROM Pedido)as PedidoId,
	2 as AtendimentoId,
	2 as GarconId,
	time('20:47:23') as HorarioPedido
;

insert into Pedido(
	PedidoId,
	AtendimentoId,
	GarconId,
	HorarioPedido
)
SELECT 
	(SELECT COALESCE(MAX(PedidoId),0) + 1 FROM Pedido)as PedidoId,
	1 as AtendimentoId,
	2 as GarconId,
	time('19:47:23') as HorarioPedido
;

insert into Pedido_Produto(
	PedidoProdutoId,
	PedidoId,
	ProdutoId,
	Quantidade
)
SELECT 
	(SELECT COALESCE(MAX(PedidoProdutoId),0) + 1 FROM Pedido_Produto)as PedidoProdutoId,
	1 as PedidoId,
	4 AS ProdutoId,
	3 as Quantidade
;

insert into Pedido_Produto(
	PedidoProdutoId,
	PedidoId,
	ProdutoId,
	Quantidade
)
SELECT 
	(SELECT COALESCE(MAX(PedidoProdutoId),0) + 1 FROM Pedido_Produto)as PedidoProdutoId,
	2 as PedidoId,
	6 AS ProdutoId,
	7 as Quantidade
;

insert into Pedido_Produto(
	PedidoProdutoId,
	PedidoId,
	ProdutoId,
	Quantidade
)
SELECT 
	(SELECT COALESCE(MAX(PedidoProdutoId),0) + 1 FROM Pedido_Produto)as PedidoProdutoId,
	3 as PedidoId,
	8 AS ProdutoId,
	3 as Quantidade
;

insert into Pedido_Produto(
	PedidoProdutoId,
	PedidoId,
	ProdutoId,
	Quantidade
)
SELECT 
	(SELECT COALESCE(MAX(PedidoProdutoId),0) + 1 FROM Pedido_Produto)as PedidoProdutoId,
	4 as PedidoId,
	1 AS ProdutoId,
	1 as Quantidade
;

insert into Pedido_Produto(
	PedidoProdutoId,
	PedidoId,
	ProdutoId,
	Quantidade
)
SELECT 
	(SELECT COALESCE(MAX(PedidoProdutoId),0) + 1 FROM Pedido_Produto)as PedidoProdutoId,
	4 as PedidoId,
	3 AS ProdutoId,
	1 as Quantidade
;

insert into Pedido_Produto(
	PedidoProdutoId,
	PedidoId,
	ProdutoId,
	Quantidade
)
SELECT 
	(SELECT COALESCE(MAX(PedidoProdutoId),0) + 1 FROM Pedido_Produto)as PedidoProdutoId,
	5 as PedidoId,
	8 AS ProdutoId,
	3 as Quantidade
;

