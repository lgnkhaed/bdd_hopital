# Mysql Code ::

## creating tables ::::::
``` sql
create schema Projet_BDR;
use projet_bdr;

create table client (
     id_client  int auto_increment  NOT NULL,
     nom_client    varchar(15) not null ,
     prenom_client   varchar(15) not null , 
     adresse_client   varchar(20), 
     date_de_naissance date , 
     primary key (id_client) 
     );


create table medcin (
    id_medcin int auto_increment  not null , 
    nom_medcin varchar (15) not null ,
    prenom_medcin varchar (15) not null ,
    adresse_medcin  varchar(20) , 
    date_de_naissance date, 
    primary key (id_medcin) 
); 

create table service (
    id_service int auto_increment not null primary key , 
    nom_service varchar(15) not null , 
    id_medcin_respo int  , 
    foreign key (id_medcin_respo) references medcin(id_medcin)
	on delete set null 
);

create table chambre (
   id_chambre int auto_increment  not null primary key ,
   etage int not null , 
   nbrlits int not null ,   
   cout_journee  decimal(10,2)  not null, 
   id_service int  ,
   foreign key (id_service) references service(id_service)
   on delete set null  
);
  

create table place ( 
  id_place int  not null primary key , 
  id_chambre varchar(10)  , 
  foreign key (id_chambre) references chambre(id_chambre)
  on delete set null 
);

create table categorie( 
   id_categorie int auto_increment  not null primary key , 
   nom_categorie varchar(20)
);

create table sejour(
   id_sejour int auto_increment  not null primary key , 
   date_debut_sejour   date  not null , 
   date_fin_sejour date not null ,  
   id_client int not null , 
   foreign key (id_client) references client(id_client) ,
   id_medcin int  not null , 
   foreign key (id_medcin) references medcin(id_medcin),
   id_place int not null , 
   foreign key (id_place) references place(id_place)
);


create table intervention (
  id_intervention int auto_increment  not null primary key , 
  id_sejour  int  not null , 
  foreign key (id_sejour) references sejour(id_sejour) , 
  id_categorie int ,
  foreign key (id_categorie) references categorie(id_categorie) 
);


create table medcin_service (
    id_service int  not null  ,
    foreign key (id_service) references service(id_service), 
    id_medcin int  not null , 
    foreign key (id_medcin) references medcin(id_medcin) 
);

alter table chambre 
add constraint verif_nbr_lits Check (nbrlits <= 10) ; 

```

## inserting Values :: 

``` sql 
insert into client(nom_client , prenom_client , adresse_client , date_de_naissance )
 values
 ('khaled','laggoun','limoges','2004-08-01'),
 ('aboud','laggoun','alger','2013-11-04'),
 ('aymen','laggoun','alger','2009-10-10'),
  ('Smith', 'John', 'New York', '1990-01-15'),
('Johnson', 'Emily', 'Los Angeles', '1985-06-20'),
('Brown', 'Michael', 'London', '1982-11-05'),
('Williams', 'Sarah', 'Manchester', '1994-02-28'),
('Jones', 'David', 'Sydney', '1988-09-12'),
('Davis', 'Laura', 'Melbourne', '1991-03-18'),
('Miller', 'James', 'Toronto', '1980-12-03'),
('Wilson', 'Linda', 'Vancouver', '1993-07-25'),
('Moore', 'Robert', 'Berlin', '1987-08-30'),
('Manon', 'Bouchard', 'Limoges', '1998-01-31');
 
 
 insert into medcin(nom_medcin, prenom_medcin, adresse_medcin, date_de_naissance)
values
('Garcia', 'Carlos', 'Madrid', '1979-05-22'),
('Peterson', 'Liam', 'Oslo', '1983-11-16'),
('Guedourra', 'Sara Leila', 'Alger', '2005-03-28'),
('Lopez', 'Maria', 'Barcelona', '1985-04-30'),
('Schmidt', 'Jan', 'Berlin', '1980-12-12'),
('Kim', 'Jiwoo', 'Seoul', '1992-03-21'),
('Fischer', 'Anna', 'Zurich', '1987-02-25'),
('Martinez', 'Pablo', 'Buenos Aires', '1995-01-11'),
('Rossi', 'Giovanni', 'Rome', '1988-08-03'),
('Santos', 'Paula', 'Lisbon', '1991-06-17'),('Smith', 'John', 'New York', '1976-02-15'),
('Brown', 'Emily', 'London', '1984-06-28'),
('Williams', 'James', 'Sydney', '1990-09-12'),
('Jones', 'Olivia', 'Toronto', '1988-11-22'),
('Miller', 'Michael', 'Los Angeles', '1982-07-04'),
('Davis', 'Isabella', 'Paris', '1994-01-09'),
('Martinez', 'Carlos', 'Madrid', '1986-12-30'),
('Hernandez', 'Antonio', 'Mexico City', '1975-05-06'),
('Gonzalez', 'Sofia', 'Miami', '1990-08-18'),
('Perez', 'David', 'Buenos Aires', '1989-10-25');

 
 
 insert into categorie (nom_categorie) 
values 
('chirurgie'),
('radiologie'),
('Appendicectomie'),
('Cholécystectomie'),
('Prostatectomie'),
('Hystérectomie'),
('Chirurgie'),
('cardiaque'),
('Arthroplastie'),
('hanche'),
('Craniotomie'),
('Chirurgie'),
('bariatrique'),
('Hernie'),
('inguinale'),
('Césarienne'),
('Mastectomie'),
('Réduction'),
('fracture'),
('Liposuccion'),
('Résection'),
('intestinale'),
('Nephrectomie'),
('Radiologie'),
('Radiographie'),
('Scanner'),
('Tomodensitométrie'),
('IRM'),
('Échographie'),
('Angiographie'),
('Mammographie'),
('Fibroscopie'),
('Radiothérapie'),
('Tomographie'),
('TEP'),
('Densitométrie'),
('Médecine'),
('interne'),
('Cardiologie'),
('Endoscopie'),
('Dialyse'),
('Bronchoscopie'),
('Fibroscopie'),
('pulmonaire'),
('Rééducation'),
('respiratoire'),
('Tests'),
('allergiques');



insert into service (nom_service, id_medcin_respo) 
values 
('Urgences', 1),
('Chirurgie', 9),
('Médecine générale', 2),
('Radiologie', 8),
('Pédiatrie', 5),
('Cardiologie', 6),
('Neurologie', 7),
('Psychiatrie', 8),
('Oncologie', 12),
('Dentisterie', 3),
('Pharmacie', 11),
('Hématologie', 16),
('Ophtalmologie', 5);


insert into chambre(etage, nbrlits, cout_journee, id_service)
values
(1, 2, 100, 1),
(1, 2, 100, 1),
(1, 3, 120, 1),
(1, 3, 120, 1),
(1, 2, 110, 1),
(1, 2, 110, 1),

(2, 2, 130, 2),
(2, 2, 130, 2),
(2, 3, 140, 2),
(2, 3, 140, 2),
(2, 2, 135, 2),
(2, 2, 135, 2),

(3, 2, 150, 3),
(3, 2, 150, 3),
(3, 3, 160, 3),
(3, 3, 160, 3),
(3, 2, 155, 3),
(3, 2, 155, 3),

(4, 2, 120, 4),
(4, 2, 120, 4),
(4, 3, 130, 4),
(4, 3, 130, 4),
(4, 2, 125, 4),
(4, 2, 125, 4),

(5, 2, 140, 5),
(5, 2, 140, 5),
(5, 3, 150, 5),
(5, 3, 150, 5),
(5, 2, 145, 5),
(5, 2, 145, 5),

(6, 2, 160, 6),
(6, 2, 160, 6),
(6, 3, 170, 6),
(6, 3, 170, 6),
(6, 2, 165, 6),
(6, 2, 165, 6),

(7, 2, 180, 7),
(7, 2, 180, 7),
(7, 3, 190, 7),
(7, 3, 190, 7),
(7, 2, 185, 7),
(7, 2, 185, 7),

(8, 2, 130, 8),
(8, 2, 130, 8),
(8, 3, 140, 8),
(8, 3, 140, 8),
(8, 2, 135, 8),
(8, 2, 135, 8),

(9, 2, 150, 9),
(9, 2, 150, 9),
(9, 3, 160, 9),
(9, 3, 160, 9),
(9, 2, 155, 9),
(9, 2, 155, 9),

(10, 2, 120, 10),
(10, 2, 120, 10),
(10, 3, 130, 10),
(10, 3, 130, 10),
(10, 2, 125, 10),
(10, 2, 125, 10),

(11, 2, 140, 11),
(11, 2, 140, 11),
(11, 3, 150, 11),
(11, 3, 150, 11),
(11, 2, 145, 11),
(11, 2, 145, 11),

(12, 2, 160, 12),
(12, 2, 160, 12),
(12, 3, 170, 12),
(12, 3, 170, 12),
(12, 2, 165, 12),
(12, 2, 165, 12),

(13, 2, 180, 13),
(13, 2, 180, 13),
(13, 3, 190, 13),
(13, 3, 190, 13),
(13, 2, 185, 13),
(13, 2, 185, 13);








```