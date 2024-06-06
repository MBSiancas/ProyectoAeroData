use AERODATA

insert into AEROPUERTO(id_aeropuerto, nombre_aeropuerto, ciudad, pais, num_compañias)
values 
('JRGCHV', 'Jorge Chavez', 'Lima', 'Peru', '3'),
('ELDRDO', 'El Dorado', 'Bogota', 'Colombia', '3'),
('ARMRBE', 'Arturo Martino Benitez', 'Santiago', 'Chile', '3'),
('BNJREZ', 'Benito Juarez', 'Ciudad de Mexico', 'Mexico', '3'),
('ALJVLA', 'Alejandro Velasco Astete', 'Cusco', 'Peru', '3');

select *from AEROPUERTO

insert into EMPLEADO (id_empleado, nombre_empleado, id_aeropuerto, fecha_contratacion, salario, email, telefono, actividad)
values
('EMP001', 'Carlos López', 'JRGCHV', '2020-01-15 08:00:00', 3500.00, 'carloslopez@gmail.com', '955123456', 'ACTIVO'),
('EMP002', 'Laura Martínez', 'ELDRDO', '2018-03-20 09:00:00', 2800.00, 'lauramartinez@gmail.com', '955234567', 'ACTIVO'),
('EMP003', 'Miguel Rodríguez', 'ARMRBE', '2019-07-10 10:00:00', 3000.00, 'miguelrodriguez@gmail.com', '955345678', 'ACTIVO'),
('EMP004', 'Ana Fernández', 'BNJREZ', '2021-05-22 11:00:00', 3200.00, 'anafernandez@gmail.com', '955456789', 'ACTIVO'),
('EMP005', 'José García', 'ALJVLA', '2017-11-18 12:00:00', 3600.00, 'josegarcia@gmail.com', '955567890', 'ACTIVO');

select *from EMPLEADO

insert into MANTENIMIENTO (id_mantenimiento, id_aeropuerto, descripcion, fecha_inicio, fecha_fin)
values
('MAN001', 'JRGCHV', 'Revisión general de pistas', '2023-01-10 09:00:00', '2023-01-15 17:00:00'),
('MAN002', 'ELDRDO', 'Mantenimiento de sistemas de iluminación', '2023-02-01 08:00:00', '2023-02-03 18:00:00'),
('MAN003', 'ARMRBE', 'Inspección de seguridad en hangares', '2023-03-15 10:00:00', '2023-03-18 16:00:00'),
('MAN004', 'BNJREZ', 'Reparación de la torre de control', '2023-04-05 07:00:00', '2023-04-10 20:00:00'),
('MAN005', 'ALJVLA', 'Actualización del sistema de gestión de vuelos', '2023-05-12 09:00:00', '2023-05-14 19:00:00');

select *from MANTENIMIENTO

insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values 
('LAN001', 'LATAM AIRLINES', '3'),
('LAN002', 'SKY AIRLINE', '3'),
('LAN003', 'AZUL', '3'),
('LAN004', 'COPA AIRLINES', '3'),
('LAN005', 'SA AVIANCA', '3')

select *from COMPAÑIA


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

select *from VUELO

insert into PASAJERO(id_pasajero, nombre_pasajero, num_pasaporte, nacionalidad,
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
('000012', 'Fernando Perez', 'ES2583697', 'Española', 8, 'fperez45@gmail.com', '925698467')

select *from PASAJERO

insert into RESERVA (id_reserva, id_pasajero, id_vuelo, fecha_reserva, estado)
values
('RES001', '000001', 'VUE001', '2023-06-01 10:00:00', 'Confirmada'),
('RES002', '000002', 'VUE002', '2023-06-02 12:00:00', 'Confirmada'),
('RES003', '000003', 'VUE003', '2023-06-03 14:00:00', 'Pendiente'),
('RES004', '000004', 'VUE004', '2023-06-04 16:00:00', 'Cancelada'),
('RES005', '000005', 'VUE005', '2023-06-05 18:00:00', 'Confirmada'),
('RES006', '000006', 'VUE011', '2023-06-06 20:00:00', 'Confirmada'),
('RES007', '000007', 'VUE012', '2023-06-07 22:00:00', 'Pendiente'),
('RES008', '000008', 'VUE008', '2023-06-08 09:00:00', 'Confirmada'),
('RES009', '000009', 'VUE009', '2023-06-09 11:00:00', 'Confirmada'),
('RES010', '000010', 'VUE010', '2023-06-10 13:00:00', 'Cancelada'),
('RES011', '000011', 'VUE008', '2023-06-11 15:00:00', 'Confirmada'),
('RES012', '000012', 'VUE002', '2023-06-12 17:00:00', 'Confirmada');

select *from RESERVA



select *from PASAJERO
