-- REQUETE 1 :

Select LoginUtilisateur
From Utilisateur
Where IdUtilisateur in (Select distinct IdUtilisateur
						From Liste
						Where lower(TypeObjet) like lower('livre')
						and IdUtilisateur in (Select IdUtilisateur
											From Liste
											Where lower(TypeObjet) like lower('film')
											and IdUtilisateur in (Select IdUtilisateur
																From Liste
																Where lower(TypeObjet) like lower('albummusique'))));


-- REQUETE 2 :

Select IdObjet, TypeObjet
From Objet
Group By IdObjet, TypeObjet
Having count(Commentaire)>20 and avg(Note)>14;

-- REQUETE 3 :

Select LoginUtilisateur
From Utilisateur
Where IdUtilisateur not in (Select distinct IdUtilisateur 
							From Objet
							Where Note < 8);

-- REQUETE 4 :

Select IdObjet,TypeObjet
From Objet
Where ((to_char(sysdate,'yyyymmdd') - to_char(DateCom,'yyyymmdd')) < 7)
Group By IdObjet,TypeObjet
Having (count(Commentaire) in (Select max(count(Commentaire))
								From Objet
								Group By IdObjet,TypeObjet));
