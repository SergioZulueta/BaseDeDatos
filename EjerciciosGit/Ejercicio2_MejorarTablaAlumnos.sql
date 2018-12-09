--2
/*A�adir a la tabla ALUMNOS dos columnas: SEXO e IMPORTE.
 Definir la columna SEXO con la restricci�n NOT NULL. S�lo podr�n introducir los valores M o F. 
 La columna IMPORTE numerica entera de precisi�n 10 con dos decimales. Por defecto, contendr� el valor 0 .*/
 
ALTER TABLE ALUMNOS ADD(
    SEXO VARCHAR2(1) NOT NULL,
    IMPORTE NUMBER(10,2) DEFAULT 0,
    CONSTRAINT SEX_CH CHECK (SEXO = 'M' OR SEXO ='H')
);

DESC ALUMNOS;

/*Eliminar la columna EDAD.*/

ALTER TABLE ALUMNOS DROP(
    EDAD
);

DESC ALUMNOS;

/*A�adir dos nuevas columnas:
FECHA_NAC que contiene la fecha de nacimiento.
FECHA_ALTA que es la fecha de ingreso en la escuela.*/

ALTER TABLE ALUMNOS ADD(
    FECHA_NAC DATE,
    FECHA_ALTA DATE
);

DESC ALUMNOS;

/*A�adir una restricci�n que haga cumplir que la FECHA_NAC sea siempre anterior a la FECHA_ALTA.
�Podr�as luego eliminar la columna FECHA_NAC?*/

ALTER TABLE ALUMNOS MODIFY (
    CONSTRAINT FEC_ALT_CH CHECK (FECHA_ALTA > TO_DATE(FECHA_NAC, 'DD/MM/YYYY')                                 )                                 
);
    
--NO SE PUEDE ELIMINAR FECHA_NAC POR QUE HACE REFERENCIA A UNA COLUMNA CON RESTRICCIONES

/*Cambiar el nombre de la columna IMPORTE que pasar� a denominarse TASAS.*/

ALTER TABLE ALUMNOS RENAME COLUMN IMPORTE TO TASAS;

DESC ALUMNOS;

--3
DESC USER_CONSTRAINTS;

SELECT *
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME = 'ALUMNOS';

