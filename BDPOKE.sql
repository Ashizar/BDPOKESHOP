CREATE DATABASE PokeShop;
USE PokeShop;

CREATE TABLE Usuario(
	idUsuario INT NOT NULL AUTO_INCREMENT,
    nombreUsuario VARCHAR(64) NOT NULL,
    apelPaterno VARCHAR(64) NOT NULL,
    apelMaterno VARCHAR(64) NOT NULL,
    correo VARCHAR(64) NOT NULL,
    nick VARCHAR(64) NOT NULL,
    contrasenia VARCHAR(64) NOT NULL,
    perfil MEDIUMBLOB NOT NULL,
    extPerfil VARCHAR(8) NOT NULL,
    portada MEDIUMBLOB NOT NULL,
    extPortada VARCHAR(8) NOT NULL,
    PRIMARY KEY(idUsuario)
);

CREATE TABLE Direccion(
	idDireccion INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    calle VARCHAR(64) NOT NULL,
    colonia VARCHAR(64) NOT NULL,
    ciudad VARCHAR(64) NOT NULL,
    estado VARCHAR(64) NOT NULL,
    pais VARCHAR(64) NOT NULL,
    zipCode VARCHAR(16) NOT NULL,
    noInt VARCHAR(32) NOT NULL,
    noExt VARCHAR(32) NOT NULL,
    PRIMARY KEY(idDireccion),
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Categoria(
	idCategoria INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(32) NOT NULL,
    PRIMARY KEY(idCategoria)
);

CREATE TABLE TipoPago(
	idTipoPago INT NOT NULL AUTO_INCREMENT,
    pago VARCHAR(32) NOT NULL,
    PRIMARY KEY(idTipoPago)
);

CREATE TABLE Producto(
	idProducto INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    nombreProducto VARCHAR(64) NOT NULL,
    descripcion TEXT NOT NULL,
    idCategoria INT NOT NULL,
    idTipoPago INT NOT NULL,
    precio FLOAT NOT NULL,
    unidad INT NOT NULL,
    estado TINYINT NOT NULL,
    PRIMARY KEY(idProducto),
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY(idCategoria) REFERENCES Categoria(idCategoria),
    FOREIGN KEY(idTipoPago) REFERENCES TipoPago(idTipoPago)
);

CREATE TABLE Comentario(
	idComentario INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idProducto INT NOT NULL,
    comentario TEXT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    PRIMARY KEY(idComentario),
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY(idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE Valoracion(
	idValoracion INT NOT NULL AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    idProducto INT NOT NULL,
    valoracion INT NOT NULL,
    PRIMARY KEY(idValoracion),
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario),
    FOREIGN KEY(idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE ImagenProducto(
	idImagen INT NOT NULL AUTO_INCREMENT,
    idProducto INT NOT NULL,
    imagen MEDIUMBLOB NOT NULL,
    extImg VARCHAR(16) NOT NULL,
    PRIMARY KEY(idImagen),
    FOREIGN KEY(idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE VideoProducto(
	idVideo INT NOT NULL AUTO_INCREMENT,
    idProducto INT NOT NULL,
    video LONGBLOB NOT NULL,
    extVideo VARCHAR(16) NOT NULL,
    PRIMARY KEY(idVideo),
    FOREIGN KEY(idProducto) REFERENCES Producto(idProducto)
);

CREATE TABLE Historial(
	idHistorial INT NOT NULL AUTO_INCREMENT,
    idProducto INT NOT NULL,
    idUsuario INT NOT NULL,
    fecha DATE,
    hora TIME,
    unidad INT NOT NULL,
    total FLOAT NOT NULL,
    PRIMARY KEY(idHistorial),
    FOREIGN KEY(idProducto) REFERENCES Producto(idProducto),
    FOREIGN KEY(idUsuario) REFERENCES Usuario(idUsuario)
);

/*--------*/
USE `pokeshop`;
DROP procedure IF EXISTS `sp_ObtenerUsuario`;

DELIMITER $$
USE `pokeshop`$$
CREATE PROCEDURE `sp_ObtenerUsuario` (
    IN inNick VARCHAR(64),
    IN inContrasenia VARCHAR(64)
)
BEGIN
    SELECT idUsuario, nombreUsuario, correo,
        perfil, extPerfil, portada, extPortada
    FROM Usuario
    WHERE nick = inNick AND
        contrasenia = inContrasenia;
END$$

DELIMITER ;

/*--------*/
USE `pokeshop`;
DROP procedure IF EXISTS `sp_CrearUsuario`;

DELIMITER $$
USE `pokeshop`$$
CREATE PROCEDURE `sp_CrearUsuario` (
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
END$$

DELIMITER ;