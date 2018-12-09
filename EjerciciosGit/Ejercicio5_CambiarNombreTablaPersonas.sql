--5
/*Modifica el script SQL anterior para cambiar el nombre de la tabla Personas.
Cambia el nombre de la tabla PERSONAS a CIUDADANOS.
Visualizar de nuevo las restricciones para las tablas PROVINCIAS y CIUDADANOS.
Observar que ha pasado con las restricciones.*/

ALTER TABLE PERSONAS RENAME TO CIUDADANOS;

SELECT *
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'CIUDADANOS';

SELECT *
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'PROVINCIAS';

DROP TABLE PROVINCIAS CASCADE CONSTRAINTS;

DESC CIUDADANOS;

