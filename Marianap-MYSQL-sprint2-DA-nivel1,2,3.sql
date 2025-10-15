-- Nivel 1 
-- Ejercicio 1.1
-- Tu tarea es diseñar y crear una tabla llamada "credit_card" que almacene detalles cruciales sobre las tarjetas de crédito. 
--                       OBS: PRIMARY KEY  Para ello, se define una columna o un conjunto de ellas como su identificador. El identificador es por tanto, un valor o valores que no pueden repetirse y que permiten obtener una fila de datos de entre todas las que hay en la tabla. 

 CREATE TABLE credit_card (
  id VARCHAR(8),
	iban VARCHAR(100),
	pan VARCHAR(30),
	pin VARCHAR(6),
	cvv VARCHAR(6),
	expiring_date VARCHAR (20) 
);



-- La nueva tabla debe ser capaz de identificar de forma única cada tarjeta y establecer una relación adecuada con las otras dos tablas ("transaction" y "company"). 


-- Después de crear la tabla será necesario que ingreses la información del documento denominado "datos_introducir_credit". 
-- Recuerda mostrar el diagrama y realizar una breve descripción del mismo.


-- Nivel 1 
-- Ejercicio 2
-- El departamento de Recursos Humanos ha identificado un error en el número de cuenta asociado a su tarjeta de crédito con ID CcU-2938.
-- La información que debe mostrarse para este registro es: TR323456312213576817699999. Recuerda mostrar que el cambio se realizó.


update credit_card
set iban = 'TR323456312213576817699999'
where id = 'CcU-2938';

-- confirmación de que se ha actualizado:
select id, iban
from credit_card
where id = 'CcU-2938';






-- Nivel 1 
-- Ejercicio 3
-- En la tabla "transaction" ingresa una nueva transacción con la siguiente información:
-- Id	108B1D1D-5B23-A76C-55EF-C568E49A99DD
-- credit_card_id	CcU-9999
-- company_id	b-9999
-- user_id	9999
-- lato	829.999
-- longitud	-117.999
-- amunt	111.11
-- declined	0


-- COMENTARIOS: (NO TERMINADO)
-- el ejercicios no ofrece timestamp*
-- primero tengo que crear un nuevo id en credit card con el valor CcU-9999
-- luego usar join (?) or constraint para juntar las dos tablas   

INSERT INTO transaction (id, credit_card_id, company_id,  user_id, lat, longitude, amount, declined  )
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0' );




-- Nivel 2
-- Ejercicio 1
-- Elimina de la tabla transacción el registro con ID 000447FE-B650-4DCF-85DE-C7ED0EE1CAAD de la base de datos.


-- Nivel 2
-- Ejercicio 2
-- La sección de marketing desea tener acceso a información específica para realizar análisis y estrategias efectivas. 
-- Se ha solicitado crear una vista que proporcione detalles clave sobre las compañías y sus transacciones. Será necesaria que crees una vista llamada VistaMarketing que contenga la siguiente información: 
-- Nombre de la compañía. 
-- Teléfono de contacto. 
-- País de residencia. -- 
-- Media de compra realizado por cada compañía. 
-- Presenta la vista creada, ordenando los datos de mayor a menor promedio de compra.




-- Nivel 2
-- Ejercicio 3
-- Filtra la vista VistaMarketing para mostrar sólo las compañías que tienen su país de residencia en "Germany"



-- Nivel 3
-- Ejercicio 1
-- La próxima semana tendrás una nueva reunión con los gerentes de marketing. 
-- Un compañero de tu equipo realizó modificaciones en la base de datos, pero no recuerda cómo las realizó. 
-- Te pide que le ayudes a dejar los comandos ejecutados para obtener el siguiente diagrama: (vide diagrama en el moodle)
-- ** Recordatorio: En esta actividad, es necesario que describas el "paso a paso" de las tareas realizadas. 
-- ** Es importante realizar descripciones sencillas, simples y fáciles de comprender. Para realizar esta actividad deberás trabajar con los archivos denominados "estructura_datos_user" y "datos_introducir_user" 
-- ** Recuerda seguir trabajando sobre el modelo y las tablas con las que ya has trabajado hasta ahora.




-- Nivel 3
-- Ejercicio 2
-- La empresa también le pide crear una vista llamada "InformeTecnico" que contenga la siguiente información:
-- ID de la transacción
-- Nombre del usuario/a
-- Apellido del usuario/a
-- IBAN de la tarjeta de crédito usada.
-- Nombre de la compañía de la transacción realizada.
-- Asegúrese de incluir información relevante de las tablas que conocerá y utilice alias para cambiar de nombre columnas según sea necesario.
-- Muestra los resultados de la vista, ordena los resultados de forma descendente en función de la variable ID de transacción.
