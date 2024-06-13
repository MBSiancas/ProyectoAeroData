USE master;
go

IF( EXISTS ( SELECT name FROM master.sys.databases WHERE name = 'AERODATA' ) )
BEGIN
	DROP DATABASE AERODATA;
END;
go

CREATE DATABASE AERODATA;
go

use AERODATA
go

create table AEROPUERTO(
id_aeropuerto char(6) primary key not null,
nombre varchar(50) not null,
ciudad varchar(30) not null,
pais varchar(30) not null,
num_compañias int not null,
)
go

create table EMPLEADO(
id_empleado char(6) primary key not null,
nombre varchar(150) not null,
id_aeropuerto char(6) not null,
fecha_contratacion datetime not null,
salario money not null,
email varchar(100) not null,
telefono char(9) not null,
actividad varchar(20) not null,
foreign key (id_aeropuerto) references AEROPUERTO(id_aeropuerto)
)
go

create table MANTENIMIENTO (
id_mantenimiento char(6) PRIMARY KEY NOT NULL,
id_aeropuerto char(6) NOT NULL,
descripcion varchar(255) NOT NULL,
fecha_inicio datetime NOT NULL,
fecha_fin datetime NOT NULL,
foreign key (id_aeropuerto) references AEROPUERTO(id_aeropuerto)
);
go

create table COMPAÑIA(
id_compañia char(6) primary key not null,
nombre varchar(50) not null,
num_vuelos int not null,
)
go

create table VUELO(
id_vuelo char(6) primary key not null,
id_aeropuerto char(6) not null,
id_compañia char(6) not null,
ciudad_origen varchar(30) not null,
ciudad_destino varchar(30) not null,
fecha datetime not null,
precio money not null,
num_max_pasajeros int not null,
num_actu_pasajeros int not null,
foreign key (id_aeropuerto) references AEROPUERTO(id_aeropuerto),
foreign key (id_compañia) references COMPAÑIA(id_compañia)
)
go

create table PASAJERO(
id_pasajero char(6) primary key not null,
nombre varchar(150) not null,
num_pasaporte char(9) not null,
nacionalidad varchar(30) not null,
num_vuelos int not null,
email varchar(100) not null,
telefono char(9) not null,
)
go

create table RESERVA(
id_reserva char(6) primary key not null,
id_pasajero char(6) not null,
id_vuelo char(6) not null,
fecha_reserva datetime not null,
pago money,
estado varchar(20) not null,
foreign key (id_pasajero) REFERENCES PASAJERO(id_pasajero),
foreign key (id_vuelo) REFERENCES VUELO(id_vuelo)
)
go

use AERODATA

insert into AEROPUERTO(id_aeropuerto, nombre, ciudad, pais, num_compañias)
values 
('JRGCHV', 'Jorge Chavez', 'Lima', 'Peru', '3'),
('ELDRDO', 'El Dorado', 'Bogota', 'Colombia', '3'),
('ARMRBE', 'Arturo Martino Benitez', 'Santiago', 'Chile', '3'),
('BNJREZ', 'Benito Juarez', 'Ciudad de Mexico', 'Mexico', '3'),
('ALJVLA', 'Alejandro Velasco Astete', 'Cusco', 'Peru', '3');

insert into EMPLEADO (id_empleado, nombre, id_aeropuerto, fecha_contratacion, salario, email, telefono, actividad)
values
('EMP001', 'Carlos López', 'JRGCHV', '2020-01-15 08:00:00', 3500.00, 'carloslopez@gmail.com', '955123456', 'ACTIVO'),
('EMP002', 'Laura Martínez', 'ELDRDO', '2018-03-20 09:00:00', 2800.00, 'lauramartinez@gmail.com', '955234567', 'ACTIVO'),
('EMP003', 'Miguel Rodríguez', 'ARMRBE', '2019-07-10 10:00:00', 3000.00, 'miguelrodriguez@gmail.com', '955345678', 'ACTIVO'),
('EMP004', 'Ana Fernández', 'BNJREZ', '2021-05-22 11:00:00', 3200.00, 'anafernandez@gmail.com', '955456789', 'ACTIVO'),
('EMP005', 'José García', 'ALJVLA', '2017-11-18 12:00:00', 3600.00, 'josegarcia@gmail.com', '955567890', 'ACTIVO');

insert into MANTENIMIENTO (id_mantenimiento, id_aeropuerto, descripcion, fecha_inicio, fecha_fin)
values
('MAN001', 'JRGCHV', 'Revisión general de pistas', '2023-01-10 09:00:00', '2023-01-15 17:00:00'),
('MAN002', 'ELDRDO', 'Mantenimiento de sistemas de iluminación', '2023-02-01 08:00:00', '2023-02-03 18:00:00'),
('MAN003', 'ARMRBE', 'Inspección de seguridad en hangares', '2023-03-15 10:00:00', '2023-03-18 16:00:00'),
('MAN004', 'BNJREZ', 'Reparación de la torre de control', '2023-04-05 07:00:00', '2023-04-10 20:00:00'),
('MAN005', 'ALJVLA', 'Actualización del sistema de gestión de vuelos', '2023-05-12 09:00:00', '2023-05-14 19:00:00');

insert into COMPAÑIA(id_compañia, nombre, num_vuelos)
values 
('LAN001', 'LATAM AIRLINES', '3'),
('LAN002', 'SKY AIRLINE', '3'),
('LAN003', 'AZUL', '3'),
('LAN004', 'COPA AIRLINES', '3'),
('LAN005', 'SA AVIANCA', '3');

insert into VUELO(id_vuelo, id_aeropuerto, id_compañia, ciudad_origen, ciudad_destino,
fecha, precio, num_max_pasajeros, num_actu_pasajeros)
values 
('VUE001', 'JRGCHV', 'LAN001', 'Lima', 'Londres', '2023-01-10 08:00:00', 3877.00, 300, 156),
('VUE002', 'ELDRDO', 'LAN001', 'Bogota', 'Paris', '2023-02-15 09:00:00', 2502.00, 250, 136),
('VUE003', 'ARMRBE', 'LAN001', 'Santiago', 'Lima', '2023-03-20 10:00:00', 650.00, 200, 97),
('VUE004', 'JRGCHV', 'LAN002', 'Lima', 'Madrid', '2023-04-25 11:00:00', 2400.00, 230, 159),
('VUE005', 'BNJREZ', 'LAN002', 'Ciudad de Mexico', 'Nueva York', '2023-05-30 12:00:00', 750.00, 300, 235),
('VUE006', 'ALJVLA', 'LAN002', 'Cusco', 'Lima', '2023-06-10 13:00:00', 200.00, 150, 89),
('VUE007', 'ELDRDO', 'LAN003', 'Bogota', 'Buenos Aires', '2023-07-15 14:00:00', 600.00, 200, 106),
('VUE008', 'ARMRBE', 'LAN003', 'Santiago', 'Lisboa', '2023-08-20 15:00:00', 2400.00, 230, 138),
('VUE009', 'BNJREZ', 'LAN003', 'Ciudad de Mexico', 'Ottawa', '2023-09-25 16:00:00', 800.00, 240, 224),
('VUE010', 'JRGCHV', 'LAN004', 'Lima', 'Paris', '2023-10-30 17:00:00', 3500.00, 300, 257),
('VUE011', 'BNJREZ', 'LAN004', 'Ciudad de Mexico', 'Londres', '2023-11-05 18:00:00', 2800.00, 280, 169),
('VUE012', 'ALJVLA', 'LAN004', 'Cusco', 'Londres', '2023-11-20 19:00:00', 3600.00, 200, 98),
('VUE013', 'ELDRDO', 'LAN005', 'Bogota', 'Lima', '2023-12-05 20:00:00', 550.00, 150, 125),
('VUE014', 'ARMRBE', 'LAN005', 'Santiago', 'Caracas', '2023-12-10 21:00:00', 650.00, 200, 108),
('VUE015', 'ALJVLA', 'LAN005', 'Cusco', 'Asuncion', '2023-12-20 22:00:00', 600.00, 230, 168);

insert into PASAJERO(id_pasajero, nombre, num_pasaporte, nacionalidad,
num_vuelos, email, telefono)
values 
('000001', 'Gustavo Coronel', 'PE6789636', 'Peruana', 4, 'gcoronel@gmail.com', '945678965'),
('000002', 'Pedro Gonzales', 'MX7654366', 'Mexicana', 5 , 'pgonzales@gmail.com', '989658743'),
('000003', 'Andrea Fernandez', 'PE4589723', 'Peruana', 6, 'mferna@gmail.com', '987654321'),
('000004', 'Lisbeth Miranda', 'ES9876125', 'Española', 7, 'libmiran@gmail.com', '976543210'),
('000005', 'Angel Ruiz', 'CH3215698', 'Chilena', 4, 'angrz56@gmail.com', '965432109'),
('000006', 'Diego Echebarria', 'CO1428579', 'Colombiana', 9, 'diegrria8@gmail.com', '998765432'),
('000007', 'Justo Montoya', 'PE5328964', 'Peruana', 2, 'justmontoya59@gmail.com', '954321098'),
('000008', 'Anibal Malger', 'UR8764532', 'Uruguaya', 3, 'amlgr5@gmail.com', '943210987'),
('000009', 'Maria Hernandez', 'CO2198765', 'Colombiana', 5, 'mariahernan89@gmail.com', '932109876'),
('000010', 'Chie Hiromoto', 'JP5642317', 'Japonesa', 1, 'hiroch5@gmail.com', '921098765'),
('000011', 'Jose Casas', 'MX3957214', 'Mexicana', 7, 'josecas54@gmail.com', '910987654'),
('000012', 'Fernando Perez', 'ES2583697', 'Española', 8, 'fperez45@gmail.com', '925698467');

insert into RESERVA (id_reserva, id_pasajero, id_vuelo, fecha_reserva, pago, estado)
values
('RES001', '000001', 'VUE001', '2023-06-01 10:00:00', 3877.00, 'Confirmada'),
('RES002', '000002', 'VUE002', '2023-06-02 12:00:00', 2502.00, 'Confirmada'),
('RES003', '000003', 'VUE003', '2023-06-03 14:00:00', 250.00, 'Pendiente'),
('RES004', '000004', 'VUE004', '2023-06-04 16:00:00', 2400.00, 'Cancelada'),
('RES005', '000005', 'VUE005', '2023-06-05 18:00:00', 750.00, 'Confirmada'),
('RES006', '000006', 'VUE011', '2023-06-06 20:00:00', 2800.00, 'Confirmada'),
('RES007', '000007', 'VUE012', '2023-06-07 22:00:00', 1000.00, 'Pendiente'),
('RES008', '000008', 'VUE008', '2023-06-08 09:00:00', 2400.00, 'Confirmada'),
('RES009', '000009', 'VUE009', '2023-06-09 11:00:00', 800.00, 'Confirmada'),
('RES010', '000010', 'VUE010', '2023-06-10 13:00:00', 1500.00, 'Cancelada'),
('RES011', '000011', 'VUE008', '2023-06-11 15:00:00', 2400.00, 'Confirmada'),
('RES012', '000012', 'VUE002', '2023-06-12 17:00:00', 2502.00, 'Confirmada');

select *from AEROPUERTO
select *from EMPLEADO
select *from MANTENIMIENTO
select *from COMPAÑIA
select *from VUELO
select *from PASAJERO
select *from RESERVA
