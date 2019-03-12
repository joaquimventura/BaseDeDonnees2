@dropTables
SET SERVEROUTPUT ON;

CREATE TABLE Utilisateur( 
    IdUtilisateur INTEGER,
    LoginUtilisateur VARCHAR2(128) NOT NULL,
    MotDePasse VARCHAR2(128) NOT NULL,
    Nom VARCHAR2(128) NOT NULL,
    Prenom VARCHAR2(128) NOT NULL,
    Adresse VARCHAR2(512) NOT NULL,
    DateNaiss DATE NOT NULL,
    DateInscrip DATE DEFAULT SYSDATE,	-- par defaut, date du jour
    CONSTRAINT PK_utilisateur PRIMARY KEY (IdUtilisateur) -- Clé primaire
) ;

CREATE OR REPLACE TRIGGER T_IU_UTILISATEUR_MDP BEFORE INSERT OR UPDATE
ON Utilisateur
FOR EACH ROW
BEGIN
	IF(NOT regexp_like(:new.MotDePasse,'^([a-z]|[A-Z]|[0-9]|_)+$','i'))
	THEN
		RAISE_APPLICATION_ERROR(-20103,'Format mot de passe incorrect !');
	END IF;
END;
/	
show errors;

CREATE OR REPLACE TRIGGER T_IU_UTILISATEUR_LOGIN BEFORE INSERT OR UPDATE
ON Utilisateur
FOR EACH ROW
DECLARE
	premiere_v VARCHAR2(1);
	autres_v VARCHAR2(7);
	lettres_v VARCHAR2(8); -- les lettres qui constituent le login
	taille_login_v INTEGER;
BEGIN
	-- PREMIERE LETTRE PRENOM (pour concatener utilise + ou concat()
	premiere_v := lower(SUBSTR(:new.Prenom,1,1));
	-- 7 PREMIERES LETTRES NOM
	autres_v := lower(SUBSTR(:new.Nom,1,7));
	lettres_v := premiere_v || autres_v;
	--DBMS_OUTPUT.PUT_LINE(lettres_v);
	taille_login_v := LENGTH(:new.LoginUtilisateur) - 2;
	IF(lettres_v NOT like lower(SUBSTR(:new.LoginUtilisateur,1,taille_login_v)))
	THEN
		RAISE_APPLICATION_ERROR(-20103,'Format login lettres incorrect !');
	END IF;
	
	-- LES 2 DERNIERS CHIFFRES A VERIFIER AVEC UNE EXPRESSION REGULIERE
	IF(NOT regexp_like(:new.LoginUtilisateur,'^([a-z]+([0-9]{2}))+$','i'))
	THEN
		RAISE_APPLICATION_ERROR(-20103,'Format login chiffres incorrect !');
	END IF;
	
END;
/	
show errors;
-- TRIGGER POUR LOGIN ET PASSWORD QUI MARCHENT SA MERE


CREATE TABLE Livre( 
    IdOeuvre INTEGER,
    Titre VARCHAR2(512) NOT NULL,
    Auteur VARCHAR2(128) NOT NULL,
    Style VARCHAR2(128) NOT NULL,
    Genre VARCHAR2(128) NOT NULL,
    AnneeParution INTEGER NOT NULL,
    Collection VARCHAR2(128),
    CONSTRAINT PK_livre PRIMARY KEY (IdOeuvre), -- PK
    CONSTRAINT unique_titre_livre UNIQUE (Titre)
) ;


CREATE TABLE Film( 
    IdOeuvre INTEGER,
    Titre VARCHAR2(512) NOT NULL,
    Realisateur VARCHAR2(128) NOT NULL,
    Acteur VARCHAR2(128) NOT NULL,
    Genre VARCHAR2(128) NOT NULL,
    AnneeSortie INTEGER NOT NULL,
    CONSTRAINT PK_film PRIMARY KEY (IdOeuvre), -- PK
    CONSTRAINT unique_titre_film UNIQUE (Titre)
) ;


CREATE TABLE AlbumMusique( 
    IdOeuvre INTEGER,
    Titre VARCHAR2(512) NOT NULL,
    Auteur VARCHAR2(128) NOT NULL,
    Genre VARCHAR2(128) NOT NULL,
    AnneeEdition INTEGER NOT NULL,
    CONSTRAINT PK_albumMusique PRIMARY KEY (IdOeuvre), -- PK
    CONSTRAINT unique_titre_albummusique UNIQUE (Titre)
) ;


CREATE TABLE Objet( 
    IdUtilisateur INTEGER NOT NULL,
    IdObjet INTEGER NOT NULL,
    TypeObjet VARCHAR2(20) NOT NULL,
    Commentaire VARCHAR2(1024),
    DateCom DATE DEFAULT SYSDATE, -- Date Dernier Commentaire
    DateAjoutObjet DATE DEFAULT SYSDATE,
    Note INTEGER,
    -- DIFFERENCE ENTRE POSSEDE ET POSSEDER
    CONSTRAINT FK_user FOREIGN KEY (IdUtilisateur) REFERENCES Utilisateur(IdUtilisateur), -- PK
    CONSTRAINT CHK_note CHECK (Note BETWEEN 1 AND 20),
    CONSTRAINT CHK_type CHECK (TypeObjet IN ('livre','film','albummusique'))
) ;

CREATE TABLE Liste(
    Nom VARCHAR2(50) NOT NULL,
    IdUtilisateur INTEGER NOT NULL,
    Descriptif VARCHAR2(1024),
    IdObjet INTEGER NOT NULL,
    TypeObjet VARCHAR2(20) NOT NULL,
    CONSTRAINT FK_utilisateur FOREIGN KEY (IdUtilisateur) REFERENCES Utilisateur(IdUtilisateur), -- PK
    CONSTRAINT CHK_TypeObjet CHECK (TypeObjet IN ('livre','film','albummusique'))
);

CREATE TABLE Nouveaute(
    IdUtilisateur INTEGER NOT NULL,
    IdObjet INTEGER NOT NULL,
    TypeObjet VARCHAR2(20) NOT NULL,
    Titre VARCHAR2(512) NOT NULL,
    DateAjout DATE DEFAULT SYSDATE,
    CONSTRAINT CHK_type_nouveaute CHECK (TypeObjet IN ('livre','film','albummusique'))
);

--CREATE INDEX ind_table_Nouveaute 
--ON Nouveaute (IdUtilisateur);