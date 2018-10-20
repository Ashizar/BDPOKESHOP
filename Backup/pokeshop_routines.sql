-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: pokeshop
-- ------------------------------------------------------
-- Server version	5.5.59

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
-- Dumping routines for database 'pokeshop'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_CrearUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CrearUsuario`(
    IN _nombreUsuario VARCHAR(64),
    IN _apelPaterno VARCHAR(64),
    IN _apelMaterno VARCHAR(64),
    IN _correo VARCHAR(64),
    IN _nick VARCHAR(64),
    IN _contrasenia VARCHAR(64),
    IN _perfil MEDIUMBLOB,
    IN _extPerfil VARCHAR(8),
    IN _portada MEDIUMBLOB,
    IN _extPortada VARCHAR(8),
    IN _calle VARCHAR(64),
    IN _colonia VARCHAR(64),
    IN _ciudad VARCHAR(64),
    IN _estado VARCHAR(64),
    IN _pais VARCHAR(64),
    IN _zipCode VARCHAR(16),
    IN _noInt VARCHAR(32),
    IN _noExt VARCHAR(32)
)
BEGIN
	DECLARE _idExistente INT DEFAULT NULL;
    
    SELECT idUsuario
    INTO _idExistente
    FROM Usuario
    WHERE nick LIKE _nick;
    
    if(_idExistente IS NULL)
    THEN
		INSERT INTO Usuario
        VALUES (
			DEFAULT,
            _nombreUsuario,
			_apelPaterno,
			_apelMaterno,
			_correo,
			_nick,
			_contrasenia,
			_perfil,
			_extPerfil,
			_portada,
			_extPortada
        );
        
        SELECT idUsuario
		INTO _idExistente
		FROM Usuario
		WHERE nick LIKE _nick;
        
        INSERT INTO Direccion
        VALUES(
			DEFAULT,
            _idExistente,
            _calle,
			_colonia,
			_ciudad,
			_estado,
			_pais,
			_zipCode,
			_noInt,
			_noExt
        );
	ELSE
		SELECT 'Error, usuario existente';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ObtenerUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ObtenerUsuario`(
	IN inNick VARCHAR(64),
    IN inContrasenia VARCHAR(64)
)
BEGIN
	SELECT idUsuario, nombreUsuario, correo,
		perfil, extPerfil, portada, extPortada
	FROM Usuario
    WHERE nick = inNick AND
		contrasenia = inContrasenia;
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

-- Dump completed on 2018-10-19  1:07:36
