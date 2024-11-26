# Mysql Code ::

## creating tables ::::::
``` sql
create schema Projet_BDR;
use projet_bdr;




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
  id_place int auto_increment not null primary key , 
  id_chambre int  , 
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

create table intervention_sejour (
    id_sejour int primary key not null , 
    foreign key (id_sejour) references intervention(id_sejour),
    id_intervention int  not null , 
    foreign key (id_intervention) references intervention(id_intervention)
);


alter table intervention 
add column cout_inter decimal(10,2);


alter table chambre 
add constraint verif_nbr_lits Check (nbrlits <= 10) ; 

create table intervention_medcin (
    id_inter int primary key not null , 
    foreign key (id_inter) references  intervention(id_intervention),
    id_medcin int not null , 
    foreign key (id_medcin) references medcin(id_medcin)
);


set foreign_key_checks = 0 ;
ALTER TABLE intervention_medcin DROP PRIMARY KEY;
ALTER TABLE intervention_medcin ADD PRIMARY KEY (id_inter, id_medcin);
set foreign_key_checks = 1 ;

set foreign_key_checks = 0 ;
ALTER TABLE intervention_sejour DROP PRIMARY KEY;
ALTER TABLE intervention_sejour ADD PRIMARY KEY (id_intervention, id_sejour);
set foreign_key_checks = 1 ;

drop table intervention_sejour; 


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
('opération hernie discale'),
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
('bariatrique'),
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
('Radiothérapie');



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


insert into place(id_chambre) 
values 
(1),(1),(2),(2),(3),(3),(3),(4),(4),(4),(5),(5),(6),(6),(7),(7),(8),(8),(9),(9),(9),(10),(10),(10),(11),(11),(12),(12),(13),(13),
(14),(14),
(15),(15),(15), 
(16),(16),(16), 
(17),(17), 
(18),(18), 
(19),(19),
(20),(20), 
(21),(21),(21),
(22),(22),(22),
(23),(23), 
(24),(24), 
(25),(25), 
(26),(26), 
(27),(27),(27), 
(28),(28),(28), 
(29),(29), 
(30),(30),
(31),(31), 
(32),(32), 
(33),(33),(33),
(34),(34),(34),
(35),(35), 
(36),(36),
(37),(37),
(38),(38), 
(39),(39),(39), 
(40),(40),(40), 
(41),(41), 
(42),(42), 
(43),(43), 
(44),(44),
(45),(45),(45), 
(46),(46),(46), 
(47),(47), 
(48),(48), 
(49),(49), 
(50),(50),
(51),(51),(51),
(52),(52),(52),
(53),(53), 
(54),(54), 
(55),(55), 
(56),(56), 
(57),(57),(57), 
(58),(58),(58),
(59),(59), 
(60),(60), 
(61),(61), 
(62),(62),
(63),(63),(63),
(64),(64),(64), 
(65),(65), 
(66),(66), 
(67),(67), 
(68),(68), 
(69),(69),(69),
(70),(70),(70),
(71),(71), 
(72),(72), 
(73),(73), 
(74),(74), 
(75),(75),(75),
(76),(76),(76),
(77),(77), 
(78),(78); 

insert into sejour(date_debut_sejour ,date_fin_sejour,id_client,id_medcin,id_place)
values 
('2024-09-01','2024-09-02',1,1,1),
('2024-09-05', '2024-09-06', 3, 3, 3),
('2024-09-07', '2024-09-08', 4, 4, 4),
('2024-09-09', '2024-09-10', 5, 5, 5),
('2024-09-11', '2024-09-12', 6, 6, 6),
('2024-09-13', '2024-09-14', 7, 7, 7),
('2024-09-15', '2024-09-16', 8, 8, 8),
('2024-09-17', '2024-09-18', 9, 9, 9),
('2024-09-19', '2024-09-20', 10, 10, 10);


INSERT INTO medcin_service (id_medcin, id_service)
VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
(6, 2), (7, 2), (8, 2), (9, 2), (10, 2),
(11, 3), (12, 3), (2, 3), (14, 3), (15, 3),
(16, 4), (17, 4), (8, 4), (19, 4), (20, 4),
(1, 5), (2, 5), (3, 5), (4, 5), (5, 5),
(6, 6), (7, 6), (8, 6), (9, 6), (10, 6),
(11, 7), (7, 7), (13, 7), (14, 7), (15, 7),
(16, 8), (17, 8), (8, 8), (19, 8), (20, 8),
(1, 9), (12, 9), (3, 9), (4, 9), (5, 9),
(6, 10), (3, 10), (8, 10), (9, 10), (10, 10),
(11, 11), (12, 11), (13, 11), (14, 11), (15, 11),
(16, 12), (17, 12), (18, 12), (19, 12), (20, 12),
(1, 13), (2, 13), (3, 13), (4, 13), (5, 13);


INSERT INTO intervention (id_sejour, id_categorie, cout_inter)
VALUES
(1, 5, 300), (1, 12, 450), (1, 25, 700),
(2, 8, 250), (2, 18, 600), (2, 33, 800), (2, 45, 750), (2, 21, 400),
(3, 10, 500), (3, 28, 670),
(4, 3, 200), (4, 15, 450), (4, 27, 640), (4, 35, 750),
(5, 26, 600),
(6, 6, 350), (6, 14, 400), (6, 32, 700), (6, 41, 850), (6, 9, 300),
(7, 2, 150), (7, 13, 300), (7, 24, 550),
(8, 17, 420), (8, 29, 680), (8, 36, 750), (8, 43, 800),
(9, 4, 270), (9, 20, 600);

INSERT INTO intervention_medcin (id_inter, id_medcin)
VALUES
(69, 1), (69, 2),
(70, 3), (70, 4),
(71, 5), (71, 6),
(72, 7), (72, 8),
(73, 9), (73, 10),
(74, 11), (74, 12),
(75, 13), (75, 14),
(76, 15), (76, 16),
(77, 17), (77, 18),
(78, 19), (78, 20),
(79, 1), (79, 3),
(80, 2), (80, 4),
(81, 5), (81, 7),
(82, 6), (82, 8),
(83, 9), (83, 11),
(84, 10), (84, 12),
(85, 13), (85, 15),
(86, 14), (86, 16),
(87, 17), (87, 19),
(88, 18), (88, 20),
(89, 1), (89, 5),
(90, 2), (90, 6),
(91, 3), (91, 7),
(92, 4), (92, 8),
(93, 5), (93, 9),
(94, 6), (94, 10),
(95, 7), (95, 11),
(96, 8), (96, 12),
(97, 9), (97, 13);





```
# updating the table client to add the Boolean option 
```sql 
alter table client 
add column boursier Boolean;


select * from client ; 

UPDATE client
SET boursier = true
WHERE id_client IN (1, 6, 3, 11, 13);



UPDATE client 
SET boursier = false 
WHERE boursier IS NOT TRUE AND id_client > 0;



```