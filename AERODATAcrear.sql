create database AERODATA

use AERODATA

create table AEROPUERTO(
id_aeropuerto char(6) primary key not null,
id_tipo char(2) not null,
nombre_aeropuerto varchar(50) not null,
ciudad varchar(30) not null,
pais varchar(30) not null,
num_compa�ias int not null,
)

create table COMPA�IA(
id_compa�ia char(6) primary key not null,
nombre_compa�ia varchar(50) not null,
num_vuelos int not null,
)

create table VUELO(
id_vuelo char(6) primary key not null,
id_aeropuerto char(6) not null,
id_compa�ia char(6) not null,
ciudad_origen varchar(30) not null,
ciudad_destino varchar(30) not null,
precio money not null,
num_max_pasajeros int not null,
num_actu_pasajeros int not null,
)

create table PASAJERO(
id_pasajero char(6) primary key not null,
id_vuelo char(6) not null,
nombre_pasajero varchar(150) not null,
num_pasaporte char(9) not null,
nacionalidad varchar(30) not null,
)

create table TIPOAEROPUERTO(
id_tipo char(2) primary key not null,
tipo_aeropuerto varchar(20) not null
)

alter table AEROPUERTO
add foreign key (id_tipo) references TIPOAEROPUERTO(id_tipo)

alter table VUELO
add foreign key (id_aeropuerto) references AEROPUERTO(id_aeropuerto)

alter table VUELO
add foreign key (id_compa�ia) references COMPA�IA(id_compa�ia)

alter table PASAJERO
add foreign key (id_vuelo) references VUELO(id_vuelo)

