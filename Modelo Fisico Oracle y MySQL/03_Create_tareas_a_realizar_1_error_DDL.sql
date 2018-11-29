REM **** Borrado de las tablas

drop table employees cascade constraint;
drop table departments cascade constraint;
drop table articulos cascade constraint;
drop table fabricantes cascade constraint;
drop table tiendas cascade constraint;
drop table pedidos cascade constraint;
drop table ventas cascade constraint;


REM **** Creación de las tablas
create table departments(
   department_id NUMBER(2),
   department_name VARCHAR2(30) CONSTRAINT dept_name_nn NOT NULL, --quito la S a CONSTRAINTS
   manager_id NUMBER(3),
   location_id NUMBER(4),
CONSTRAINT dept_id_pk PRIMARY KEY(department_id)--nombre columna corregido
);


create table employees(--faltaba (
   employee_id NUMBER(6),
   first_name VARCHAR2(25) NOT NULL ,
   last_name VARCHAR2(25),
   email VARCHAR2(25)
      		CONSTRAINT emp_email_uk UNIQUE,
   phone_number NUMBER(12),
   hire_date DATE  DEFAULT SYSDATE ,
   job_id VARCHAR2(10),
   salary NUMBER(8,2),
   comission_pct NUMBER(5,2),
   manager_id NUMBER(3),
   department_id NUMBER(2),
   CONSTRAINT emp_id_pk PRIMARY KEY(employee_id),
   CONSTRAINT emp_dept_fk FOREIGN KEY(department_id)--estaba como FOREING               
    		      REFERENCES departments(department_id)--estaba como departmentes_id
);--faltaba ( y ; (en vez de ; se puede usar /)


CREATE TABLE fabricantes (
cod_fabricante VARCHAR2(3),--NOT NULL sobra porque es PRIMARY KEY
nombre VARCHAR2(15),
pais VARCHAR2(15), 
CONSTRAINT fab_cod_fab_pk PRIMARY KEY(cod_fabricante),
CONSTRAINT fab_nombre_mayusculas_CK CHECK (nombre = upper(nombre)),--CHECK mal escrito y posicion erronea, falta CONSTRAINT y elck en el nombre
CONSTRAINT fab_pais_mayusculas_CK CHECK (pais= upper(pais))
);


CREATE TABLE articulos (
articulo VARCHAR2(20) ,--NOT NULL sobra porque es PRIMARY KEY
cod_fabricante VARCHAR2(3) ,--NOT NULL sobra porque es PRIMARY KEY
peso NUMBER(3) ,--NOT NULL sobra porque es PRIMARY KEY
categoria VARCHAR2(10) ,--el tipo de dato mal escrito 5 no se puede porque la categoria 'primero' tiene mas de 5 letras--NOT NULL sobra porque es PRIMARY KEY
precio_venta NUMBER(4),
precio_costo NUMBER(4),
existencias NUMBER(5),
CONSTRAINT art_pk PRIMARY KEY(articulo, cod_fabricante, peso, categoria),
CONSTRAINT art_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
CONSTRAINT art_precioventa_CK CHECK (precio_venta>0),--CONSTRAINTy nombre faltan. El CHECK solo tiene un valor, no muchos como estaba
CONSTRAINT art_preciocosto_CK CHECK (precio_costo>0),--CONSTRAINTy nombre faltan. El CHECK solo tiene un valor, no muchos como estaba
CONSTRAINT art_peso_CK CHECK (peso>0),--CONSTRAINTy nombre faltan. El CHECK solo tiene un valor, no muchos como estaba
CHECK (categoria IN('primera','segunda','tercera')--categria IN va dentro de CHECK entre (), IN es igual a = solo que con mas porsibilidades
));


CREATE TABLE tiendas (
nif VARCHAR2(10) CONSTRAINT tie_nif_pk PRIMARY KEY,--PRIMARY KEY mal escrito y falta el nombre junto con CONSTRAINT
nombre VARCHAR2(20),
direccion  VARCHAR2(20),
poblacion  VARCHAR2(20),
provincia  VARCHAR2(20),
codpostal  VARCHAR2(5),
CONSTRAINT tie_upper CHECK(provincia = upper(provincia))-- es upper no uppercase
);


CREATE TABLE pedidos (--pones despues de tiendas porque tiene FOREING KEY a tiendas
nif VARCHAR2 (10),--NOT NULL sobra porque es PRIMARY KEY
articulo VARCHAR2 (20),--NOT NULL sobra porque es PRIMARY KEY
cod_fabricante VARCHAR2 (3),--NOT NULL sobra porque es PRIMARY KEY
peso NUMBER(3),--NOT NULL sobra porque es PRIMARY KEY
categoria VARCHAR2 (10),--NOT NULL sobra porque es PRIMARY KEY
fecha_pedido DATE DEFAULT SYSDATE,-- flata añadir DEFAULT para el SYSDATE (fecha de hoy) para que exista un valor por defecto en fecha_pedido
unidades_pedidas NUMBER(4),
CONSTRAINT ped_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
CONSTRAINT ped_fk FOREIGN KEY (cod_fabricante) REFERENCES fabricantes(cod_fabricante),--es REFERENCES no REFERENCE
CONSTRAINT ped_unidades_ck CHECK (unidades_pedidas>0),
CONSTRAINT ped_categoria_ck CHECK (categoria  IN('primera','segunda','tercera')),--faltan comillas simples a las categorias
CONSTRAINT ped_art_fk FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES articulos(articulo,cod_fabricante,peso,categoria),
CONSTRAINT ped_tie_fk FOREIGN KEY (nif) REFERENCES tiendas(nif)
);


CREATE TABLE ventas(--estaba arriba del todo y salia que no existia por las referencias que estaban por crear
nif VARCHAR2(10),--NOT NULL sobra porque es PRIMARY KEY
articulo VARCHAR2(20),--NOT NULL sobra porque es PRIMARY KEY
cod_fabricante VARCHAR2(3),--NOT NULL sobra porque es PRIMARY KEY
peso NUMBER(3),--NOT NULL sobra porque es PRIMARY KEY
categoria VARCHAR2(10),--NOT NULL sobra porque es PRIMARY KEY
fecha_venta DATE DEFAULT SYSDATE,
unidades_vendidas NUMBER(4), 
CONSTRAINT ven_pk PRIMARY KEY(nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
CONSTRAINT ven_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),--codigo no existe en referente fabrcantes (codigo), es cod_fabricante
CONSTRAINT ven_undidades_ck CHECK (unidades_vendidas>0),--poner el CONSTRAINT y el nombre
CONSTRAINT ven_categoria_ck CHECK (categoria IN('primera','segunda','tercera')),--poner el CONSTRAINT y el nombre
CONSTRAINT ven_art_fk FOREIGN KEY(articulo, cod_fabricante, peso, categoria) REFERENCES
articulos(articulo, cod_fabricante, peso, categoria),
CONSTRAINT ven_tie_fk FOREIGN KEY(nif) REFERENCES tiendas(nif)
);

--3

ALTER TABLE tiendas MODIFY(
CONSTRAINT nombre_uper_CK CHECK(nombre=INITCAP(nombre))
);

--5

ALTER TABLE pedidos MODIFY(
unidades_pedidas NUMBER(6));

ALTER TABLE ventas MODIFY(
unidades_vendidas NUMBER(6));

--6

ALTER TABLE tiendas ADD 
CONSTRAINT tie_prov_CK CHECK (provincia != 'TOLEDO'); 

--7

ALTER TABLE pedidos ADD (PVP NUMBER (4) DEFAULT 0);

ALTER TABLE ventas ADD (PVP NUMBER (4) DEFAULT 0);

--8

--ALTER TABLE ventas DROP 
--PVP;

--ALTER TABLE pedidos DROP
--PVP;

