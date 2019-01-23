/* 1) Obt�n la relaci�n de todos los jugadores espa�oles o 
eslovenos de los Lakers.
NOTA: Las nacionalidades est�n en ingl�s.*/

SELECT *
FROM EQUIPOS
WHERE UPPER(NOMBRE)='LAKERS';

SELECT NOMBRE
FROM JUGADORES
WHERE UPPER(PROCEDENCIA) IN ('SPAIN','SLOVENIA');

SELECT NOMBRE
FROM JUGADORES
WHERE UPPER(PROCEDENCIA) IN ('SPAIN','SLOVENIA')
AND ID_EQUIPO=(SELECT ID
        FROM EQUIPOS
        WHERE UPPER(NOMBRE)='LAKERS');

/*2.	Seleccionar los jugadores cuyo peso est� entre 150 y
300 libras. Para cada jugador informa de su nombre,
el nombre del equipo en el que juegan y su peso. 
Saca el peso en Kilogramos teniendo en cuenta que una libra
equivale a 0.4535 kilos.
NOTA: Recuerda que esta en ingl�s.*/

SELECT JUGADORES.NOMBRE,JUGADORES.ID_EQUIPO,EQUIPOS.NOMBRE "EQUIPO",JUGADORES.PESO * 0.4535 "Peso en Kilos"
FROM EQUIPOS,JUGADORES
WHERE EQUIPOS.ID = JUGADORES.ID_EQUIPO 
AND JUGADORES.PESO BETWEEN 150 AND 300;
    
/*3.	Averigua la relaci�n de jugadores cuya procedencia es
desconocida, indicando el nombre del jugador y el nombre del
equipo.*/

SELECT NOMBRE,CODIGO
FROM JUGADORES
WHERE PROCEDENCIA IS NULL;

SELECT JUGADORES.NOMBRE,EQUIPOS.NOMBRE
FROM EQUIPOS,JUGADORES
WHERE EQUIPOS.ID = JUGADORES.ID_EQUIPO AND
    JUGADORES.PROCEDENCIA IS NULL;
    
    
/*4.	Obt�n la relaci�n de equipos cuyos nombres tengan 7
caracteres, empiecen por R y terminen por S. 
Indica el nombre del equipo y a que conferencia pertenecen.*/

SELECT NOMBRE,CONFERENCIA
FROM EQUIPOS;


SELECT NOMBRE,CONFERENCIA
FROM EQUIPOS 
WHERE UPPER(NOMBRE) LIKE 'R_____S';


/*5.	Se necesita escoger a 25 jugadores para una campa�a.
Se ha decidido que ser�n los 25 primeros jugadores que
devuelva el sistema.
 NOTA: Hay que usar la pseudo columna del sistema rownum
 en Oracle y Limit en Mysql.*/
 
SELECT NOMBRE
FROM JUGADORES
WHERE ROWNUM <= 25;

/*6.	Obt�n la divisi�n y los equipos de la conferencia
oeste ordenados por divisi�n, y dentro de cada divisi�n
los equipos aparecer�n ordenados alfab�ticamente.*/

SELECT DIVISION, NOMBRE, CONFERENCIA
FROM EQUIPOS
WHERE UPPER(CONFERENCIA) = 'OESTE'
ORDER BY DIVISION, NOMBRE;

/*7.	 Saca los nombres de los jugadores de la divisi�n
SouthEast.*/

SELECT JUGADORES.NOMBRE,EQUIPOS.DIVISION
FROM EQUIPOS,JUGADORES
WHERE EQUIPOS.ID = JUGADORES.ID_EQUIPO
    AND UPPER(EQUIPOS.DIVISION)='SOUTHEAST';


/*8.	Indica las divisiones de la NBA donde juegan jugadores
espa�oles.*/

SELECT JUGADORES.NOMBRE, EQUIPOS.DIVISION
FROM JUGADORES, EQUIPOS
WHERE JUGADORES.ID_EQUIPO=EQUIPOS.ID
AND UPPER(JUGADORES.PROCEDENCIA)='SPAIN';

/*9.	 Jos� Calderon ha fichado por otro equipo los 
Pistons de Detroit de la conferencia:este, divisi�n Central,
actualiza para dicho jugador este dato.*/

SELECT *
FROM JUGADORES
WHERE UPPER(NOMBRE)='JOSE CALDERON';

SELECT *
FROM EQUIPOS
WHERE ID=(SELECT ID_EQUIPO
          FROM JUGADORES
          WHERE UPPER(NOMBRE)='JOSE CALDERON');
          
SELECT *
FROM EQUIPOS
WHERE UPPER(NOMBRE)='PISTONS';

UPDATE JUGADORES
SET ID_EQUIPO=(SELECT ID
                FROM EQUIPOS
               WHERE UPPER(NOMBRE)='PISTONS') -- LIKE '%PISTONS%'
WHERE UPPER(NOMBRE)='JOSE CALDERON'; --LIKE '%CALDERON%'

SELECT *
FROM JUGADORES
WHERE UPPER(NOMBRE)='JOSE CALDERON';

SELECT *
FROM EQUIPOS
WHERE ID=(SELECT ID_EQUIPO
          FROM JUGADORES
          WHERE UPPER(NOMBRE)='JOSE CALDERON');

/*10.	Jorge Garbajosa ya no juega en la NBA,
actualiza los datos.*/

SELECT *
FROM JUGADORES
WHERE UPPER(NOMBRE)='JORGE GARBAJOSA';

DELETE FROM ESTADISTICAS
WHERE JUGADOR =(SELECT CODIGO
                FROM JUGADORES
                WHERE UPPER(NOMBRE)='JORGE GARBAJOSA');
                
DELETE FROM JUGADORES
WHERE UPPER(NOMBRE)='JORGE GARBAJOSA';
