DROP TABLE pedidos CASCADE CONSTRAINT;
DROP TABLE ventas CASCADE CONSTRAINT;
DROP TABLE articulos CASCADE CONSTRAINT;
DROP TABLE fabricantes CASCADE CONSTRAINT;

DROP TABLE tiendas CASCADE CONSTRAINT;

CREATE TABLE fabricantes
(
cod_fabricante VARCHAR2(3),
nombre VARCHAR2(15),
pais VARCHAR2(15),
  CONSTRAINT fabr_pk PRIMARY KEY(cod_fabricante),
  CONSTRAINT fabr_nombre_ck CHECK (nombre=UPPER(nombre)),
  CONSTRAINT fabr_pais_ck CHECK (pais=UPPER(pais))
);

INSERT INTO fabricantes
VALUES (1,'FABRICANTE 1','PORTUGAL'); --1 Y PORTUGAL

INSERT INTO fabricantes
VALUES (2,'FABRICANTE 2','FRANCIA'); -- 2



CREATE TABLE articulos
 (
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
precio_venta NUMBER(4),
precio_costo NUMBER(4),
existencias NUMBER(5),
  CONSTRAINT art_comp_pk PRIMARY KEY(articulo,cod_fabricante,peso,categoria),
  CONSTRAINT art_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
  CONSTRAINT art_precio_venta_ck CHECK(precio_venta>0),
  CONSTRAINT art_precio_costo_ck CHECK(precio_costo>0),
  CONSTRAINT art_peso_ck CHECK(existencias>0),
  CONSTRAINT art_categoria_ck CHECK(categoria IN ('Primera','Segunda','Tercera'))
);

INSERT INTO articulos
VALUES ('ARTICULO1','1',100, 'Primera',222,180,1000);

INSERT INTO articulos
VALUES ('ARTICULO2','1',200, 'Primera',522,480,500); --initcap Primera

INSERT INTO articulos
VALUES ('ARTICULO3','2',100, 'Segunda',322,280,300); -- el codigo 3 no existe

--INSERT INTO articulos
--VALUES ('ARTICULO2','1',200, 'Primera',522,480,500);-- repetida

--INSERT INTO articulos
--VALUES ('ARTICULO3','2',100, 'Segunda',322,280,300);-- repetida

INSERT INTO articulos
VALUES ('ARTICULO4','2',200, 'Primera',422,380,400);





CREATE TABLE tiendas (
nif VARCHAR2(10),
nombre VARCHAR2(20),
direccion VARCHAR2(20),
poblacion VARCHAR2(20),
provincia VARCHAR2(20),
codpostal VARCHAR2(5),
  CONSTRAINT tien_pk PRIMARY KEY(nif),
  CONSTRAINT tien_provincia_ck CHECK(provincia=UPPER(provincia))
);

INSERT INTO tiendas
VALUES ('A010038I','TIENDA 1', 'SANTIAGO, 25', 'VITORIA','ALAVA','01003');

INSERT INTO tiendas
VALUES ('A020058I','TIENDA 2', 'DIVINO PASTOR, 15', 'MADRID','MADRID','28004');




CREATE TABLE pedidos (
nif VARCHAR2(10),
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
fecha_pedido DATE,
unidades_pedidas NUMBER(4),
  CONSTRAINT ped_comp_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
  CONSTRAINT ped_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
  CONSTRAINT ped_tien_fk FOREIGN KEY(nif) REFERENCES tiendas(nif),
  CONSTRAINT ped_art_fk FOREIGN KEY(articulo,cod_fabricante,peso,categoria) 
     REFERENCES articulos(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
  CONSTRAINT ven_unidades_pedidas_ck CHECK(unidades_pedidas>0),
  CONSTRAINT ped_categoria_ck CHECK(categoria IN ('Primera','Segunda','Tercera'))
);  

INSERT INTO pedidos
VALUES ('A010038I', 'ARTICULO4','2',200, 'Primera',SYSDATE,100);

INSERT INTO pedidos
VALUES ('A010038I', 'ARTICULO4','2',200, 'Tercera',SYSDATE,100);

/*INSERT INTO pedidos
VALUES ('A010038I', 'ARTICULO4','2',200, 'Primera',SYSDATE,100);*/ -- primera initcap



CREATE TABLE ventas (
nif VARCHAR2(10),
articulo VARCHAR2(20),
cod_fabricante VARCHAR2(3),
peso NUMBER(3),
categoria VARCHAR2(10),
fecha_venta DATE,
unidades_vendidas NUMBER(4),
  CONSTRAINT ven_comp_pk PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
  CONSTRAINT ven_fab_fk FOREIGN KEY(cod_fabricante) REFERENCES fabricantes(cod_fabricante),
  CONSTRAINT ven_tien_fk FOREIGN KEY(nif) REFERENCES tiendas(nif),
  CONSTRAINT ven_art_fk FOREIGN KEY(articulo,cod_fabricante,peso,categoria) REFERENCES articulos(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
  CONSTRAINT ven_unidades_vendidas_ck CHECK(unidades_vendidas>0),
  CONSTRAINT ven_categoria_ck CHECK(categoria IN ('Primera','Segunda','Tercera'))
);  

INSERT INTO ventas
VALUES ('A010038I', 'ARTICULO4',2,200, 'Primera','21-ENE-12',10);

INSERT INTO ventas
VALUES ('A010038I', 'ARTICULO4',2,200, 'Primera','15/01/2012',10);

INSERT INTO ventas
VALUES ('A010038I', ''ARTICULO3','3',100, 'Segunda',TO_DATE('15-01-2012','DD-MM-YYYY'),10);

