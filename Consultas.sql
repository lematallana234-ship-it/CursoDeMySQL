--- Consultas de la base de datos SaludTotal
use saludtotal;
SELECT * FROM clientes;
SELECT * FROM medicinas;

#Con eso me registra la cantidad que tengo en cada tabla 
SELECT count(*) FROM clientes;

SELECT count(*) FROM medicinas;

----Consultar los datos de un cliente por su nemero de cédula 
----ejemplo:1000000006
SELECT *
FROM clientes
WHERE cedula = '1000000006';

---Caso: Proyeccion. Consultar  el correo de un cliente con su cedula
SELECT 
 email
from clientes
WHERE cedula = '1000000006';

---Caso: Consulta nombre de cliente por medio de su cedula 
SELECT 
 email,
 nombre
from clientes
WHERE cedula = '1000000006';

---Caso: Consultar el nombre de medicina con su ID
SELECT 
 nombre,
 precio
from medicinas
WHERE id = '15';

---Caso: Consultar todas los clientes con el nombre empieze con la letra A.
SELECT 
 cedula,
 nombre
FROM clientes
WHERE nombre LIKE 'A%';

---Caso: Consultar las medicinas que empieze con su primera letra.
SELECT 
 id,
 nombre
FROM medicinas
WHERE nombre LIKE 'F%';

SELECT 
 cedula,
 nombre
FROM clientes
WHERE nombre LIKE '%herrera%';

---Caso: Buscar los clientes tipo NAT cuyos nombres contengan 'Juan'
SELECT cedula, nombre, tipo
FROM clientes
WHERE tipo = 'NAT'
  AND nombre LIKE 'Juan%';

  --Caso: Buscar los clientes cuyo correo tenga dominio en gmail y sean de tipo JUR
SELECT cedula, nombre, email, tipo
FROM clientes
WHERE tipo = 'NAT'
  AND LOWER(email) LIKE '%@gmail.com';

  ---
SELECT 
    id,
    nombre,
    fechaCaducidad
FROM medicinas
WHERE tipo = 'GEN'
  AND NOMBRE LIKE 'P%';

