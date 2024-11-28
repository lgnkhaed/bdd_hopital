  -- les requetes :
     -- 1  
    select distinct id_client , nom_client , prenom_client 
    from client join sejour using (id_client)
    join intervention using (id_sejour) 
    join intervention_medcin on intervention_medcin.id_inter =  intervention.id_intervention 
    join medcin on medcin.id_medcin = intervention_medcin.id_medcin 
    where medcin.nom_medcin in ('Dupond' , 'Durant');  

    --2  
    select sum(i.cout_intervention) + sum(m.prix_inter) + (datediff(s.date_fin_sejour,s.date_debut_sejour) * c.cout_journee) as cout_sejour 
    from sejour s 
    join intervention i on s.id_sejour = i.id_sejour 
    join intervention_medcin im on im.id_inter = i.id_intervention 
    join medcin m on m.id_medcin = im.id_medcin 
    join place p on p.id_place = s.id_place 
    join chambre c on c.id_chambre = p.id_chambre 
    group by s.id_sejour 
    Having s.id_sejour='S123';

    --3 : fausse faut la modifier 
    -- requete pour ttouver les medcins qui ont fait une ointervention de type hernie d'escale 

    select distinct  m.id_medcin , m.nom_medcin , medcin.prenom_medcin 
    from medecin_service m
    join medcin on medcin.id_medcin = m.id_medcin 
    where nom_service = 'Chirurgie' and (m.id_medcin , m.nom_medcin ) not in ( select distinct im.id_medcin , im.nom_medcin 
            from vue_intervention_medcin im
            where nom_categorie = 'opération hernie discale'
			);



