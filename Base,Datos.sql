-- ===============================
-- CREACIÓN DE BASE DE DATOS
-- ===============================
DROP DATABASE IF EXISTS SaludTotal;
CREATE DATABASE SaludTotal;
USE SaludTotal;

-- ===============================
-- TABLA MEDICINAS
-- ===============================
CREATE TABLE medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3),
    precio DECIMAL(15,2),
    stock INT,
    fechaCaducidad DATETIME
);
 
 ALTER TABLE medicinas
 MODIFY COLUMN tipo char(3) DEFAULT 'GEN';  --- se pone en automatico en tipo

alter table medicinas 
modify COLUMN nombre VARCHAR(100) not null; --Modificar y no haya datos nulos 

alter TABLE medicinas                       --- Con esto me corrige lo que declaro GEN COM
add constraint medicinas_tipo_val       
check(                                
    tipo in ('GEN', 'COM')
);

update medicinas
SET TIPO = 'GEN'

insert into medicinas
values (1,'Paracetamol', 'GEN', 1.50, 12, '2026-01-01 00:00:00');
insert into medicinas
values (2, 'Acetaminofen', 'GEN', 0.56, 23,'2027-01-01 00:00:00');
insert into medicinas
values (3, 'Ibuprofeno', 'COM', 2.75, 43,'2028-01-01 00:00:00');
insert into medicinas
values (4,'Losartan', 'GEN', 5.95, 62, '2029-01-01 00:00:00');
insert into medicinas (id, nombre, precio, stock, fechaCaducidad)
values (5, 'Formoterol', 25.40, 43, '2028-01-01 00:00:00');
insert into medicinas
values (6,'Metformina', 'GEN', 4.80, 59, '2029-08-17 00:00:00');
insert into medicinas
values (7,'Levotiroxina', 'GEN', 5.73, 110,'2028-12-12 00:00:00');

DELETE FROM medicinas
WHERE id=5

                 ---Atributo email unico en la tabla medicina (es para que no se repita los correos de clientes)
alter table medicinas
add constraint clientes_nombre_nombre_uq
UNIQUE (nombre);

insert into medicinas
values (
    5, 
    'Losartan', 
    'GEN',
    5.95, 62,
    '2029-01-01 00:00:00'
);
                   --------------

select * from medicinas;
-- ===============================
-- TABLA CLIENTES
-- ===============================
CREATE TABLE clientes (
    cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3),
    edad INT,
    email VARCHAR(20),
    telefono VARCHAR(20)
);

insert into clientes
values ('1726367459', 'Pablo Cortez','NAT',20 , 'pablo@gmail.com', '0954123012');

insert into clientes
values ('0912345678', 'Maria Lopez', 'NAT', 28, 'marialopez@gmail.com','0987654321');

insert into clientes
values ('0923456789', 'Carlos Andrade', 'NAT', 35, 'carlosan@gmail.com', '0976543210');

insert into clientes
values ('0945678901', 'Luis Mendoza', 'NAT', 30, 'mendoza@gmail.com', '0954321098');

insert into clientes
values ('0934567890', 'Ana Torres', 'NAT', 42, 'ana.torres@gmail.com', '0965432109');

   ---Atributo email unico en la tabla clientes (es para que no se repita los correos de clientes)
alter table clientes
add constraint clientes_email_email_uq
UNIQUE (email);
insert into clientes
values ('0912345645', 'sandra perez', 'NAT', 28, 'marialopez@gmail.com','0987654321');
     ---------------------------

SELECT * FROM clientes;
-- ===============================
-- TABLA EMPRESA (INDEPENDIENTE)
-- ===============================
CREATE TABLE empresa (
    ruc CHAR(13) PRIMARY KEY,
    razonsocial VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(14),
    email VARCHAR(25)
);

insert into empresa 
values ('1754230589', 'Salud Total S.A', 'AV. 10 de agosto', '0996254612', 'jorje234@gmail.com' );

SELECT * FROM empresa;
-- ===============================
-- TABLA FACTURAS
-- ===============================
CREATE TABLE facturas (
    facturanumero CHAR(10) PRIMARY KEY,
    fecha DATE,
    cedula CHAR(10),
    total DECIMAL(15,2),

    CONSTRAINT facturas_cliente_fk
        FOREIGN KEY (cedula)
        REFERENCES clientes(cedula)
);

INSERT INTO facturas
 VALUES('0000000001', '2025-01-15', '1726367459', 25.50);
INSERT INTO facturas
 values('0000000002', '2025-01-16', '0912345678', 18.75);

SELECT * FROM facturas;
-- ===============================
-- TABLA FACTURA DETALLE
-- ===============================
CREATE TABLE facturadetalle (
    facturanumero CHAR(10),
    medicamento_id INT,
    cantidad INT,
    precio DECIMAL(15,2),

    PRIMARY KEY (facturanumero, medicamento_id),

    CONSTRAINT fd_factura_fk
        FOREIGN KEY (facturanumero)
        REFERENCES facturas(facturanumero),

    CONSTRAINT fd_medicina_fk
        FOREIGN KEY (medicamento_id)
        REFERENCES medicinas(id),

    CONSTRAINT fd_cantidad_ck CHECK (cantidad > 0),
    CONSTRAINT fd_precio_ck CHECK (precio > 0)
);

INSERT INTO facturadetalle 
VALUES('0000000001', 1, 2, 1.50);

INSERT INTO facturadetalle
values('0000000002', 2, 3, 0.56);

SELECT * FROM facturadetalle;
-- ===============================
-- PACIENTES PERMANENTES
-- ===============================
CREATE TABLE pacientes_permanentes (
    cedula_cliente CHAR(10),
    id_medicamento INT,
    padecimiento VARCHAR(50),
    frecuencia CHAR(3),
    paquete CHAR(2),
    via_administracion VARCHAR(10),
    cantidad INT,
    descuento DECIMAL(5,2),

    PRIMARY KEY (cedula_cliente, id_medicamento),

    CONSTRAINT pp_cliente_fk
        FOREIGN KEY (cedula_cliente)
        REFERENCES clientes(cedula),

    CONSTRAINT pp_medicina_fk
        FOREIGN KEY (id_medicamento)
        REFERENCES medicinas(id)
);

INSERT INTO pacientes_permanentes
VALUES('1726367459', 1, 'Dolor', 'DIA', 'SI', 'ORAL', 30, 10.00);
INSERT INTO pacientes_permanentes
values('0912345678', 4, 'Presion', 'DIA', 'NO', 'ORAL', 60, 15.00);

INSERT INTO pacientes_permanentes
values('0923456789', 3, 'Inflamacion', 'SEM', 'SI', 'ORAL', 20, 7.50);

SELECT * FROM pacientes_permanentes;
-- ===============================
-- CLASIFICACIÓN DE MEDICINAS
-- ===============================
CREATE TABLE clasificacion_medicinas (
    id_medicina INT,
    alternativa INT,

    PRIMARY KEY (id_medicina, alternativa),

    CONSTRAINT cm_medicina_fk
        FOREIGN KEY (id_medicina)
        REFERENCES medicinas(id),

    CONSTRAINT cm_alternativa_fk
        FOREIGN KEY (alternativa)
        REFERENCES medicinas(id)
);

INSERT INTO clasificacion_medicinas VALUES (1, 2); -- Paracetamol ↔ Acetaminofen
INSERT INTO clasificacion_medicinas VALUES (2, 1); -- Acetaminofen ↔ Paracetamol
INSERT INTO clasificacion_medicinas VALUES (3, 1); -- Ibuprofeno ↔ Paracetamol
INSERT INTO clasificacion_medicinas VALUES (6, 4); -- Metformina ↔ Losartan

SELECT * FROM clasificacion_medicinas;
-- ===============================
-- PROVEEDORES
-- ===============================
CREATE TABLE proveedor (
    ruc CHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO  proveedor
VALUES('17000000001', 'Bayer Ecuador', 'Luis Mayorga', 'bayer@gmail.com');
INSERT INTO  proveedor
VALUES('17000000002', 'HealthCom', 'adres zotoso', 'soto@gmail.com');

SELECT* FROM proveedor;
-- ===============================
-- PROVEEDOR_MEDICINAS
-- ===============================
CREATE TABLE proveedor_medicinas (
    proveedor_ruc CHAR(13),
    medicina_id INT,
    proveedor_precio DECIMAL(10,2),
    lote INT,
    plazo INT,

    PRIMARY KEY (proveedor_ruc, medicina_id),

    CONSTRAINT proveedor_fk
        FOREIGN KEY (proveedor_ruc)
        REFERENCES proveedor(ruc),

    CONSTRAINT medicina_proveedor_fk
        FOREIGN KEY (medicina_id)
        REFERENCES medicinas(id)
);

INSERT INTO  proveedor_medicinas
VALUES ('17000000001', 1, 0.25, 100, 15);
INSERT INTO  proveedor_medicinas
VALUES ('17000000001', 2, 0.12, 200, 30);
INSERT INTO  proveedor_medicinas
VALUES ('17000000001', 3, 0.32, 300, 7);
INSERT INTO  proveedor_medicinas
VALUES ('17000000001', 1, 0.25, 100, 15);
INSERT INTO  proveedor_medicinas
VALUES ('17000000002', 3, 0.30, 250, 7);

SELECT * FROM proveedor_medicinas

