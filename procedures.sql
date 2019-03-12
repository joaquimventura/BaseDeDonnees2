SET SERVEROUTPUT ON;

-- FONCTION 1 :

CREATE OR REPLACE FUNCTION moyenne(IdOeuvre Objet.IdObjet%TYPE, TypeOeuvre Objet.TypeObjet%TYPE)
RETURN NUMBER
AS
	nbre_note NUMBER;
	moyenne_note NUMBER;
BEGIN
	SELECT count(Note), avg(Note) INTO nbre_note, moyenne_note
	FROM Objet
	WHERE (IdObjet = IdOeuvre) AND (TypeObjet = TypeOeuvre)
	Group by IdObjet,TypeObjet;
	IF(nbre_note < 20 OR nbre_note IS NULL)
	THEN
		RETURN 0;
	ELSE
		RETURN moyenne_note;
	END IF;
END;
/
show errors;
-- SELECT DISTINCT moyenne(1,'film') FROM Objet;

-- PROCEDURE 2 :

CREATE OR REPLACE PROCEDURE preference(id_user Objet.IdUtilisateur%TYPE)
IS
	compteur NUMBER;
	compteur_l INTEGER := 0;
	nom_livre VARCHAR2(512);
	CURSOR livre_c IS
		SELECT IdObjet, Note, DateAjoutObjet
		From Objet
		Where ((lower(TypeObjet) like lower('%livre%')) AND (IdUtilisateur = id_user))
		Order by Note DESC, DateAjoutObjet DESC;

	compteur_f INTEGER := 0;
	nom_film VARCHAR2(512);
	CURSOR film_c IS
		SELECT IdObjet, Note, DateAjoutObjet
		From Objet
		Where (lower(TypeObjet) like lower('%film%')) AND (IdUtilisateur = id_user)
		Order by Note DESC, DateAjoutObjet DESC;

	compteur_a INTEGER := 0;
	nom_album VARCHAR2(512);
	CURSOR album_c IS
		SELECT IdObjet, Note, DateAjoutObjet
		From Objet
		Where (lower(TypeObjet) like lower('%albummusique%')) AND (IdUtilisateur = id_user)
		Order by Note DESC, DateAjoutObjet DESC;

BEGIN
	FOR livre_r IN livre_c
	LOOP
		compteur_l := compteur_l + 1;
	END LOOP;
	IF(compteur_l < 10)
	THEN
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('		Moins de 10 livres !');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
	ELSE
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('		Livres préférés');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		compteur := 0;
		FOR livre_r IN livre_c
		LOOP
			Select Titre INTO nom_livre From Livre Where IdOeuvre = livre_r.IdObjet;
			DBMS_OUTPUT.PUT_LINE(nom_livre || ' avec une note de : ' || livre_r.Note || ' date d ajout : ' || livre_r.DateAjoutObjet);
			compteur := compteur + 1;
		EXIT WHEN compteur = 10;
		END LOOP;
	END IF;

	FOR film_r IN film_c
	LOOP
		compteur_f := compteur_f + 1;
	END LOOP;
	IF(compteur_f < 10)
	THEN
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('		Moins de 10 films !');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
	ELSE
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('		Films préférés');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		compteur := 0;
		FOR film_r IN film_c
		LOOP
			Select Titre INTO nom_film From Film Where IdOeuvre = film_r.IdObjet;
			DBMS_OUTPUT.PUT_LINE(nom_film || ' avec une note de : ' || film_r.Note || ' date d ajout : ' || film_r.DateAjoutObjet);
			compteur := compteur + 1;
		EXIT WHEN compteur = 10;
		END LOOP;
	END IF;

	FOR album_r IN album_c
	LOOP
		compteur_a := compteur_a + 1;
	END LOOP;
	IF(compteur_a < 10)
	THEN
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('		Moins de 10 albums de musique !');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
	ELSE
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('		Albums de musique préférés');
		DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
		compteur := 0;
		FOR album_r IN album_c
		LOOP
			Select Titre INTO nom_album From AlbumMusique Where IdOeuvre = album_r.IdObjet;
			DBMS_OUTPUT.PUT_LINE(nom_album || ' avec une note de : ' || album_r.Note || ' date d ajout : ' || album_r.DateAjoutObjet);
			compteur := compteur + 1;
		EXIT WHEN compteur = 10;
		END LOOP;
	END IF;

END;
/
show errors;
-- execute preference(id_user);