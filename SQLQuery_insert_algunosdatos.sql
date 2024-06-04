use AERODATA

insert into AEROPUERTO(id_aeropuerto, id_tipo, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('JRGCHV', '01', 'Jorge Chavez', 'Lima', 'Peru', '10')
insert into AEROPUERTO(id_aeropuerto, id_tipo, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('ELDRDO', '01', 'El Dorado', 'Bogota', 'Colombia', '8')
insert into AEROPUERTO(id_aeropuerto, id_tipo, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('ARMRBE', '01', 'Arturo Martino Benitez', 'Santiago', 'Chile', '10')
insert into AEROPUERTO(id_aeropuerto, id_tipo, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('ELVALR', '02', 'El Valor', 'Amazonas', 'Peru', '10')
insert into AEROPUERTO(id_aeropuerto, id_tipo, nombre_aeropuerto, ciudad, pais, num_compañias)
values ('KITENI', '02', 'Kiteni', 'Cusco', 'Peru', '10')



select *from AEROPUERTO

insert into COMPAÑIA(id_compañia, nombre_compañia, num_vuelos)
values ('LAN001', 'LATAM Airlines', '3')

select *from COMPAÑIA


insert into VUELO(id_vuelo, id_aeropuerto, id_compañia,
ciudad_origen, ciudad_destino, precio,
num_max_pasajeros, num_actu_pasajeros)
values ('123456','JRGCHV','LAN001','Lima','Londres','600','40','35')

select *from VUELO

insert into PASAJERO(id_pasajero, id_vuelo, nombre_pasajero, num_pasaporte, nacionalidad)
values ('000001', '123456', 'Gustavo Coronel', '456789636', 'Chino')

select *from PASAJERO


insert into TIPOAEROPUERTO(id_tipo,tipo_aeropuerto)
values('01','PUBLICO')
insert into TIPOAEROPUERTO(id_tipo,tipo_aeropuerto)
values('02','PRIVADO')

select *from TIPOAEROPUERTO
