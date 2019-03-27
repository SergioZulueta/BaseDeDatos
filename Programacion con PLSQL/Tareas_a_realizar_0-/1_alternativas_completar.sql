-- EJERCICIO 1
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion: Sacar por pantalla el valor de a
*/
-- IF

DECLARE
   a number(3) := 10;
   b number(3) := 21;
BEGIN
     IF ( a = 50 ) THEN
        dbms_output.put_line('El valor exacto de a es: 10' );
     ELSIF ( a = 75 ) THEN
        dbms_output.put_line('El valor exacto de a es: 20' );
     ELSE
        dbms_output.put_line('Ninguno de los valores coincide');
    END IF;
    --- Sacar por pantalla el valor de la variable a
    dbms_output.put_line ('El valor exacto de a es: '|| a ); 
END;

-- EJERCICIO 2
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion: sacar por pantalla los valores 1, 2 y 3
*/
--CASE
set SERVEROUTPUT ON;
Declare
    LN$Num pls_integer := 0 ;
    Begin
        Loop
          LN$Num := LN$Num + 1 ;
          CASE LN$Num
            WHEN 1 THEN dbms_output.put_line( '1' ) ;
            WHEN 2 THEN dbms_output.put_line( '2' ) ;
            WHEN 3 THEN dbms_output.put_line( '3' ) ;
           ELSE      
              EXIT ;
         END CASE ;
       End loop ;
   End ;
  
--Otra forma de escribirlo
Declare
     LN$Num pls_integer := 0 ;
Begin
      Loop
          LN$Num := LN$Num + 1 ;
          CASE 
            WHEN LN$Num=1 THEN dbms_output.put_line ( '1' ) ;
            WHEN LN$Num=2 THEN dbms_output.put_line ( '2' ) ;
            WHEN LN$Num=3 THEN dbms_output.put_line ( '3' ) ;
           ELSE      
              EXIT ;
         END CASE;
       End loop ;
End ;

-- EJERCICIO 3
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion: sacamos por pantalla el rango de valores por los que se va pasando 
 en la secuencia de valores de 1 a 5
*/
-- CASE MULTIPLES
Declare
     LN$Num pls_integer := 0 ;
Begin
      Loop
          LN$Num := LN$Num + 1 ;
          CASE
            WHEN LN$Num between  1 and 3
                 THEN dbms_output.put_line( To_char( LN$Num ) || ' -> 1-3' ) ;
            WHEN LN$Num < 5 
                 THEN dbms_output.put_line( To_char( LN$Num ) || ' < 5' ) ;
            ELSE 
                 dbms_output.put_line( To_char( LN$Num ) || ' >= 5' ) ;
          END CASE ;
         -- Condición de salida LN$Num = 5
         exit when LN$Num = 5 ;
       End loop ;
End ;
