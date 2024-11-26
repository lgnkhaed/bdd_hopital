create schema projet_bdr2;
use projet_bdr2;

create table client (
     id_client  varchar(10) primary key   NOT NULL,
     nom_client    varchar(15) not null ,
     prenom_client   varchar(15) not null , 
     adresse_client   varchar(20), 
     date_de_naissance date 
);

create table medcin (
    id_medcin varchar(10)  primary key  not null , 
    nom_medcin varchar (15) not null ,
    prenom_medcin varchar (15) not null ,
    adresse_medcin  varchar(20) , 
    date_de_naissance date
    ); 
    
    
create table service (
    id_service int auto_increment not null primary key , 
    nom_service varchar(15) not null , 
    id_medcin_respo  varchar(10)  , 
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
   nom_categorie varchar(20)
);


create table sejour(
   id_sejour varchar(10)  not null primary key , 
   date_debut_sejour   date  not null , 
   date_fin_sejour date not null ,  
   id_client varchar(10) not null , 
   foreign key (id_client) references client(id_client) ,
   id_medcin varchar(10)  not null , 
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
    id_medcin varchar(10)  not null , 
    foreign key (id_medcin) references medcin(id_medcin) ,
    primary key (id_service,id_medcin)
);


create table intervention_medcin (
    id_inter int  not null , 
    foreign key (id_inter) references  intervention(id_intervention),
    id_medcin varchar(10) not null , 
    foreign key (id_medcin) references medcin(id_medcin),
    primary key (id_inter , id_medcin ) 
);



-- insertion 

INSERT INTO client (id_client, nom_client, prenom_client, adresse_client, date_de_naissance)
VALUES
('C123', 'laggoun', 'khaled', 'limoges', '2004-08-01'),
('C001', 'laggoun', 'aboud', 'alger', '2013-11-04'),
('C002', 'laggoun', 'aymen', 'alger', '2009-10-10'),
('C003', 'Smith', 'John', 'New York', '1990-01-15'),
('C004', 'Johnson', 'Emily', 'Los Angeles', '1985-06-20'),
('C005', 'Brown', 'Michael', 'London', '1982-11-05'),
('C006', 'Williams', 'Sarah', 'Manchester', '1994-02-28'),
('C007', 'Jones', 'David', 'Sydney', '1988-09-12'),
('C008', 'Davis', 'Laura', 'Melbourne', '1991-03-18'),
('C009', 'Miller', 'James', 'Toronto', '1980-12-03'),
('C010', 'Wilson', 'Linda', 'Vancouver', '1993-07-25'),
('C011', 'Moore', 'Robert', 'Berlin', '1987-08-30'),
('C012', 'Bouchard', 'Manon', 'Limoges', '1998-01-31');



INSERT INTO medcin (id_medcin, nom_medcin, prenom_medcin, adresse_medcin, date_de_naissance)
VALUES
('M000', 'Dupond', 'Carlos', 'Madrid', '1979-05-22'),
('M001', 'Durant', 'Liam', 'Oslo', '1983-11-16'),
('M002', 'Guedourra', 'Sara Leila', 'Alger', '2005-03-28'),
('M003', 'Lopez', 'Maria', 'Barcelona', '1985-04-30'),
('M004', 'Schmidt', 'Jan', 'Berlin', '1980-12-12'),
('M005', 'Kim', 'Jiwoo', 'Seoul', '1992-03-21'),
('M006', 'Fischer', 'Anna', 'Zurich', '1987-02-25'),
('M007', 'Martinez', 'Pablo', 'Buenos Aires', '1995-01-11'),
('M008', 'Rossi', 'Giovanni', 'Rome', '1988-08-03'),
('M009', 'Santos', 'Paula', 'Lisbon', '1991-06-17'),
('M010', 'Smith', 'John', 'New York', '1976-02-15'),
('M011', 'Brown', 'Emily', 'London', '1984-06-28'),
('M012', 'Williams', 'James', 'Sydney', '1990-09-12');


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


alter table client 
add column boursier Boolean;

update client
SET boursier = true
WHERE id_client IN ('C001', 'C002', 'C003', 'C004', 'C005');
update client 
set boursier = false 
where id_client in ('C006','C007','C008','C009','C010','C011','C012','C123');

alter table medcin 
add column  prix_inter decimal(10,2) ;


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

insert into client 
value  ('C234' , 'Hamiti' , 'Amine','Canada', '2005-01-04', true);

insert into sejour 
values ('S123' , '2024-09-01','2024-09-04' , 'C234' , 'M001' , 1);

INSERT INTO intervention ( id_sejour, id_categorie, cout_intervention)
VALUES
( 'S123', 1, 150.00),
( 'S123', 3, 200.00),
( 'S123', 5, 300.00),
( 'S123', 7, 400.00);

INSERT INTO intervention_medcin (id_inter, id_medcin)
VALUES
(1, 'M000'),
(2, 'M001'),
(3, 'M000'),
(4, 'M001');


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
     (13,'M012');
     

update medcin 
set prix_inter = 40.00
where id_medcin in ('M000','M006','M002','M004','M008','M010','M012');
update medcin 
set prix_inter = 50.00
where id_medcin in ('M001','M003','M005','M007','M009','M011');



     -- les requetes :
     -- 1  
    select distinct id_client , nom_client , prenom_client 
    from client join sejour using (id_client)
    join intervention using (id_sejour) 
    join intervention_medcin on intervention_medcin.id_inter =  intervention.id_intervention 
    join medcin on medcin.id_medcin = intervention_medcin.id_medcin 
    where medcin.nom_medcin in ('Dupond' , 'Durant');  