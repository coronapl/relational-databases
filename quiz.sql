/******************************************************************************
*  @coronapl
*  Relational Databases
*  Quiz
******************************************************************************/

-- CREACION DE TABLAS

/*
 Carrera (Codigo, Nombre)
 Ejemplo:
 Carrera ('CS', 'Computer Science')
*/

CREATE TABLE Carrera (
    Codigo CHAR(5) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(64) NOT NULL
);

/*
 Alumno (Matricula, Nombre, ApellidoP, AMaterno, Codigo)
 Ejemplo:
 Alumno ('E0101015', 'Pablo', 'Ruiz', 'Picasso', 'CS')
*/

CREATE TABLE Alumno (
    Matricula CHAR(9) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(64) NOT NULL,
    ApellidoP VARCHAR(64) NOT NULL,
    AMaterno VARCHAR(64),
    Codigo CHAR(5),
    FOREIGN KEY (Codigo) REFERENCES Carrera(Codigo)
);

-- INSERT DE CARRERAS
INSERT INTO Carrera (Codigo, Nombre)
VALUES ('CS', 'Computer Science');

INSERT INTO Carrera (Codigo, Nombre)
VALUES ('BIO', 'Biology');

INSERT INTO Carrera (Codigo, Nombre)
VALUES ('MED', 'Medicine');

INSERT INTO Carrera (Codigo, Nombre)
VALUES ('PHY', 'Physics');

INSERT INTO Carrera (Codigo, Nombre)
VALUES ('BA', 'Business Administration');

-- INSERT DE ALUMNOS
INSERT INTO Alumno (Matricula, Nombre, ApellidoP, AMaterno, Codigo)
VALUES ('E0101015', 'Pablo', 'Ruiz', 'Picasso', 'CS');

INSERT INTO Alumno (Matricula, Nombre, ApellidoP, Codigo)
VALUES ('E0101214', 'Napoleon', 'Bonaparte', 'BIO');

INSERT INTO Alumno (Matricula, Nombre, ApellidoP, AMaterno, Codigo)
VALUES ('E0202456', 'Alvaro', 'Obregon', 'Salido', 'MED');

INSERT INTO Alumno (Matricula, Nombre, ApellidoP, Codigo)
VALUES ('E0906712', 'Pancho', 'Villa', 'PHY');

INSERT INTO Alumno (Matricula, Nombre, ApellidoP, AMaterno, Codigo)
VALUES ('E0089767', 'Emiliano', 'Zapata', 'Salazar', 'BA');

-- Delete Alumno
DELETE FROM Alumno
WHERE Matricula = 'E0101015';

-- Sección de consultas

/*
 Mostrar la descripción (sin repeticiones)
 de los materiales utilizados en los proyectos
 cuya denominación empiece con “La” ordenados alfabéticamente.
*/

SELECT DISTINCT P.Denominacion, M.Descripcion
From Materiales M, Entregan E, Proyectos P
WHERE M.Clave = E.Clave AND P.Numero = E.Numero AND P.Denominacion LIKE 'La%'
ORDER BY M.Descripcion ASC;

/*
 Total de unidades entregadas a cada proveedor en el año del 2010, ordenados
 de manera descendente con base en el total de unidades.
*/

set dateformat dmy;

SELECT P.RazonSocial, SUM(E.Cantidad) AS 'Total Unidades 2010'
FROM Entregan E, Proveedores P
WHERE E.RFC = P.RFC AND Fecha >= '01/01/10' AND Fecha <= '31/12/10'
GROUP BY P.RazonSocial
ORDER BY SUM(E.Cantidad) DESC;

/*
 Número y denominación de los proyectos a los que no se les ha entregado
 materiales a lo largo del tiempo. Agregar 3 registros en la tabla de proyectos
 para poder validar el resultado de la consulta.
*/

INSERT INTO Proyectos (Numero, Denominacion)
VALUES (5020, 'Tren MEX-PUE');

INSERT INTO Proyectos (Numero, Denominacion)
VALUES (5021, 'Nuevo aeropuerto CDMX');

INSERT INTO Proyectos (Numero, Denominacion)
VALUES (5022, 'Segundo piso PUE');

SELECT P.Numero, P.Denominacion
FROM Proyectos p
WHERE P.Numero NOT IN (
    SELECT E.Numero
    FROM Entregan E
);

