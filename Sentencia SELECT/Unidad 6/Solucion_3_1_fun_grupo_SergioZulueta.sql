--1. Mostrar la media, salario mayor, menor y suma de salarios mensuales de todos los comerciales.
DESC EMPLE

SELECT AVG(SALARIO) "MEDIA", 
        MAX(SALARIO) "MAX", 
        MIN(SALARIO) "MIN", 
        SUM(SALARIO)"SUM"
FROM EMPLE
WHERE UPPER(OFICIO) = 'COMERCIAL';

--2. Mostrar la fecha de mayor antig�edad y la de menor antig�edad.

SELECT MIN(FECHA_ALTA)"MENOR", MAX(FECHA_ALTA)"MAYOR"
FROM EMPLE;

--3. Mostrar el primer apellido y el �ltimo de la lista alfab�tica de todos los empleados.

SELECT MAX(APELLIDO)"ULTIMO", MIN(APELLIDO)"PRIMERO"
FROM EMPLE;

--4. Mostrar el n�mero de empleados del departamento 40.
SELECT APELLIDO FROM EMPLE WHERE DEPT_NO = 30;

SELECT COUNT(EMP_NO) "NUMERO DE PERSONAS"
FROM EMPLE 
WHERE DEPT_NO = 30;

--5. Mostrar el n�mero de empleados del departamento 30 que pueden percibir comisi�n.

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

--7. Visualizar el n�mero de empleados que hay en cada departamento. Mostrar las columnas n� departamento y n� de empleados -cantidad-.

SELECT DEPT_NO "N� DEPARTAMENTO", COUNT(EMP_NO) "N� EMPLEADOS"
FROM EMPLE
GROUP BY DEPT_NO;

--8. Visualizar ( n� departamento y n� de empleados -cantidad-) s�lo de los departamentos con m�s de 4 empleados.

SELECT DEPT_NO "N� DEPARTAMENTO", COUNT(EMP_NO) "N� EMPLEADOS"
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(EMP_NO) > 4;
