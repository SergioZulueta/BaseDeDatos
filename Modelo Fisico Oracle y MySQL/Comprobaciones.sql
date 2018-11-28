--COMPROBAR EXISTENCIA DE OBJETOS 
DESCRIBE USER_TABLES;

SELECT table_name 
FROM   user_tables 
WHERE  Lower(table_name) IN ( 'tiendas', 'ventas', 'pedidos', 'articulos', 
                              'fabricantes', 'departments', 'employees' ); 
                              
--COMPROBAR COLUMNAS DE CADA TABLA                        
DESC TIENDAS;
DESC VENTAS;
DESC PEDIDOS;
DESC ARTICULOS;
DESC FABRICANTES;
DESC DEPATMENTS;
DESC EMPLOYEES;

--COMPROBAR DESCRIPCIONES Y SUS COLUMNAS
DESC USER_CONSTRAINTS;

SELECT table_name, 
       constraint_type, 
       constraint_name 
FROM   user_constraints 
WHERE  Lower(table_name) IN ( 'tiendas', 'ventas', 'pedidos', 'articulos', 
                              'fabricantes', 'departments', 'employees' ) 
ORDER  BY table_name;

--COMPROBAR  LAS COLUMNAS CON RESTRICCIONES
DESC USER_CONS_COLUMNS;

SELECT * 
FROM   user_cons_columns 
WHERE  Lower(table_name) IN ( 'tiendas', 'ventas', 'pedidos', 'articulos', 
                              'fabricantes', 'departments', 'employees' ) 
ORDER  BY table_name; 

--4
SELECT table_name, 
       owner, 
       constraint_name, 
       constraint_type, 
       search_condition_vc 
FROM   user_constraints 
WHERE  Lower(table_name) IN ( 'tiendas', 'ventas', 'pedidos', 'articulos', 
                              'fabricantes', 'departments', 'employees' ); 


