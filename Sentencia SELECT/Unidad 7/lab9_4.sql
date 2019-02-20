--Para saber las columnas que hay en la tabla
DESC DEPARTSEQ;

--Alteramos la tabla para que podamos introducir la sequencia
ALTER TABLE DEPARTSEQ 
MODIFY (DEPT_NO number(4));

--Introducimos los valores
INSERT INTO DEPARTSEQ VALUES(DEPT_ID_SEQ.NEXTVAL, 'EDUCACION', 'VITORIA');
INSERT INTO DEPARTSEQ VALUES(DEPT_ID_SEQ.NEXTVAL, 'ADMINISTRACION', 'MADRID');

--Comprobamos que se han introducido bien
SELECT * FROM DEPARTSEQ;

