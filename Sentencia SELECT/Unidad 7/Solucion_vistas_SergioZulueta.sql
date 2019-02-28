/*Apartado 1*/
DROP VIEW EMP_30;

CREATE VIEW EMP_30 (COD_EMPLE, APELLIDO, SALARIO, DEPT_NO) AS
(SELECT emp_no, apellido, salario, dept_no
  FROM EMPLE
  WHERE DEPT_NO=30);

SELECT * FROM USER_VIEWS
WHERE UPPER(VIEW_NAME)='EMP_30';

DESC EMP_30;

SELECT * FROM EMP_30;
/*Apartado 2*/

ALTER TABLE EMPLE ADD(
SEXO VARCHAR (1),
CONSTRAINT SEX_CK CHECK (SEXO IN ('S','N'))
);

ALTER TABLE EMPLE MODIFY(
CONSTRAINT SEX_CK_MOD CHECK (SEXO IN ('S','M'))
);

SELECT * FROM USER_CONSTRAINTS

WHERE TABLE_NAME = 'EMPLE';


INSERT INTO EMPLE VALUES(9999,'URRUTIA','ANALISTA',7698,NULL,200000,NULL,30);

SELECT * from EMP_30;--Se añade a la vista


/*Apartado 3*/

INSERT INTO EMP_30 VALUES(8888,'RUIZ',280000,30);
INSERT INTO EMP_30 VALUES(8889,'RUIZ',280000,10);
--Deja hacer la insert aunuque esté en otro departamento


/*Apartado 4*/

CREATE OR REPLACE VIEW EMP_30 AS (SELECT emp_no, apellido, salario, dept_no
  FROM EMPLE
  WHERE dept_no=30)
WITH CHECK OPTION CONSTRAINT EMP_30_ERROR;
INSERT INTO EMP_30 VALUES (1111, 'LOPEZ', 1200,30);  
INSERT INTO EMP_30 VALUES (2222, 'RUIZ', 2200,20);  --No funciona

DROP VIEW EMP_30;
/*Apartado 5*/

CREATE OR REPLACE VIEW SAL_20 (ID_EMP, APE_EMP, SAL_ANUAL) AS
  (SELECT emp_no, apellido, salario*12
    FROM EMPLE
    WHERE dept_no = 20);

SELECT * FROM USER_VIEWS
WHERE UPPER(VIEW_NAME)='SAL_20';

SELECT * FROM SAL_20;

DESC SAL_20

CREATE PUBLIC SYNONYM S20 FOR SCOTT.SAL_20;

/*Apartado 6*/

CREATE OR REPLACE VIEW DEPT_SUM (DEPT_NOMBRE, SAL_MIN, SAL_MAX, SAL_MED) AS
  (SELECT d.dnombre, MIN(e.SALARIO), MAX(e.salario), AVG(e.salario)
   FROM depart d, emple e
   WHERE d.dept_no = e.dept_no
   GROUP BY e.dept_no, d.dnombre);

SELECT * FROM USER_VIEWS
WHERE UPPER(VIEW_NAME)='DEPT_SUM';

DESC DEPT_SUM;

SELECT * FROM DEPT_SUM;

/*Apartado 7*/

DROP VIEW SAL_20;

SELECT *
FROM USER_VIEWS
WHERE UPPER(VIEW_NAME) = 'SAL_20';

/*Apartado 8*/

CREATE OR REPLACE VIEW V_DEPT_SALMAX (CODIGO_DEPT, NOMBRE_DEPT, DEPT_SALMAX) AS
  (SELECT d.dept_no, d.dnombre, MAX(e.salario)
   FROM depart d, emple e
   WHERE d.dept_no = e.dept_no
   GROUP BY d.dept_no, d.dnombre);

SELECT * FROM USER_VIEWS
WHERE UPPER(VIEW_NAME)='DEPT_SUM';

DESC DEPT_SUM;

SELECT * FROM V_DEPT_SALMAX;

DROP VIEW V_DEPT_SALMAX;

/*Apartado 9*/

CREATE OR REPLACE VIEW V_DEPT_SALAVG (CODIGO_DEPT,  DEPT_SALAVG) AS
  (SELECT d.dept_no,  AVG(e.salario)
   FROM depart d, emple e
   WHERE d.dept_no = e.dept_no
   GROUP BY d.dept_no, d.dnombre);

SELECT e.apellido, e.salario, e.dept_no, round(d.dept_salavg,2)
FROM emple e, V_DEPT_SALAVG d
WHERE e.dept_no=d.codigo_dept
and e.salario > d.dept_salavg;

/*Apartado 10*/

DROP VIEW PROP;

CREATE OR REPLACE VIEW PROP (APELLIDO, SALARIO, DEPT_NO, SALARIO_MAX) AS
  (SELECT e.apellido, e.salario, e.dept_no, D.SALMAX
   FROM emple e, (SELECT MAX(salario) SALMAX, DEPT_NO
                      FROM EMPLE em group by DEPT_NO)  D
   WHERE e.dept_no= d.dept_no
   AND e.salario < D.SALMAX);
                      
SELECT * FROM USER_VIEWS
WHERE UPPER(VIEW_NAME)='PROP';

DESC PROP;

SELECT * FROM PROP;

/*Apartado 11*/

SELECT * FROM USER_VIEWS
WHERE UPPER(VIEW_NAME)='PROP';

DESC PROP;

SELECT * FROM PROP;


