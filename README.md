# PROJET BDD - Collection d'objets

Ce projet vise à proposer une base de données pour la gestion de collections d'objets qui permet à un utilisateur, de répertorier les différents objets culturels qu'il possède ou a possédé (livres, films, albums de musique), de les noter/commenter et de les organiser par listes thématiques.

## Fichiers inclus
```
tables.sql
dropTables.sql
data.sql
requetes.sql
procedures.sql
triggers.sql
t_triggers.sql
index.sql
drop_index.sql
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