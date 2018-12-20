--1
/* A partir de las tablas EMPLE y DEPART obtener los siguientes datos de los empleados: 
apellido, oficio, número de empleado, nombre de departamento y localidad.
*/
SELECT E.APELLIDO, E.OFICIO, E.EMP_NO, D.DNOMBRE, D.LOC
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO = D.dept_no;

--2
/*Queremos consultar los datos de los empleados y el nombre de la localidad de aquellos que  
trabajan en ‘MADRID’ o ‘BARCELONA’. 
*/

SELECT E.EMP_NO, E.APELLIDO, E.OFICIO, D.LOC
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO = D.DEPT_NO
AND UPPER(LOC) IN ('MADRID', 'BARCELONA');

--3
/*Obtener para cada empleado (código y apellidos), así como los apellidos de su jefe. 
La columna JEFE de un empleado indica el numero de empleado de su jefe.*/

SELECT E.EMP_NO, E.APELLIDO, J.APELLIDO AS JEFE
FROM EMPLE E, EMPLE J
WHERE E.ID_JEFE = J.EMP_NO
ORDER BY J.APELLIDO;

--4
/*Visualizar el apellido, el oficio y la localidad de los departamentos donde trabajan los ANALISTAS.*/

SELECT APELLIDO, OFICIO, LOC
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO = D.DEPT_NO
AND UPPER(OFICIO) = 'ANALISTA';


--5
/*Mostrar para cada empleado quién es su jefe (apellido ). Si no tiene jefe, mostrar ausencia de valor(NULL).*/

SELECT E.EMP_NO, E.APELLIDO, J.APELLIDO AS JEFE
FROM EMPLE E, EMPLE J
WHERE E.ID_JEFE = J.EMP_NO(+)
ORDER BY J.APELLIDO;

SELECT E.EMP_NO, E.APELLIDO, NVL(J.APELLIDO,'NO TIENE JEFE') AS JEFE
FROM EMPLE E, EMPLE J
WHERE E.ID_JEFE = J.EMP_NO(+)
ORDER BY J.APELLIDO;

--6
/*Mostrar para todos los departamentos que tenemos en la empresa los apellidos de los empleados 
que pertenecen a cada uno de ellos. Si algún departamento está vacío, mostrar ausencia de valor NULL.*/

SELECT APELLIDO, D.DEPT_NO
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO(+) = D.DEPT_NO
ORDER BY DEPT_NO;