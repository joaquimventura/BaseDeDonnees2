-- TEST TRIGGER DEMANDE 1 ET 2:

SELECT * FROM Nouveaute;
SELECT * FROM Objet WHERE IdUtilisateur = 1 AND IdObjet = 1 AND lower(TypeObjet) LIKE lower('livre');
INSERT INTO Objet VALUES (1,1,'livre','Enfait siii',SYSDATE,SYSDATE,NULL);
SELECT * FROM Nouveaute;
SELECT * FROM Objet WHERE IdUtilisateur = 1 AND IdObjet = 1 AND lower(TypeObjet) LIKE lower('livre');


-- TEST TRIGGER LOGIN ET MDP
INSERT INTO Utilisateur(IdUtilisateur,LoginUtilisateur,MotDePasse,Nom,Prenom,Adresse,DateNaiss,DateInscrip) VALUES (30,'jdupond23','1545Affe&','Dupond','Jacques','31 rue du Palais','21-FEB-1995','01-JAN-2015');
INSERT INTO Utilisateur(IdUtilisateur,LoginUtilisateur,MotDePasse,Nom,Prenom,Adresse,DateNaiss,DateInscrip) VALUES (30,'jdupond2','1545Affeaqs','Dupond','Jacques','31 rue du Palais','21-FEB-1995','01-JAN-2015');
INSERT INTO Utilisateur(IdUtilisateur,LoginUtilisateur,MotDePasse,Nom,Prenom,Adresse,DateNaiss,DateInscrip) VALUES (30,'jdupo23','1545Affeaqs','Dupond','Jacques','31 rue du Palais','21-FEB-1995','01-JAN-2015');