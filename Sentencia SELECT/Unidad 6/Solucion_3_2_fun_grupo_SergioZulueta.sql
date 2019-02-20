/*1-Visualizar ( nº departamento y nº de empleados) sólo los departamentos
con más de 4 empleados, pero ordenar la salida en descendente por número de
empleados.*/

SELECT DISTINCT DEPT_NO "Nº DEPARTAMENTO",
COUNT(EMP_NO)"Nº EMPLEADOS"
FROM EMPLE 
GROUP BY DEPT_NO
HAVING COUNT(EMP_NO)>4
ORDER BY COUNT(EMP_NO) DESC;

/*2-Partiendo de la tabla EMPLE, obtener la suma de salarios,
el salario máximo y el salario mínimo por cada departamento (nº departamento) 
con el nombre del departamento.*/

SELECT E.DEPT_NO "Nº DEPARTAMENTO",SUM(SALARIO),MIN(SALARIO), MAX(SALARIO), DNOMBRE
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO = D.DEPT_NO
GROUP BY E.DEPT_NO, DNOMBRE;

/*3-Calcular el número de empleados que realizan cada oficio por departamento.
Los datos que se visualizan son: departamento, oficio y número de empleados.*/

SELECT E.DEPT_NO "Nº DEPARTAMENTO", COUNT(EMP_NO)"NUMERO DE EMPLEADOS", OFICIO, DNOMBRE
FROM EMPLE E, DEPART D
WHERE E.DEPT_NO = D.DEPT_NO
GROUP BY E.DEPT_NO, DNOMBRE, OFICIO
ORDER BY E.DEPT_NO;

/*4-Visualizar el valor numérico que nos indique el número de empleados que
hay en el departamento que más empleados hay. EL NOMBRE  Y EL CODIGO QUE TENGA EL NUMERO MAX
DE EMPLEADOS*/

SELECT COUNT(EMP_NO)"Nº DE EMPLEADOS", DEPT_NO "Nº DEPARTAMENTO"
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(EMP_NO)= MAX;

SELECT MAX(COUNT(*)) "MAXIMO"
FROM EMPLE
GROUP BY DEPT_NO;

/*5-Mostrar los números de departamento y el salario medio para los 
departamentos cuyos salarios máximos sean mayores de 250000.*/

SELECT DISTINCT DEPT_NO,ROUND(AVG (SALARIO),2) "MEDIA"
FROM EMPLE
GROUP BY DEPT_NO
HAVING MAX(SALARIO) > 2500 ;


/*6-Visualizar el salario medio máximo por  departamento.*/

SELECT MAX(ROUND(AVG(SALARIO))) "MEDIA"
FROM EMPLE
GROUP BY DEPT_NO;

/*7-Escribir una consulta para mostrar el número de personas con el 
mismo oficio.*/

SELECT COUNT(EMP_NO)"N� PERSONAS"
FROM EMPLE
GROUP BY OFICIO;


/*8-Mostrar el número de director y el salario del empleado peor pagado
para ese director. Excluir los empleados de los que se desconozca el director.
Excluir los grupos en los que el salario mínimo sea 200000 o menos.
Ordenar el resultado por salario de forma descendente.*/

SELECT ID_JEFE, MIN(SALARIO)
FROM EMPLE 
WHERE ID_JEFE IS NOT NULL 
GROUP BY ID_JEFE
HAVING MIN(SALARIO) > 2000
ORDER BY MIN(SALARIO) DESC;


