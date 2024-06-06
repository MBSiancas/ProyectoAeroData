create database AERODATA
go

use AERODATA
go

create table AEROPUERTO(
id_aeropuerto char(6) primary key not null,
nombre_aeropuerto varchar(50) not null,
ciudad varchar(30) not null,
pais varchar(30) not null,
num_compañias int not null,
)
go

create table EMPLEADO(
id_empleado char(6) primary key not null,
nombre_empleado varchar(150) not null,
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
nombre_compañia varchar(50) not null,
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
nombre_pasajero varchar(150) not null,
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
estado varchar(20) not null,
foreign key (id_pasajero) REFERENCES PASAJERO(id_pasajero),
foreign key (id_vuelo) REFERENCES VUELO(id_vuelo)
)
go



