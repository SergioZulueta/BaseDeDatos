--2

CREATE TABLE ERRORES(
ID NUMBER(3) GENERATED ALWAYS AS IDENTITY,
NUMERO NUMBER(4),
DESCRIPCION VARCHAR2(60),
CONSTRAINT ERR_ID_PK PRIMARY KEY(ID)
);

--3

CREATE OR REPLACE PROCEDURE AUMENTAR_SALARIO
(P_NUM_EMPLE EMPLE.EMP_NO%TYPE,P_AUMENTO_SALARIO NUMBER)
IS
EMPLE_CAMBIAR EMPLE.EMP_NO%TYPE;
SAL_EMPLE EMPLE.SALARIO%TYPE;
BEGIN 
--Busqueda de empleado Y SALARIO
 SELECT EMP_NO, SALARIO INTO EMPLE_CAMBIAR, SAL_EMPLE
 FROM EMPLE WHERE EMP_NO=P_NUM_EMPLE; 
-- SI EL SALARIO ES NULO
 IF SAL_EMPLE IS NULL THEN
   INSERT INTO ERRORES (NUMERO,DESCRIPCION)
   VALUES (EMPLE_CAMBIAR,'SALARIO NULO');
   DBMS_OUTPUT.PUT_LINE(EMPLE_CAMBIAR||'SALARIO NULO');
 ELSE
--ACTUALIZAR SALARIO
 UPDATE EMPLE
    SET SALARIO=SAL_EMPLE+P_AUMENTO_SALARIO
    WHERE EMP_NO=EMPLE_CAMBIAR;
--COMPROBAR UPDATE
 IF SQL%FOUND THEN
    DBMS_OUTPUT.PUT_LINE('ACTUALIZACION COMPLETA');
 ELSE
    RAISE_APPLICATION_ERROR(-20001, 'ERROR EN LA ACTUALIZACION');
 END IF;
 END IF;
-- EN EL CASO DE QUE NO EXISTA EMPLEADO
 EXCEPTION 
    WHEN NO_DATA_FOUND THEN
       INSERT INTO ERRORES (NUMERO,DESCRIPCION)
       VALUES (P_NUM_EMPLE,'NO ENCONTRADO');
       DBMS_OUTPUT.PUT_LINE(P_NUM_EMPLE||'NO ENCONTRADO');
END AUMENTAR_SALARIO;

--4

Select * from emple;

EXECUTE aumentar_salario(7839,100);
Select * from errores;
Select * from emple
where EMP_NO=7839;

EXECUTE aumentar_salario(2222,1);
Select * from errores;

EXECUTE aumentar_salario(1111,100);
Select * from errores;

EXECUTE aumentar_salario(6666,100);
Select * from errores;

EXECUTE aumentar_salario(7934,100);
Select * from errores;
Select * from emple
where EMP_NO=7934;