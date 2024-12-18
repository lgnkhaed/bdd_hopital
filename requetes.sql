  -- les requetes :
     -- 1  
    select distinct vcs.id_client , vcs.nom_client , vcs.prenom_client 
    from vue_client_sejour vcs 
    join intervention i using (id_sejour)
    join vue_intervention_medecin vim on vim.id_inter = i.id_intervention 
    where vim.nom_medecin ='Dupond' and vcs.id_client in (
															select distinct id_client 
															from vue_client_sejour vcs 
															join intervention i using (id_sejour)
															join vue_intervention_medecin vim on vim.id_inter = i.id_intervention 
															where vim.nom_medecin ='Durant'); 

    -- 2  
    select sum(i.cout_intervention) + sum(m.prix_inter) + (datediff(s.date_fin_sejour,s.date_debut_sejour) * c.cout_journee) as cout_sejour 
    from sejour s 
    join intervention i on s.id_sejour = i.id_sejour 
    join intervention_medecin im on im.id_inter = i.id_intervention 
    join medecin m on m.id_medecin = im.id_medecin 
    join place p on p.id_place = s.id_place 
    join chambre c on c.id_chambre = p.id_chambre 
    group by s.id_sejour 
    Having s.id_sejour='S123';

    -- 3 : 
    select distinct  m.id_medecin , m.nom_medecin , medecin.prenom_medecin 
    from vue_medecin_service m
    join medecin on medecin.id_medecin = m.id_medecin 
    where nom_service = 'Chirurgie' and (m.id_medecin , m.nom_medecin ) not in ( select distinct im.id_medecin , im.nom_medecin 
            from vue_intervention_medecin im
            where nom_categorie = 'opération hernie discale'
			);
    
    -- 4 
   
    select distinct v.id_client , v.nom_client , v.prenom_client 
    from vue_sejour_medecin_client v
    where v.nom_medecin = 'Dupond' and (v.id_client , v.nom_client , v.prenom_client ) not in  (
           select v2.id_client , v2.nom_client , v2.prenom_client 
           from vue_sejour_medecin_client v2
	         where v2.nom_medecin <> 'Dupond'
          );
  


