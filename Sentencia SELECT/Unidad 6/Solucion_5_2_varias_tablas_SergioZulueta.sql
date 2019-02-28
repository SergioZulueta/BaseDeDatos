/*1. Crear un listado unico con todos los oficios que haya en
el departamento 10. Incluir la localidad del departamento en el
resultado.*/

SELECT DISTINCT E.OFICIO, D.LOC
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO=D.DEPT_NO
AND E.DEPT_NO=10;
       
/*2. Obtener la siguiente salida:*/

SELECT D.DEPT_NO, D.DNOMBRE, COUNT(E.EMP_NO)"NUMERO DE EMPLEADOS"
FROM EMPLE E, DEPART D
WHERE D.DEPT_NO=E.DEPT_NO (+)
GROUP BY D.DEPT_NO,D.DNOMBRE, E.DEPT_NO;

/*3. Visualizar el numero de departamento, el nombre del 
departamento, y la cantidad de empleados del departamento 
con mas empleados.*/

SELECT E.DEPT_NO, D.DNOMBRE, COUNT(*)
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO=D.DEPT_NO
GROUP BY E.DEPT_NO,D.DNOMBRE, E.DEPT_NO
HAVING COUNT(EMP_NO)=(SELECT (COUNT(EMP_NO))
                            FROM EMPLE
                            GROUP BY DEPT_NO);
       
/*4. Mostrar el apellido, el nombre del departamento y el 
salario de cualquier empleado cuyo salario y comision coincidan
con los de cualquier empleado que trabaje en Barcelona, 
incluidos los que no tienen comision.*/

SELECT E.APELLIDO, D.DNOMBRE, E.SALARIO
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO=D.DEPT_NO
AND NVL(TO_CHAR(COMISION_PCT,'SIN'), E.SALARIO) IN (SELECT NVL(TO_CHAR(COMISION_PCT,'SIN')), E.SALARIO
                                            FROM EMPLE
                                            WHERE DEPT_NO IN(SELECT DEPT_NO
                                                                FROM DEPART
                                                                WHERE UPPER(LOC)='BARCELONA'));
