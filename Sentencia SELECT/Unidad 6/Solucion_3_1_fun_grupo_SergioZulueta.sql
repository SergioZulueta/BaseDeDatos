--1. Mostrar la media, salario mayor, menor y suma de salarios mensuales de todos los comerciales.
DESC EMPLE

SELECT AVG(SALARIO) "MEDIA", 
        MAX(SALARIO) "MAX", 
        MIN(SALARIO) "MIN", 
        SUM(SALARIO)"SUM"
FROM EMPLE
WHERE UPPER(OFICIO) = 'COMERCIAL';

--2. Mostrar la fecha de mayor antigüedad y la de menor antigüedad.

SELECT MIN(FECHA_ALTA)"MENOR", MAX(FECHA_ALTA)"MAYOR"
FROM EMPLE;

--3. Mostrar el primer apellido y el último de la lista alfabética de todos los empleados.

SELECT MAX(APELLIDO)"ULTIMO", MIN(APELLIDO)"PRIMERO"
FROM EMPLE;

--4. Mostrar el número de empleados del departamento 40.
SELECT APELLIDO FROM EMPLE WHERE DEPT_NO = 30;

SELECT COUNT(EMP_NO) "NUMERO DE PERSONAS"
FROM EMPLE 
WHERE DEPT_NO = 30;

--5. Mostrar el número de empleados del departamento 30 que pueden percibir comisión.

/*SELECT COUNT(EMP_NO) "NUMERO DE PERSONAS"
FROM EMPLE 
WHERE DEPT_NO = 30
AND COMISION_PCT IS NOT NULL;*/

SELECT COUNT(COMISION_PCT) "NUMERO DE PERSONAS"
FROM EMPLE 
WHERE DEPT_NO = 30;

--6. Visualizar la cantidad de departamento distintos que hay en la tabla empleados.

SELECT COUNT(DISTINCT DEPT_NO)
FROM EMPLE;

--7. Visualizar el número de empleados que hay en cada departamento. Mostrar las columnas nº departamento y nº de empleados -cantidad-.

SELECT DEPT_NO "Nº DEPARTAMENTO", COUNT(EMP_NO) "Nº EMPLEADOS"
FROM EMPLE
GROUP BY DEPT_NO;

--8. Visualizar ( nº departamento y nº de empleados -cantidad-) sólo de los departamentos con más de 4 empleados.

SELECT DEPT_NO "Nº DEPARTAMENTO", COUNT(EMP_NO) "Nº EMPLEADOS"
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(EMP_NO) > 4;
