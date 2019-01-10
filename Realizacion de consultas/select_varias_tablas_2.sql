/*Crear un listado único con todos los oficios que haya en el departamento 10. 
Incluir la localidad del departamento en el resultado.*/
DESC DEPART;
DESC EMPLE;

SELECT OFICIO, LOC, D.DEPT_NO
FROM DEPART D, EMPLE E
WHERE D.DEPT_NO = E.DEPT_NO
AND D.DEPT_NO = 10;

/*Obtener la siguiente salida:*/

/*Visualizar el número de departamento, el nombre del departamento, 
y la cantidad de empleados del departamento con más empleados.*/
SELECT DEPT_NO
FROM EMPLE
GROUP BY COUNT(*)
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                    FROM EMPLE 
                    GROUP BY DEPT_NO);
/*Mostrar el apellido, el nombre del departamento y el salario de cualquier empleado cuyo salario 
y comisión coincidan con los de cualquier empleado que trabaje en Barcelona, incluidos los que no tienen comisión.*/
SELECT APELLIDO, DNOMBRE, SALARIO
FROM EMPLE E, DEPART D
WHERE D.DEPT_NO = E.DEPT_NO
AND SALARIO IN (SELECT SALARIO
                FROM EMPLE
                WHERE D.DEPT_NO =(SELECT D.DEPT_NO
                                    FROM DEPART
                                    WHERE UPPER(LOC)='BARCELONA'))
AND NVL(COMISION_PCT, 0) IN (SELECT COMISION_PCT
                                FROM EMPLE
                                WHERE D.DEPT_NO =(SELECT D.DEPT_NO
                                                    FROM DEPART
                                                    WHERE UPPER(LOC)='BARCELONA'));
                                                    
                                                    
SELECT E.APELLIDO, D.DNOMBRE, E.SALARIO, E.COMISION_PCT
FROM EMPLE E, DEPART D
WHERE D.DEPT_NO = E.DEPT_NO
AND (E.SALARIO, E.COMISION_PCT) IN (SELECT E.SALARIO, E.COMISION_PCT                
                                    FROM EMPLE E, DEPART D
                                    WHERE D.DEPT_NO = E.DEPT_NO
                                    AND UPPER(D.LOC)='BARCELONA'));
