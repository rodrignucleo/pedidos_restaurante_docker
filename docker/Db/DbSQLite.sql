-- MySQL dump 10.16  Distrib 10.1.48-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	10.1.48-MariaDB-0+deb9u2
CREATE DATABASE IF NOT EXISTS DbRestaurante;
USE DbRestaurante;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Atendimento`
--

DROP TABLE IF EXISTS `Atendimento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Atendimento` (
  `AtendimentoId` INT NOT NULL,
  `MesaId` INT NOT NULL,
  `AtendimentoFechado` INT NOT NULL,
  `DataCriacao` varchar(27) NOT NULL,
  `DataSaida` varchar(26) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Atendimento`
--

LOCK TABLES `Atendimento` WRITE;
/*!40000 ALTER TABLE `Atendimento` DISABLE KEYS */;
INSERT INTO `Atendimento` VALUES (1,1,1,'2023-04-10 18:34:30.9550028','2023-05-15 08:52:43.196791'),(2,2,0,'2023-04-11 21:57:30.9550028',''),(21,4,1,'2023-04-17 10:46:44.6823062','2023-05-07 02:38:30.0183'),(73,20,0,'2023-05-07 02:46:07.800734','');
/*!40000 ALTER TABLE `Atendimento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categoria`
--

DROP TABLE IF EXISTS `Categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Categoria` (
  `CategoriaId` INT NOT NULL,
  `Nome` varchar(17) NOT NULL,
  `Descricao` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categoria`
--

LOCK TABLES `Categoria` WRITE;
/*!40000 ALTER TABLE `Categoria` DISABLE KEYS */;
INSERT INTO `Categoria` VALUES (1,'Bebidas Alcoólica','+18'),(2,'Bebidas','Todas as idades'),(3,'Frutos do Mar','Verificar Alergias'),(4,'Pizza','8 Pedaços'),(6,'Sucos','Feito de Frutas naturais'),(7,'Laticinios','Contém Leite');
/*!40000 ALTER TABLE `Categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Garcon`
--

DROP TABLE IF EXISTS `Garcon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Garcon` (
  `GarconId` INT NOT NULL,
  `Nome` varchar(8) NOT NULL,
  `Sobrenome` varchar(25) NOT NULL,
  `Cpf` varchar(14) NOT NULL,
  `Telefone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Garcon`
--

LOCK TABLES `Garcon` WRITE;
/*!40000 ALTER TABLE `Garcon` DISABLE KEYS */;
INSERT INTO `Garcon` VALUES (1,'Roberson','Silva','123.456.789.10','(11)98764-4578'),(2,'Fabiana','Oliveira Ferreira Andrade','654.987.321.58','(11)99847-3165'),(3,'Juan','Felix','546.328.173-43','(11) 99266-8225'),(5,'Maitê','Carolina Rosa Lopes','967.327.928-49','(21) 98672-8543'),(6,'Tomás','Marcelo Baptista','217.510.340-46','(91) 99606-8777'),(7,'Augusto','Oliveira','894.457.149-74','(45) 97874-4513');
/*!40000 ALTER TABLE `Garcon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mesa`
--

DROP TABLE IF EXISTS `Mesa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Mesa` (
  `MesaId` INT NOT NULL,
  `Numero` smallint(6) NOT NULL,
  `Status` INT NOT NULL,
  `HoraAbertura` varchar(27) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mesa`
--

LOCK TABLES `Mesa` WRITE;
/*!40000 ALTER TABLE `Mesa` DISABLE KEYS */;
INSERT INTO `Mesa` VALUES (1,1805,0,''),(2,205,1,'2023-05-07 03:37:37.3678925'),(3,240,0,''),(4,280,0,''),(20,777,1,'2023-05-07 04:09:57.8450952');
/*!40000 ALTER TABLE `Mesa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pedido` (
  `PedidoId` smallint(6) NOT NULL,
  `AtendimentoId` INT NOT NULL,
  `GarconId` INT NOT NULL,
  `HorarioPedido` varchar(19) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (1,2,3,'20:34:57'),(2,2,2,'20:47:23'),(3,2,1,'21:35:57'),(4,1,3,'21:35:57'),(5,1,2,'19:47:23'),(156,19,6,'2023-05-18 10:43:00'),(157,21,3,'2023-04-17 10:47:00'),(174,73,7,'2023-05-07 20:09:20'),(175,73,7,'2023-05-07 20:09:34');
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedido_Produto`
--

DROP TABLE IF EXISTS `Pedido_Produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pedido_Produto` (
  `PedidoProdutoId` INT NOT NULL,
  `PedidoId` smallint(6) NOT NULL,
  `ProdutoId` INT NOT NULL,
  `Quantidade` decimal(2,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido_Produto`
--

LOCK TABLES `Pedido_Produto` WRITE;
/*!40000 ALTER TABLE `Pedido_Produto` DISABLE KEYS */;
INSERT INTO `Pedido_Produto` VALUES (1,1,4,3.0),(2,2,6,7.0),(3,3,8,3.0),(4,4,1,1.0),(6,5,8,3.0),(11,157,8,5.0),(13,174,4,1.0),(14,175,11,2.0);
/*!40000 ALTER TABLE `Pedido_Produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Produto`
--

DROP TABLE IF EXISTS `Produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Produto` (
  `ProdutoId` INT NOT NULL,
  `Nome` varchar(21) NOT NULL,
  `Descricao` varchar(207) NOT NULL,
  `Preco` decimal(4,2) NOT NULL,
  `CategoriaId` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Produto`
--

LOCK TABLES `Produto` WRITE;
/*!40000 ALTER TABLE `Produto` DISABLE KEYS */;
INSERT INTO `Produto` VALUES (1,'Pizza de Calabresa','Uma pizza de calabresa é um prato típico da culinária italiana, composta por uma base de massa de pizza coberta com molho de tomate, queijo muçarela e fatias de calabresa, que é uma linguiça defumada picante',45.95,4),(2,'Pizza de Mussarela','Uma pizza de Mussarela é composta por uma base de massa de pizza coberta com molho de tomate, queijo Mussarela.',41.99,4),(4,'Caipirinha ','Limão',25.50,1),(5,'Vodka com Energetico ','Askov com RedBull',20.00,1),(6,'Sushi','Contém 4 peças',50.00,3),(7,'Sashimi','Contém 6 peças',55.00,3),(8,'Coca-Cola','600 ml',7.99,2),(9,'Sprite','450 ml',5.00,2),(11,'Sorvete 2 Bolas','Sabores: Morango, Chocolate, Baunilha, Maracujá, Flocos',13.99,7);
/*!40000 ALTER TABLE `Produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__EFMigrationsHistory`
--

DROP TABLE IF EXISTS `__EFMigrationsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(32) NOT NULL,
  `ProductVersion` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__EFMigrationsHistory`
--

LOCK TABLES `__EFMigrationsHistory` WRITE;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;
INSERT INTO `__EFMigrationsHistory` VALUES ('20230430025004_CreateDatabaseApi','7.0.5');
/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sqlite_sequence`
--

DROP TABLE IF EXISTS `sqlite_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sqlite_sequence` (
  `name` varchar(14) NOT NULL,
  `seq` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sqlite_sequence`
--

LOCK TABLES `sqlite_sequence` WRITE;
/*!40000 ALTER TABLE `sqlite_sequence` DISABLE KEYS */;
INSERT INTO `sqlite_sequence` VALUES ('Garcon',12),('Mesa',21),('Categoria',10),('Produto',12),('Atendimento',75),('Pedido',175),('Pedido_Produto',14);
/*!40000 ALTER TABLE `sqlite_sequence` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-27 22:44:48
