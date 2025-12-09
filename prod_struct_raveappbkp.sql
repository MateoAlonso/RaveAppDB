-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: localhost    Database: prod_raveapp
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tblartista`
--

DROP TABLE IF EXISTS `tblartista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblartista` (
  `idartista` varchar(36) NOT NULL,
  `dsnombre` varchar(45) DEFAULT NULL,
  `dsbio` text,
  `dtalta` date DEFAULT NULL,
  `isactivo` tinyint DEFAULT NULL,
  `idsocial` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`idartista`),
  KEY `tblartista_tblsocial_fk` (`idsocial`),
  CONSTRAINT `tblartista_tblsocial_fk` FOREIGN KEY (`idsocial`) REFERENCES `tblsocial` (`idsocial`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblartistafav`
--

DROP TABLE IF EXISTS `tblartistafav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblartistafav` (
  `idartista_fav` varchar(36) NOT NULL DEFAULT (uuid()),
  `idusuario` varchar(36) DEFAULT NULL,
  `idartista` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`idartista_fav`),
  KEY `FK_artista_tblartistafav` (`idartista`),
  KEY `FK_usuario_tblartistafav` (`idusuario`),
  CONSTRAINT `FK_usuario_tblartistafav` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`),
  CONSTRAINT `tblartistafav_tblusuario_FK` FOREIGN KEY (`idartista`) REFERENCES `tblartista` (`idartista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblcobranza`
--

DROP TABLE IF EXISTS `tblcobranza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcobranza` (
  `idcobranza` varchar(36) NOT NULL DEFAULT (uuid()),
  `idcompra` varchar(36) DEFAULT NULL,
  `ammontocancelado` decimal(19,4) DEFAULT NULL,
  `cdmediopago` int DEFAULT NULL,
  PRIMARY KEY (`idcobranza`),
  KEY `FK_mediopago_tblcobranza_idx` (`cdmediopago`),
  KEY `FK_compra_tblcobranza` (`idcompra`),
  CONSTRAINT `FK_compra_tblcobranza` FOREIGN KEY (`idcompra`) REFERENCES `tblcompra` (`idcompra`),
  CONSTRAINT `FK_mediopago_tblcobranza` FOREIGN KEY (`cdmediopago`) REFERENCES `tblmediopago` (`cdmediopago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblcompra`
--

DROP TABLE IF EXISTS `tblcompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblcompra` (
  `idcompra` varchar(36) NOT NULL DEFAULT (uuid()),
  `idusuario` varchar(36) DEFAULT NULL,
  `ammonto` decimal(19,4) DEFAULT NULL,
  `cdestado` int DEFAULT NULL,
  `dtinsert` datetime DEFAULT NULL,
  `amsubtotal` decimal(19,4) DEFAULT NULL,
  `amservicio` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`idcompra`),
  KEY `FK_estadocompra_tblcompra_idx` (`cdestado`),
  KEY `FK_usuario_tblcompra` (`idusuario`),
  CONSTRAINT `FK_estadocompra_tblcompra` FOREIGN KEY (`cdestado`) REFERENCES `tblestadocompra` (`cdestado`),
  CONSTRAINT `FK_usuario_tblcompra` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbldomicilio`
--

DROP TABLE IF EXISTS `tbldomicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbldomicilio` (
  `iddomicilio` varchar(36) NOT NULL DEFAULT (uuid()),
  `dsdireccion` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cdlocalidad` varchar(36) DEFAULT NULL,
  `cdmunicipio` varchar(36) DEFAULT NULL,
  `cdprovincia` varchar(36) DEFAULT NULL,
  `nmlatitud` decimal(10,0) DEFAULT NULL,
  `nmlongitud` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`iddomicilio`),
  KEY `tbldomicilio_tbllocalidad_FK` (`cdlocalidad`),
  KEY `tbldomicilio_tblprovincia_FK` (`cdprovincia`),
  KEY `tbldomicilio_tblmunicipio_FK` (`cdmunicipio`),
  CONSTRAINT `tbldomicilio_tbllocalidad_FK` FOREIGN KEY (`cdlocalidad`) REFERENCES `tbllocalidad` (`cdlocalidad`),
  CONSTRAINT `tbldomicilio_tblmunicipio_FK` FOREIGN KEY (`cdmunicipio`) REFERENCES `tblmunicipio` (`cdmunicipio`),
  CONSTRAINT `tbldomicilio_tblprovincia_FK` FOREIGN KEY (`cdprovincia`) REFERENCES `tblprovincia` (`cdprovincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblentrada`
--

DROP TABLE IF EXISTS `tblentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblentrada` (
  `identrada` varchar(36) NOT NULL DEFAULT (uuid()),
  `idcompra` varchar(36) DEFAULT NULL,
  `mdqr` varchar(200) DEFAULT NULL,
  `cdestado` int DEFAULT NULL,
  `cdtipo` int DEFAULT NULL,
  `amprecio` decimal(19,4) DEFAULT NULL,
  `idfecha` varchar(36) DEFAULT NULL,
  `dtreserva` datetime DEFAULT NULL,
  PRIMARY KEY (`identrada`),
  KEY `FK_compra_tblentrada` (`idcompra`),
  KEY `FK_estadoentrada_tblentrada` (`cdestado`),
  KEY `FK_tipoentrada_tblentrada` (`cdtipo`),
  KEY `tblentrada_tblfecha_FK` (`idfecha`),
  CONSTRAINT `FK_compra_tblentrada` FOREIGN KEY (`idcompra`) REFERENCES `tblcompra` (`idcompra`) ON DELETE SET NULL,
  CONSTRAINT `FK_estadoentrada_tblentrada` FOREIGN KEY (`cdestado`) REFERENCES `tblestadoentrada` (`cdestado`),
  CONSTRAINT `FK_tipoentrada_tblentrada` FOREIGN KEY (`cdtipo`) REFERENCES `tbltipoentrada` (`cdtipo`),
  CONSTRAINT `tblentrada_tblfecha_FK` FOREIGN KEY (`idfecha`) REFERENCES `tblfecha` (`idfecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblestadocompra`
--

DROP TABLE IF EXISTS `tblestadocompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblestadocompra` (
  `cdestado` int NOT NULL,
  `dsestado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblestadoentrada`
--

DROP TABLE IF EXISTS `tblestadoentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblestadoentrada` (
  `cdestado` int NOT NULL,
  `dsestado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblestadoevento`
--

DROP TABLE IF EXISTS `tblestadoevento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblestadoevento` (
  `cdestado` int NOT NULL,
  `dsestado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblestadofecha`
--

DROP TABLE IF EXISTS `tblestadofecha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblestadofecha` (
  `cdestado` int NOT NULL,
  `dsestado` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cdestado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblevento`
--

DROP TABLE IF EXISTS `tblevento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblevento` (
  `idevento` varchar(36) NOT NULL DEFAULT (uuid()),
  `iddomicilio` varchar(36) DEFAULT NULL,
  `idusuario` varchar(36) DEFAULT NULL,
  `dsnombre` varchar(200) DEFAULT NULL,
  `dsevento` text,
  `cdestado` int DEFAULT NULL,
  `dtinsert` datetime DEFAULT NULL,
  `isafter` tinyint DEFAULT NULL,
  `islgbt` tinyint DEFAULT NULL,
  `dtinicioevento` datetime DEFAULT NULL,
  `dtfinevento` datetime DEFAULT NULL,
  `idfiesta` varchar(36) DEFAULT NULL,
  `idsocial` varchar(36) DEFAULT NULL,
  `mdsoundcloud` varchar(200) DEFAULT NULL,
  `dtupdate` datetime DEFAULT NULL,
  PRIMARY KEY (`idevento`),
  KEY `FK_domicilio_tblevento` (`iddomicilio`),
  KEY `FK_usuario_tblevento` (`idusuario`),
  KEY `FK_estadoevento_tblevento` (`cdestado`),
  KEY `tblevento_tblfiesta_FK` (`idfiesta`),
  KEY `tblevento_tblsocial_FK` (`idsocial`),
  CONSTRAINT `FK_domicilio_tblevento` FOREIGN KEY (`iddomicilio`) REFERENCES `tbldomicilio` (`iddomicilio`),
  CONSTRAINT `FK_estadoevento_tblevento` FOREIGN KEY (`cdestado`) REFERENCES `tblestadoevento` (`cdestado`),
  CONSTRAINT `FK_usuario_tblevento` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`),
  CONSTRAINT `tblevento_tblfiesta_FK` FOREIGN KEY (`idfiesta`) REFERENCES `tblfiesta` (`idfiesta`),
  CONSTRAINT `tblevento_tblsocial_FK` FOREIGN KEY (`idsocial`) REFERENCES `tblsocial` (`idsocial`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblevento_artista`
--

DROP TABLE IF EXISTS `tblevento_artista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblevento_artista` (
  `idevento_artista` varchar(36) NOT NULL DEFAULT (uuid()),
  `idevento` varchar(36) DEFAULT NULL,
  `idartista` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`idevento_artista`),
  KEY `FK_evento_tblevento_artista` (`idevento`),
  KEY `FK_artista_tblevento_artista` (`idartista`),
  CONSTRAINT `FK_evento_tblevento_artista` FOREIGN KEY (`idevento`) REFERENCES `tblevento` (`idevento`),
  CONSTRAINT `tblevento_artista_tblartista_FK` FOREIGN KEY (`idartista`) REFERENCES `tblartista` (`idartista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblevento_genero`
--

DROP TABLE IF EXISTS `tblevento_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblevento_genero` (
  `idevento_genero` varchar(36) NOT NULL DEFAULT 'uuid()',
  `idevento` varchar(36) DEFAULT NULL,
  `cdgenero` int DEFAULT NULL,
  PRIMARY KEY (`idevento_genero`),
  UNIQUE KEY `tblevento_genero_unique` (`idevento`,`cdgenero`),
  KEY `tblevento_genero_tblgeneroevento_FK` (`cdgenero`),
  CONSTRAINT `tblevento_genero_tblevento_FK` FOREIGN KEY (`idevento`) REFERENCES `tblevento` (`idevento`) ON DELETE CASCADE,
  CONSTRAINT `tblevento_genero_tblgeneroevento_FK` FOREIGN KEY (`cdgenero`) REFERENCES `tblgeneroevento` (`cdgenero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblevento_usuario`
--

DROP TABLE IF EXISTS `tblevento_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblevento_usuario` (
  `ideventousuario` varchar(36) NOT NULL DEFAULT (uuid()),
  `idusuario` varchar(36) DEFAULT NULL,
  `idevento` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ideventousuario`),
  UNIQUE KEY `tblevento_usuario_uk` (`idevento`,`idusuario`),
  KEY `tblevento_usuario_tblusuario_idusuario_fk` (`idusuario`),
  CONSTRAINT `tblevento_usuario_tblevento_idevento_fk` FOREIGN KEY (`idevento`) REFERENCES `tblevento` (`idevento`),
  CONSTRAINT `tblevento_usuario_tblusuario_idusuario_fk` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbleventofav`
--

DROP TABLE IF EXISTS `tbleventofav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbleventofav` (
  `ideventosfav` varchar(36) NOT NULL DEFAULT (uuid()),
  `idusuario` varchar(36) DEFAULT NULL,
  `idevento` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ideventosfav`),
  KEY `FK_usuario_tbleventofav` (`idusuario`),
  KEY `FK_evento_tbleventofav` (`idevento`),
  CONSTRAINT `FK_evento_tbleventofav` FOREIGN KEY (`idevento`) REFERENCES `tblevento` (`idevento`),
  CONSTRAINT `FK_usuario_tbleventofav` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblfecha`
--

DROP TABLE IF EXISTS `tblfecha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblfecha` (
  `idfecha` varchar(36) NOT NULL,
  `idevento` varchar(36) DEFAULT NULL,
  `dtinicio` datetime DEFAULT NULL,
  `dtfin` datetime DEFAULT NULL,
  `cdestado` int DEFAULT NULL,
  `dtinicioventa` datetime DEFAULT NULL,
  `dtfinventa` datetime DEFAULT NULL,
  PRIMARY KEY (`idfecha`),
  KEY `tblfecha_tblevento_FK` (`idevento`),
  KEY `tblfecha_tblestadofecha_FK` (`cdestado`),
  CONSTRAINT `tblfecha_tblestadofecha_FK` FOREIGN KEY (`cdestado`) REFERENCES `tblestadofecha` (`cdestado`),
  CONSTRAINT `tblfecha_tblevento_FK` FOREIGN KEY (`idevento`) REFERENCES `tblevento` (`idevento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblfiesta`
--

DROP TABLE IF EXISTS `tblfiesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblfiesta` (
  `idfiesta` varchar(36) NOT NULL,
  `idusuario` varchar(36) DEFAULT NULL,
  `dsnombre` varchar(200) DEFAULT NULL,
  `isactivo` tinyint DEFAULT NULL,
  `idsocial` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`idfiesta`),
  KEY `tblfiesta_tblusuario_FK` (`idusuario`),
  KEY `tblfiesta_tblsocial_FK` (`idsocial`),
  CONSTRAINT `tblfiesta_tblsocial_FK` FOREIGN KEY (`idsocial`) REFERENCES `tblsocial` (`idsocial`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tblfiesta_tblusuario_FK` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblgeneroevento`
--

DROP TABLE IF EXISTS `tblgeneroevento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblgeneroevento` (
  `cdgenero` int NOT NULL,
  `dsgenero` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdgenero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbllocalidad`
--

DROP TABLE IF EXISTS `tbllocalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbllocalidad` (
  `dslocalidad` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cdlocalidad` varchar(36) NOT NULL,
  PRIMARY KEY (`cdlocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblloggeneral`
--

DROP TABLE IF EXISTS `tblloggeneral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblloggeneral` (
  `idloggegneral` varchar(36) NOT NULL DEFAULT (uuid()),
  `dsmensaje` text,
  `dsmodulo` varchar(200) DEFAULT NULL,
  `nmcodigo` varchar(100) DEFAULT NULL,
  `dssqlex` varchar(100) DEFAULT NULL,
  `dtinsert` datetime DEFAULT NULL,
  PRIMARY KEY (`idloggegneral`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbllogwebhookmp`
--

DROP TABLE IF EXISTS `tbllogwebhookmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbllogwebhookmp` (
  `idlog` varchar(36) NOT NULL,
  `idcompra` varchar(36) DEFAULT NULL,
  `dsestadopago` varchar(100) DEFAULT NULL,
  `dsdealleestadopago` varchar(100) DEFAULT NULL,
  `ammonto` decimal(19,4) DEFAULT NULL,
  `dtinsert` datetime DEFAULT NULL,
  `idpagomp` bigint DEFAULT NULL,
  PRIMARY KEY (`idlog`),
  KEY `tbllogwebhookmp_tblcompra_FK` (`idcompra`),
  CONSTRAINT `tbllogwebhookmp_tblcompra_FK` FOREIGN KEY (`idcompra`) REFERENCES `tblcompra` (`idcompra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblmedia`
--

DROP TABLE IF EXISTS `tblmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmedia` (
  `idmedia` varchar(36) NOT NULL DEFAULT (uuid()),
  `identidadmedia` varchar(36) DEFAULT NULL,
  `mdvideo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idmedia`),
  KEY `tblmedia_identidadmedia_IDX` (`identidadmedia`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblmediopago`
--

DROP TABLE IF EXISTS `tblmediopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmediopago` (
  `cdmediopago` int NOT NULL,
  `dsmediopago` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdmediopago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblmunicipio`
--

DROP TABLE IF EXISTS `tblmunicipio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblmunicipio` (
  `dsmunicipio` varchar(100) DEFAULT NULL,
  `cdmunicipio` varchar(36) NOT NULL,
  PRIMARY KEY (`cdmunicipio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblnoticia`
--

DROP TABLE IF EXISTS `tblnoticia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblnoticia` (
  `idnoticia` varchar(36) NOT NULL DEFAULT (uuid()),
  `dstitulo` varchar(100) DEFAULT NULL,
  `dscontenido` text,
  `dtpublicado` date DEFAULT NULL,
  `dsurlevento` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idnoticia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblparametros`
--

DROP TABLE IF EXISTS `tblparametros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblparametros` (
  `cdparametro` varchar(100) NOT NULL,
  `vlparametro` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dsparametro` text,
  `cdsistema` varchar(100) DEFAULT NULL,
  UNIQUE KEY `tblparametros_unique` (`cdparametro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblprovincia`
--

DROP TABLE IF EXISTS `tblprovincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblprovincia` (
  `cdprovincia` varchar(36) NOT NULL,
  `dsprovincia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdprovincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblresenia`
--

DROP TABLE IF EXISTS `tblresenia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblresenia` (
  `idresenia` varchar(36) NOT NULL DEFAULT (uuid()),
  `idusuario` varchar(36) DEFAULT NULL,
  `nmestrellas` int DEFAULT NULL,
  `dscomentario` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `dtinsert` datetime DEFAULT NULL,
  `idfiesta` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`idresenia`),
  KEY `FK_usuario_tblresenia` (`idusuario`),
  KEY `tblresenia_tblfiesta_FK` (`idfiesta`),
  CONSTRAINT `FK_usuario_tblresenia` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `tblresenia_tblfiesta_FK` FOREIGN KEY (`idfiesta`) REFERENCES `tblfiesta` (`idfiesta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblrol`
--

DROP TABLE IF EXISTS `tblrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrol` (
  `cdrol` int NOT NULL,
  `dsrol` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`cdrol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblrol_usuario`
--

DROP TABLE IF EXISTS `tblrol_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblrol_usuario` (
  `idrol_usuario` varchar(36) NOT NULL DEFAULT (uuid()),
  `idusuario` varchar(36) NOT NULL,
  `cdrol` int NOT NULL,
  PRIMARY KEY (`idrol_usuario`),
  KEY `tblrol_usuario_tblusuario_FK` (`idusuario`),
  KEY `tblrol_usuario_tblrol_FK` (`cdrol`),
  CONSTRAINT `tblrol_usuario_tblrol_FK` FOREIGN KEY (`cdrol`) REFERENCES `tblrol` (`cdrol`),
  CONSTRAINT `tblrol_usuario_tblusuario_FK` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblsocial`
--

DROP TABLE IF EXISTS `tblsocial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblsocial` (
  `idsocial` varchar(36) NOT NULL,
  `mdinstagram` varchar(200) DEFAULT NULL,
  `mdspotify` varchar(200) DEFAULT NULL,
  `mdsoundcloud` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idsocial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbltipoentrada`
--

DROP TABLE IF EXISTS `tbltipoentrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbltipoentrada` (
  `cdtipo` int NOT NULL,
  `dstipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cdtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblusuario`
--

DROP TABLE IF EXISTS `tblusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblusuario` (
  `idusuario` varchar(36) NOT NULL DEFAULT (uuid()),
  `iddomicilio` varchar(36) DEFAULT NULL,
  `dsnombrereal` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dsapellido` varchar(45) DEFAULT NULL,
  `dscorreo` varchar(45) DEFAULT NULL,
  `nmdni` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nmtelefono` varchar(45) DEFAULT NULL,
  `dscbu` varchar(45) DEFAULT NULL,
  `dtalta` date DEFAULT NULL,
  `isactivo` tinyint DEFAULT '1',
  `dtbaja` date DEFAULT NULL,
  `dsbio` text,
  `dspass` varchar(200) DEFAULT NULL,
  `idsocial` varchar(36) DEFAULT NULL,
  `dtnacimiento` date DEFAULT NULL,
  `isverificado` tinyint DEFAULT '0',
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `tblusuario_unique_dscorreo` (`dscorreo`),
  KEY `FK_domicilio_tblusuario` (`iddomicilio`),
  KEY `tblusuario_tblsocial_FK` (`idsocial`),
  CONSTRAINT `FK_domicilio_tblusuario` FOREIGN KEY (`iddomicilio`) REFERENCES `tbldomicilio` (`iddomicilio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tblusuariocontrol`
--

DROP TABLE IF EXISTS `tblusuariocontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tblusuariocontrol` (
  `IdUsuarioControl` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'uuid()',
  `dsnombreusuario` varchar(200) NOT NULL,
  `dspass` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `idusuario` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`IdUsuarioControl`),
  UNIQUE KEY `tblusuariocontrol_unique` (`dsnombreusuario`),
  KEY `tblusuariocontrol_tblusuario_FK` (`idusuario`),
  CONSTRAINT `tblusuariocontrol_tblusuario_FK` FOREIGN KEY (`idusuario`) REFERENCES `tblusuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'prod_raveapp'
--
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ARTISTAS_DeleteArtista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ARTISTAS_DeleteArtista`(
	in p_idArtista varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	start transaction;
	
	delete from tblartista
	where idartista = p_idArtista;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ARTISTAS_GetArtistas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ARTISTAS_GetArtistas`(IN p_idArtista varchar(36), IN p_isActivo tinyint,
                                                             IN p_idUsuario varchar(36))
    READS SQL DATA
BEGIN
	
	select distinct a.idartista, 
	a.dsnombre, 
	a.dsbio, 
	a.dtalta, 
	a.isactivo,
	s.idsocial,
	s.mdinstagram,
	s.mdspotify,
	s.mdsoundcloud,
	m.idmedia,
	if(af.idartista_fav is null, 0, 1) isfavorito
	from tblartista a
	left join tblsocial s on a.idsocial = s.idsocial
	left join tblmedia m on a.idartista = m.identidadmedia
	left join tblartistafav af on a.idartista = af.idartista and af.idusuario = p_idUsuario
	where a.idartista = coalesce(p_idArtista, a.idartista)
	and a.isactivo = coalesce(p_isActivo, a.isactivo);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ARTISTAS_GetCantLikesArtista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_ARTISTAS_GetCantLikesArtista`(IN p_idArtista varchar(36), OUT p_Cant int)
    READS SQL DATA
begin
	
	select count(*)
	into p_Cant
	from tblartistafav af
	where af.idartista = p_idArtista;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_Artistas_GetImgLikesArtista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_Artistas_GetImgLikesArtista`(IN p_idArtista varchar(36))
    READS SQL DATA
BEGIN

    select af.idusuario
    from tblartistafav af
    join tblmedia mm on af.idusuario = mm.identidadmedia
    where af.idartista = p_idArtista
    order by rand()
    limit 4;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ARTISTAS_SetArtista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ARTISTAS_SetArtista`(
	in p_dsNombre varchar(45),
	in p_dsBio text,
	in p_mdInstagram varchar(200),
	in p_mdSpotify varchar(200),
	in p_mdSoundcloud varchar(200),
	in p_isActivo tinyint,
	out p_idArtista varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	declare v_idSocials varchar(36);
	start transaction;
	set p_idArtista = uuid();

	if p_mdInstagram != '' or p_mdSpotify != '' or p_mdSoundcloud != '' then
		call PCD_SOCIALS_SetSocials(p_mdInstagram, p_mdSpotify, p_mdSoundcloud, v_idSocials);
	end if;

	 insert into tblartista (idartista, dsnombre, dsbio, dtalta, isactivo, idsocial)
	 values (p_idArtista, p_dsNombre, p_dsBio, SYSDATE(), p_isActivo, v_idSocials);
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ARTISTAS_UpdateArtista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ARTISTAS_UpdateArtista`(IN p_idArtista varchar(36), IN p_dsNombre varchar(45),
                                                               IN p_dsBio text, IN p_mdInstagram varchar(200),
                                                               IN p_mdSpotify varchar(200),
                                                               IN p_mdSoundcloud varchar(200), IN p_isActivo tinyint)
    MODIFIES SQL DATA
BEGIN
	declare v_idSocials varchar(36);
	start transaction;
	
	select coalesce(a.idsocial, '')
	into v_idSocials
	from tblartista a
	where a.idartista = p_idArtista;

	call PCD_LOG_SetLogGeneral('PCD_ARTISTAS_UpdateArtista', concat('insta', p_mdInstagram, ' sd ', p_mdSoundcloud, ' sp ', p_mdSpotify, ' id ', v_idSocials), '', '');

	if p_mdInstagram != '' or p_mdSpotify != '' or p_mdSoundcloud != '' then
	    call PCD_LOG_SetLogGeneral('PCD_ARTISTAS_UpdateArtista', 'entro a ifor', '', '');
		if v_idSocials != '' then
		    call PCD_LOG_SetLogGeneral('PCD_ARTISTAS_UpdateArtista', 'entro a update', '', '');
			call PCD_SOCIALS_UpdateSocials(p_mdInstagram, p_mdSpotify, p_mdSoundcloud, v_idSocials);
		else 
		    call PCD_LOG_SetLogGeneral('PCD_ARTISTAS_UpdateArtista', 'entro a create', '', '');
			set v_idSocials = uuid();
			call PCD_SOCIALS_SetSocials(p_mdInstagram, p_mdSpotify, p_mdSoundcloud, v_idSocials);
		end if;
	else
	    call PCD_LOG_SetLogGeneral('PCD_ARTISTAS_UpdateArtista', 'entro a delete', '', '');
		call PCD_SOCIALS_DeleteSocials(v_idSocials);
	end if;
	
	if  v_idSocials != '' then
        update tblartista a
        set a.dsnombre = p_dsNombre,
        a.dsbio = p_dsBio,
        a.isactivo = p_isActivo,
        a.idsocial = v_idSocials
        where a.idartista = p_idArtista;
	else
        update tblartista a
        set a.dsnombre = p_dsNombre,
        a.dsbio = p_dsBio,
        a.isactivo = p_isActivo
        where a.idartista = p_idArtista;
	end if;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_AnularCompra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_AnularCompra`(IN p_idCompra varchar(36))
    MODIFIES SQL DATA
BEGIN

    start transaction;

    insert into tblentrada (cdestado, cdtipo, amprecio, idfecha)
    select 0, ee.cdtipo, ee.amprecio, ee.idfecha
    from tblentrada ee
    where ee.idcompra = p_idCompra;

    update tblentrada ee
    set ee.cdestado = 3
    where ee.idcompra = p_idCompra;

    update tblcompra cc
    set cc.cdestado = 4
    where cc.idcompra = p_idCompra;

    commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_FinalizarCompra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_FinalizarCompra`(IN p_idCompra varchar(36), IN p_cdMedioPago int)
    MODIFIES SQL DATA
main_block:BEGIN
	
	DECLARE p_existe int;

    start transaction;
   
	SELECT count(1)
	INTO p_existe
	FROM tblcompra c
	WHERE c.idcompra = p_idCompra
	AND c.cdestado = 1;

	IF p_existe > 0 THEN
		ROLLBACK;
		LEAVE main_block;
	END IF;

    insert into tblcobranza (idcompra, ammontocancelado, cdmediopago)
    select cc.idcompra, cc.ammonto, p_cdMedioPago
    from tblcompra cc
    where cc.idcompra = p_idCompra;

    update tblcompra cc
    set cc.cdestado = 1
    where cc.idcompra = p_idCompra;
   
   	update tblentrada ee
   	set ee.cdestado  = 4
   	where ee.idcompra  = p_idCompra;

    commit;
   
   select t.identrada
   from tblentrada t
   where t.idcompra  = p_idCompra;
  
END main_block ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_GetDatosReembolso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_GetDatosReembolso`(IN p_idCompra varchar(36))
    READS SQL DATA
BEGIN
	
	SELECT c.amsubtotal, mp.idpagomp
	FROM tblcompra c
	JOIN tbllogwebhookmp mp
	ON c.idcompra = mp.idcompra
	WHERE c.idcompra = p_idCompra
	AND c.cdestado = 1
	LIMIT 1;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_GetDatosReembolsoMasivo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_GetDatosReembolsoMasivo`(IN p_idEvento varchar(36))
    READS SQL DATA
BEGIN
	
	SELECT DISTINCT w.idpagomp,
	c.amsubtotal,
	c.idcompra,
	ev.dsnombre,
	u.dscorreo
	FROM tblevento ev
	JOIN tblfecha f ON ev.idevento = f.idevento 
	JOIN tblentrada e ON f.idfecha = e.idfecha 
	JOIN tblcompra c ON e.idcompra = c.idcompra 
	JOIN tbllogwebhookmp w ON c.idcompra = w.idcompra
	JOIN tblusuario u ON c.idusuario = u.idusuario
	WHERE ev.idevento = p_idEvento
	AND c.cdestado = 1
	AND ev.cdestado = 5;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_Reembolso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_Reembolso`(IN p_idCompra varchar(36))
    MODIFIES SQL DATA
BEGIN
	
	START TRANSACTION;

	insert into tblentrada (cdestado, cdtipo, amprecio, idfecha)
    select 0, ee.cdtipo, ee.amprecio, ee.idfecha
    from tblentrada ee
    where ee.idcompra = p_idCompra
   	AND ee.cdestado = 4;

    update tblentrada ee
    set ee.cdestado = 3
    where ee.idcompra = p_idCompra;

    update tblcompra cc
    set cc.cdestado = 4
    where cc.idcompra = p_idCompra
	AND cc.cdestado = 1;

	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_RefreshTimerReserva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_RefreshTimerReserva`(in p_idCompra varchar(36))
    MODIFIES SQL DATA
BEGIN
	start transaction;
	update tblentrada ee
    join tblcompra cc on ee.idcompra = cc.idcompra
    set ee.dtreserva = sysdate()
    where cc.idcompra = p_idCompra
    and ee.cdestado = 1
    and cc.cdestado = 5;
   commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_SetCompra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_SetCompra`(
in p_idUsuario varchar(36),
in p_ammonto decimal,
out p_idCompra varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	start transaction;
	set p_idCompra = uuid();
	insert into tblcompra (idcompra, idusuario, ammonto, cdestado, dtinsert)
	values (p_idCompra, p_idUsuario, p_ammonto, 5, sysdate());

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_SetCompraPendiente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_SetCompraPendiente`(p_idCompra varchar(36),
in p_amSubTotal decimal,
in p_amServicio decimal)
    MODIFIES SQL DATA
BEGIN
	start transaction;
	update tblcompra cc
	set cc.cdestado = 0,
	cc.amsubtotal = p_amSubTotal,
	cc.amservicio = p_amServicio
	where cc.idcompra  = p_idCompra;

	update tblentrada ee
	set ee.cdestado  = 5
	where ee.idcompra = p_idCompra;

	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_COMPRA_UpdateCompra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_COMPRA_UpdateCompra`(
in p_idCompra varchar(36),
in p_amMonto decimal,
in p_cdEstado int
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	
	update tblcompra co
	set co.ammonto = p_amMonto,
	co.cdestado = p_cdEstado
	where co.idcompra = p_idCompra;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_DIRECCIONES_SetDomicilio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_DIRECCIONES_SetDomicilio`(
	in p_dsDireccion varchar(200),
	in p_nmLatitud decimal,
	in p_nmLongitud decimal,
	in p_dsProvincia varchar(45),
	in p_cdProvincia varchar(36),
	in p_dsMunicipio varchar(45),
	in p_cdMunicipio varchar(36),
	in p_dsLocalidad varchar(45),
	in p_cdLocalidad varchar(36),
	out p_idDomicilio varchar(36),
	out p_ok integer,
	out p_error text
)
    MODIFIES SQL DATA
begin
	declare v_modulo varchar(200);
	set v_modulo = 'PCD_DIRECCIONES_SetDomicilio';
	set p_ok = 1;
	set p_idDomicilio = uuid();
	
	if not (exists(
			select 1
			from tbllocalidad l
			where l.cdlocalidad = p_cdLocalidad))
	then
		insert into tbllocalidad (cdlocalidad, dslocalidad)
		values (p_cdLocalidad, p_dsLocalidad);
	end if;		
	
	if not (exists(
			select 1
			from tblmunicipio m
			where m.cdmunicipio = p_cdMunicipio))
	then
		insert into tblmunicipio (cdmunicipio, dsmunicipio)
		values (p_cdMunicipio, p_dsMunicipio);
	end if;	
	
	if not (exists(
			select 1
			from tblprovincia p
			where p.cdprovincia = p_cdProvincia))
	then
		insert into tblprovincia (cdprovincia, dsprovincia)
		values (p_cdProvincia, p_dsProvincia);
	end if;	
	
	insert into tbldomicilio (iddomicilio, dsdireccion, cdlocalidad, cdmunicipio, cdprovincia, nmlatitud, nmlongitud)
	values (p_idDomicilio, p_dsDireccion, p_cdLocalidad, p_cdMunicipio, p_cdProvincia, p_nmLatitud, p_nmLongitud);
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_DIRECCIONES_UpdateDomicilio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_DIRECCIONES_UpdateDomicilio`(
	in p_idDomicilio varchar(36),
	in p_dsDireccion varchar(200),
	in p_nmLatitud decimal,
	in p_nmLongitud decimal,
	in p_dsProvincia varchar(45),
	in p_cdProvincia varchar(36),
	in p_dsMunicipio varchar(45),
	in p_cdMunicipio varchar(36),
	in p_dsLocalidad varchar(45),
	in p_cdLocalidad varchar(36),
	out p_ok integer,
	out p_error text
)
    MODIFIES SQL DATA
BEGIN
	declare v_modulo varchar(200);        
	set v_modulo = 'PCD_DIRECCIONES_UpdateDomicilio';
	set p_ok = 1;

	if not (exists(
			select 1
			from tbllocalidad l
			where l.cdlocalidad = p_cdLocalidad))
	then
		insert into tbllocalidad (cdlocalidad, dslocalidad)
		values (p_cdLocalidad, p_dsLocalidad);
	end if;	
	
	if not (exists(
			select 1
			from tblmunicipio m
			where m.cdmunicipio = p_cdMunicipio))
	then
		insert into tblmunicipio (cdmunicipio, dsmunicipio)
		values (p_cdMunicipio, p_dsMunicipio);
	end if;	
	
	if not (exists(
			select 1
			from tblprovincia p
			where p.cdprovincia = p_cdProvincia))
	then
		insert into tblprovincia (cdprovincia, dsprovincia)
		values (p_cdProvincia, p_dsProvincia);
	end if;
	
	update tbldomicilio d
	set d.dsdireccion = p_dsDireccion,
	d.cdlocalidad = p_cdLocalidad,
	d.cdmunicipio = p_cdMunicipio,
	d.cdprovincia = p_cdProvincia,
	d.nmlatitud = p_nmLatitud,
	d.nmlongitud = p_nmLongitud
	where d.iddomicilio = p_idDomicilio;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EMAIL_GetCorreosEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EMAIL_GetCorreosEvento`(IN p_idEvento varchar(36))
    READS SQL DATA
BEGIN
	
	SELECT DISTINCT u.dscorreo
	FROM tblevento ev
	JOIN tblfecha f ON ev.idevento = f.idevento
	JOIN tblentrada e ON f.idfecha = e.idfecha 
	JOIN tblcompra c ON e.idcompra = c.idcompra 
	JOIN tblusuario u ON c.idusuario = u.idusuario
	WHERE ev.idevento = p_idEvento
    AND c.cdestado = 1;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EMAIL_GetQrEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EMAIL_GetQrEntradas`(in p_idCompra varchar(36))
    READS SQL DATA
BEGIN
	
select ee.mdqr,
ee.identrada,
ev.dsnombre,
ff.dtinicio,
uu.dscorreo,
te.dstipo 
from tblcompra cc
join tblentrada ee on cc.idcompra  = ee.idcompra 
join tblusuario uu on cc.idusuario = uu.idusuario 
join tblfecha ff on ee.idfecha = ff.idfecha 
join tblevento ev on ff.idevento = ev.idevento
join tbltipoentrada te on ee.cdtipo = te.cdtipo 
where cc.idcompra = p_idCompra;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_CancelarReserva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_CancelarReserva`(IN p_idCompra varchar(36))
    MODIFIES SQL DATA
BEGIN
	start transaction;


	update tblentrada en
	set en.cdestado = 0,
	en.dtreserva = null,
	en.idcompra = null
	where en.idcompra = p_idCompra
	and en.cdestado  = 1;

	delete from tblcompra cc
    where cc.idcompra = p_idCompra
    and cc.cdestado = 5;


	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_ControlarEntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_ControlarEntrada`(IN p_idEntrada varchar(36), IN p_mdQr varchar(36))
    MODIFIES SQL DATA
BEGIN
	DECLARE v_ok TINYINT DEFAULT 0;
	
	START TRANSACTION;

	SELECT count(1)
	INTO v_ok
	FROM tblentrada e
	WHERE e.cdestado = 4
	AND e.identrada = p_idEntrada
	AND e.mdqr = p_mdQr;
	
	IF v_ok > 0 THEN
	
		UPDATE tblentrada e
		SET e.cdestado = 2
		WHERE e.identrada = p_idEntrada;
	
	END IF;

	COMMIT;

	SELECT v_ok AS isOk, ee.dsestado 
	FROM tblentrada e
	JOIN tblestadoentrada ee ON e.cdestado = ee.cdestado 
	WHERE e.identrada = p_idEntrada
	AND e.mdqr = p_mdQr;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_GetEntradasFecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_GetEntradasFecha`(
	in p_idFecha varchar(36),
	in p_cdEstado int
)
    READS SQL DATA
BEGIN
	
	SELECT count(1) as nmcantidad,
	en.cdtipo,
	en.amprecio,
	en.cdestado,
	fe.dtinicio,
	fe.dtfin,
	fe.dtinicioventa,
	fe.dtfinventa,
	fe.idfecha
	from tblentrada en
	inner join tblfecha fe on en.idfecha = fe.idfecha
	where fe.idfecha = p_idFecha
	and en.cdestado = coalesce(p_cdEstado, en.cdestado)
	group by en.cdtipo,
	en.amprecio,
	en.cdestado,
	fe.dtinicioventa,
	fe.dtfinventa,
	fe.idfecha;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_GetEstadoEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_GetEstadoEntradas`()
    READS SQL DATA
BEGIN
	
	select *
	from tblestadoentrada;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_GetEstadosEntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_GetEstadosEntrada`()
    READS SQL DATA
BEGIN
	
	select *
	from tblestadoentrada;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_GetReservaActiva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_GetReservaActiva`(IN p_idUsuario varchar(36))
    MODIFIES SQL DATA
BEGIN

    start transaction;

    update tblentrada ee
    join tblcompra cc on ee.idcompra = cc.idcompra
    set ee.dtreserva = sysdate()
    where cc.idusuario = p_idUsuario
    and ee.cdestado = 1
    and cc.cdestado = 5;

    commit;
   
	select count(1) as nmcantidad,
	ee.cdtipo,
	cc.idcompra,
	ff.idfecha,
	ev.idevento
	from tblentrada ee
	join tblcompra cc on ee.idcompra = cc.idcompra
	join tblfecha ff on ee.idfecha = ff.idfecha
	join tblevento ev on ff.idevento = ev.idevento
	where cc.idusuario = p_idUsuario
	and ee.cdestado = 1
	and cc.cdestado = 5
	group by ee.cdtipo,
	cc.idcompra,
	ff.idfecha,
	ev.idevento;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_GetTipoEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_GetTipoEntradas`()
    READS SQL DATA
BEGIN
	
	select *
	from tbltipoentrada;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_ReservarEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_ReservarEntradas`(IN p_jsonEntradas JSON, IN p_idUsuario varchar(36),
                                                                  IN p_idFecha varchar(36),
                                                                  OUT p_idCompra varchar(36))
    MODIFIES SQL DATA
BEGIN
	declare i int default 0;
	declare j int default 0;
	declare v_amMontoTotal decimal default 0;
	declare v_amMonto decimal default 0;
	declare v_idEntrada varchar(36);
    declare v_lenght int default JSON_LENGTH(p_jsonEntradas);
	declare v_cant int default 0;
	declare v_cdTipoEntrada int default 0;
	start transaction;
	while i < v_lenght do
		set v_cdTipoEntrada = cast(
		  JSON_UNQUOTE(
		    JSON_EXTRACT(p_jsonEntradas, CONCAT('$[', i, '].TipoEntrada'))
		  ) AS unsigned);
		set v_cant = cast(
			  JSON_UNQUOTE(
			    JSON_EXTRACT(p_jsonEntradas, CONCAT('$[', i, '].Cantidad'))
			  ) AS unsigned);
			 
		while j < v_cant do
		
			select en.identrada, en.amprecio
			into v_idEntrada, v_amMonto
			from tblentrada en
			inner join tblfecha fe on en.idfecha = fe.idfecha
			where fe.idFecha = p_idFecha
			and en.cdestado = 0
			and en.cdtipo = v_cdTipoEntrada
			limit 1;
		
			if i = 0 and j = 0 then
				CALL PCD_COMPRA_SetCompra(p_idUsuario, 0, p_idCompra);
			end if;
	
			set v_amMontoTotal = v_amMontoTotal + v_amMonto;
		
			update tblentrada e
			set e.cdestado = 1,
			e.idcompra = p_idCompra,
			e.dtreserva = sysdate()
			where e.identrada = v_idEntrada;
			
			set j = j + 1;
		end while;
		set j = 0;
		set i = i + 1;
	end while;
		
	call PCD_COMPRA_UpdateCompra(p_idCompra, v_amMontoTotal, 5);

	commit;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_SetEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_SetEntradas`(
	in p_idFecha varchar(36),
	in p_cdTipo int,
	in p_amPrecio decimal(19, 4),
	in p_vlCant int
)
    MODIFIES SQL DATA
BEGIN
	declare v_limiteInsert int;
	declare i int default 0;
	call PCD_PARAM_GetParametro('LimiteInsertEntradas', null, v_limiteInsert);
	start transaction;

	if p_vlCant > v_limiteInsert then
		set p_vlCant = v_limiteInsert;
	end if;
	
	while i < p_vlCant do
	
		insert into tblentrada (identrada, cdestado, cdtipo, amprecio, idfecha)
		values (uuid(), 0, p_cdTipo, p_amPrecio, p_idFecha);
		set i = i + 1;
	end while;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_SetQREntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_SetQREntrada`(IN p_idEntrada varchar(36), IN p_mdQr varchar(36), OUT p_ok int)
    MODIFIES SQL DATA
BEGIN

    start transaction;

    update tblentrada ee
    set ee.mdqr = p_mdQr
    where ee.identrada = p_idEntrada;
	
    SET p_ok = ROW_COUNT();
   
    commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_UpdateEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_UpdateEntradas`(IN p_idFecha varchar(36), IN p_amPrecio decimal(19, 4),
                                                                IN p_cdTipo int)
    MODIFIES SQL DATA
BEGIN
    start transaction;

    update tblentrada e
    set e.amprecio = p_amPrecio
    where e.idfecha = p_idFecha
    and e.cdestado = 0
    and e.cdtipo = p_cdTipo;
    
    commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADAS_UpdateEstadoEntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADAS_UpdateEstadoEntrada`(IN p_idEntrada varchar(36), IN p_cdEstado int)
    MODIFIES SQL DATA
BEGIN
	
	START TRANSACTION;

	UPDATE tblentrada e
	SET e.cdestado = p_cdEstado
	WHERE e.identrada = p_idEntrada;

	COMMIT;

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_ENTRADA_GetReservaActiva` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_ENTRADA_GetReservaActiva`(IN p_idUsuario varchar(36))
    MODIFIES SQL DATA
BEGIN

    start transaction;

    update tblentrada ee
    join tblcompra cc on ee.idcompra = cc.idcompra
    set ee.dtreserva = sysdate()
    where cc.idusuario = p_idUsuario
    and ee.cdestado = 1
    and cc.cdestado = 5;

    commit;
   
	select count(1) as nmcantidad,
	ee.cdtipo,
	cc.idcompra,
	ff.idfecha,
	ev.idevento
	from tblentrada ee
	join tblcompra cc on ee.idcompra = cc.idcompra
	join tblfecha ff on ee.idfecha = ff.idfecha
	join tblevento ev on ff.idevento = ev.idevento
	where cc.idusuario = p_idUsuario
	and ee.cdestado = 1
	and cc.cdestado = 5
	group by ee.cdtipo,
	cc.idcompra,
	ff.idfecha,
	ev.idevento;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_DeleteEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_DeleteEvento`(
	in p_idEvento varchar(36),
	out p_ok int,
	out p_error text
)
    MODIFIES SQL DATA
BEGIN
	declare c_EstadoEventoBorrado int default 5;
    declare v_Modulo varchar(200) default "PCD_EVENTOS_DeleteEvento"; 
	set p_ok = 1;
	start transaction;
	update tblevento
	set cdestado = c_EstadoEventoBorrado
	where idevento = p_idEvento;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_DeleteFechaEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_DeleteFechaEvento`(
	p_idFecha varchar(36),
	p_ok int,
	p_error text
)
    MODIFIES SQL DATA
BEGIN
	set p_ok = 1;
	start transaction;
	update tblfecha
	set cdestado = 2
	where idfecha = p_idFecha;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetArtistasEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetArtistasEvento`(
in p_idEvento varchar(36)
)
    READS SQL DATA
BEGIN
	
	select a.idartista, 
	a.dsnombre, 
	a.dsbio, 
	a.dtalta, 
	a.isactivo,
	s.idsocial,
	s.mdinstagram,
	s.mdspotify,
	s.mdsoundcloud,
	m.idmedia
	from tblevento_artista ea
	join tblartista a on ea.idartista = a.idartista
	left join tblsocial s on a.idsocial = s.idsocial
	left join tblmedia m on a.idartista = m.identidadmedia
	where ea.idevento = p_idEvento;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetEstadosEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetEstadosEvento`()
    READS SQL DATA
BEGIN
	
	select e.cdestado,
	e.dsestado
	from tblestadoevento e;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetEstadosFecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetEstadosFecha`()
    READS SQL DATA
BEGIN
	
	select f.cdestado, f.dsestado
	from tblestadofecha f;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetEventos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetEventos`(IN p_idEvento varchar(36), IN p_cdEstadoEvento int,
                                                           IN p_cdProvincia int, IN p_cdMunicipio int,
                                                           IN p_cdLocalidad int, IN p_cdGeneroList text,
                                                           IN p_isAfter int, IN p_isLgbt int, IN p_idFiesta varchar(36),
                                                           IN p_idUsuarioOrg varchar(36), IN p_idUsuarioFav varchar(36))
    READS SQL DATA
BEGIN
	
	SELECT DISTINCT 
    e.idevento,
    e.dsnombre,
    e.dsevento, 
    e.isafter,
    e.islgbt,
    e.dtinicioevento,
    e.dtfinevento,
    ee.cdestado,
    d.dsdireccion,
    d.nmlatitud,
    d.nmlongitud,
    l.cdlocalidad,
    l.dslocalidad,
    m.cdmunicipio,
    m.dsmunicipio,
    p.cdprovincia,
    p.dsprovincia,
    f.dsnombre,
    f.idfiesta,
    e.idusuario,
    if(ea.ideventousuario is null, 0, 1) isfavorito,
    e.mdsoundcloud,
    e.dtupdate
	FROM 
    tblevento e
    JOIN tblestadoevento ee ON e.cdestado = ee.cdestado
    JOIN tblevento_genero eg ON e.idevento = eg.idevento
    JOIN tblgeneroevento ge ON eg.cdgenero = ge.cdgenero
    LEFT JOIN tblfiesta f ON e.idfiesta = f.idfiesta
    JOIN tbldomicilio d ON e.iddomicilio = d.iddomicilio
    JOIN tbllocalidad l ON d.cdlocalidad = l.cdlocalidad
    JOIN tblmunicipio m ON d.cdmunicipio = m.cdmunicipio
    JOIN tblprovincia p ON d.cdprovincia = p.cdprovincia
	left join tblevento_usuario ea on ea.idevento = e.idevento and ea.idusuario = p_idUsuarioFav
	WHERE 
    ee.cdestado = COALESCE(p_cdEstadoEvento, ee.cdestado)
    AND d.cdlocalidad = COALESCE(p_cdLocalidad, d.cdlocalidad)
    AND d.cdmunicipio = COALESCE(p_cdMunicipio, d.cdmunicipio)
    AND d.cdprovincia = COALESCE(p_cdProvincia, d.cdprovincia)
    AND (p_cdGeneroList IS NULL OR FIND_IN_SET(ge.cdgenero, p_cdGeneroList) > 0)
    AND e.isafter = COALESCE(p_isAfter, e.isafter)
    AND e.islgbt = COALESCE(p_isLgbt, e.islgbt)
    AND e.idevento = COALESCE(p_idEvento, e.idevento)
    AND e.idusuario = COALESCE(p_idUsuarioOrg, e.idusuario)
    AND (p_idFiesta IS NULL OR e.idfiesta = p_idFiesta);

	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetFechasEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetFechasEvento`(
	in p_idEvento varchar(36)
)
    READS SQL DATA
BEGIN
	
	SELECT f.idfecha, 
	f.dtinicio, 
	f.dtfin, 
	f.cdestado, 
	f.dtinicioventa, 
	f.dtfinventa
	from tblevento e,
	tblfecha f
	where e.idevento = f.idevento
	and e.idevento = p_idEvento;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetGeneros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetGeneros`()
    READS SQL DATA
BEGIN
	
	SELECT ge.cdgenero,
	ge.dsgenero
	from tblgeneroevento ge;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_GetGenerosByEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_GetGenerosByEvento`(
in p_idEvento varchar(36)
)
    READS SQL DATA
BEGIN
	
	select ev.cdgenero
	from tblevento_genero ev
	where ev.idevento = p_idEvento;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_SetEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_SetEvento`(IN p_idUsuario varchar(36), IN p_idArtistaList text,
                                                          IN p_dsDireccion varchar(200), IN p_nmLatitud decimal,
                                                          IN p_nmLongitud decimal, IN p_dsProvincia varchar(45),
                                                          IN p_cdProvincia varchar(36), IN p_dsMunicipio varchar(45),
                                                          IN p_cdMunicipio varchar(36), IN p_dsLocalidad varchar(45),
                                                          IN p_cdLocalidad varchar(36), IN p_dsNombre varchar(200),
                                                          IN p_dsEvento text, IN p_cdGeneroList text, IN p_isAfter int,
                                                          IN p_isLgbt int, IN p_dtInicioEvento datetime,
                                                          IN p_dtFinEvento datetime, IN p_cdEstado int,
                                                          IN p_idFiesta varchar(36), IN p_mdSoundCloud varchar(200),
                                                          OUT p_idEvento varchar(36), OUT p_ok int, OUT p_error text)
    MODIFIES SQL DATA
BEGIN
	declare v_idDomicilio varchar(36);
	declare v_modulo varchar(200);
	
	
	declare v_done int default 0;
	declare v_cdGenero int;
	declare v_idArtista varchar(36);
	declare v_cur_genero cursor for 
		select ge.cdgenero
	    from tblgeneroevento ge
    	where find_in_set(ge.cdgenero, p_cdGeneroList) > 0;
	declare v_cur_art cursor for 
		select art.idartista
	    from tblartista art
    	where find_in_set(art.idartista, p_idArtistaList) > 0;
	
	
	declare continue handler for not found set v_done = 1;
	
	set v_modulo = 'PCD_EVENTOS_SetEvento';
	set p_ok = 1;
	set p_idEvento = uuid();
	start transaction;
	call PCD_DIRECCIONES_SetDomicilio(p_dsDireccion, p_nmLatitud, p_nmLongitud, p_dsProvincia, p_cdProvincia, p_dsMunicipio, p_cdMunicipio, p_dsLocalidad, p_cdLocalidad, v_idDomicilio, p_ok, p_error);
	
	
	insert into tblevento (idevento, iddomicilio, idusuario, dsnombre, dsevento, cdestado, dtinsert, isafter, islgbt, dtinicioevento, dtfinevento, idfiesta, mdsoundcloud)
	values (p_idEvento, v_idDomicilio, p_idUsuario, p_dsNombre, p_dsEvento, p_cdEstado, SYSDATE(), p_isAfter, p_isLgbt, p_dtInicioEvento, p_dtFinEvento, p_idFiesta, p_mdSoundCloud);
	
	open v_cur_genero;
	loop_genero: loop
		
		fetch v_cur_genero into v_cdGenero;
		if v_done = 1 then
			set v_done = 0;
			leave loop_genero;
		end if;
		
		insert into tblevento_genero (idevento_genero, idevento, cdgenero)
		values (uuid(), p_idEvento, v_cdGenero);
	end loop;
	close v_cur_genero;
		
	open v_cur_art;
	loop_art: loop
		
		fetch v_cur_art into v_idArtista;
		if v_done = 1 then
			set v_done = 0;
			leave loop_art;
		end if;
		
		insert into tblevento_artista (idevento_artista, idevento, idartista)
		values (uuid(), p_idEvento, v_idArtista);
	end loop;
	close v_cur_art;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_SetFechaEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_SetFechaEvento`(
	in p_idEvento varchar(36),
	in p_dtInicio datetime,
	in p_dtInicioVenta datetime,
	in p_dtFin datetime,
	in p_dtFinVenta datetime,
	in p_cdEstado int,
	out p_ok int,
	out p_error text
)
    MODIFIES SQL DATA
BEGIN
	declare v_Modulo varchar(100) default "PCD_EVENTOS_SetFechaEvento";
    
	set p_ok = 1;
	start transaction;
	
	insert into tblfecha (idfecha, idevento, dtinicio, dtfin, cdestado, dtinicioventa, dtfinventa)
	values (uuid(), p_idEvento, p_dtInicio, p_dtFin, p_cdEstado, p_dtInicioVenta, p_dtFinVenta);
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_UpdateEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_UpdateEvento`(
	in p_idEvento varchar(36),
	in p_idArtistaList text,
	in p_dsDireccion varchar(200),
	in p_nmLatitud decimal,
	in p_nmLongitud decimal,
	in p_dsProvincia varchar(45),
	in p_cdProvincia varchar(36),
	in p_dsMunicipio varchar(45),
	in p_cdMunicipio varchar(36),
	in p_dsLocalidad varchar(45),
	in p_cdLocalidad varchar(36),
	in p_dsNombre varchar(200),
	in p_dsEvento text,
	in p_cdGeneroList text,
	in p_isAfter int,
	in p_isLgbt int,
	in p_dtInicioEvento datetime,
	in p_dtFinEvento datetime,
	in p_cdEstado int,
	in p_idFiesta varchar(36),
	out p_ok int,
	out p_error text
)
    MODIFIES SQL DATA
BEGIN
	
	declare v_modulo varchar(200) default "PCD_EVENTOS_UpdateEvento";
	declare v_idDomicilio varchar(36);
	
	declare v_done int default 0;
	declare v_cdGenero int;
	declare v_idArtista varchar(36);
	declare v_cur_genero cursor for 
		select ge.cdgenero
	    from tblgeneroevento ge
    	where find_in_set(ge.cdgenero, p_cdGeneroList) > 0;
	declare v_cur_art cursor for 
		select art.idartista
	    from tblartista art
    	where find_in_set(art.idartista, p_idArtistaList) > 0;
        
	
	declare continue handler for not found set v_done = 1;
	set p_ok = 1;	
	start transaction;
	
	select e.iddomicilio
	into v_idDomicilio
	from tblevento e
	where e.idevento = p_idEvento;
	
	call PCD_DIRECCIONES_UpdateDomicilio(v_idDomicilio, p_dsDireccion, p_nmLatitud, p_nmLongitud, p_dsProvincia, p_cdProvincia, p_dsMunicipio, p_cdMunicipio, p_dsLocalidad, p_cdLocalidad, p_ok, p_error);
	
	
	delete from tblevento_genero
	where idevento = p_idEvento;
	
	delete from tblevento_artista
	where idevento = p_idEvento;
	
	open v_cur_genero;
	loop_genero: loop
		
		fetch v_cur_genero into v_cdGenero;
		if v_done = 1 then
			set v_done = 0;
			leave loop_genero;
		end if;
		
		insert into tblevento_genero (idevento_genero, idevento, cdgenero)
		values (uuid(), p_idEvento, v_cdGenero);
	end loop;
	close v_cur_genero;
		
	open v_cur_art;
	loop_art: loop
		
		fetch v_cur_art into v_idArtista;
		if v_done = 1 then
			set v_done = 0;
			leave loop_art;
		end if;
		
		insert into tblevento_artista (idevento_artista, idevento, idartista)
		values (uuid(), p_idEvento, v_idArtista);
	end loop;
	close v_cur_art;
	
	update tblevento e
	set e.dsnombre = p_dsNombre,
	e.dsevento = p_dsEvento,
	e.cdestado = p_cdEstado,
	e.isafter = p_isAfter,
	e.islgbt = p_isLgbt,
	e.dtinicioevento = p_dtInicioEvento,
	e.dtfinevento = p_dtFinEvento,
	e.idfiesta = p_idFiesta,
	e.dtupdate = sysdate()
	where e.idevento = p_idEvento;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_EVENTOS_UpdateFechaEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_EVENTOS_UpdateFechaEvento`(IN p_idFecha varchar(36), IN p_cdEstado int,
                                                                  IN p_dtInicio datetime, IN p_dtFin datetime,
                                                                  IN p_dtInicioVenta datetime, IN p_dtFinVenta datetime,
                                                                  OUT p_ok int, OUT p_error text)
    MODIFIES SQL DATA
BEGIN
	set p_ok = 1;
	start transaction;
	
	update tblfecha f
	set f.dtinicio = p_dtInicio,
	f.dtfin = p_dtFin,
	f.cdestado = p_cdEstado,
	f.dtinicioventa = p_dtInicioVenta,
	f.dtfinventa = p_dtFinVenta
	where f.idfecha = p_idFecha;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_FIESTAS_DeleteFiesta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_FIESTAS_DeleteFiesta`(
	in p_idFiesta varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	
	update tblfiesta f
	set f.isactivo = 0
	where f.idfiesta = p_idFiesta;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_FIESTAS_GetFiesta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_FIESTAS_GetFiesta`(
	in p_idFiesta varchar(36),
	in p_idUsuario varchar(36)
)
    READS SQL DATA
BEGIN
	
	select *
	from tblfiesta f
	where f.idfiesta = coalesce(p_idFiesta, f.idfiesta)
	and f.idusuario = coalesce(p_idUsuario, f.idusuario);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_FIESTAS_SetFiesta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_FIESTAS_SetFiesta`(
	in p_idUsuario varchar(36),
	in p_dsNombre varchar(200),
	out p_ok int,
	out p_error text,
	out p_idFiesta varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	set p_ok = 1;
	set p_idFiesta = uuid();
	start transaction;
	insert into tblfiesta (idfiesta, idusuario, dsnombre, isactivo)
	values (p_idFiesta, p_idUsuario, p_dsNombre, 1);
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_FIESTAS_UpdateFiesta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_FIESTAS_UpdateFiesta`(
	in idFiesta varchar(36),
	in p_dsNombre varchar(200),
	out p_ok int,
	out p_error text
)
    MODIFIES SQL DATA
BEGIN
	set p_ok = 1;
	start transaction;

	update tblfiesta f
	set f.dsnombre = p_dsNombre
	where f.idfiesta = idFiesta;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_CancelarReservas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_CancelarReservas`()
    MODIFIES SQL DATA
BEGIN
    start transaction;

    delete cc
    from tblcompra cc
    join tblentrada ee on cc.idcompra = ee.idcompra
    where ee.dtreserva < sysdate() - interval 11 minute
    and cc.cdestado = 5;

	update tblentrada ee
    set ee.dtreserva = null,
        ee.cdestado = 0,
        ee.idcompra = null
    where ee.dtreserva < sysdate() - interval 11 minute
    and ee.cdestado = 1;
    
    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_EntradasNoUtilizadas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_EntradasNoUtilizadas`()
    MODIFIES SQL DATA
BEGIN
	
	START TRANSACTION;
	
	UPDATE tblentrada e
	JOIN tblfecha f ON e.idfecha = f.idfecha 
	JOIN tblevento ev ON f.idevento = ev.idevento
	SET e.cdestado = 6
	WHERE ev.cdestado = 4
	AND e.cdestado = 4;

	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_FinEventos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_FinEventos`()
    MODIFIES SQL DATA
BEGIN
	
	update tblevento e
	set e.cdestado = 4
	where e.dtfinevento <= sysdate()
	and e.cdestado = 3;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_FinFecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_FinFecha`()
    MODIFIES SQL DATA
BEGIN
	
	update tblfecha f
	set f.cdestado = 4
	where f.dtfin <= sysdate()
	and f.cdestado = 3;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_FinVentaEventos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_FinVentaEventos`()
    MODIFIES SQL DATA
BEGIN
	
	update tblevento e
	join tblfecha f on e.idevento = f.idevento 
	and (select max(f.dtfinventa)) <= sysdate()
	set e.cdestado = 3
	where e.cdestado = 2;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_FinVentaFechas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_FinVentaFechas`()
    MODIFIES SQL DATA
BEGIN
	
	update tblfecha f
	set f.cdestado = 3
	where f.dtfinventa <= sysdate()
	and f.cdestado = 2;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_JOBS_InicioVentaEventosFecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_JOBS_InicioVentaEventosFecha`()
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	update tblfecha f
	join tblevento e on f.idevento = e.idevento 
	set f.cdestado = 2, e.cdestado = 2
	where e.cdestado = 1
	and f.cdestado = 1
	and f.dtinicioventa <= sysdate();
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_LOG_SetLogGeneral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_LOG_SetLogGeneral`(IN p_modulo varchar(200), IN p_error text,
                                                             IN p_errcode char(5), IN p_sqlex text)
    MODIFIES SQL DATA
begin
    
    start transaction;
	insert into tblloggeneral 
	(dsmodulo, dsmensaje, nmcodigo, dssqlex, dtinsert)
	values
	(p_modulo, p_error, p_errcode, p_sqlex, sysdate());
    commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_LOG_SetLogWebhookMP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_LOG_SetLogWebhookMP`(in p_idCompra varchar(36),
in p_dsEstadoPago varchar(100),
in p_dsDetalleEstadoPago varchar(100),
in p_ammonto decimal(19,4),
in p_idPagoMP bigint)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;

	insert into tbllogwebhookmp (idlog, idcompra, dsestadopago, dsdealleestadopago, ammonto, dtinsert, idpagomp)
	values (uuid(), p_idCompra, p_dsEstadoPago, p_dsDetalleEstadoPago, p_ammonto, sysdate(), p_idPagoMP);

	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_MEDIA_DeleteMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_MEDIA_DeleteMedia`(
	in p_idMedia varchar(36)
)
BEGIN
	
	start transaction;
	
	delete from tblmedia m
	where m.idmedia = p_idMedia;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_MEDIA_GetMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_MEDIA_GetMedia`(
	in p_idEntidadMedia varchar(36)
)
    READS SQL DATA
BEGIN
	
	select m.idmedia,
	m.identidadmedia,
	m.mdvideo
	from tblmedia m
	where m.identidadmedia = p_idEntidadMedia;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_MEDIA_SetMedia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_MEDIA_SetMedia`(
	in p_idEntidadMedia varchar(36),
	in p_mdVideo varchar(200),
	out p_idMedia varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	set p_idMedia = uuid();
	start transaction;
	
	insert into tblmedia
	(idmedia, identidadmedia, mdvideo)
	values (p_idMedia, p_idEntidadMedia, p_mdVideo);
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_NOTICIAS_DeleteNoticia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_NOTICIAS_DeleteNoticia`(
	in p_idnoticia varchar(36),
	out p_ok int,
	out p_error text
)
    MODIFIES SQL DATA
BEGIN
	
	set p_ok = 1;
	start transaction;
	
	delete from tblnoticia n
	where n.idnoticia = p_idnoticia;
	
	delete from tblmedia m
	where m.identidadmedia = p_idnoticia;
	
	commit;
	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_NOTICIAS_GetNoticias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_NOTICIAS_GetNoticias`(
	in p_idNoticia varchar(36)
)
    READS SQL DATA
begin
	declare v_mesesatras date;
	declare v_diasatras varchar(100);
	
	call PCD_PARAM_GetParametro('GetNoticiasDiasAtras', null, v_diasatras);

	set v_mesesatras = date_sub(curdate(), INTERVAL v_diasatras DAY);
	
	select *
	from tblnoticia n
	left join tblmedia m on n.idnoticia = m.identidadmedia
	where n.dtpublicado > v_mesesatras
	and n.idnoticia = coalesce(p_idNoticia, n.idnoticia);
	
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_NOTICIAS_SetNoticia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_NOTICIAS_SetNoticia`(
in p_titulo varchar(100),
in p_contenido text,
in p_dsurlevento varchar(200),
out p_idNoticia varchar(36),
out p_ok int,
out p_error text
)
    MODIFIES SQL DATA
begin
	set p_idNoticia = uuid();
	set p_ok = 1;
	start transaction;
	INSERT INTO tblnoticia
	(idnoticia, dstitulo, dscontenido, dtpublicado, dsurlevento)
	VALUES (p_idNoticia, p_titulo, p_contenido, curdate(), p_dsurlevento);
	
	commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_NOTICIAS_UpdateNoticia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_NOTICIAS_UpdateNoticia`(
	in p_dsTitulo varchar(100),
	in p_dsContenido text,
	in p_idNoticia varchar(36),
	in p_dsUrlEvento varchar(200)
)
    MODIFIES SQL DATA
BEGIN
	start transaction;

	update tblnoticia n
	set n.dstitulo = p_dsTitulo,
	n.dscontenido = p_dsContenido,
	n.dsurlevento = p_dsUrlEvento
	where n.idnoticia = p_idNoticia;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_PARAM_GetParametro` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_PARAM_GetParametro`(
	in p_cdparametro varchar(100),
	in p_cdsistema varchar(100),
	out p_result varchar(100)
)
    READS SQL DATA
BEGIN
	if p_cdparametro is not null then
		select p.vlparametro
		into p_result
		from tblparametros p
		where p.cdparametro = COALESCE(p_cdparametro, p.cdparametro);
	else
		select p.vlparametro
		from tblparametros p
		where p.cdparametro = COALESCE(p_cdparametro, p.cdparametro)
		and p.cdsistema = COALESCE(p_cdsistema, p.cdsistema);
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_REPORTE_GetVentasEvento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_REPORTE_GetVentasEvento`(IN p_idEvento varchar(36), IN p_idUsuarioOrg varchar(36))
    READS SQL DATA
BEGIN
	
DECLARE v_vlServicio decimal(10,
2) DEFAULT 10;

CALL PCD_PARAM_GetParametro('PctCargoServicio',
'Compras',
v_vlServicio);

SET
v_vlServicio = v_vlServicio / 100;

WITH fechas AS (
SELECT
	f.idfecha,
	f.idevento,
	f.dtinicio,
	ROW_NUMBER() OVER (
ORDER BY
	f.idfecha) AS num_fecha
FROM
	tblfecha f
WHERE
	f.idevento = p_idEvento
),
totales AS (
SELECT
	f.idfecha,
	ROUND(SUM(c.ammonto), 2) AS TotalVenta,
	ROUND(sum(c.amsubtotal), 2) AS Subtotal,
	ROUND(sum(c.amservicio), 2) AS TotalServicio
FROM
	tblcompra c
JOIN (
	SELECT
		DISTINCT e.idcompra,
		e.idfecha
	FROM
		tblentrada e
	JOIN tblfecha f ON
		e.idfecha = f.idfecha
	JOIN tblevento ev ON
		f.idevento = ev.idevento
	WHERE
		e.cdestado in (2, 4, 6)
		AND ev.idevento = p_idEvento
) ce ON
	ce.idcompra = c.idcompra
JOIN tblfecha f ON
	f.idfecha = ce.idfecha
GROUP BY
	f.idfecha
)
SELECT
	fe.idfecha,
    fe.dtinicio,
	fe.num_fecha,
	te.dstipo AS dsTipoEntrada,
	count(1) AS vlStockInicial,
	sum(CASE WHEN e.cdestado in (2, 4, 6) THEN 1 ELSE 0 END) AS vlVendidas,
	ROUND(e.amprecio, 2) AS amPrecioEntrada,
	ROUND(sum(CASE WHEN e.cdestado in (2, 4, 6) THEN e.amprecio + (e.amprecio * v_vlServicio) ELSE 0 END)) amTotalVenta,
	ROUND(sum(CASE WHEN e.cdestado in (2, 4, 6) THEN e.amprecio ELSE 0 END)) amSubtotal,
	ROUND(sum(CASE WHEN e.cdestado in (2, 4, 6) THEN e.amprecio * v_vlServicio ELSE 0 END)) amTotalServicio,
	sum(CASE WHEN e.cdestado IN (0, 1) THEN 1 ELSE 0 END) AS vlStockActual
FROM
	tblentrada e
JOIN fechas fe ON
	e.idfecha = fe.idfecha
JOIN tblevento ev ON
	ev.idevento = fe.idevento
JOIN tbltipoentrada te ON
	e.cdtipo = te.cdtipo
JOIN tblestadoentrada es ON
	e.cdestado = es.cdestado
WHERE
	e.cdestado IN (0, 1, 2, 4, 6, 5)
	AND ev.idevento = p_idEvento
	AND ev.idusuario = p_idUsuarioOrg
GROUP BY
	fe.num_fecha,
	te.dstipo,
	e.amprecio,
	e.cdtipo,
	fe.idfecha,
	fe.dtinicio
UNION ALL
SELECT
	fe.idfecha,
	fe.dtinicio,
	fe.num_fecha,
	'TOTAL' AS dsTipoEntrada,
	NULL AS vlStockInicial,
	SUM(CASE WHEN e.cdestado in (2, 4, 6) THEN 1 ELSE 0 END) AS vlVendidas,
	NULL AS amPrecioEntrada,
	COALESCE(t.TotalVenta + t.TotalServicio, 0) AS amTotalVenta,
	COALESCE(t.Subtotal, 0) AS amSubtotal,
	COALESCE(t.TotalServicio, 0) AS amTotalServicio,
	NULL AS vlStockActual
FROM
	tblentrada e
JOIN fechas fe ON
	e.idfecha = fe.idfecha
JOIN tblevento ev ON
	ev.idevento = fe.idevento
LEFT JOIN totales t ON
	fe.idfecha = t.idfecha
WHERE
	e.cdestado IN (0, 1, 2, 4, 6)
	AND ev.idevento = p_idEvento
	AND ev.idusuario = p_idUsuarioOrg
GROUP BY
	fe.num_fecha,
	fe.idfecha,
	fe.dtinicio
ORDER BY
	num_fecha,
	CASE
		WHEN dsTipoEntrada = 'TOTAL' THEN 1
		ELSE 0
	END,
	"dsTipoEntrada";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_RESENIAS_DeleteResenia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_RESENIAS_DeleteResenia`(
in p_idResenia varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	delete from tblresenia r
	where r.idresenia = p_idResenia;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_RESENIAS_GetAvgResenias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_RESENIAS_GetAvgResenias`(
in p_idFiesta varchar(36)
)
    READS SQL DATA
BEGIN
	
	select round(avg(r.nmestrellas), 1) as avgestrellas, 
	f.idfiesta, 
	count(1) AS cantresenias
	from tblfiesta f
	inner join tblresenia r on f.idfiesta = r.idfiesta
	where f.idfiesta = coalesce(p_idFiesta, f.idfiesta)
	group by f.idfiesta;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_RESENIAS_GetResenias` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_RESENIAS_GetResenias`(
in p_idResenia varchar(36),
in p_idFiesta varchar(36),
in p_idUsuario varchar(36),
in p_nmEstrellas int
)
    READS SQL DATA
BEGIN
	
	select us.dsnombrereal,
	us.dsapellido,
	re.nmestrellas,
	re.dscomentario, 
	fi.idfiesta,
	us.idusuario,
	re.dtinsert,
	re.idresenia
	from tblresenia re
	inner join tblfiesta fi on re.idfiesta = fi.idfiesta
	INNER JOIN tblusuario us ON re.idusuario = us.idusuario 
	where re.idresenia = coalesce(p_idResenia, re.idresenia)
	and re.idfiesta = coalesce(p_idFiesta, re.idfiesta)
	and re.idusuario = coalesce(p_idUsuario, re.idusuario)
	and re.nmestrellas >= coalesce(p_nmEstrellas, 0);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_RESENIAS_SetResenia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_RESENIAS_SetResenia`(
in p_idFiesta varchar(36),
in p_idUsuario varchar(36),
in p_nmEstrellas int,
in p_dsComentario text,
out p_idResenia varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	set p_idResenia = uuid();
	start transaction;
	insert into tblresenia (idresenia, idusuario, nmestrellas, dscomentario, dtinsert, idfiesta)
	values (p_idResenia, p_idUsuario, p_nmEstrellas, p_dsComentario, sysdate(), p_idFiesta);

	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_RESENIAS_UpdateResenia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_RESENIAS_UpdateResenia`(
in p_idResenia varchar(36),
in p_nmEstrellas int,
in p_dsComentario text
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	update tblresenia r
	set r.nmestrellas = p_nmEstrellas,
	r.dscomentario = p_dsComentario
	where r.idresenia = p_idResenia;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_SOCIALS_DeleteSocials` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_SOCIALS_DeleteSocials`(IN p_idSocials varchar(36))
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	
	delete from tblsocial s
	where s.idsocial = p_idSocials;
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_SOCIALS_SetSocials` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_SOCIALS_SetSocials`(IN p_mdInstagram varchar(200), IN p_mdSpotify varchar(200),
                                                           IN p_mdSoundcloud varchar(200), OUT p_idSocials varchar(36))
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	set p_idSocials = uuid();
	insert into tblsocial (idsocial, mdinstagram, mdspotify, mdsoundcloud)
	values (p_idSocials, p_mdInstagram, p_mdSpotify, p_mdSoundcloud);
	
	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_SOCIALS_UpdateSocials` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_SOCIALS_UpdateSocials`(
	in p_mdInstagram varchar(200),
	in p_mdSpotify varchar(200),
	in p_mdSoundcloud varchar(200),
	in p_idSocials varchar(36)
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	
	update tblsocial s
	set s.mdinstagram = p_mdInstagram,
	s.mdspotify = p_mdSpotify,
	s.mdsoundcloud = p_mdSoundcloud
	where s.idsocial = p_idSocials;
	
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_TEST_DoMultiple` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_TEST_DoMultiple`(
in v_cant int
)
BEGIN
	DECLARE i INT default 0;
	

	WHILE i < v_cant DO
		insert into tblnoticia
		select uuid(), 
		'LOREM IPSUM',
		'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
		SYSDATE();
		set i = i + 1;
	end while;
	commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_TEST_InsertMultiRow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_TEST_InsertMultiRow`()
    MODIFIES SQL DATA
begin
 	declare randomString varchar(200);
 	declare randomEstado int;
 	declare randomTipo int;
	declare randomPrecio int;
	DECLARE done TINYINT DEFAULT FALSE;
	declare v_id varchar(36) default '';
	DECLARE v_cursor
	 CURSOR FOR
	 SELECT t.idevento
	   FROM tblevento t; 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;	
    
    
   
   	
       



OPEN v_cursor;
v_loop: 
LOOP
  FETCH NEXT FROM v_cursor INTO v_id;
  IF done THEN 
    LEAVE v_loop; 
  ELSE
    set randomEstado = FLOOR(0+RAND()*(3-0+1));
    set randomTipo = FLOOR(0+RAND()*(2-0+1));
   	set randomPrecio = FLOOR(10000+RAND()*(50000-10000+1));
	INSERT INTO raveapp.tblentrada
	(idevento,  mdqr, cdestado, cdtipo, amprecio)
	VALUES(v_id, 'https://127.0.0.1/media', randomEstado, randomTipo, randomPrecio);
  
  END IF;
END LOOP;

CLOSE v_cursor;

   

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_ConfirmarCuenta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_ConfirmarCuenta`(IN p_dsCorreo varchar(45))
    MODIFIES SQL DATA
BEGIN
	
	START TRANSACTION;
	
	UPDATE tblusuario u
	SET u.isverificado = 1
	WHERE u.dscorreo = p_dsCorreo;
	
	COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_DeleteRolUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_DeleteRolUsuario`(
in p_idusuario varchar(36),
in p_cdrol int
)
    MODIFIES SQL DATA
BEGIN
	
	delete from tblrol_usuario ru
	where ru.idusuario = p_idusuario
	and ru.cdrol = p_cdrol;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_DeleteUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_USUARIOS_DeleteUsuario`(
in p_idusuario varchar(36),
out p_ok integer,
out p_error text
)
    MODIFIES SQL DATA
begin
	
	declare v_iddomicilio varchar(36);
	declare v_modulo varchar(200);
    
	set v_modulo = 'PCD_USUARIOS_DeleteUsuario';
	set p_ok = 1;
	set p_error = '';
	start transaction;

	update tblusuario u
	set u.isactivo = 0
	where u.idusuario = p_idusuario;
	
	commit;
	
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_DeleteUsuarioControl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_DeleteUsuarioControl`(
IN p_idUsuarioOrg varchar(36), 
IN p_idUsuarioControl varchar(36))
    MODIFIES SQL DATA
BEGIN
	START TRANSACTION;
	
	DELETE FROM tblusuariocontrol t
	WHERE t.idusuario = p_idUsuarioOrg
	AND t.idusuariocontrol = p_idUsuarioControl;
	
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_GetComprasUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_GetComprasUsuario`(IN p_idUsuario varchar(36), in p_cdEstado int)
    READS SQL DATA
BEGIN

    select cc.ammonto,
           cc.dtinsert
    from tblcompra cc
    where cc.idusuario = p_idUsuario
    and cc.cdestado = coalesce(p_cdEstado, cc.cdestado);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_GetEntradas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_GetEntradas`(in p_idUsuario varchar(36))
    READS SQL DATA
BEGIN
	
	select ee.identrada, 
	ee.cdestado, 
	es.dsestado,
	ee.cdtipo, 
	et.dstipo,
	ee.amprecio,
	ee.idfecha,
	f.idevento,
	cc.idcompra,
    cc.dtinsert,
    DENSE_RANK() OVER (ORDER BY cc.idcompra) AS num_compra
	from tblentrada ee
	join tblcompra cc on ee.idcompra = cc.idcompra
	join tblusuario uu on cc.idusuario = uu.idusuario
	join tblestadoentrada es on ee.cdestado = es.cdestado 
	join tbltipoentrada et on ee.cdtipo = et.cdtipo 
	join tblfecha f on ee.idfecha = f.idfecha 
	where uu.idusuario = p_idUsuario
	and ee.cdestado  in (3, 4, 5, 2, 6)
	ORDER BY num_compra;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_GetEventosFavoritos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_GetEventosFavoritos`(IN p_idUsuario varchar(36))
    READS SQL DATA
BEGIN

    select eu.idevento
    from tblevento_usuario eu
    where eu.idusuario = p_idUsuario;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_GetRolesUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_GetRolesUsuario`(
	in p_idUsuario varchar(36)
)
    READS SQL DATA
BEGIN
	if p_idUsuario is null then
	
	SELECT r.cdrol,
	r.dsrol 
	from tblrol r;

	else
	
	SELECT r.cdrol,
	r.dsrol 
	from tblrol r, tblrol_usuario ru
	where ru.idusuario = p_idUsuario
	and ru.cdrol = r.cdrol;
	
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_GetUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_USUARIOS_GetUsuario`(
	in p_idusuario varchar(36),
	in p_mail varchar(45),
	in p_isactivo tinyint,
	in p_cdrol int
)
    READS SQL DATA
begin
	
	SELECT 
    p.cdprovincia,
    p.dsprovincia,
    m.cdmunicipio,
    m.dsmunicipio,
    l.cdlocalidad,
    l.dslocalidad,
    d.dsdireccion,
    d.nmlatitud,
    d.nmlongitud,
    s.idsocial,
    s.mdinstagram,
    s.mdspotify,
    s.mdsoundcloud,
    u.*
	FROM tblusuario u
	INNER JOIN tbldomicilio d ON u.iddomicilio = d.iddomicilio
	INNER JOIN tbllocalidad l ON d.cdlocalidad = l.cdlocalidad
	INNER JOIN tblmunicipio m ON d.cdmunicipio = m.cdmunicipio
	INNER JOIN tblprovincia p ON d.cdprovincia = p.cdprovincia
	LEFT JOIN tblsocial s ON u.idsocial = s.idsocial
	WHERE u.idusuario = COALESCE(p_idusuario, u.idusuario)
	  AND u.dscorreo = COALESCE(p_mail, u.dscorreo)
	  AND u.isactivo = COALESCE(p_isactivo, u.isactivo)
	  AND EXISTS (
	      SELECT 1
	      FROM tblrol_usuario ru
	      WHERE ru.idusuario = u.idusuario
	        AND ru.cdrol = COALESCE(p_cdrol, ru.cdrol)
	  );


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_GetUsuariosControl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_GetUsuariosControl`(IN p_idUsuarioOrg varchar(36))
    READS SQL DATA
BEGIN
	
	SELECT t.IdUsuarioControl, t.dsnombreusuario
	FROM tblusuariocontrol t
	WHERE t.idusuario = p_idUsuarioOrg;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_LoginUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_LoginUsuario`(
	in p_dsCorreo varchar(45),
	out p_dsPass varchar(200)
)
    READS SQL DATA
BEGIN
	
	select u.dspass
	into p_dsPass
	from tblusuario u
	where lower(u.dscorreo) = lower(p_dsCorreo);
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_LoginUsuarioControl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_LoginUsuarioControl`(
	IN p_dsNombreUsuario varchar(200),
	out p_dsPass varchar(200))
    READS SQL DATA
BEGIN
	
	SELECT t.dsPass
	INTO p_dsPass
	FROM tblusuariocontrol t
	WHERE t.dsnombreusuario = p_dsNombreUsuario;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_RecoverPass` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_RecoverPass`(
	in p_dsCorreo varchar(45),
	in p_dsNewPass varchar(200)
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;
	
	update tblusuario u
	set u.dspass = p_dsNewPass
	where lower(u.dscorreo) = lower(p_dsCorreo);
	
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_ResetPass` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_ResetPass`(
	in p_dsCorreo varchar(45),
	in p_dsNewPass varchar(200)
)
    MODIFIES SQL DATA
BEGIN
	
	start transaction;

	update tblusuario u
	set u.dspass = p_dsNewPass
	where lower(u.dscorreo) = lower(p_dsCorreo);
	
	commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_SetRolUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_SetRolUsuario`(
in p_idusuario varchar(36),
in p_cdrol int
)
    MODIFIES SQL DATA
BEGIN
	
	insert into tblrol_usuario (idusuario, cdrol)
	select p_idusuario, 
	p_cdrol 
	from tblrol r 
	where r.cdrol = p_cdrol;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_SetUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_USUARIOS_SetUsuario`(IN p_dsDireccion varchar(200), IN p_nmLatitud decimal,
                                                               IN p_nmLongitud decimal, IN p_dsProvincia varchar(45),
                                                               IN p_cdProvincia varchar(36),
                                                               IN p_dsMunicipio varchar(45),
                                                               IN p_cdMunicipio varchar(36),
                                                               IN p_dsLocalidad varchar(45),
                                                               IN p_cdLocalidad varchar(36), IN p_dsNombre varchar(45),
                                                               IN p_dsApellido varchar(45), IN p_dsCorreo varchar(45),
                                                               IN p_nmDni varchar(45), IN p_nmTelefono varchar(45),
                                                               IN p_dsCbu varchar(45), IN p_dsBio text,
                                                               IN p_dsPass varchar(200), IN p_mdInstagram varchar(200),
                                                               IN p_mdSpotify varchar(200),
                                                               IN p_mdSoundcloud varchar(200), IN p_dtNacimiento date,
                                                               IN p_isVerificado TINYINT,
                                                               OUT p_idUsuario varchar(36), OUT p_ok int,
                                                               OUT p_error text)
    MODIFIES SQL DATA
begin
	declare v_idDomicilio varchar(36);
	declare v_idSocials varchar(36);
	declare v_modulo varchar(200);
	declare c_cdrolusuario int;
	
   	set c_cdrolusuario = 0;
	set v_modulo = 'PCD_USUARIOS_SetUsuario';
	set p_ok = 1;
	set p_idUsuario = uuid();
	
	start transaction;
	
	call PCD_DIRECCIONES_SetDomicilio(p_dsDireccion, p_nmLatitud, p_nmLongitud, p_dsProvincia, p_cdProvincia, p_dsMunicipio, p_cdMunicipio, p_dsLocalidad, p_cdLocalidad, v_idDomicilio, p_ok, p_error);
	
	if p_mdInstagram != '' or p_mdSpotify != '' or p_mdSoundcloud != '' then
		call PCD_SOCIALS_SetSocials(p_mdInstagram, p_mdSpotify, p_mdSoundcloud, v_idSocials);
	end if;
	
	INSERT INTO tblusuario
	(idusuario, iddomicilio, dsnombrereal, dsapellido, dscorreo, nmdni, nmtelefono, dscbu, dtalta, dsbio, dspass, idsocial, dtnacimiento, isverificado)
	VALUES(p_idUsuario, v_iddomicilio, p_dsNombre, p_dsApellido, lower(p_dsCorreo), p_nmdni, p_nmtelefono, p_dscbu, sysdate(), p_dsbio, p_dsPass, v_idSocials, p_dtNacimiento, p_isVerificado);
	
	call PCD_USUARIOS_SetRolUsuario(p_idUsuario, c_cdrolusuario);

	commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_SetUsuarioControl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_SetUsuarioControl`(
IN p_idUsuarioOrg varchar(36), 
IN p_dsNombreUsuario varchar(200), 
IN p_dsPass varchar(200),
OUT p_idUsuarioControl varchar(36))
    MODIFIES SQL DATA
BEGIN
	set p_idUsuarioControl = uuid();
	START TRANSACTION;

	INSERT INTO tblusuariocontrol (IdUsuarioControl ,dsnombreusuario, dspass, idusuario)
	VALUES (p_idUsuarioControl, p_dsNombreUsuario, p_dsPass, p_idUsuarioOrg);

	COMMIT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_ToggleEventoFavorito` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `PCD_USUARIOS_ToggleEventoFavorito`(IN p_idUsuario varchar(36), IN p_idEvento varchar(36))
    MODIFIES SQL DATA
BEGIN

    if exists (select 1 from tblevento_usuario ea where ea.idusuario = p_idUsuario and ea.idevento = p_idEvento) then
       delete from tblevento_usuario ea
        where ea.idusuario = p_idUsuario
        and ea.idevento = p_idEvento;
    else
        insert into tblevento_usuario (idusuario, idevento)
        values (p_idUsuario, p_idEvento);
    end if;

    commit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_ToggleLikeArtista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_USUARIOS_ToggleLikeArtista`(IN p_idartista varchar(36), IN p_idusuario varchar(36))
    MODIFIES SQL DATA
begin
	
	if exists(select 1 from tblartistafav af where af.idartista = p_idartista and af.idusuario = p_idusuario) then
		delete from tblartistafav af
		where af.idartista = p_idartista
		and af.idusuario = p_idusuario;
	else
		insert into tblartistafav
		(idartista, idusuario)
		values (p_idartista, p_idusuario);
	end if;
	
	commit;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PCD_USUARIOS_UpdateUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PCD_USUARIOS_UpdateUsuario`(IN p_idUsuario varchar(36),
                                                                  IN p_dsDireccion varchar(200), IN p_nmLatitud decimal,
                                                                  IN p_nmLongitud decimal, IN p_dsProvincia varchar(45),
                                                                  IN p_cdProvincia varchar(36),
                                                                  IN p_dsMunicipio varchar(45),
                                                                  IN p_cdMunicipio varchar(36),
                                                                  IN p_dsLocalidad varchar(45),
                                                                  IN p_cdLocalidad varchar(36),
                                                                  IN p_dsNombre varchar(45),
                                                                  IN p_dsApellido varchar(45),
                                                                  IN p_dsCorreo varchar(45), IN p_nmDni varchar(45),
                                                                  IN p_nmTelefono varchar(45), IN p_dsCbu varchar(45),
                                                                  IN p_dsBio text, IN p_cdRolList text,
                                                                  IN p_mdInstagram varchar(200),
                                                                  IN p_mdSpotify varchar(200),
                                                                  IN p_mdSoundcloud varchar(200),
                                                                  IN p_dtNacimiento date,
                                                                  IN p_isVerificado TINYINT,
                                                                  OUT p_ok int,
                                                                  OUT p_error text)
    MODIFIES SQL DATA
begin

	declare v_iddomicilio varchar(36);
	declare v_idSocials varchar(36);
	declare v_modulo varchar(200);
	declare v_cdRol int;
	declare v_done int default 0;
    declare v_cur_rol cursor for 
		select r.cdrol
	    from tblrol r
    	where find_in_set(r.cdrol, p_cdRolList) > 0;
	declare continue handler for not found set v_done = 1;
	
	set v_modulo = 'PCD_USUARIOS_UpdateUsuario';
	set p_ok = 1;
	start transaction;
	
	select coalesce(u.idsocial, '')
	into v_idSocials
	from tblusuario u
	where u.idusuario = p_idUsuario;
	
	if p_mdInstagram != '' or p_mdSpotify != '' or p_mdSoundcloud != '' then
		if v_idSocials != '' then
			call PCD_SOCIALS_UpdateSocials(p_mdInstagram, p_mdSpotify, p_mdSoundcloud, v_idSocials);
		else 
			set v_idSocials = uuid();
			call PCD_SOCIALS_SetSocials(p_mdInstagram, p_mdSpotify, p_mdSoundcloud, v_idSocials);
		end if;
	else
		call PCD_SOCIALS_DeleteSocials(v_idSocials);
	end if;

	select u.iddomicilio
	into v_iddomicilio
	from tblusuario u
	where u.idusuario = p_idUsuario;
	
	call PCD_DIRECCIONES_UpdateDomicilio(v_iddomicilio, p_dsDireccion, p_nmLatitud, p_nmLongitud, p_dsProvincia, p_cdProvincia, p_dsMunicipio, p_cdMunicipio, p_dsLocalidad, p_cdLocalidad, p_ok, p_error);
	
	update tblusuario u set
	u.dsnombrereal = p_dsNombre,
	u.dsapellido = p_dsApellido,
	u.dscorreo = lower(p_dsCorreo),
	u.nmdni = p_nmDni,
	u.nmtelefono = p_nmTelefono,
	u.dscbu = p_dsCbu,
	u.dsbio = p_dsBio,
	u.idsocial = v_idSocials,
	u.dtnacimiento = p_dtNacimiento,
	u.isverificado = p_isVerificado
	where u.idusuario = p_idUsuario;
	if p_cdRolList is not null then
		delete from tblrol_usuario r
		where r.idusuario = p_idUsuario;
		
		open v_cur_rol;
		loop_rol: loop
			
			fetch v_cur_rol into v_cdRol;
			if v_done = 1 then
				set v_done = 0;
				leave loop_rol;
			end if;
			call PCD_USUARIOS_SetRolUsuario(p_idUsuario, v_cdRol);
		end loop;
		close v_cur_rol;
	end if;
	commit;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test_error_handler` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`raveapp`@`%` PROCEDURE `test_error_handler`(OUT p_ok INT, OUT p_error VARCHAR(255))
BEGIN
    
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
	    DECLARE v_errcode CHAR(5);
    	DECLARE v_sqlex TEXT;
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 
            v_errcode = MYSQL_ERRNO, 
            v_sqlex   = MESSAGE_TEXT;
        
        SET p_ok = 0;
        SET p_error = CONCAT(v_errcode ,' Error: ', v_sqlex);
        call PCD_LOG_SetLogGeneral("TEST LOGEO", p_error, v_errcode, v_sqlex);
        
    END;
   
    START TRANSACTION;

    CREATE TEMPORARY TABLE IF NOT EXISTS temp_test (
        id INT PRIMARY KEY,
        name VARCHAR(50)
    );

    INSERT INTO temp_test (id, name) VALUES (1, 'Initial');

    

    INSERT INTO temp_test (id, name) VALUES (1, 'Duplicate');

    COMMIT;

    SET p_ok = 1;
    SET p_error = 'No error encountered';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-09 23:41:57
