--ESTO SE APRUEBA FIJO MY FRIEND!!

--1.	¿Cuánto pesa en libras el jugador más pesado de la NBA?

SELECT MAX(peso)
from jugadores;



--2.	Modifica el ejercicio para sacar el nombre del jugador más pesado de la NBA y su peso con la cabecera libras.

SELECT
    nombre,
    peso   AS libras
FROM
    jugadores
WHERE
    peso = (
        SELECT
            MAX(peso)
        FROM
            jugadores
    );

--3.	¿Cuánto mide el jugador más bajito de la NBA?

SELECT
    nombre,
    altura
FROM
    jugadores
WHERE
    altura = (
        SELECT
            MIN(altura)
        FROM
            jugadores
    );


--4.	¿Cuántos jugadores tienen los LAKERS?

SELECT
    COUNT(*) AS "JUGADORES LAKERS"
FROM
    jugadores
WHERE
    id_equipo = (
        SELECT
            id
        FROM
            equipos
        WHERE
            upper(nombre) = 'LAKERS'
    );

--5.	¿Cuánto pesan de media los jugadores de los BLAZERS (no conocemos el nombre completo del equipo)?

SELECT
    ROUND(AVG(peso),1) AS "Peso medio Blazers"
FROM
    jugadores
WHERE
    id_equipo IN (
        SELECT
            id_equipo
        FROM
            equipos
        WHERE
            UPPER(nombre) LIKE '%BLAZERS%'
    );

SELECT * FROM EQUIPOS;

--6.	Indica el nombre del equipo y el peso en kilos del jugador más pesado de cada equipo . Saca el peso en Kilogramos 
--teniendo en cuenta que una libra equivale a 0.4535 kilos.


SELECT
    e.nombre,
    MAX(j.peso) * 0.4535 AS "KG"
FROM
    jugadores j
    JOIN equipos e ON j.id_equipo = e.id
GROUP BY
    e.nombre
ORDER BY
    MAX(j.peso);


--7.	 ¿Cuántos equipos tiene cada conferencia en la NBA?

SELECT conferencia, COUNT(*)
FROM equipos
GROUP BY conferencia;

--8.	Indica, para cada una de las siguientes nacionalidades España, Francia e Italia, cuánto pesan de media los jugadores
--NOTA: Las nacionalidades están en inglés


SELECT
    procedencia,
    AVG(peso)
FROM
    jugadores
WHERE
    upper(procedencia) IN (
        'SPAIN',
        'FRANCE',
        'ITALY'
    )
GROUP BY
    procedencia;
    

--9.	Selecciona que equipos de la NBA tienen más de 1 jugador español.

SELECT
    e.nombre AS "equipo"
FROM
    equipos e
    JOIN jugadores j ON e.id = j.id_equipo
WHERE
    upper(procedencia) = 'SPAIN'
GROUP BY
    e.nombre
HAVING
    COUNT(j.nombre) > 1;

--EXPLICACION: Necesitamos una JOIN porque en el HAVING queremos filtrar la cantidad de jugadores y es una tabla a la que no tenemos acceso
--porque en el FROM hemos llamado a equipos.

--CONSULTAS DE COMPROBACIÓN ALEATORIAS PORQUE NO ME SALIA EL EJERCICIO
--Busqueda para comprobar los equipos en los que están los jugadores españoles
SELECT
    j.nombre,
    e.nombre AS equipo
FROM
    jugadores j
JOIN equipos e ON j.id_equipo = e.id
WHERE
    upper(procedencia) = 'SPAIN';

--Verificacion de que los Raptors tienen 2 jugadores españoles
SELECT
    nombre
FROM
    jugadores
WHERE
    id_equipo IN (
        SELECT
            id
        FROM
            equipos
        WHERE
            upper(nombre) = 'RAPTORS'
            AND upper(procedencia) = 'SPAIN'
    );

--10.	 Saca los nombres de los jugadores de la división SouthEast.

SELECT 
    nombre
FROM
    jugadores
WHERE
    id_equipo IN (
        SELECT
            id
        FROM
            equipos
        WHERE
            upper(division) = 'SOUTHEAST'
    );


--11.	Obtén el nombre del jugador de mayor altura de la NBA

SELECT
    nombre, altura
FROM
    jugadores
WHERE
    altura = (
        SELECT
            MAX(altura)
        FROM
            jugadores
    );

--12.	Extrae las divisiones de la NBA donde juegan jugadores españoles.

--CON JOIN (No es la opcion más optima)
SELECT
    division
FROM
    equipos e
    JOIN jugadores j ON e.id = j.id_equipo
WHERE
    upper(procedencia) = 'SPAIN';
    
--CON SUBCONSULTA
SELECT
    division
FROM
    equipos
WHERE
    id IN (
        SELECT
            id_equipo
        FROM
            jugadores
        WHERE
            upper(procedencia) = 'SPAIN'
    );
--13.	Se desea conocer los jugadores de la NBA que pesan más que todos los jugadores españoles.

SELECT
    nombre
FROM
    jugadores
WHERE
    peso > (
        SELECT
            MAX(peso)
        FROM
            jugadores
        WHERE
            upper(procedencia) = 'SPAIN'
    );

--DUDA RESUELTA
SELECT
    nombre
FROM
    jugadores
WHERE
    peso > (
        SELECT
            peso --Esto no funciona porque esta evaluando 1 condicion (peso jugadores) a muchas condiciones (todos los pesos de los jugadores españoles). Tenemos que evaluar 1 condicion (peso jugadores) a 1 condicion (el peso del jugador español mas pesado).
        FROM
            jugadores
        WHERE
            upper(procedencia) = 'SPAIN'
    );



--14.	Consulta cuales son los bases que pesan más que cualquier pivot de la NBA. 
--G = BASE.
--C = PIVOT.

SELECT
    posicion
FROM
    jugadores;

SELECT
    nombre
FROM
    jugadores
WHERE
    upper(posicion) = 'G'
    AND peso > (
        SELECT
            MAX(peso)
        FROM
            jugadores
        WHERE
            upper(posicion) = 'C'
    );

SELECT
    *
FROM
    jugadores
ORDER BY
    peso DESC;
    
--No hay bases que pesen mas que cualquier PIVOT porque el jugador mas pesado es Shaquel Oneal y su posicion es PIVOT.
--14.1	Consulta cuales son los pivots que pesan más que cualquier base de la NBA. 

SELECT
    nombre
FROM
    jugadores
WHERE
    upper(posicion) = 'C'
    AND peso > (
        SELECT
            MAX(peso)
        FROM
            jugadores
        WHERE
            upper(posicion) = 'G'
    );


--15.	Obtén el nombre de la ciudad donde juega el jugador mas alto de la NBA.

SELECT
    ciudad
FROM
    equipos
WHERE
    id = (
        SELECT
            id_equipo
        FROM
            jugadores
        WHERE
            altura = (
                SELECT
                    MAX(altura)
                FROM
                    jugadores
            )
    );
