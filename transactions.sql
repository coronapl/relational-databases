/******************************************************************************
*  @coronapl
*  Relational Databases
*  Transactions
******************************************************************************/

CREATE TABLE Clientes_Banca (
    NoCuenta VARCHAR(5) PRIMARY KEY,
    Nombre VARCHAR(30),
    Saldo numeric(10,2)
)

CREATE TABLE Tipo_Movimiento (
    ClaveM varchar(2) PRIMARY KEY,
    Descripcion varchar(30)
)

CREATE TABLE Realizan (
    NoCuenta VARCHAR(5),
    ClaveM varchar(2),
    Fecha DATETIME,
    Monto numeric(10,2),
    PRIMARY KEY (NoCuenta, ClaveM, Fecha),
    FOREIGN KEY (NoCuenta) REFERENCES Clientes_Banca(NoCuenta),
    FOREIGN KEY (ClaveM) REFERENCES Tipo_Movimiento(ClaveM)
)

BEGIN TRANSACTION PRUEBA1
INSERT INTO CLIENTES_BANCA VALUES('001', 'Manuel Rios Maldonado', 9000);
INSERT INTO CLIENTES_BANCA VALUES('002', 'Pablo Perez Ortiz', 5000);
INSERT INTO CLIENTES_BANCA VALUES('003', 'Luis Flores Alvarado', 8000);
COMMIT TRANSACTION PRUEBA1

SELECT * FROM CLIENTES_BANCA

SELECT * FROM CLIENTES_BANCA where NoCuenta='001'

ROLLBACK TRANSACTION PRUEBA2

SELECT * FROM CLIENTES_BANCA

BEGIN TRANSACTION PRUEBA3
INSERT INTO TIPO_MOVIMIENTO VALUES('A','Retiro Cajero Automatico');
INSERT INTO TIPO_MOVIMIENTO VALUES('B','Deposito Ventanilla');
COMMIT TRANSACTION PRUEBA3

BEGIN TRANSACTION PRUEBA4
INSERT INTO Realizan VALUES('001','A',GETDATE(),500);
UPDATE CLIENTES_BANCA SET SALDO = SALDO -500
WHERE NoCuenta='001'
COMMIT TRANSACTION PRUEBA4

SELECT * FROM Tipo_Movimiento
SELECT * FROM Realizan
SELECT * FROM Clientes_Banca

BEGIN TRANSACTION PRUEBA5
INSERT INTO CLIENTES_BANCA VALUES('005','Rosa Ruiz Maldonado',9000);
INSERT INTO CLIENTES_BANCA VALUES('006','Luis Camino Ortiz',5000);
INSERT INTO CLIENTES_BANCA VALUES('001','Oscar Perez Alvarado',8000);

IF @@ERROR = 0
COMMIT TRANSACTION PRUEBA5
ELSE
BEGIN
PRINT 'A transaction needs to be rolled back'
ROLLBACK TRANSACTION PRUEBA5
END

CREATE PROCEDURE REGISTRAR_RETIRO_CAJERO
    @uNuCuenta VARCHAR(5),
    @uMonto numeric(10,2)
AS
    BEGIN TRANSACTION Retiro
    INSERT INTO Realizan VALUES (@uNuCuenta, 'A', GETDATE(), @uMonto);
    UPDATE Clientes_Banca SET Saldo = Saldo - @uMonto WHERE NoCuenta = @uNuCuenta;
    IF @@ERROR = 0
    COMMIT TRANSACTION Retiro
    ELSE
    BEGIN
    PRINT 'A transaction needs to be rolled back'
    ROLLBACK TRANSACTION Retiro
    END
GO

CREATE PROCEDURE REGISTRAR_DEPOSITO_VENTANILLA
    @uNuCuenta VARCHAR(5),
    @uMonto numeric(10,2)
AS
    BEGIN TRANSACTION Deposito
    INSERT INTO Realizan VALUES (@uNuCuenta, 'B', GETDATE(), @uMonto);
    UPDATE Clientes_Banca SET Saldo = Saldo + @uMonto WHERE NoCuenta = @uNuCuenta;
    IF @@ERROR = 0
    COMMIT TRANSACTION Deposito
    ELSE
    BEGIN
    PRINT 'A transaction needs to be rolled back'
    ROLLBACK TRANSACTION Deposito
    END
GO

EXECUTE REGISTRAR_RETIRO_CAJERO '002', 500;
EXECUTE REGISTRAR_DEPOSITO_VENTANILLA '003', 1000;

