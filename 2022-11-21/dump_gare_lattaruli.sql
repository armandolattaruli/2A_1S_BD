-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: gare_lattaruli
-- ------------------------------------------------------
-- Server version	5.7.9-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fondista`
--

DROP TABLE IF EXISTS `fondista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fondista` (
  `numero` int(11) NOT NULL,
  `nome` text NOT NULL,
  `cognome` text NOT NULL,
  `nazionalità` text NOT NULL,
  `età` int(11) NOT NULL,
  `gara` int(11) NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `gara` (`gara`),
  CONSTRAINT `fondista_ibfk_1` FOREIGN KEY (`gara`) REFERENCES `gare` (`idGara`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fondista`
--

LOCK TABLES `fondista` WRITE;
/*!40000 ALTER TABLE `fondista` DISABLE KEYS */;
INSERT INTO `fondista` VALUES (1,'armando','lattaruli','italiana',25,1),(2,'pippo','pippo','italiana',30,2),(3,'pluto','pluto','italiana',18,1),(4,'topolino','topolino','italiana',10,5),(5,'minnie','minnie','italiana',80,3);
/*!40000 ALTER TABLE `fondista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gare`
--

DROP TABLE IF EXISTS `gare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gare` (
  `idGara` int(11) NOT NULL,
  `nome` text NOT NULL,
  `luogo` text NOT NULL,
  `nazione` text NOT NULL,
  `lunghezza` int(11) NOT NULL,
  PRIMARY KEY (`idGara`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gare`
--

LOCK TABLES `gare` WRITE;
/*!40000 ALTER TABLE `gare` DISABLE KEYS */;
INSERT INTO `gare` VALUES (1,'gara1','bari','italia',100),(2,'gara2','napoli','italia',200),(3,'gara3','catania','italia',150),(4,'gara4','cagliari','italia',400),(5,'gara5','milano','italia',1000);
/*!40000 ALTER TABLE `gare` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-21 12:45:13
