/*1.  Crear un procedimiento, llamado aumentar_salario_2. Aumentar el salario de los empleados de la tabla EMP de tal forma que:
si el empleado tiene el oficio de DIRECTOR deberemos a�adir a su salario el 8% de la media del salario de los directores
si es analista deberemos a�adir el 5% de la media del salario de los analistas
si tiene cualquier otro oficio se a�adir� el 4% de la media de todos los empleados no sean ni directores, ni analistas. En este caso adem�s, si el empleado tiene comisi�n, deberemos a�adir a su nuevo salario el 2% de la comisi�n.

      Para realizar el ejercicio utiliza un cursor de actualizaci�n (mira en los apuntes).

NOTA: Si tienes que escribir n�meros con decimales recuerda usar la notaci�n anglosajona, es decir, el punto en lugar de la coma para los decimales. Ejemplo: 0.08*/

CREATE OR REPLACE PROCEDURE AUMENTAR_SALARIO_2

BEGIN 

EXCEPTION 

END AUMENTAR_SALARIO_2;



/*2. Escribe un procedimiento, llamado cambio_oficio,  que modifique el oficio de los empleados de la tabla EMPLE que ganan m�s de 300000. El nuevo oficio ser� el oficio que se le pase como par�metro, pero teniendo en cuenta lo siguiente:
si en el momento de la actualizaci�n, el n�mero de empleados que hay en su departamento con dicho oficio es superior a 2, su nuevo oficio NO SERA el que nos han pasado, sino que ser� el oficio en el que menos empleados haya de su departamento. 

Adem�s, si la actualizaci�n es correcta se mostrar� por pantalla,  para cada empleado, el n�mero de empleado, apellido, el oficio que ten�a anterior y el nuevo oficio. 

El procedimiento antes de finalizar, informar� por pantalla el n�mero de empleados que han sido actualizados.

Controlar posibles excepciones:
El oficio que se le pasa en la llamada es un oficio nuevo (no existe nadie con dicho oficio en EMPLE).
Para cualquier otra excepci�n, mostrar el c�digo de la excepci�n ( funci�n SQLCODE) y el mensaje de error (SQLERRM).*/

      CREATE OR REPLACE PROCEDURE CAMBIO_OFICIO
      (P_OFICIO EMPLE.OFICIO%TYPE)
      IS
      SALARIO_EMPLE EMPLE.SALARIO%TYPE;
      
      CURSOR C_OFICIOS  IS
      SELECT EMP_NO,OFICIO,DEPT_NO
      FROM EMPLE
      WHERE SALARIO > 300000;
      VREG C_OFICIOS%ROWTYPE;
      V_OFICIO_EMPLE_DEPART EMPLE.OFICIO%TYPE;
      BEGIN
      OPEN C_OFICIOS;
      LOOP
      FETCH C_OFICIOS INTO VREG;
      SELECT COUNT(EMP_NO) INTO V_OFICIO_EMPLE_DEPART FROM EMPLE WHERE UPPER(OFICIO) = P_OFICIO AND DEPT_NO = VREG.DEPT_NO;
      IF V_OFICIO_EMPLE_DEPART > 2 
      THEN NULL; --SELECT DE MINIMO
     
      ELSE NULL; -- UPDATE 
      END IF;
      end loop;
      END CAMBIO_OFICIO;

