--1
/*La Gerencia desea contar con informaci�n de los jefes a cargo de cada empleado. 
Para ello se requiere que construya una consulta que muestre el apellido del empleado  
con el alias empleado y la identificaci�n de su jefe con la cabecera jefe. 
Si el empleado NO posee jefe se debe mostrar el mensaje NO TIENE JEFE. 
La informaci�n se debe mostrar ordenada en forma descendente por  identificaci�n del jefe. 
*/

SELECT APELLIDO AS EMPLEADO, NVL(TO_CHAR(ID_JEFE),'NO TIENE JEFE') AS JEFE
FROM EMPLE
ORDER BY ID_JEFE DESC;

--2
/* Los empleados han planteado la necesidad de que se les aumente el valor de movilizaci�n mensual 
que se les debe pagar por ley. Por ello, la Gerencia ha definido que el valor de movilizaci�n 
ser� un porcentaje del salario mensual del empleado. Este porcentaje corresponder� por cada 1000 
del salario de cada empleado es decir, si el salario del empleado es 8200 el porcentaje de aumento
de movilizaci�n ser� de 8%, si el salario del empleado es de 15000 el porcentaje de aumento ser� de 15% etc. 
Como primera etapa se debe generar un informe que muestre la identificaci�n del empleado, su salario actual 
y el porcentaje del salario que le corresponder� como movilizaci�n. Dar a cada columna de salida las cabeceras empleado, 
salario y "porcentaje de movilizaci�n� respectivamente.
*/

SELECT APELLIDO AS EMPLEADO, SALARIO , TRUNC(SALARIO/1000) AS PORCENTAJE
FROM EMPLE;

--3
/* La empresa ha decido modificar las pol�ticas de asignaci�n de usuario y 
clave a acceso del personal a los diferentes sistemas inform�ticos que existen.
Desde el pr�ximo mes la pol�tica de asignaci�n de nombres de usuarios y claves ser�:
Nombre de Usuario: corresponder� a las tres primeras letras del apellido del empleado 
(la primera en may�scula y las otras dos en min�sculas), seguido de la longitud del apellido
y de la identificaci�n del trabajo que desempe�a. 
Clave del Usuario: corresponder� al mes y a�o (en 4 d�gitos) de contrato del empleado seguido 
de las dos �ltimas letras de su apellido en may�sculas.
Se nos pide construir una consulta que permita obtener el nombre del empleado, su apellido, 
identificaci�n de su trabajo, nombre de usuario y clave. La informaci�n se requiere 
ordenada por apellido en forma ascendente
*/

SELECT APELLIDO, OFICIO TRABAJO, 
    INITCAP(SUBSTR(APELLIDO,1,3)) || LENGTH(APELLIDO) || OFICIO "NOMBRE USUARIO", 
    TO_CHAR(FECHA_ALTA, 'MMYYYY') || UPPER(SUBSTR(APELLIDO, -2)) "CLAVE USUARIO"
FROM EMPLE
ORDER BY APELLIDO;


--4
/* La empresa desea que se automatice algunos de los procesos involucrados en el c�lculo 
de las remuneraciones mensuales de los empleados. En un esfuerzo por mejorar las necesidades 
econ�micas de los empleados, se desea saber el costo que significar�a efectuar un aumento en sus salarios. 
Para ello, se ha pensado que el porcentaje de reajuste corresponder� al primer d�gito del salario actual 
de cada empleado es decir, si el empleado posee un salario de 24000 su aumento ser� de 2%, si su salario 
es de 7500 su aumento ser� de 7% etc. Se requiere de un informe que muestre el nombre y apellido del 
empleado concatenado, salario actual y porcentaje de reajuste. Dar a cada columna de salida el alias 
correspondiente y formato a los valores del salario 999,999.999 y el reajuste 9,999.999.

NOTA: Tener en cuenta si nuestra base de datos utiliza o no el sistema anglosajon a la hora 
de elaborar la mascara formato de salida.
*/

SELECT APELLIDO EMPLEADO, 
        TO_CHAR(SALARIO, '999,999.999') AS SALARIO,
        TO_CHAR((SALARIO * SUBSTR(SALARIO,1,1)/100),'9,999.999') AS REAJUSTE
FROM EMPLE;

--5
/*Se nos pide que realicemos una consulta que implementar el c�lculo de las comisiones y  
salario total de cada uno de los empleados considerando las siguientes especificaciones:
Si el empleado posee porcentaje de comisi�n se debe mostrar, de lo contrario se debe mostrar el literal 'SIN COMISION'.
El valor de la comisi�n  corresponder� al valor del salario actual multiplicado 
por el porcentaje de comisi�n. Si el empleado no posee porcentaje de comisi�n se debe mostrar el valor cero.
 El valor salario total corresponder� a la suma del valor del salario actual m�s el 
 valor de la comisi�n. Si el empleado no posee omisi�n el salario total ser� igual al valor del salario actual.

En esta primera etapa, solo se requiere de un listado que muestre  la identificaci�n del 
empleado con el alias id_emp, el valor del salario actual, el porcentaje de comisi�n, 
el valor de la comisi�n calculada y el valor del salario total calculado. 
*/

SELECT  EMP_NO "ID EMPLEADO", SALARIO "SALARIO SIN COMISION",
        NVL(TO_CHAR(COMISION_PCT), 'SIN COMISION') AS "PORC. COMISION",
        NVL2(COMISION_PCT, SALARIO*COMISION_PCT,0) AS "VALOR COMISION",
        NVL2(COMISION_PCT,SALARIO+(SALARIO*COMISION_PCT),SALARIO) "SALARIO TOTAL"
FROM EMPLE;

--6
/*?	Mostrar el n�mero de empleado, la fecha de alta en la empresa, 
el n�mero de meses que lleva empleado, la fecha de revisi�n de los 6 meses, 
el primer viernes tras la fecha de alta y el �ltimo d�a del mes de contrataci�n 
para todos los trabajadores que llevan menos de 460 meses.
Nota: Mira en la teor�a las funciones: MONTHS_BETWEEN, ADD_MONTH, NEXT_DAY,  y LAST_DAY.*/

SELECT EMP_NO, FECHA_ALTA,
    TRUNC(MONTHS_BETWEEN(SYSDATE, FECHA_ALTA),0) AS MESES,
    ADD_MONTHS(FECHA_ALTA,6) AS REVISION, NEXT_DAY(FECHA_ALTA,'VIERNES'),
    LAST_DAY(FECHA_ALTA)
FROM EMPLE
WHERE MONTHS_BETWEEN(SYSDATE,FECHA_ALTA)<460;

SELECT *
FROM DEPART;

SELECT * 
FROM EMPLE;

SELECT *
FROM EMPLE E, DEPART D
WHERE E.dept_no = D.dept_no;

