use AERODATA

insert into VUELO(id_vuelo, id_aeropuerto, id_compañia,
ciudad_origen, ciudad_destino, precio,
num_max_pasajeros, num_actu_pasajeros)
values ('123456','JRGCHV','LAN001','Lima','Londres','600','40','35')

select *from AEROPUERTO


insert into TIPOAEROPUERTO(id_tipo,tipo_aeropuerto)
values('01','PUBLICO')
insert into TIPOAEROPUERTO(id_tipo,tipo_aeropuerto)
values('02','PRIVADO')

select *from TIPOAEROPUERTO