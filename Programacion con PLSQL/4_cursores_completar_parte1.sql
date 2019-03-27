-- EJERCICIO 1
/* 
 Autor:Sergio Zulueta
 Fecha: 20/03/2019
 Descripcion: xxxxx
*/
Declare
   -- DEFIINIR el Cursor DE NOMBRE C_EMP 
   Cursor C_EMP  Is
   Select EMP_NO,APELLIDO
   From EMPLE
   ;
   -- Variable para recoger los datos del cursor
   Reg_emp  C_EMP%ROWTYPE ;
Begin
   --Abrir Cursor C_EMP
   OPEN  C_EMP ;

   -- Tratar Cursor C_EMP con bucle LOOP BÃ?SICO
   LOOP
      FETCH C_EMP Into Reg_emp ;
      -- Salir del bucle cuando no hay mas filas en el cursor C_EMP
      EXIT WHEN C_EMP%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE ('CODIGO EMPLEADO: '||TO_CHAR(Reg_emp.emp_no)||' PARA EL EMPLEADO: '|| Reg_emp.apellido);
   END LOOP;
   
   --Cerrar Cursor
   CLOSE C_EMP ;
End ;

-- EJERCICIO 2
/* 
 Autor:Sergio Zulueta
 Fecha: 20/03/2019
 Descripcion: xxxxx
*/
Declare
   -- Cursor llamdo C_EMP para tratar todos los codigos de empleados y apellidos de trabajadores de la empresa
   Cursor C_EMP  Is
   select emp_no, apellido
   from emple
   ;
Begin
   -- Tratar Cursor C_EMP con bucle FOR
   FOR reg_emp IN C_EMP LOOP
      DBMS_OUTPUT.PUT_LINE ('CODIGO EMPLEADO: '||TO_CHAR(Reg_emp.emp_no)||' PARA EL EMPLEADO: '|| Reg_emp.apellido);
   END LOOP;
End ;



