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

--19/12/2025
---Crear todas las combinaciones posibles en las tablas 
-- de clientes y la tabla de medicinafrecunete.
-- Producto Carteciano 
SELECT * FROM clientes, medicinas_frecuentes
WHERE clientes.cedula=medicinas_frecuentes.cedula_cliente;
  --- Producto carteciano entre 3 conjuntos
SELECT 
  c.cedula,
  c.nombre,
  m.nombre AS medicina,
  mf.descuento,
  m.tipo
FROM  
  medicinas_frecuentes mf
JOIN clientes c ON c.cedula = mf.cedula_cliente
JOIN medicinas m ON m.id = mf.id_medicina
WHERE 
  m.tipo = 'COM';


SELECT
  mcom.id, 
  mcom.nombre,
  mcom.precio,
  mcg.alternativa,
  mgen.nombre,
  mgen.precio,
  mgen.precio - mgen.precio as diferencia
FROM
  clasificacion_medicinas mcg
JOIN medicinas mcom on mcom.id = mcg.id_medicina
JOIN medicinas mgen on mgen.id = mcg.id_medicina
;

--- Caso: Presentar una fractura y sus detalles, que incluya,
--        los datos de la farmacia: nombre, ruc, correo
--        los datos del client:...
--        los datos de la cabera de la factura: numero, fecha
--        las medicinas vendidas: nombre de medicina, id, cantidad, precio, subtotal
--        los datos al pie de la factura: Total y la forma de pago

-- 1. Carga de datos en factura cabecera y detalle
--    usar los datos ya existentes
-- 2. selec para cabecera de factura
-- 3. selec para los detalles de factura
-- 4. selec para el pie factura.

USE SaludTotal;

-- =====================================
-- 1. CARGA DE DATOS (CABECERA)
-- =====================================
INSERT INTO facturas
VALUES ('0000000200', '2025-12-19', '1000000001', 0);

INSERT INTO facturas
VALUES ('0000000300', '2025-12-20', '1000000002', 0);
-- =====================================
-- 1. CARGA DE DATOS (DETALLE – 3 MEDICINAS)
-- =====================================
INSERT INTO facturadetalle VALUES
('0000000200', 8, 2, 3.25),   -- Amoxicilina
('0000000200', 9, 1, 8.50),   -- Azitromicina
('0000000200', 10, 3, 1.80);  -- Diclofenaco
INSERT INTO facturadetalle VALUES
('0000000300', 11, 2, 2.40),   
('0000000300', 12, 1, 0.95),   
('0000000300', 13, 3, 0.60);

-- =====================================
-- ACTUALIZAR TOTAL DE FACTURA
-- =====================================
UPDATE facturas
SET total = (
    SELECT SUM(cantidad * precio)
    FROM facturadetalle
    WHERE facturanumero = '0000000200'
)
WHERE facturanumero = '0000000200';

UPDATE facturas
SET total = (
    SELECT SUM(cantidad * precio)
    FROM facturadetalle
    WHERE facturanumero = '0000000300'
)
WHERE facturanumero = '0000000300';


-- =====================================
-- 2. CABECERA DE FACTURA
-- =====================================
SELECT
    e.ruc,
    e.direccion,
    e.telefono,
    e.email,
    f.facturanumero,
    f.fecha
FROM facturas f
CROSS JOIN empresa e
WHERE f.facturanumero = '0000000200';

-- =====================================
-- 3. DETALLE DE FACTURA
-- =====================================
SELECT
    m.id AS medicamento_id,
    m.nombre AS medicamento,
    fd.cantidad,
    fd.precio,
    (fd.cantidad * fd.precio) AS subtotal
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000200';

SELECT
    m.id AS medicamento_id,
    m.nombre AS medicamento,
    fd.cantidad,
    fd.precio,
    (fd.cantidad * fd.precio) AS subtotal
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000300'


-- =====================================
-- 4. PIE DE FACTURA
-- =====================================
SELECT
    f.total,
    'EFECTIVO' AS forma_pago
FROM facturas f
WHERE f.facturanumero = '0000000200';

SELECT
    f.total,
    'Tarjeta' AS forma_pago
FROM facturas f
WHERE f.facturanumero = '0000000300';

SELECT
    SUM(fd.cantidad * fd.precio) AS subtotal
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000300'

SELECT
    SUM(fd.cantidad * fd.precio) AS subtotal
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000200';