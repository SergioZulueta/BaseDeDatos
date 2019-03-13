-- EJERCICIO 1
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion: sacar la secuencia de valores 1 2 y 3
 
*/
-- LOOP
Declare
    LN$I pls_integer := 0 ;
Begin
    Loop
        LN$I := LN$I + 1 ;
        dbms_output.put_line( to_char( LN$I) ) ;
        exit when LN$I > 2 ;
    End loop ;
End ;

-- EJERCICIO 2
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion:sacar la secuencia de valores 1 2 y 3
*/
-- WHILE
Declare
      LN$I pls_integer := 0 ;
Begin
    While LN$I < 3
      Loop
        LN$I := LN$I + 1 ;
        dbms_output.put_line( to_char( LN$I) ) ;
      End loop ;
End ;

-- EJERCICIO 3
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion: sacar la secuencia de valores 1 2 y 3s
*/
--FOR
Declare
    LN$I BINARY_INTEGER := 0 ; 
Begin
    -- FOR de 3 a 1
    For i in reverse 1..3
      Loop
        dbms_output.put_line( to_char( i ) ) ;
      End loop ;
  End ;


-- EJERCICIO 4
/* 
 Autor: Sergio Zulueta
 Fecha: 13/03/2019
 Descripcion: sacar la secuencia de valores 1 2 y 3
*/
-- FOR  de 1 a 3 
Declare
    LN$I pls_integer := 0 ; 
    -- FOR  de 1 a 3 
begin
    For i in 1..3
      Loop
        -- Sacar el valor de i
        dbms_output.put_line( to_char( i ) )  ;
      End loop ;
End ;