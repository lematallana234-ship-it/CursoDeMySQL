-- Creacion de la base de datos del sistema SaludTotal

-- Creacion de la base de datos
create database SaludTotal;

-- confirmar la creacion de la base de datos

show databases;

use SaludTotal;
-- creacion de tablas
-- crear tabla de medicinas

create table Medicinas
(
    Id int primary key,
    Nombre VARCHAR (100),
    Tipo CHAR (3),
    Precio DECIMAL (15,2),
    Stock int,
    FechaCaducidad datetime
);

show tables;

select * from medicinas;

desc medicinas;

insert into medicinas

values (
    1, 
    'Paracetamol', 
    'GEN',
    1.50, 12,
    '2026-01-01 00:00:00'
);

insert into medicinas
values (
    2, 
    'Acetaminofen', 
    'GEN',
    0.56, 23,
    '2027-01-01 00:00:00'
);

insert into medicinas
values (
    3, 
    'Finalin', 
    'COM',
    2.75, 43,
    '2028-01-01 00:00:00'
);

insert into medicinas
values (
    4, 
    'Losartan', 
    'GEN',
    5.95, 62,
    '2029-01-01 00:00:00'
);

insert into medicinas
values (
    5, 
    'Insulina Glargina', 
    'COM',
    43.25, 98,
    '2028-10-01 00:00:00'
);

insert into medicinas
values (
    6, 
    'Metformina', 
    'GEN',
    4.80, 59,
    '2029-08-17 00:00:00'
);

insert into medicinas
values (
    7, 
    'Levotiroxina', 
    'GEN',
    5.73, 110,
    '2028-12-12 00:00:00'
);

insert into medicinas
values (
    8, 
    'Budesonida', 
    'COM',
    22.31, 74,
    '2030-01-01 00:00:00'
);

insert into medicinas
values (
    9, 
    'Acido Valproico', 
    'GEN',
    9.10, 55,
    '2029-01-01 00:00:00'
);

insert into medicinas
values (
    10, 
    'Dolutegravir', 
    'COM',
    21.50, 96,
    '2030-01-01 00:00:00'
);

insert into medicinas
values (
    11, 
    'Tenofovir', 
    'COM',
    29.87, 84,
    '2029-01-01 00:00:00'
);

insert into medicinas
values (
    12, 
    'Emtricitabina', 
    'COM',
    34.99, 105,
    '2027-10-10 00:00:00'
);

insert into medicinas
values (
    13, 
    'Metotrexato', 
    'GEN',
    8.54, 76,
    '2029-01-01 00:00:00'
);

insert into medicinas
values (
    14, 
    'Enalapril', 
    'GEN',
    5.28, 63,
    '2030-01-01 00:00:00'
);

insert into medicinas
values (
    15, 
    'Levodopa', 
    'COM',
    12.70, 57,
    '2029-01-01 00:00:00'
);

insert into medicinas
values (
    16, 
    'Carbidopa', 
    'COM',
    19.80, 71,
    '2029-05-01 00:00:00'
);

insert into medicinas
values (
    17, 
    'Tylenol', 
    'COM',
    8.24, 61,
    '2029-05-01 00:00:00'
);

insert into medicinas
values (
    18, 
    'Panadol', 
    'COM',
    5.97, 87,
    '2030-05-01 00:00:00'
);

insert into medicinas
values (
    19, 
    'Antihistamínico', 
    'COM',
    4.80, 95,
    '2028-05-01 00:00:00'
);

insert into medicinas
values (
    20, 
    'Cozaar', 
    'COM',
    7.19, 70,
    '2029-12-01 00:00:00'
);

insert into medicinas
values (
    21, 
    'Lantus', 
    'GEN',
    29.80, 47,
    '2029-05-01 00:00:00'
);

insert into medicinas
values (
    22, 
    'Glucophage', 
    'COM',
    5.25, 100,
    '2027-01-01 00:00:00'
);

insert into medicinas
values (
    23, 
    'Synthroid', 
    'COM',
    11.20, 80,
    '2027-01-01 00:00:00'
);

insert into medicinas
values (
    24, 
    'Formoterol', 
    'GEN',
    25.40, 55,
    '2028-01-01 00:00:00'
);

insert into medicinas
values (
    25, 
    'Depakene', 
    'COM',
    11.40, 90,
    '2029-05-01 00:00:00'
);

insert into medicinas
values (
    26, 
    'TDF Generico', 
    'GEN',
    18.80, 94,
    '2028-05-01 00:00:00'
);

insert into medicinas
values (
    27, 
    'FTC generico', 
    'GEN',
    19.50, 140,
    '2029-01-01 00:00:00'
);

insert into medicinas
values (
    28, 
    'DTG generica', 
    'GEN',
    26.48, 103,
    '2028-01-01 00:00:00'
);

insert into medicinas
values (
    29, 
    'Rheumatrex', 
    'COM',
    11.23, 80,
    '2028-12-01 00:00:00'
);

insert into medicinas
values (
    30, 
    'Vasotec', 
    'COM',
    9.50, 60,
    '2030-08-01 00:00:00'
);

insert into medicinas
values (
    31, 
    'Levodopa generica', 
    'GEN',
    8.71, 110,
    '2027-01-01 00:00:00'
);

insert into medicinas
values (
    32, 
    'Carbidopa generica', 
    'GEN',
    12.65, 95,
    '2028-12-01 00:00:00'
);


create table CLientes
(
    Cedula char (10) primary key,
    Nombre VARCHAR (100),
    Apellido VARCHAR (100),
    Tipo CHAR (3),
    Edad int
);

select * from clientes;

insert into clientes
values (
    '1726367459', 
    'Pablo',
    'Cortez',
    'NAT',
    20
);

insert into clientes
values (
    '1710544337', 
    'Marco',
    'Cortez', 
    'JUR',
    56
);

insert into clientes
values (
    '1711932798', 
    'Marcia',
    'Hidalgo', 
    'JUR',
    51
);

insert into clientes
values (
    '1352104851', 
    'Margarita',
    'Dueñaz', 
    'NAT',
    65
);

insert into clientes
values (
    '1752879531', 
    'William',
    'Ortiz', 
    'NAT',
    72
);

insert into clientes
values (
    '2362800765', 
    'Sara',
    'Flores', 
    'NAT',
    87
);

insert into clientes
values (
    '5187403021', 
    'Andrés',
    'Páez', 
    'NAT',
    28
);

#Me permite modificar en los clinetes y i incluir telefono, coreo y direccion
alter table clientes 
add COLUMN email VARCHAR(20);

UPDATE clientes
set email = 'margarita@er.com'
where cedula = '1352104851';

alter table clientes 
add COLUMN telefono VARCHAR(20);

UPDATE clientes
set telefono = '0952146320'
where cedula = '1352104851';
--  --
create table pacientes_permanentes
(
    Cedula_Cliente char (10),
    Padecimiento VARCHAR (50),
    Frecuencia CHAR (3),
    Paquete CHAR (2),
    ID_Medicamento int,
    Via_administracion VARCHAR (10),
    Cantidad int,
    Descuento DECIMAL (5,2)
);

alter table pacientes_permanentes
add CONSTRAINT clientecedula_fk
Foreign Key (cedula_cliente) 
REFERENCES clientes(cedula);

alter table pacientes_permanentes
add CONSTRAINT MedicinaId_fk
Foreign Key (ID_Medicamento)
REFERENCES medicinas(Id);
alter table pacientes_permanentes
add primary KEY (cedula_cliente, ID_Medicamento);

select * from pacientes_permanentes;

insert into pacientes_permanentes

values (
    '1752879531',
    'Hipertension Arterial',
    'MEN',
    'NO',
    4,
    'Oral',
    3,
    34.5
);

insert into pacientes_permanentes
values (
    '1352104851',
    'Diabetes',
    'MEN',
    'NO',
    5,
    'Subcutanea',
    10,
    48.7
);

insert into pacientes_permanentes
values (
    '2362800765',
    'Parkinson',
    '15D',
    'SI',
    15,
    'Oral',
    6,
    25.5
);

show tables;

select * from pacientes_permanentes;

insert into pacientes_permanentes
values (
    '5187403021',
    'Asma Cronica',
    'SEM',
    'NO',
    8,
    'Inhalada',
    7,
    41.7
);

select * from medicinas;

delete from pacientes_permanentes;

create table clasificacion_medicinas 
(
    ID_medicina int,
    Alternativa int,
    primary key (ID_medicina, Alternativa),
    Foreign Key (ID_medicina) REFERENCES medicinas(id),
    Foreign Key (Alternativa) REFERENCES medicinas(id)
);
select * from clasificacion_medicinas;
insert into clasificacion_medicinas
values (
    1,
    17
);
insert into clasificacion_medicinas
values (
    2,
    18
);
insert into clasificacion_medicinas
values (
    3,
    19
);
insert into clasificacion_medicinas
values (
    4,
    20
);
insert into clasificacion_medicinas
values (
    5,
    21
);
insert into clasificacion_medicinas
values (
    6,
    22
);
insert into clasificacion_medicinas
values (
    7,
    23
);
insert into clasificacion_medicinas
values (
    8,
    24
);
insert into clasificacion_medicinas
values (
    9,
    25
);
insert into clasificacion_medicinas
values (
    10,
    26
);
insert into clasificacion_medicinas
values (
    11,
    27
);
insert into clasificacion_medicinas
values (
    12,
    28
);
insert into clasificacion_medicinas
values (
    13,
    29
);
insert into clasificacion_medicinas
values (
    14,
    30
);
insert into clasificacion_medicinas
values (
    15,
    31
);
insert into clasificacion_medicinas
values (
    16,
    32
);

select * from clasificacion_medicinas;

# Creacion de latabla datos de la empresa
CREATE table empresa(
    ruc char (13),
    razonsocial VARCHAR (100),
    direccion VARCHAR(100),
    telefono VARCHAR(14),
    email VARCHAR(25)
);

insert into empresa values ('1754230589', 'Salud Total S.A', 'AV. 10 de agosto', '0996254612', 'jorje234@gmail.com' );

SELECT * FROM empresa;


#Creacion de las tablas de facturas y facturasdetalle
create table facturas(
    facturanumero CHAR(10) PRIMARY key,
    fecha DATE,
    cedula char (10),
    total DECIMAL(15,2)
);

alter table facturas
add constraint facturascedula_fk
Foreign Key (cedula) REFERENCES clientes(cedula);

insert into facturas values(
    '0000000001','2025-12-12', '1352104851', 5.25
);

insert into facturas values(
    '0000000002','2025-12-13', '1726367459', 7.60
);

create table facturadetalle(
    facturanumero char(19),
    medicamento_id int,
    cantidad int,
    precio decimal(15,2)
);
#validacion de clave primaria
alter Table facturadetalle
add PRIMARY key (facturanumero, medicamento_id);

alter TABLE facturadetalle
add constraint facturadetalle_cantidad_ck
check (cantidad > 0);

alter TABLE facturadetalle
add constraint facturadetalle_precio_ck
check (precio > 0);

insert into facturadetalle VALUES('0000000001', 1, 12, 1.50);

insert into facturadetalle VALUES(
    '0000000001', 2, 12, 0.56
);

insert into facturadetalle VALUES(
    '0000000002', 3, 12, 2.75
);

insert into facturadetalle VALUES(
    '0000000002',4 , 12, 5.92
);

SELECT * FROM facturadetalle

-- hola

