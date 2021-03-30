/******************************************************************************
*  @coronapl
*  Relational Databases
*  Subqueries
******************************************************************************/

SELECT SUM(Cantidad) as 'cantidad_total',
       SUM((Costo + (PorcentajeImpuesto * Costo / 100))) as importe_total
FROM Entregan E, Materiales M
WHERE E.Clave = M.Clave

SELECT P.RazonSocial,
       COUNT(*) as numero_entregas,
       SUM((M.Costo + (M.PorcentajeImpuesto * M.Costo / 100))) as importe_total
FROM Entregan E, Materiales M, Proveedores P
WHERE E.RFC = P.RFC AND E.Clave = M.Clave
GROUP BY RazonSocial

SELECT M.Clave, M.Descripcion,
        SUM(E.Cantidad) AS 'total_entregados',
        MIN(E.Cantidad) AS 'min_entregados',
        MAX(E.Cantidad) AS 'max_entregados',
        SUM((M.Costo + (M.PorcentajeImpuesto * M.Costo / 100))) as importe_total
FROM Entregan E, Materiales M
WHERE E.Clave = M.Clave
GROUP BY M.Clave, M.Descripcion
HAVING AVG(E.Cantidad) > 400

SELECT P.RazonSocial,
       AVG(E.Cantidad) AS 'promedio_material_entregado',
       M.Clave,
       M.Descripcion
FROM Entregan E, Materiales M, Proveedores P
WHERE E.Clave = M.Clave AND P.RFC = E.RFC
GROUP BY P.RazonSocial, M.Clave, M.Descripcion
HAVING AVG(E.Cantidad) > 500

SELECT P.RazonSocial,
       AVG(E.Cantidad) AS 'promedio_material_entregado',
       M.Clave,
       M.Descripcion
FROM Entregan E, Materiales M, Proveedores P
WHERE E.Clave = M.Clave AND P.RFC = E.RFC
GROUP BY P.RazonSocial, M.Clave, M.Descripcion
HAVING AVG(E.Cantidad) < 370 OR AVG(E.Cantidad) > 450

INSERT INTO Materiales VALUES (1440, 'Ladrillos rojos', 120.00, 2*1440/1000)
INSERT INTO Materiales VALUES (1450, 'Cemento preparado', 285.00, 2*1450/1000)
INSERT INTO Materiales VALUES (1460, 'Concreto CEMEX', 422.00, 2*1460/1000)
INSERT INTO Materiales VALUES (1470, 'Alambre de construccion', 85.00, 2*1470/1000)
INSERT INTO Materiales VALUES (1480, 'Cable de instalacion', 75.00, 2*1480/1000)

SELECT M.Clave, M.descripcion
FROM Materiales M
WHERE M.Clave NOT IN (
    SELECT E.Clave
    FROM Entregan E
)

SELECT P.RazonSocial
FROM Proveedores P
WHERE P.RFC IN (
    SELECT E.RFC
    FROM Entregan E, Proyectos Pr
    WHERE E.Numero = Pr.Numero
    AND Pr.Denominacion = 'Vamos Mexico'
) AND P.RFC IN (
    SELECT E.RFC
    FROM Entregan E, Proyectos Pr
    WHERE E.Numero = Pr.Numero
    AND Pr.Denominacion = 'CIT Yucatan'
)

SELECT M.Descripcion
FROM Materiales M
WHERE M.Clave NOT IN (
    SELECT E.Clave
    FROM Entregan E, Proyectos Pr
    WHERE E.Numero = Pr.Numero
    AND Pr.Denominacion = 'CIT Yucatan'
)

SELECT P.RazonSocial, AVG(E.Cantidad) as 'Promedio'
FROM Proveedores P, Entregan E
WHERE P.RFC = E.RFC
GROUP BY P.RazonSocial
HAVING AVG(E.Cantidad) > (
    SELECT AVG(E.Cantidad)
    FROM Entregan E
    WHERE E.RFC = 'VAGO780901'
)

CREATE VIEW [2000] AS
SELECT E.RFC, P.RazonSocial, SUM(E.Cantidad) as 'Cantidad'
FROM Entregan E, Proyectos Pr, Proveedores P
WHERE E.Numero = PR.Numero AND E.RFC = P.RFC
  AND Pr.Denominacion = 'Infonavit Durango'
  AND E.Fecha >= '01/01/2000'
  AND E.Fecha <= '31/12/2000'
GROUP BY E.RFC, P.RazonSocial

CREATE VIEW [2001] AS
SELECT E.RFC, P.RazonSocial, SUM(E.Cantidad) as 'Cantidad'
FROM Entregan E, Proyectos Pr, Proveedores P
WHERE E.Numero = PR.Numero
  AND E.RFC = P.RFC AND Pr.Denominacion = 'Infonavit Durango'
  AND E.Fecha >= '01/01/2001'
  AND E.Fecha <= '31/12/2001'
GROUP BY E.RFC, P.RazonSocial

SELECT [2000].RFC, [2000].RazonSocial
FROM [2000], [2001]
WHERE [2000].RFC = [2001].RFC AND [2000].Cantidad > [2001].Cantidad

