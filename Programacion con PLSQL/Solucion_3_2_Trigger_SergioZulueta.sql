/*Ejercicio 1*/
SET SERVEROUTPUT ON;
--NO FUNCIONA EL EJERCICIO
CREATE OR REPLACE TRIGGER ins_productos
AFTER INSERT ON PRODUCTOS2
FOR EACH ROW
DECLARE
  l_coprod PRODUCTOS2.NO_PRODUCTO%TYPE;
BEGIN
  INSERT INTO PRODUCTOS2 (NO_PRODUCTO) VALUES (:NEW.NO_PRODUCTO);
  
  SELECT CO_PRODUCTO INTO l_coprod 
  FROM PRODUCTOS2
  WHERE NO_PRODUCTO = :NEW.NO_PRODUCTO;
  
  INSERT INTO PRECIOS_PRODUCTOS2 VALUES (l_coprod, 100, SYSDATE);
  
END ins_productos;

--


CREATE OR REPLACE TRIGGER ins_productos
AFTER INSERT ON PRODUCTOS2
FOR EACH ROW
BEGIN
  INSERT INTO PRECIOS_PRODUCTOS2 (CO_PRODUCTO,PRECIO,FECHA_ACTUALIZACION) VALUES (:NEW.CO_PRODUCTO,100,SYSDATE);
END;


insert into PRODUCTOS2 (no_producto) values('PANTALON');
insert into PRODUCTOS2 (no_producto) values('ZAPATOS');
insert into PRODUCTOS2 (no_producto) values('COMIDA');

--Comprobar

SELECT PRO.CO_PRODUCTO, PRO.NO_PRODUCTO, PRE.PRECIO, PRE.FECHA_ACTUALIZACION
FROM PRODUCTOS2 PRO, PRECIOS_PRODUCTOS2 PRE
WHERE PRO.CO_PRODUCTO = PRE.CO_PRODUCTO;

SELECT * FROM PRODUCTOS2;








/*Ejercicio 2*/

CREATE OR REPLACE TRIGGER INSERT_COMISION
BEFORE INSERT ON EMPLE 
FOR EACH ROW
BEGIN

  IF(:NEW.COMISION = 0)
  THEN 
      RAISE_APPLICATION_ERROR(-20001, 'LA COMISION NO PUEDE SER 0');
  END IF;
  
  IF(:NEW.COMISION IS NULL)
  THEN
      RAISE_APPLICATION_ERROR(-20000, 'LA COMISION NO PUEDE SER NULA');
  END IF;  
END INSERT_COMISION;

-- CON UN SOLO IF

CREATE OR REPLACE TRIGGER INSERT_COMISION
BEFORE INSERT ON EMPLE 
FOR EACH ROW
BEGIN
  IF(:NEW.COMISION = 0 OR :NEW.COMISION IS NULL)
  THEN 
      RAISE_APPLICATION_ERROR(-20001, 'LA COMISION NO PUEDE SER 0 O NULO');
  END IF;  
END INSERT_COMISION;


INSERT INTO EMPLE VALUES (7777,'Rodrigo','EMPLEADO',7782,'23/01/1982',169000,0,10);
INSERT INTO EMPLE VALUES (7777,'Rodrigo','EMPLEADO',7782,'23/01/1982',169000,null,10);

SELECT * FROM EMPLE;


/*Ejercicio 3*/

--Desabilitar el trigger

ALTER TRIGGER INSERT_COMISION DISABLE;

SELECT * FROM USER_TRIGGERS WHERE UPPER(TRIGGER_NAME) = 'INSERT_COMISION';

--Modificar el triger
DROP TRIGGER INSERT_COMISION;

CREATE OR REPLACE TRIGGER insert_comision
BEFORE INSERT ON EMPLE 
FOR EACH ROW
BEGIN
  IF(:new.comision = 0 OR :new.comision IS NULL)
  THEN 
      :NEW.COMISION:=1;
  END IF;  
END;

--Habilitar el trigger

ALTER TRIGGER insert_comision ENABLE;

--Hacer una insert
SELECT * FROM EMPLE;
DESC EMPLE
INSERT INTO EMPLE VALUES (7777,'Rodrigo','EMPLEADO',7782,'23/01/1982',169000,null,10);

ROLLBACK;

/*Ejercicio 4*/

CREATE OR REPLACE PACKAGE RI_EMP AS
NEWEMP EMPLE%ROWTYPE :=NULL;
END;
/
CREATE OR REPLACE TRIGGER T_NUM_DIR
AFTER INSERT OR UPDATE ON EMPLE
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        RI_EMP.NEWEMP.EMP_NO := :NEW.EMP_NO;
        RI_EMP.NEWEMP.DIRECTOR := :NEW.DIRECTOR;
        RI_EMP.NEWEMP.DEPT_NO := :NEW.DEPT_NO;
        RI_EMP.NEWEMP.SALARIO := :NEW.SALARIO;
    ELSIF UPDATING THEN
        RI_EMP.NEWEMP.EMP_NO := :NEW.EMP_NO;
        RI_EMP.NEWEMP.DIRECTOR := :NEW.DIRECTOR;    
    END IF;
END;




