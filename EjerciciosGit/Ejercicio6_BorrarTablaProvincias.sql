/*Modifica el script SQL anterior, a�adiendo al final la sentencia necesaria para borrar la tabla PROVINCIAS.
�Puedes? �Influye el que la tabla PERSONAS este relacionada con �sta mediante una clave for�nea?. Razona tu respuesta.*/

DROP TABLE PROVINCIAS CASCADE CONSTRAINTS;

--SE PUEDE ELIMINAR SIN NINGUN PROBLEMA, EL CODIGO DE LA PROVINCIA SEGUIRA ESTANDO PERO NO LIGADO A OTRA TABLA