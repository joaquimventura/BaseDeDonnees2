SET SERVEROUTPUT ON;
-- TRIGGER 1 :

CREATE OR REPLACE TRIGGER T_I_OBJET_NOUVEAUTE BEFORE INSERT
ON Objet
FOR EACH ROW
DECLARE
	titre_v VARCHAR2(512);
BEGIN
	IF(lower(:new.TypeObjet) like lower('livre'))
	THEN
		SELECT Titre INTO titre_v
		FROM Livre
		WHERE (IdOeuvre = :new.IdObjet);
	END IF;
	
	IF(lower(:new.TypeObjet) like lower('film'))
	THEN
		SELECT Titre INTO titre_v
		FROM Film
		WHERE (IdOeuvre = :new.IdObjet);
	END IF;
	
	IF(lower(:new.TypeObjet) like lower('albummusique'))
	THEN
		SELECT Titre INTO titre_v
		FROM AlbumMusique
		WHERE (IdOeuvre = :new.IdObjet);
	END IF;
	
	DELETE FROM Nouveaute WHERE (IdUtilisateur = :new.IdUtilisateur) AND (IdObjet = :new.IdObjet) AND (lower(TypeObjet) like lower(:new.TypeObjet));
	INSERT INTO Nouveaute VALUES ( :new.IdUtilisateur, :new.IdObjet, :new.TypeObjet, titre_v, :new.DateAjoutObjet);
	DELETE FROM Nouveaute WHERE (to_char(sysdate,'yyyymm') > to_char(:new.DateAjoutObjet,'yyyymm'));
END;
/	
show errors;

-- TRIGGER 2 :

CREATE OR REPLACE TRIGGER T_I_OBJET BEFORE INSERT
ON Objet
FOR EACH ROW
DECLARE
	ancien_v VARCHAR2(1024);
BEGIN
	Select Commentaire INTO ancien_v
	From Objet
	Where (IdUtilisateur = :new.IdUtilisateur) AND
	(IdObjet = :new.IdObjet) AND (TypeObjet = :new.TypeObjet);

	--DBMS_OUTPUT.PUT_LINE('Ancien Commentaire : ' || ancien_v);
	--DBMS_OUTPUT.PUT_LINE('Nouveau Commentaire : ' || :new.Commentaire);
	--comm_complet_v := ancien_v || :new.Commentaire;
	--DBMS_OUTPUT.PUT_LINE('Total : ' || comm_complet_v);
	
	DELETE FROM Objet Where (IdUtilisateur = :new.IdUtilisateur) AND
	(IdObjet = :new.IdObjet) AND (lower(TypeObjet) like lower(:new.TypeObjet));
	
	:new.Commentaire := ancien_v || :new.Commentaire;
END;
/	
show errors;
-- INSERT INTO Objet VALUES (1,1,'livre','Enfait si',SYSDATE,SYSDATE,NULL);
-- select * from Objet where IdUtilisateur = 1 and IdObjet = 1 and TypeObjet like ('livre');

CREATE OR REPLACE TRIGGER T_I_LISTE BEFORE INSERT
ON Liste
FOR EACH ROW
DECLARE
	ancien_v VARCHAR2(1024);
BEGIN
	Select Descriptif INTO ancien_v
	From Liste
	Where (IdUtilisateur = :new.IdUtilisateur) AND
	(IdObjet = :new.IdObjet) AND (TypeObjet = :new.TypeObjet);

	--DBMS_OUTPUT.PUT_LINE('Ancien Commentaire : ' || ancien_v);
	--DBMS_OUTPUT.PUT_LINE('Nouveau Commentaire : ' || :new.Commentaire);
	--comm_complet_v := ancien_v || :new.Commentaire;
	--DBMS_OUTPUT.PUT_LINE('Total : ' || comm_complet_v);
	
	DELETE FROM Liste Where (IdUtilisateur = :new.IdUtilisateur) AND
	(IdObjet = :new.IdObjet) AND (lower(TypeObjet) like lower(:new.TypeObjet));
	
	:new.Descriptif := ancien_v || :new.Descriptif;
END;
/	
show errors;