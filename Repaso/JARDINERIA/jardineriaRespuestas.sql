/*1.	 Sacar la ciudad y el tel�fono de las oficinas de 
Estados Unidos. Obt�n la salida ordenada alfab�ticamente.*/

DESC OFICINAS

SELECT PAIS
FROM OFICINAS;

SELECT CIUDAD,TELEFONO
FROM OFICINAS
WHERE UPPER(PAIS)='EEUU'
ORDER BY CIUDAD;


/*2.	 Obtener una lista con el c�digo de oficina, ciudad,
regi�n y pa�s de aquellas oficinas que est�n en pa�ses que
cuyo nombre empiece por �E�.*/

SELECT CODIGOOFICINA,CIUDAD,REGION,PAIS
FROM OFICINAS
WHERE UPPER(PAIS) LIKE 'E%';


/*3.	 Obtener los distintos estados por los que puede 
pasar un pedido.*/

SELECT DISTINCT INITCAP(ESTADO)
FROM PEDIDOS;

/*4.	Obtener el nombre, los dos apellidos concatenados 
bajo la cabecera apellidos y el puesto de los empleados 
que no representan a ning�n cliente.*/

DESC EMPLEADOS

SELECT CLIENTES.CODIGOEMPLEADOREPVENTAS
FROM CLIENTES, EMPLEADOS
WHERE EMPLEADOS.CODIGOEMPLEADO=CLIENTES.CODIGOEMPLEADOREPVENTAS(+);

SELECT NOMBRE,APELLIDO1||' ' || APELLIDO2 AS APELLIDOS,PUESTO
FROM CLIENTES, EMPLEADOS
WHERE EMPLEADOS.CODIGOEMPLEADO=CLIENTES.CODIGOEMPLEADOREPVENTAS(+)
AND CLIENTES.CODIGOEMPLEADOREPVENTAS IS NULL;


/*5.	Listar  el nombre y la ciudad de aquellos clientes 
que residan en ciudades donde no hay oficinas.
El resultado saldr� ordenado por la ciudad donde residen.*/
SELECT * 
FROM OFICINAS;

SELECT NOMBRECLIENTE, CIUDAD
FROM CLIENTES
WHERE CODIGOEMPLEADOREPVENTAS IN(SELECT CODIGOEMPLEADO
                                FROM EMPLEADOS
                                WHERE CODIGOOFICINA IN(SELECT CODIGOOFICINA
                                                      FROM OFICINAS
                                                      WHERE CLIENTES.CIUDAD NOT IN OFICINAS.CIUDAD))
ORDER BY CIUDAD;

/*6.	Obtener un listado con los nombres de los clientes 
que han pedido m�s de 200 unidades de cualquier producto.
El listado tendr� la cabecera �Nombre de los Clientes� y
los nombres saldr� en formato T�tulo, es decir la primera
letra de cada palabra en may�sculas.*/

SELECT INITCAP(NOMBRECLIENTE) AS "NOMBRE DE LOS CLIENTES"
FROM CLIENTES
WHERE CODIGOCLIENTE IN (SELECT CODIGOCLIENTE
                        FROM PEDIDOS
                        WHERE CODIGOPEDIDO IN (SELECT CODIGOPEDIDO
                                                FROM DETALLEPEDIDOS
                                                WHERE CANTIDAD > 200));
                                                


/*7.	 Sacar un listado con el nombre de cada cliente y
el nombre y dos apellidos de su representante de ventas 
bajo una cabecera �nica denominada Representante 
(el nombre ir� separado por coma de los apellidos) .*/

SELECT CLIENTES.NOMBRECLIENTE,EMPLEADOS.NOMBRE || ', '|| APELLIDO1|| ' ' || APELLIDO2 AS "REPRESENTANTE"
FROM EMPLEADOS,CLIENTES
WHERE CLIENTES.CODIGOEMPLEADOREPVENTAS = EMPLEADOS.CODIGOEMPLEADO;

/*8.Mostrar el nombre de los clientes, que no hayan 
realizado pago,s junto con el nombre de sus representantes
de ventas, este �ltimo nombre llevar� la cabecera 
�Nom. Representante�.*/


SELECT CLIENTES.NOMBRECLIENTE,CODIGOEMPLEADOREPVENTAS AS "NOM.REPRESENTANTE",PAGOS.CODIGOCLIENTE
FROM PAGOS,CLIENTES
WHERE PAGOS.CODIGOCLIENTE = CLIENTES.CODIGOCLIENTE
      AND PAGOS.CANTIDAD IS NULL;

SELECT *
FROM PAGOS;