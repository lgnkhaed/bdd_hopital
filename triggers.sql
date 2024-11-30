-- Listage de la structure de la base pour projet_bdr2
CREATE DATABASE IF NOT EXISTS `projet_bdr2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projet_bdr2`;

-- Listage de la structure de déclencheur projet_bdr2. intervention_medecin_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `intervention_medecin_before_insert` BEFORE INSERT ON `intervention_medecin` FOR EACH ROW BEGIN


if NEW.id_medecin NOT IN (SELECT id_medecin 
									FROM medecins_service 
									JOIN service ON (service.id_service=medecins_service.id_service) 
									WHERE service.nom_service='Chirurgie') 
AND NEW.id_inter IN (SELECT intervention.id_intervention
							FROM intervention
							JOIN categorie ON ( categorie.id_categorie=intervention.id_categorie)
							JOIN service ON ( service.id_service=categorie.id_service)
							WHERE service.nom_service='Chirurgie')

then 
SIGNAL	SQLSTATE	'45000'	
SET	MESSAGE_TEXT	=	"il est interdit d'affecter une operation de type chirurgie a un medecin non chirurgien";	
end if;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;




