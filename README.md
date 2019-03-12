# PROJET BDD - Collection d'objets

*Projet réalisé pour la matière Base De Données 2 du semestre 5 (3è année de licence informatique)*

Ce projet vise à proposer une base de données pour la gestion de collections d'objets qui permet à un utilisateur, de répertorier les différents objets culturels qu'il possède ou a possédé (livres, films, albums de musique), de les noter/commenter et de les organiser par listes thématiques.

Il utilise le langage *sqlplus* d'*Oracle*.

## Fichiers inclus
```
tables.sql  :  création des tables
dropTables.sql  :  drop des tables
data.sql  :  les données de test
requetes.sql  :  les différentes requêtes demandées 
procedures.sql  :  les différentes procédures demandées
triggers.sql  :  les différents triggers demandés
t_triggers.sql  :  pour tester le bon fonctionnement des triggers
index.sql  :  création des indexs
drop_index.sql  :  drop des indexs
README.md
```

## Compilation

Instructions à suivre pour compiler:
```
Lancer sqlplus
SQL> @tables
SQL> @data
SQL> @procedures
SQL> @triggers
SQL> @index
```

## Implémentation

Utilisateur ( **_IdUtilisateur_**, LoginUtilisateur, MotDePasse, Nom, Prenom, Adresse, DateNaiss, DateInscrip )

Livre ( **_IdOeuvre_**, Titre, Auteur, Style, Genre, AnneeParution, Collection )

Film ( **_IdOeuvre_**, Titre, Realisateur, Acteur, Genre, AnneeSortie )

AlbumMusique ( **_IdOeuvre_**, Titre, Auteur, Genre, AnneeEdition, )

Objet ( _#IdUtilisateur_, IdObjet, TypeObjet, Commentaire, DateCom, DateAjoutObjet, Note )

Liste ( Nom, _#IdUtilisateur_, Descriptif, IdObjet, TypeObjet )

Nouveaute ( IdUtilisateur, IdObjet, TypeObjet, DateAjout )

## Auteurs
* **Joaquim Ventura**, **Jeanne Truong**
