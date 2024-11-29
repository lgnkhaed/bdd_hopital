create schema projet_bdr2;
use projet_bdr2;

create table client (
     id_client  varchar(20) primary key   NOT NULL,
     nom_client    varchar(25) not null ,
     prenom_client   varchar(25) not null , 
     adresse_client   varchar(20), 
     date_de_naissance date , 
     boursier Boolean 
);

create table medcin (
    id_medcin varchar(20)  primary key  not null , 
    nom_medcin varchar (25) not null ,
    prenom_medcin varchar (25) not null ,
    adresse_medcin  varchar(20) , 
    date_de_naissance date,
    prix_inter decimal(10,2) 

    ); 
    
    
create table service (
    id_service int auto_increment not null primary key , 
    nom_service varchar(25) not null , 
    id_medcin_respo  varchar(20)  , 
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
   on delete cascade 
);

create table place ( 
  id_place int auto_increment not null primary key , 
  id_chambre int  , 
  foreign key (id_chambre) references chambre(id_chambre)
  on delete cascade
);


create table categorie( 
   id_categorie int auto_increment  not null primary key , 
   nom_categorie varchar(50),
   id_service int ,
   foreign key (id_service) references service(id_service)
);


create table sejour(
   id_sejour varchar(10)  not null primary key , 
   date_debut_sejour   date  not null , 
   date_fin_sejour date not null ,  
   id_client varchar(20) not null , 
   foreign key (id_client) references client(id_client) ,
   id_medcin varchar(20)  not null , 
   foreign key (id_medcin) references medcin(id_medcin),
   id_place int not null , 
   foreign key (id_place) references place(id_place)
);

create table intervention (
  id_intervention int auto_increment  not null , 
  id_sejour  varchar(10)  not null , 
  foreign key (id_sejour) references sejour(id_sejour) , 
  id_categorie int ,
  foreign key (id_categorie) references categorie(id_categorie) ,
  cout_intervention decimal(10,2) ,
  primary key (id_intervention)
  
);

create table medcin_service (
    id_service int  not null  ,
    foreign key (id_service) references service(id_service), 
    id_medcin varchar(20)  not null , 
    foreign key (id_medcin) references medcin(id_medcin) ,
    primary key (id_service,id_medcin)
);


create table intervention_medcin (
    id_inter int  not null , 
    foreign key (id_inter) references  intervention(id_intervention),
    id_medcin varchar(20) not null , 
    foreign key (id_medcin) references medcin(id_medcin),
    primary key (id_inter , id_medcin ) 
);


-- insertion 

INSERT INTO client (id_client, nom_client, prenom_client, adresse_client, date_de_naissance,boursier)
VALUES
('C234' , 'Hamiti' , 'Amine','Canada', '2005-01-04', true),
('C123', 'laggoun', 'khaled', 'limoges', '2004-08-01',false ),
('C001', 'laggoun', 'aboud', 'alger', '2013-11-04',true ),
('C002', 'laggoun', 'aymen', 'alger', '2009-10-10',true ),
('C003', 'Smith', 'John', 'New York', '1990-01-15',true ),
('C004', 'Johnson', 'Emily', 'Los Angeles', '1985-06-20',true),
('C005', 'Brown', 'Michael', 'London', '1982-11-05',true),
('C006', 'Williams', 'Sarah', 'Manchester', '1994-02-28',true),
('C007', 'Jones', 'David', 'Sydney', '1988-09-12',false),
('C008', 'Davis', 'Laura', 'Melbourne', '1991-03-18',false),
('C009', 'Miller', 'James', 'Toronto', '1980-12-03',false),
('C010', 'Wilson', 'Linda', 'Vancouver', '1993-07-25',false),
('C011', 'Moore', 'Robert', 'Berlin', '1987-08-30',false),
('C012', 'Bouchard', 'Manon', 'Limoges', '1998-01-31',false);



INSERT INTO medcin (id_medcin, nom_medcin, prenom_medcin, adresse_medcin, date_de_naissance, prix_inter)
VALUES
('M000', 'Dupond', 'Carlos', 'Madrid', '1979-05-22',40.00),
('M001', 'Durant', 'Liam', 'Oslo', '1983-11-16',50.00),
('M002', 'Guedourra', 'Sara Leila', 'Alger', '2005-03-28',40.00),
('M003', 'Lopez', 'Maria', 'Barcelona', '1985-04-30',50.00),
('M004', 'Schmidt', 'Jan', 'Berlin', '1980-12-12',40.00),
('M005', 'Kim', 'Jiwoo', 'Seoul', '1992-03-21',50.00),
('M006', 'Fischer', 'Anna', 'Zurich', '1987-02-25',40.00),
('M007', 'Martinez', 'Pablo', 'Buenos Aires', '1995-01-11',50.00),
('M008', 'Rossi', 'Giovanni', 'Rome', '1988-08-03',40.00),
('M009', 'Santos', 'Paula', 'Lisbon', '1991-06-17',50.00),
('M010', 'Smith', 'John', 'New York', '1976-02-15',40.00),
('M011', 'Brown', 'Emily', 'London', '1984-06-28',50.00),
('M012', 'Williams', 'James', 'Sydney', '1990-09-12',40.00);





insert into service (nom_service, id_medcin_respo) 
values 
('Urgences', 'M000'),
('Chirurgie', 'M001'),
('Médecine générale','M003'),
('Radiologie', 'M004'),
('Pédiatrie', 'M005'),
('Cardiologie', 'M006'),
('Neurologie', 'M007'),
('Psychiatrie', 'M008'),
('Oncologie', 'M009'),
('Dentisterie', 'M002'),
('Pharmacie', 'M010'),
('Hématologie', 'M011'),
('Ophtalmologie', 'M012');

insert into categorie (nom_categorie,id_service) 
values 
('opération hernie discale',2),
('IRM',4);

insert into chambre(etage, nbrlits, cout_journee, id_service)
values
(1, 2, 100, 1),
(1, 2, 100, 1),
(2, 2, 130, 2),
(3, 2, 130, 2),
(3, 2, 150, 3),
(3, 2, 150, 3),
(4, 2, 120, 4),
(2, 2, 120, 4),
(5, 2, 140, 5),
(4, 2, 140, 5),
(6, 2, 160, 6),
(5, 2, 160, 6),
(7, 2, 180, 7),
(1, 2, 180, 7),
(8, 2, 130, 8),
(7, 2, 130, 8),
(9, 2, 150, 9),
(3, 2, 150, 9),
(10, 2, 120, 10),
(8, 2, 120, 10),
(11, 2, 140, 11),
(4, 2, 150, 11),
(2, 2, 160, 12),
(1, 2, 160, 12),
(1, 2, 180, 13),
(3, 2, 180, 13);


INSERT INTO place (id_chambre)
VALUES 
(1), (1),
(2), (2),
(3), (3),
(4), (4),
(5), (5),
(6), (6),
(7), (7),
(8), (8),
(9), (9),
(10), (10),
(11), (11),
(12), (12),
(13), (13),
(14), (14),
(15), (15),
(16), (16),
(17), (17),
(18), (18),
(19), (19),
(20), (20),
(21), (21),
(22), (22),
(23), (23),
(24), (24),
(25), (25),
(26), (26);


insert into sejour 
values
('S123' , '2024-09-01','2024-09-04' , 'C234' , 'M001' , 1),
('S001','2022-08-01','2022-08-04','C123','M002',10),
('S002','2023-04-01','2023-04-04','C001','M005',12),
('S003' , '2020-08-06', '2020-08-08','C003','M000',8),
('S004' , '2021-01-29', '2021-02-04','C003','M000',9),
('S005' , '2022-01-15', '2022-01-20','C005','M000',11),
('S006' , '2023-01-15', '2023-01-18','C005','M000',15),
('S007' , '2023-02-10', '2023-02-13','C007','M000',19),
('S008' , '2024-02-18', '2023-02-21','C007','M007',14);


INSERT INTO intervention ( id_sejour, id_categorie, cout_intervention)
VALUES
( 'S123', 1, 150.00),
( 'S123', 2, 200.00),
( 'S123', 1, 300.00),
( 'S123', 2, 400.00),
('S001',2,2500.00), 
('S002',1,2500.00);


insert into medcin_service(id_service, id_medcin) 
values (1,'M000'),
     (1,'M012'),
     (2,'M001'),
     (2,'M011'),
     (3,'M003'),
     (3,'M010'),
     (4,'M004'),
     (4,'M009'),
     (5,'M005'),
     (5,'M008'),
     (6,'M006'),
     (6,'M007'),
     (7,'M007'),
     (7,'M001'),
     (8,'M008'),
     (8,'M001'),
     (9,'M009'),
     (9,'M003'),
     (10,'M002'),
     (10,'M010'),
     (11,'M010'),
     (12,'M011'),
     (13,'M012'),
     (2,'M002'),
     (2,'M005'),
     (2,'M008'),
     (2,'M009');
     
-- faut modifier ça aussi 
 insert into intervention_medcin(id_inter , id_medcin ) 
values 
(1,'M001'),
(1,'M003'),
(2,'M004'),
(2,'M009'),
(4,'M004'),
(4,'M009'),
(5,'M004'),
(5,'M009'),
(3,'M011'),
(3,'M001'),
(6,'M001'),
(6,'M005');
 

create view medecin_service as 
    select s.id_service , s.nom_service , m.id_medcin , m.nom_medcin 
    from service s 
    join  medcin_service ms using ( id_service)
    join medcin m  using (id_medcin);


create view vue_intervention_medcin as 
select m.id_medcin , m.nom_medcin , m.prenom_medcin , im.id_inter, i.id_categorie , c.nom_categorie
from medcin m 
join intervention_medcin im  using (id_medcin) 
join intervention i on i.id_intervention = im.id_inter
join categorie c using (id_categorie) ;


create view vue_sejour_medecin_client as 
select m.id_medcin , m.nom_medcin , s.id_sejour , c.id_client , c.nom_client , c.prenom_client 
from sejour s
join  medcin m  on s.id_medcin = m.id_medcin 
join client c on c.id_client = s.id_client;
