--3
/*A�ade al final del script SQL anterior las sentencias necesarias para :
Comprobar las restricciones de la tabla ALUMNOS.*/

DESC USER_CONSTRAINTS;

SELECT *
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'ALUMNOS';

/*Para cada restricci�n debes indicar el nombre de la restricci�n, el nombre de la tabla y el tipo de restricci�n.
�Hay alguna restricci�n NOT NULL?. �De qu� tipo es?.
Nos d�n las siguientes sentencias INSERT, para a�adir al final de nuestro script SQL.*/
    
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'ALUMNOS';

INSERT   INTO   ALUMNOS VALUES('1111','Pepe',4,1);
--ERROR, EL NOMBRE TIENE QUE ESTAR EN MAYUSCULAS
INSERT   INTO   ALUMNOS VALUES('1111','PEPE',4,1);
--ERROR, LA EDAD TIENE QUE SER ENTRE 5 Y 20 Y EL DNI SE REPETIRIA EN EL CASO DE QUE EL PRIMERO SE INSERTASE
INSERT   INTO   ALUMNOS VALUES('1112','PEPE',10,2);
-- INSERTADO, TODO CORRECTO
INSERT   INTO   ALUMNOS VALUES('1113','MARIA',32,2);
--ERROR, LA EDAD TIENE QUE SER ENTRE 5 Y 20
INSERT   INTO   ALUMNOS VALUES('2222','MARIA',12,5);
--ERROR, EL CURSO TIENE QUE SER 1, 2 O 3
INSERT   INTO   ALUMNOS VALUES('2224','MARiA',22,3);
--ERROR, LA I DEL NOMBRE Y LA EDAD