# Mysql Code :: 

create schema Projet_BDR;
use projet_bdr;

create table client (
     id_client  varchar(15) NOT NULL,
     nom_client    varchar(15) not null ,
     prenom_client   varchar(15) not null , 
     adresse_client   varchar(20), 
     date_de_naissance date , 
     primary key (id_client) 
     );


create table medcin (
    id_medcin varchar(15) not null , 
    nom_medcin varchar (15) not null ,
    prenom_medcin varchar (15) not null ,
    adresse_medcin  varchar(20) , 
    date_de_naissance date, 
    primary key (id_medcin) 
); 

create table service (
    id_service varchar(10) not null primary key , 
    nom_service varchar(15) not null , 
    id_medcin_respo varchar(15) , 
    foreign key (id_medcin_respo) references medcin(id_medcin)
	on delete set null 
);