/*Averigua la estructura de la tabla EMPLE,  sus restricciones y las columnas que forman parte de cada restricción, ya que se pretende crear una tabla de trabajo a partir de ella. 
Crear la tabla denominada EMPLEADOS30 con la misma estructura de la tabla EMPLE pero con los datos de los empleados del departamento 30 de la tabla EMPLE.  Para ello utiliza CREATE TABLE … AS SELECT …. ¿Se crean todas las restricciones?*/
DESC EMPLE;

SELECT * FROM USER_CONSTRAINTS
WHERE UPPER (TABLE_NAME) = 'EMPLE';

SELECT * FROM USER_CONS_COLUMNS
WHERE UPPER (TABLE_NAME) = 'EMPLE';

DROP TABLE EMPLEADOS30;

CREATE TABLE EMPLEADOS30 AS SELECT EMP_NO ,
APELLIDO ,
OFICIO ,
ID_JEFE ,
FECHA_ALTA ,
SALARIO ,
COMISION_PCT ,
DEPT_NO 
FROM EMPLE
WHERE DEPT_NO = 30;

SELECT * FROM EMPLE WHERE DEPT_NO = 30;

SELECT * FROM EMPLEADOS30;

SELECT * FROM USER_CONSTRAINTS
WHERE UPPER(TABLE_NAME) = 'EMPLEADOS30';

UPDATE EMPLEADOS30
SET ID_JEFE = NULL
WHERE ID_JEFE IN (7839, 7566);

ALTER TABLE EMPLEADOS30 ADD(
	CONSTRAINT EMPLE30_PK PRIMARY KEY (EMP_NO),
	CONSTRAINT EMPLE30_DIR_FK FOREIGN KEY (ID_JEFE)
				REFERENCES EMPLEADOS30(EMP_NO) ON DELETE SET NULL,
	CONSTRAINT EMPLE30_DEP_FK FOREIGN KEY (DEPT_NO)
				REFERENCES DEPART(DEPT_NO) ON DELETE CASCADE
);



/*Vamos a realizar una “transacción” que tiene los siguientes pasos. Comprobaremos cada paso. Los pasos son::*/
/*Insertar en la tabla EMPLE a un empleado de apellido 'SAAVEDRA' con número de empleado 2000. La fecha de alta será la fecha actual, el SALARIO será el mismo salario que el del empleado de apellido 'SALA' más el 20 por 100 y el resto de datos serán los mismos que los datos del empleado de apellido 'SALA'. Hazlo en un sólo paso.*/
INSERT INTO EMPLE(APELLIDO, FECHA_ALTA, EMP_NO ,SALARIO,COMISION_PCT,DEPT_NO, OFICIO) 
SELECT 'SAAVEDRA', SYSDATE,2000, SALARIO + SALARIO*0.2,COMISION_PCT, DEPT_NO, OFICIO
        FROM EMPLE
        WHERE UPPER(APELLIDO) = 'SALA';
ROLLBACK;


SELECT * FROM EMPLE;
/*Actualiza la tabla EMPLE, cambiando el número de departamento, para todos los empleados que tenga el mismo oficio que el empleado 7566, por el número de departamento actual del empleado 7499.*/
UPDATE EMPLE
SET DEPT_NO = (SELECT DEPT_NO
                FROM EMPLE
                WHERE EMP_NO = 7499)
WHERE OFICIO = (SELECT OFICIO
                FROM EMPLE
                WHERE EMP_NO = 7566);
/*Borrar todos los departamentos de la tabla DEPART para los cuales no existan empleados en EMPLE.*/

/*Eliminar a todos los empleados que están en un departamento cuyo nombre contiene una 'O'.*/

/*Incrementa el salario del empleado de apellido REY. Su nuevo salario será el que tenía antes más un importe que corresponde con la comisión que tiene ARROYO.*/

/*Deshaz toda la transacción.*/
