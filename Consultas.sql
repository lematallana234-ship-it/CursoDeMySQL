--- Consultas de la base de datos SaludTotal
use saludtotal;
SELECT * FROM clientes;
SELECT * FROM medicinas;

#Con eso me registra la cantidad que tengo en cada tabla 
SELECT count(*) FROM clientes;

SELECT count(*) FROM medicinas;

SELECT COUNT(*) FROM medicinas_frecuentes;

SELECT COUNT(*) FROM facturas;

SELECT COUNT(*) FROM facturadetalle;

----Consultar los datos de un cliente por su nemero de cédula 
----ejemplo:1000000006
SELECT *
FROM clientes
WHERE cedula = '1000000006';

SELECT 
 e.direccion,
    e.telefono,
    e.email,
    f.facturanumero,
    f.fecha       ----- SE LLAMA 
FROM facturas f
JOIN clientes c on c.cedula = f.cedula     ---BUSCAR CON JOIN
WHERE facturanumero = 'F'

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

SELECT 
 cedula,
 direccion
from clientes
WHERE direccion is NOT NULL;
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
WHERE nombre LIKE 'v%';

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
--- esto en la 7
WHERE
mcom.precio > 5
and mgen.precio <5
;

--Almacenar codigo sql en la base de datos
CREATE View v_medicinagencom      
AS
SELECT
  mcom.id, 
  mcom.nombre as nombre_comercial,
  mcom.precio,
  mcg.alternativa,
  mgen.nombre as nombre_generico,
  mgen.precioas precio_geenerico,
  mgen.precio - mgen.precio as diferencia
FROM
  clasificacion_medicinas mcg
JOIN medicinas mcom on mcom.id = mcg.id_medicina
JOIN medicinas mgen on mgen.id = mcg.id_medicina

--- esto en la 7
WHERE
mcom.precio > 5
and mgen.precio <5
;

select from vmedicinagencom;
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

SELECT 
fd.facturanumero,
fd.medicamento_id,
m.nombre,
fd.percio,
fd.cantidad,
fd.precio * cantidad
from 
facturadetalle fd
JOIN medicinas m on m.id =fd.medicamento_id
WHERE fd.facturanumero='0000000300'

DESC facturadetalle;
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

SELECT 
suma(fd.precio * fd.cantidad) as subtotal
from 
facturadetalle fd
JOIN medicinas m on m.id =fd.medicamento_id
WHERE fd.facturanumero='0000000300';

   #OTRA MANERA
    DESC facturas;
   ALTER TABLE facturas       ---ELIMINAR DATOS 
   DROP total;
   DESC facturadetalle;

# Consultar las medicinas declaradas en el plan de medicina frecuente 
---La operación LEFT JOIN en base de dos tablas que dispongan de la restricción de clave foránea
select COUNT(*) from medicinas;
select COUNT(*) from medicinas_frecuentes;

SELECT *
FROM medicinas m
JOIN medicinas_frecuentes mf on m.id = mf.id_medicina;

SELECT *
FROM medicinas m
JOIN medicinas_frecuentes mf join medicinas m on m.id = mf.id_medicina;

#Caso Lista ordenada de clientes pro nombre alfabetico 
   #Un ordenamiento sobre un atributo de forma descendente

SELECT
nombre, fechanacimiento
from clientes
ORDER BY fechanacimiento DESC
LIMIT 1;

---Caso:Conocer las 5 medicinas mas caras que tenemos 
SELECT
    nombre,
    precio
FROM medicinas
ORDER BY precio DESC
LIMIT 5;

---Caso: Conocer las 5 medicinas mas baratas 
SELECT
    nombre,
    precio
FROM medicinas
ORDER BY precio ASC
LIMIT 5;

---Caso:La medicina comercial mas barata 
SELECT
    nombre,
    precio
FROM medicinas
WHERE tipo = 'COM'
ORDER BY precio ASC
LIMIT 1;

---Caso: La medicina generica mas cara 
SELECT
    nombre,
    precio
FROM medicinas
WHERE tipo = 'GEN'
ORDER BY precio DESC
LIMIT 1;

---Caso: Las 5 medicinas comerciales con el menor descuento 
SELECT DISTINCT
    m.id,
    m.nombre,
    mf.descuento
FROM medicinas_frecuentes mf
JOIN medicinas m
    ON m.id = mf.id_medicina
WHERE m.id IN (
    SELECT m2.id
    FROM medicinas_frecuentes mf2
    JOIN medicinas m2
        ON m2.id = mf2.id_medicina
    WHERE m2.tipo = 'GEN'
)
ORDER BY mf.descuento;


select * FROM medicinas_frecuentes WHERE id_medicina=6;

SELECT
    m.id,
    m.nombre,
    MIN(mf.descuento) AS descuento
FROM medicinas m
JOIN medicinas_frecuentes mf
    ON m.id = mf.id_medicina
WHERE m.tipo = 'GEN'
GROUP BY m.id, m.nombre
ORDER BY descuento ASC
LIMIT 5;

---Csao: agrupamiento 
---Un agrupamiento sobre un atributo que no posee una restricción de unicidad y una operación de conteo
SELECT 
    tipo,
    COUNT(*) AS Numero
FROM clientes
GROUP BY tipo;

DESC medicinas;

SELECT 
id,
nombre,
precio,
stock,
precio * stock
from medicinas;

SELECT
    tipo,
    SUM(precio * stock) AS total
FROM medicinas
GROUP BY tipo;

---Caso: Factura detalle. Valor monetario por medicina vendida 
SELECT
medicamento_id,
cantidad,
precio,
cantidad * precio as subtotal
from facturadetalle
ORDER BY medicamento_id;

SELECT 
    m.nombre,
    fd.medicamento_id,
    SUM(fd.cantidad * fd.precio) AS total
FROM facturadetalle fd
JOIN medicinas m
    ON m.id = fd.medicamento_id
GROUP BY m.nombre, fd.medicamento_id
ORDER BY fd.medicamento_id;

---Caso: El cliente que mas compra en la farmacia
SELECT 
    fd.facturanumero,
    f.cedula,
    c.nombre,
    SUM(fd.cantidad * fd.precio) AS total
FROM facturadetalle fd
JOIN facturas f 
    ON f.facturanumero = fd.facturanumero
JOIN clientes c
    ON c.cedula = f.cedula
GROUP BY fd.facturanumero, f.cedula, c.nombre
ORDER BY total DESC
LIMIT 1;

#CASO: Kardex de la Farmacia.
---    De una medicina, quiero los movimientos de entrada y salida. 
---      -Stock inicial por periodos.
---      -Compras, Alta por inventario, Donaciones, etc.
---      -Ventas, Bajas de inventario, Vencimientos, etc.
---    Resultado: Stock Final.
---    Metodos para valorar: PROMEDIO, FIFO Y LIFO

-- ===============================
-- CASO 26/12/25
-- MOVIMIENTOS DE VENTAS
-- ===============================
CREATE OR REPLACE VIEW v_mov_ventas AS
SELECT
    f.fecha,
    fd.medicamento_id,
    m.nombre AS medicina,
    f.facturanumero AS documento,
    'VENTA' AS tipo_mov,
    m.stock AS stock_actual,
    fd.cantidad AS salida
FROM facturadetalle fd
JOIN facturas f
    ON f.facturanumero = fd.facturanumero
JOIN medicinas m
    ON m.id = fd.medicamento_id;


-- ===============================
-- MOVIMIENTOS DE COMPRAS
-- ===============================
CREATE OR REPLACE VIEW v_mov_compras AS
SELECT
    oc.fecha,
    ocd.medicamento_id,
    m.nombre AS medicina,
    oc.ordennumero AS documento,
    'COMPRA' AS tipo_mov,
    m.stock AS stock_actual,
    ocd.cantidad AS entrada
FROM orden_compra_detalle ocd
JOIN orden_compra oc
    ON oc.ordennumero = ocd.ordennumero
JOIN medicinas m
    ON m.id = ocd.medicamento_id;


-- ===============================
-- MOVIMIENTO GENERAL (COMPRAS + VENTAS)
-- ===============================
CREATE OR REPLACE VIEW v_movimiento AS
SELECT
    fecha,
    medicamento_id,
    medicina,
    documento,
    tipo_mov,
    stock_actual,
    entrada,
    0 AS salida
FROM v_mov_compras

UNION ALL

SELECT
    fecha,
    medicamento_id,
    medicina,
    documento,
    tipo_mov,
    stock_actual,
    0 AS entrada,
    salida
FROM v_mov_ventas;


SELECT
    f.fecha,
    fd.medicamento_id,
    m.nombre AS medicina,
    f.facturanumero AS documento,
    'VENTA' AS tipo_mov,
    sum(fd.cantidad)
    over(PARTITION BY fd.medicamento_id ORDER BY f.fecha) as acumulado,
    m.stock AS stock_actual,
    fd.cantidad AS salida
FROM facturadetalle fd
JOIN facturas f
    ON f.facturanumero = fd.facturanumero
JOIN medicinas m
    ON m.id = fd.medicamento_id;

create VIEW v_movimiento as
SELECT
*
FROM v_mov_compras
WHERE medicamento_id=7
ORDER BY fecha;

SELECT
    fecha,
    medicamento_id,
    medicina,
    documento,
    tipo_mov,
    stock_actual,
    cantidad,
    SUM(
        CASE
            WHEN tipo_mov = 'COMPRA' THEN cantidad
            WHEN tipo_mov = 'VENTA'  THEN -cantidad
        END
    ) OVER (
        PARTITION BY medicamento_id
        ORDER BY fecha
    ) AS saldo
FROM v_movimiento;


CREATE OR REPLACE VIEW v_kardex AS
SELECT
    fecha,
    medicamento_id,
    medicina,
    documento,
    tipo_mov,
    stock_actual,
    entrada,
    salida,
    SUM(
        CASE
            WHEN tipo_mov = 'COMPRA' THEN entrada
            WHEN tipo_mov = 'VENTA'  THEN -salida
        END
    ) OVER (
        PARTITION BY medicamento_id
        ORDER BY fecha
    ) AS saldo
FROM v_movimiento;

--- Caso: stock minimo 
--       - Stock de seguridad
--       - Garantizar que siempre exista disponibilidad de una determinada medicina 
--       - 
use saludtotal;
CREATE Table control_stock(
    medicina_id int,
    stock_minimo int
);

alter table control_stock
add PRIMARY KEY (medicina_id);

alter Table control_stock
add constraint control_stock_medicina_id_fk
Foreign Key (medicina_id)
REFERENCES medicinas(id);

INSERT Into control_stock
VALUES(36, 6);

--Consulta del kardex de medicina_id = 36
SELECT
fecha,
medicinas_id,
medicinas,
tipo_mov,
cantidad,
saldo
from v_kardex k
JOIN control_stock cs on cs.medicina_id=k.medicamento_id
WHERE
medicamento_id = 64

SELECT 
medicina_id,
COUNT(*)
FROM
v_kardex
GROUP BY medicamento_id
ORDER BY count(*) DESC;

SELECT * FROM v_kardex WHERE medicamento_id;

UPDATE medicinas set stock = 12 WHERE id =64;

INSERT into control_stock VALUES (64,15);

