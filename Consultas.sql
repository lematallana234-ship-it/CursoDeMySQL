--- Consultas de la base de datos SaludTotal
use saludtotal;
SELECT * FROM clientes;
SELECT * FROM medicinas;

#Con eso me registra la cantidad que tengo en cada tabla 
SELECT count(*) FROM clientes;

SELECT count(*) FROM medicinas;

SELECT COUNT(*) FROM medicinas_frecuentes;

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
WHERE nombre LIKE 'D%';

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

-----caso consulta de pacientes de medicina permanente 
--en una lista que incluya
---nombre y cedula del paciente, nombre a id de la medicina descuento

SELECT
cedula_cliente,
(SELECT nombre from clientes where cedula = cedula_cliente),
id_medicamento, 
descuento
FROM pacientes_permanentes


select 
cedula_cliente as cedula,
(SELECT nombre from clientes where cedula = cedula_cliente) as nombre,
id_medicamento AS medicinas,
    (SELECT nombre from medicinas WHERE id = id_medicamento)AS nombremedicina,
    descuento
FROM
    pacientes_permanentes;

--- caso: lista de pacientes con diabetes que tengan un descuento mayor al de un paciente especifico
SELECT
    mf.cedula_cliente,
    (SELECT c.nombre
     FROM clientes c
     WHERE c.cedula = mf.cedula_cliente) AS nombre_paciente,
    mf.descuento
FROM medicinas_frecuentes mf
WHERE mf.id_medicina = 1
AND mf.descuento > (
    SELECT descuento
    FROM medicinas_frecuentes
    WHERE cedula_cliente = '1000000027'
      AND id_medicina = 1
);



SELECT precio 
FROM medicinas
WHERE id = 86;

-- caso: listado de pacientes del plan medicinas frecuete
-- presente en el precio final de la medicina junto
-- con el precio den descuento

SELECT
    mf.cedula_cliente AS cedula,

    c.nombre AS nombre_paciente,

    m.nombre AS nombre_medicina,
    m.precio AS precio_normal,
    mf.descuento AS descuento_porcentaje,

    ROUND(
        m.precio - (m.precio * mf.descuento / 100),
        2
    ) AS precio_final

FROM medicinas_frecuentes mf
JOIN clientes c
    ON c.cedula = mf.cedula_cliente
JOIN medicinas m
    ON m.id = mf.id_medicina;


---caso: las medicinas comerciales puesden ser reemplazadas por genéricas
-- liste los pacientes que usan medicinas comerciales con su equivalente genérico
SELECT
    mf.cedula_cliente AS cedula,

    c.nombre AS nombre_paciente,

    mc.nombre AS medicina_comercial,
    mc.precio AS precio_comercial,

    mg.nombre AS medicina_generica,
    mg.precio AS precio_generica

FROM medicinas_frecuentes mf
JOIN clientes c
    ON c.cedula = mf.cedula_cliente
JOIN clasificacion_medicinas cm
    ON mf.id_medicina = cm.id_medicina
JOIN medicinas mc
    ON mc.id = cm.id_medicina
JOIN medicinas mg
    ON mg.id = cm.alternativa

WHERE mc.tipo = 'COM'
  AND mg.tipo = 'GEN';
