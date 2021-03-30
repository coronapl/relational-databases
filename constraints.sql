/******************************************************************************
*  @coronapl
*  Relational Databases
*  Constraints
******************************************************************************/

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Materiales')
    DROP TABLE Materiales

CREATE TABLE Materiales
(
  Clave NUMERIC(5) NOT NULL,
  Descripcion VARCHAR(50),
  Costo NUMERIC(8,2)
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proveedores')
    DROP TABLE Proveedores

CREATE TABLE Proveedores
(
  RFC CHAR(13) NOT NULL,
  RazonSocial VARCHAR(50)
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Proyectos')
    DROP TABLE Proyectos

CREATE TABLE Proyectos
(
  Numero NUMERIC(5) NOT NULL,
  Denominacion VARCHAR(50)
)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Entregan')
    DROP TABLE Entregan

CREATE TABLE Entregan
(
  Clave NUMERIC(5) NOT NULL,
  RFC CHAR(13) NOT NULL,
  Numero NUMERIC(5) NOT NULL,
  Fecha DATETIME NOT NULL,
  Cantidad NUMERIC(8,2)
)

BULK INSERT MATRICULA.MATRICULA.[Materiales]
  FROM 'PATH/materiales.csv'
  WITH
  (
    CODEPAGE = 'ACP',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
  )

BULK INSERT MATRICULA.MATRICULA.[Proyectos]
  FROM 'PATH/proyectos.csv'
  WITH
  (
    CODEPAGE = 'ACP',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
  )

BULK INSERT MATRICULA.MATRICULA.[Proveedores]
  FROM 'PATH/proveedores.csv'
  WITH
  (
    CODEPAGE = 'ACP',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
  )

SET DATEFORMAT dmy

BULK INSERT MATRICULA.MATRICULA.[Entregan]
  FROM 'PATH/entregan.csv'
  WITH
  (
    CODEPAGE = 'ACP',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
  )

