/******************************************************************************
*  @coronapl
*  Relational Databases
*  Stored Procedures
******************************************************************************/

/******************************************************************************
  Procedimientos
  Sección Materiales
******************************************************************************/

-- PROCEDIMIENTO PARA INSERTAR MATERIAL
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaMaterial' AND type = 'P')
    DROP PROCEDURE creaMaterial
GO

CREATE PROCEDURE creaMaterial
    @uclave NUMERIC(5,0),
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8,2),
    @uimpuesto NUMERIC(6,2)
AS
    INSERT INTO Materiales VALUES(@uclave, @udescripcion, @ucosto, @uimpuesto)
GO

EXECUTE creaMaterial 5000,'Martillos Acme',250,15

-- PROCEDIMIENTO PARA MODIFICAR MATERIAL
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaMaterial' AND type = 'P')
    DROP PROCEDURE modificaMaterial
GO

CREATE PROCEDURE modificaMaterial
    @uclave NUMERIC(5,0),
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8,2),
    @uimpuesto NUMERIC(6,2)
AS
    UPDATE Materiales
    SET Descripcion = @udescripcion, Costo = @ucosto,
        PorcentajeImpuesto = @uimpuesto
    WHERE Clave = @uclave
GO

EXECUTE modificaMaterial 5000, 'Martillo de uña', 435, 15

-- PROCEDIMIENTO PARA ELIMINAR MATERIAL
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaMaterial' AND type = 'P')
    DROP PROCEDURE eliminaMaterial
GO

CREATE PROCEDURE eliminaMaterial
    @uclave NUMERIC(5,0)
AS
    DELETE FROM Materiales
    WHERE Clave = @uclave
GO

EXECUTE eliminaMaterial 5000

/******************************************************************************
  Procedimientos
  Sección Proyectos
******************************************************************************/

-- PROCEDIMIENTO PARA CREAR PROYECTO
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaProyecto' AND type = 'P')
    DROP PROCEDURE  creaProyecto
GO

CREATE  PROCEDURE creaProyecto
    @unumero NUMERIC(5,0),
    @udenomicacion VARCHAR(50)
AS
    INSERT INTO Proyectos
    VALUES (@unumero, @udenomicacion)
GO

EXECUTE creaProyecto 12345, "Segundo piso Av. Republica"

-- PROCEDIMIENTO PARA MODIFICAR PROYECTO
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaProyecto' AND type = 'P')
    DROP PROCEDURE  modificaProyecto
GO

CREATE  PROCEDURE modificaProyecto
    @unumero NUMERIC(5,0),
    @udenomicacion VARCHAR(50)
AS
    UPDATE Proyectos
    SET Denominacion = @udenomicacion
    where Numero = @unumero
GO

EXECUTE modificaProyecto 12345, "Segundo piso Periferico"

-- PROCEDIMIENTO PARA ELIMINAR PROYECTO
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaProyecto' AND type = 'P')
    DROP PROCEDURE  eliminaProyecto
GO

CREATE  PROCEDURE eliminaProyecto
    @unumero NUMERIC(5,0)
AS
    DELETE FROM Proyectos
    where Numero = @unumero
GO

EXECUTE eliminaProyecto 12345

/******************************************************************************
  Procedimientos
  Sección Proveedores
******************************************************************************/

-- PROCEDIMIENTO PARA CREAR PROVEEDOR
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaProveedor' AND type = 'P')
    DROP PROCEDURE  creaProveedor
GO

CREATE  PROCEDURE creaProveedor
    @urfc CHAR(13),
    @urazonsocial VARCHAR(50)
AS
    INSERT INTO Proveedores
    VALUES (@urfc, @urazonsocial)
GO

EXECUTE creaProveedor ABC1234567891, "ConcretoMex"

-- PROCEDIMIENTO PARA MODIFICAR PROVEEDOR
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaProveedor' AND type = 'P')
    DROP PROCEDURE  modificaProveedor
GO

CREATE  PROCEDURE modificaProveedor
    @urfc CHAR(13),
    @urazonsocial VARCHAR(50)
AS
    UPDATE Proveedores
    SET RazonSocial = @urazonsocial
    WHERE  RFC = @urfc
GO

EXECUTE modificaProveedor ABC1234567891, "CementosMex"

-- PROCEDIMIENTO PARA ELIMINAR PROVEEDOR
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaProveedor' AND type = 'P')
    DROP PROCEDURE  eliminaProveedor
GO

CREATE  PROCEDURE eliminaProveedor
    @urfc CHAR(13)
AS
    DELETE FROM Proveedores
    WHERE  RFC = @urfc
GO

EXECUTE eliminaProveedor ABC1234567891

/******************************************************************************
  Procedimientos
  Sección Entregan
******************************************************************************/

-- PROCEDIMIENTO PARA CREAR ENTREGA
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'creaEntrega' AND type = 'P')
    DROP PROCEDURE  creaEntrega
GO

CREATE PROCEDURE creaEntrega
    @uclave NUMERIC(5,0),
    @urfc CHAR(13),
    @unumero NUMERIC(5,0),
    @ufecha DATETIME,
    @ucantidad NUMERIC(8,2)
AS
    INSERT INTO Entregan
    VALUES (@uclave, @urfc, @unumero, @ufecha, @ucantidad)
GO

SET DATEFORMAT dmy
EXECUTE creaMaterial 5000,'Martillos Acme',250,15
EXECUTE creaProveedor ABC1234567891, "ConcretoMex"
EXECUTE creaProyecto 12345, "Segundo piso Av. Republica"
EXECUTE creaEntrega 5000, ABC1234567891, 12345, '15-10-2020', 10

-- PROCEDIMIENTO PARA MODIFICAR ENTREGA
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'modificaEntrega' AND type = 'P')
    DROP PROCEDURE modificaEntrega
GO

CREATE PROCEDURE modificaEntrega
    @uclave NUMERIC(5,0),
    @urfc CHAR(13),
    @unumero NUMERIC(5,0),
    @ufecha DATETIME,
    @ucantidad NUMERIC(8,2)
AS
    UPDATE Entregan
    SET Fecha = @ufecha, Cantidad = @ucantidad
    WHERE Clave = @uclave AND RFC = @urfc AND Numero = @unumero
GO

EXECUTE modificaEntrega 5000, ABC1234567891, 12345, '20-08-2020', 5

-- PROCEDIMIENTO PARA ELIMINAR ENTREGA
IF EXISTS (SELECT name FROM sysobjects
           WHERE name = 'eliminaEntrega' AND type = 'P')
    DROP PROCEDURE eliminaEntrega
GO

CREATE PROCEDURE eliminaEntrega
    @uclave NUMERIC(5,0),
    @urfc CHAR(13),
    @unumero NUMERIC(5,0)
AS
    DELETE FROM Entregan
    WHERE Clave = @uclave AND RFC = @urfc AND Numero = @unumero
GO

EXECUTE eliminaEntrega 5000, ABC1234567891, 12345

IF EXISTS(SELECT name FROM sysobjects
          WHERE name = 'queryMaterial' AND type = 'P')
    DROP PROCEDURE queryMaterial
GO

CREATE PROCEDURE queryMaterial
    @udescripcion VARCHAR(50),
    @ucosto NUMERIC(8, 2)
AS
    SELECT *
    FROM Materiales
    WHERE descripcion LIKE '%' + @udescripcion + '%' AND costo > @ucosto
GO

EXECUTE queryMaterial 'Lad',20

CREATE DATABASE park;
USE park;

-- SITIO
CREATE TABLE sitio (
    id_sitio INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_sitio VARCHAR(256) NOT NULL
);

INSERT INTO sitio (nombre_sitio)
VALUES ('Centro turístico'),
       ('Laboratorios'),
       ('Restaurante'),
       ('Centro operativo'),
       ('Triceratops'),
       ('Dilofosaurios'),
       ('Velociraptors'),
       ('TRex'),
       ('Planicie de los herbívoros');

-- TIPOS DE INCIDENTES
CREATE TABLE tipo_incidente(
    id_tipo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(256) NOT NULL
);

INSERT INTO tipo_incidente (descripcion)
VALUES ('Falla eléctrica'),
       ('Fuga de herbívoro'),
       ('Fuga de Velociraptors'),
       ('Fuga de TRex'),
       ('Robo de ADN'),
       ('Auto descompuesto'),
       ('Visitantes en zona no autorizada');

-- INCIDENTES
CREATE TABLE incidente (
    id_incidente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    sitio INT NOT NULL,
    tipo_incidente INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    FOREIGN KEY (sitio) REFERENCES sitio(id_sitio),
    FOREIGN KEY (tipo_incidente) REFERENCES tipo_incidente(id_tipo)
);

-- PROCEDIMIENTOS PARA MANEJAR INCIDENTES
DELIMITER //
CREATE PROCEDURE registrar_incidente
    (IN usitio INT, IN utipo_incidente INT)
    BEGIN
        INSERT INTO incidente (sitio, tipo_incidente, fecha, hora)
        VALUES (usitio, utipo_incidente, SYSDATE(), CURRENT_TIME());
    end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE eliminar_incidente
    (IN id INT)
    BEGIN
        DELETE FROM incidente
        WHERE id_incidente = id;
    end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE actualizar_incidente
    (IN uid INT, IN usitio INT, IN utipo_incidente INT)
    BEGIN
        UPDATE incidente
        SET sitio = usitio, tipo_incidente = utipo_incidente,
            fecha = SYSDATE(), hora = CURRENT_TIME()
        WHERE id_incidente =  uid;
    end //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE get_public_projects
    (IN uid INT)
    BEGIN
        SELECT nombre, fecha_inicio,
                       fecha_fin,
                       descripcion,
                       descripcion_detallada,
                       status,
                       imagen
                FROM actividades
                WHERE id_actividad = uid AND (  status = 'Actual'
                                         OR     status = 'Futuro')
    end //
DELIMITER ;

