use AERODATA

insert into AEROPUERTO(id_aeropuerto, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('JRGCHV', 'Jorge Chavez', 'Lima', 'Peru', '3')
insert into AEROPUERTO(id_aeropuerto, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('ELDRDO', 'El Dorado', 'Bogota', 'Colombia', '2')
insert into AEROPUERTO(id_aeropuerto, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('ARMRBE', 'Arturo Martino Benitez', 'Santiago', 'Chile', '2')
insert into AEROPUERTO(id_aeropuerto, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('BNJREZ', 'Benito Juarez', 'Ciudad de Mexico', 'Mexico', '3')
insert into AEROPUERTO(id_aeropuerto, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('ALJVLA', 'Alejandro Velasco Astete', 'Cusco', 'Peru', '2')

select *from AEROPUERTO

insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values ('LAN001', 'LATAM AIRLINES', '3')
insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values ('LAN002', 'SKY AIRLINE', '3')
insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values ('LAN003', 'AZUL', '3')
insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values ('LAN004', 'COPA AIRLINES', '3')
insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values ('LAN005', 'SA AVIANCA', '3')

select *from COMPAÑIA


insert into VUELO(id_vuelo, id_aeropuerto, id_compañia, ciudad_origen, ciudad_destino, precio, 
num_max_pasajeros, num_actu_pasajeros) 
values ('000001','JRGCHV','LAN001','Lima','Londres','600','150','106')
insert into VUELO values ('000002','ELDRDO','LAN001','Bogota','Paris','600','150','106')
insert into VUELO values ('000003','ARMRBE','LAN001','Santiago','Lima','600','150','106')
insert into VUELO values ('000004','JRGCHV','LAN002','Lima','Madrid','600','150','106')
insert into VUELO values ('000005','BNJREZ','LAN002','Ciudad de Mexico','Nueva York','600','150','106')
insert into VUELO values ('000006','ALJVLA','LAN002','Cusco','Lima','600','150','106')
insert into VUELO values ('000007','ELDRDO','LAN003','Bogota','Buenos Aires','600','150','106')
insert into VUELO values ('000008','ARMRBE','LAN003','Santiago','Lisboa','600','150','106')
insert into VUELO values ('000009','BNJREZ','LAN003','Ciudad de Mexico','Ottawa','600','150','106')
insert into VUELO values ('000010','JRGCHV','LAN004','Lima','Londres','600','150','106')
insert into VUELO values ('000011','BNJREZ','LAN004','Ciudad de Mexico','Londres','600','150','106')
insert into VUELO values ('000012','ALJVLA','LAN004','Cusco','Londres','600','150','106')
insert into VUELO values ('000013','.','LAN005','Lima','Londres','600','150','106')
insert into VUELO values ('000014','.','LAN005','Lima','Londres','600','150','106')
insert into VUELO values ('000015','.V','LAN005','Lima','Londres','600','150','106')

select *from VUELO

insert into PASAJERO(id_pasajero, id_vuelo, nombre_pasajero, num_pasaporte, nacionalidad)
values ('000001', '123456', 'Gustavo Coronel', '456789636', 'Chino')

select *from PASAJERO
