DROP DATABASE IF EXISTS `DbRestaurante`;
CREATE DATABASE `DbRestaurante` DEFAULT CHARACTER SET utf8;
USE DbRestaurante;

DROP TABLE IF EXISTS `Mesa`;

CREATE TABLE `Mesa` (
  `MesaId` INT NOT NULL AUTO_INCREMENT,
  `Numero` INT NOT NULL,
  `Status` INT NOT NULL,
  `HoraAbertura` datetime,
  PRIMARY KEY(`MesaId`)
);

DROP TABLE IF EXISTS `Atendimento`;

CREATE TABLE `Atendimento` (
    `AtendimentoId` INT NOT NULL AUTO_INCREMENT,
    `MesaId` INT NOT NULL,
    `AtendimentoFechado` INT NOT NULL,
    `DataCriacao` datetime,
    `DataSaida` datetime,
    PRIMARY KEY(`AtendimentoId`),
    CONSTRAINT `fk_atendimentomesa`
        FOREIGN KEY (`MesaId`)
        REFERENCES `Mesa` (`MesaId`)
);

CREATE INDEX `fk_atendimentomesa_idx` ON `Atendimento` (`MesaId` ASC) VISIBLE;

DROP TABLE IF EXISTS `Categoria`;

CREATE TABLE `Categoria` (
  `CategoriaId` INT NOT NULL AUTO_INCREMENT,
  `Nome` varchar(25) NOT NULL,
  `Descricao` varchar(207) NOT NULL,
  PRIMARY KEY(`CategoriaId`)
);

DROP TABLE IF EXISTS `Garcon`;

CREATE TABLE `Garcon` (
  `GarconId` INT NOT NULL AUTO_INCREMENT,
  `Nome` varchar(35) NOT NULL,
  `Sobrenome` varchar(35) NOT NULL,
  `Cpf` varchar(14) NOT NULL,
  `Telefone` varchar(15) NOT NULL,
  PRIMARY KEY(`GarconId`)
);

DROP TABLE IF EXISTS `Pedido`;

CREATE TABLE `Pedido` (
  `PedidoId` INT NOT NULL AUTO_INCREMENT,
  `AtendimentoId` INT NOT NULL,
  `GarconId` INT NOT NULL,
  `HorarioPedido` varchar(27) NOT NULL,
  PRIMARY KEY(`PedidoId`),
  CONSTRAINT `fk_pedidoatendimento`
    FOREIGN KEY (`AtendimentoId`)
    REFERENCES `Atendimento` (`AtendimentoId`),
  CONSTRAINT `fk_pedidogarcon`
    FOREIGN KEY (`GarconId`)
    REFERENCES `Garcon` (`GarconId`)
);

CREATE INDEX `fk_pedidoatendimento_idx` ON `Pedido` (`AtendimentoId` ASC) VISIBLE;
CREATE INDEX `fk_pedidogarcon_idx` ON `Pedido` (`GarconId` ASC) VISIBLE;

DROP TABLE IF EXISTS `Produto`;

CREATE TABLE `Produto` (
  `ProdutoId` INT NOT NULL AUTO_INCREMENT,
  `Nome` varchar(25) NOT NULL,
  `Descricao` varchar(220) NOT NULL,
  `Preco` decimal(4,2) NOT NULL,
  `CategoriaId` INT NOT NULL,
  PRIMARY KEY(`ProdutoId`),
  CONSTRAINT `fk_produtocategoria`
    FOREIGN KEY (`CategoriaId`)
    REFERENCES `Categoria` (`CategoriaId`)
);

CREATE INDEX `fk_produtcategoria_idx` ON `Produto` (`CategoriaId` ASC) VISIBLE;

DROP TABLE IF EXISTS `Pedido_Produto`;

CREATE TABLE `Pedido_Produto` (
  `PedidoProdutoId` INT NOT NULL AUTO_INCREMENT,
  `PedidoId` INT NOT NULL,
  `ProdutoId` INT NOT NULL,
  `Quantidade` decimal(2,1) NOT NULL,
  PRIMARY KEY(`PedidoProdutoId`),
  CONSTRAINT `fk_pedidoprodutopedido`
    FOREIGN KEY (`PedidoId`)
    REFERENCES `Pedido` (`PedidoId`),
  CONSTRAINT `fk_pedidoprodutoproduto`
    FOREIGN KEY (`ProdutoId`)
    REFERENCES `Produto` (`ProdutoId`)
);

CREATE INDEX `fk_pedidoprodutopedido_idx` ON `Pedido_Produto` (`PedidoId` ASC) VISIBLE;
CREATE INDEX `fk_pedidoprodutoproduto_idx` ON `Pedido_Produto` (`ProdutoId` ASC) VISIBLE;


INSERT INTO `Categoria` VALUES (1,'Bebidas Alcoólica','+18'),(2,'Bebidas','Todas as idades'),(3,'Frutos do Mar','Verificar Alergias'),(4,'Pizza','8 Pedaços'),(6,'Sucos','Feito de Frutas naturais'),(7,'Laticinios','Contém Leite');
INSERT INTO `Garcon` VALUES (1,'Roberson','Silva','123.456.789.10','(11)98764-4578'),(2,'Fabiana','Oliveira Ferreira Andrade','654.987.321.58','(11)99847-3165'),(3,'Juan','Felix','546.328.173-43','(11) 99266-8225'),(5,'Maitê','Carolina Rosa Lopes','967.327.928-49','(21) 98672-8543'),(6,'Tomás','Marcelo Baptista','217.510.340-46','(91) 99606-8777'),(7,'Augusto','Oliveira','894.457.149-74','(45) 97874-4513');
INSERT INTO `Mesa` VALUES (1,1805,0,null),(2,205,1,'2023-05-07 03:37:37'),(3,240,0,null),(4,280,0,null),(20,777,1,'2023-05-07 04:09:57');
INSERT INTO `Produto` VALUES (1,'Pizza de Calabresa','Uma pizza de calabresa é um prato típico da culinária italiana, composta por uma base de massa de pizza coberta com molho de tomate, queijo muçarela e fatias de calabresa, que é uma linguiça defumada picante',45.95,4),(2,'Pizza de Mussarela','Uma pizza de Mussarela é composta por uma base de massa de pizza coberta com molho de tomate, queijo Mussarela.',41.99,4),(4,'Caipirinha ','Limão',25.50,1),(5,'Vodka com Energetico ','Askov com RedBull',20.00,1),(6,'Sushi','Contém 4 peças',50.00,3),(7,'Sashimi','Contém 6 peças',55.00,3),(8,'Coca-Cola','600 ml',7.99,2),(9,'Sprite','450 ml',5.00,2),(11,'Sorvete 2 Bolas','Sabores: Morango, Chocolate, Baunilha, Maracujá, Flocos',13.99,7);
INSERT INTO `Atendimento` VALUES (1,1,1,'2023-04-10 18:34:30','2023-05-15 08:52:43'),(2,2,0,'2023-04-11 21:57:30', null),(21,4,1,'2023-04-17 10:46:44','2023-05-07 02:38:30'),(73,20,0,'2023-05-07 02:46:07', null);
INSERT INTO `Pedido` VALUES (1,2,3,'20:34:57'),(2,2,2,'20:47:23'),(3,2,1,'21:35:57'),(4,1,3,'21:35:57'),(5,1,2,'19:47:23'),(157,21,3,'10:47:00'),(174,73,7,'20:09:20'),(175,73,7,'20:09:34');
INSERT INTO `Pedido_Produto` VALUES (1,1,4,3.0),(2,2,6,7.0),(3,3,8,3.0),(4,4,1,1.0),(6,5,8,3.0),(11,157,8,5.0),(13,174,4,1.0),(14,175,11,2.0);