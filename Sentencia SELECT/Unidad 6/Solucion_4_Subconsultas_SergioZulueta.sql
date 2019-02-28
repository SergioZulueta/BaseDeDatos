/*1.Obtener el apellido de los empleados que tienen el mismo oficio que ‘GIL’.*/

SELECT APELLIDO
FROM EMPLE
WHERE UPPER(OFICIO)=(SELECT OFICIO
                      FROM EMPLE
                      WHERE UPPER(APELLIDO)='GIL');

/*2.Queremos consultar los datos de los empleados que trabajan en las localidades de ‘MADRID’ o ‘BARCELONA’.*/

SELECT EMP_NO, APELLIDO, OFICIO
FROM EMPLE 
WHERE DEPT_NO IN(SELECT DEPT_NO
                FROM DEPART
                WHERE UPPER(LOC) IN ('MADRID','BARCELONA'));


/*3.Obtener el apellido de los empleados con el mismo oficio y salario que ‘GIL’.*/

SELECT APELLIDO, SALARIO
FROM EMPLE
WHERE UPPER(OFICIO)=(SELECT OFICIO
                      FROM EMPLE
                      WHERE UPPER(APELLIDO)='GIL')
AND SALARIO=(SELECT SALARIO
              FROM EMPLE
              WHERE UPPER(APELLIDO)='GIL');
              
/*4.Mostrar los empleados (nombre, oficio, salario y fecha de alta) que desempeñen el mismo oficio que "JIMENEZ" o que tengan un salario mayor o igual que "FERNANDEZ".
Nota: se supone que puede haber mas que un fernandez y un jimenez en la empresa*/

SELECT APELLIDO, OFICIO, SALARIO, FECHA_ALTA
FROM EMPLE
WHERE OFICIO IN(SELECT OFICIO
                FROM EMPLE 
                WHERE APELLIDO='JIMENEZ')
AND SALARIO IN (SELECT SALARIO
                FROM EMPLE
                WHERE APELLIDO='FERNANDEZ');
                
/*5.Visualizar el número de departamento y la cantidad de empleados del departamento con más empleados.*/

SELECT DEPT_NO, COUNT(DEPT_NO) AS "EMPLEADOS"
FROM EMPLE 
GROUP BY DEPT_NO
HAVING COUNT (EMP_NO) = (SELECT MAX(COUNT(EMP_NO))
                FROM EMPLE
                GROUP BY DEPT_NO);
                
SELECT DEPART.DNOMBRE,DEPART.DEPT_NO,COUNT(EMPLE.EMP_NO) AS "NUMERO DE EMPLEADO"
FROM DEPART,EMPLE
WHERE DEPART.DEPT_NO=EMPLE.DEPT_NO
GROUP BY EMPLE.DEPT_NO, DEPART.DNOMBRE, EMPLE.DEPT_NO, DEPART.DEPT_NO
HAVING COUNT (EMP_NO)=(SELECT MAX(COUNT (EMPLE.EMP_NO))
                        FROM EMPLE
                        GROUP BY DEPT_NO);

/*6. Buscar el oficio con el salario medio más bajo.*/

SELECT OFICIO, AVG(SALARIO) "SALARIO MEDIO MINIMO"
FROM EMPLE 
group by OFICIO
HAVING AVG(SALARIO)=(SELECT MIN(AVG(SALARIO))
                            FROM EMPLE
                            GROUP BY OFICIO);

/*7. ¿Qué es incorrecto en esta sentencia?*/

SELECT EMP_NO, APELLIDO
FROM EMPLE
WHERE SALARIO IN ( SELECT MIN(SALARIO)--SOBRA UN PARENTESIS ) Y EL = TIENE QUE SER IN
				FROM EMPLE
				GROUP BY DEPT_NO);

/*8.  ¿Qué ocurre con la siguiente sentencia?*/

SELECT APELLIDO, OFICIO
FROM EMPLE
WHERE OFICIO = ( SELECT OFICIO
			FROM EMPLE
			WHERE APELLIDO = 'PEREZ');
            --BUSCA EMPLEADOS QUE TENGAN EL MISMO OFICIO QUE PEREZ
      -- ¿Qué ocurriría si existiera un oficio con valor nulo?
       --NO SE MOSTRARIA
       
/*9. Mostrar los apellidos de los empleados que no tienen
subordinados.*/

SELECT APELLIDO
FROM EMPLE 
WHERE EMP_NO NOT IN (SELECT DISTINCT ID_JEFE
                    FROM EMPLE
                    WHERE ID_JEFE IS NOT NULL);


/*10.Mostrar los apellidos de los empleados que tienen subordinados.*/

SELECT APELLIDO
FROM EMPLE 
WHERE EMP_NO IN (SELECT ID_JEFE
                    FROM EMPLE);

/*11.Escribir una consulta para mostrar los códigos de empleado y los apellidos de todos los empleados que trabajen en un departamento con cualquier empleado cuyo apellido contenga una 'U'.*/

SELECT EMP_NO, APELLIDO
FROM EMPLE
WHERE DEPT_NO IN (SELECT DISTINCT DEPT_NO
                        FROM EMPLE
                        WHERE UPPER(APELLIDO) LIKE '%E%');

/*12.Modificar la consulta anterior para mostrar los códigos de empleado y los apellidos de todos los empleados que ganan más del salario medio y que trabajen en un departamento con un empleado que tenga una 'U' en su apellido.*/

SELECT EMP_NO, APELLIDO
FROM EMPLE
WHERE DEPT_NO IN (SELECT DISTINCT DEPT_NO
                        FROM EMPLE
                        WHERE UPPER(APELLIDO) LIKE '%E%')
AND SALARIO > (SELECT AVG(SALARIO)
                FROM EMPLE)
AND UPPER(APELLIDO) NOT LIKE '%E%';

/*13.Escribir una consulta para mostrar el apellido, número de departamento y el salario de cualquier empleado cuyo número de departamento  y salario coincidan con el número de departamento y salario de cualquier empleado que ganen comisión.*/

SELECT APELLIDO, DEPT_NO, SALARIO
FROM EMPLE
WHERE (DEPT_NO,SALARIO) IN (SELECT DEPT_NO, SALARIO
                FROM EMPLE
                WHERE COMISION_PCT IS NOT NULL);

/*14.Escribir una consulta para encontrar todos los empleados que ganan más que el salario medio de sus departamentos. Mostrar el apellido, el salario y el código del departamento .*/

SELECT	S.APELLIDO, S.SALARIO, S.DEPT_NO
FROM	EMPLE S
WHERE	SALARIO > ALL(	SELECT AVG(SALARIO)
                        FROM EMPLE E
                        WHERE S.DEPT_NO = E.DEPT_NO);

/*15.Modificar el ejercicio anterior para visualizar el apellido, el salario, el código del departamento y el salario medio de los sueldos de ese departamento. Ordenar por salario medio.*/

SELECT	S.APELLIDO, S.SALARIO, S.DEPT_NO, AVG(SALARIO)
FROM	EMPLE S
WHERE	SALARIO > ALL(	SELECT AVG(SALARIO)
                        FROM EMPLE E
                        WHERE S.DEPT_NO = E.DEPT_NO) 
GROUP BY S.APELLIDO, S.SALARIO, S.DEPT_NO;
