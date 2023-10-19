-- Conversion of cartes table
CREATE TABLE cartes (
                        idCarte INTEGER PRIMARY KEY AUTOINCREMENT,
                        concept TEXT DEFAULT NULL
);

-- Insert data for cartes
INSERT INTO cartes (idCarte, concept) VALUES (1, 'animaux');

-- Conversion of joueurs table
CREATE TABLE joueurs (
                         idJoueur INTEGER PRIMARY KEY AUTOINCREMENT,
                         pseudonyme TEXT NOT NULL,
                         mot2passe TEXT NOT NULL DEFAULT '12345',
                         UNIQUE(pseudonyme)
);

-- Insert data for joueurs
INSERT INTO joueurs VALUES (1,'NEFLE_Noémie','12345'),(2,'GRAVIER_Gidéon','12345'),(3,'OISELEUR_Octave','12345'),(4,'ROCHER_Romane','12345'),(5,'EPICIER_Edgard','12345'),(6,'PRAIRIE_Pascal','12345'),(7,'YUCCA_Yann','12345'),(8,'VACHER_Virginie','12345'),(9,'URUBU_Ugo','12345'),(10,'JARDINIER_Jarod','12345'),(11,'VERRIER_Victorio','12345'),(12,'VAUTOUR_Valérie','12345'),(13,'HOSTELIER_Hermine','12345'),(14,'QUINCAILLER_Queenie','12345'),(15,'BUISSON_Béatrice','12345'),(16,'CHARME_Cléo','12345'),(17,'JUPONIER_Jonah','12345'),(18,'ZIBELINE_Zoé','12345'),(19,'LEBUISSON_Laurent','12345'),(20,'TAILLEUR_Tristan','12345'),(21,'GANTIER_Gaelle','12345'),(22,'LABOUREUR_Lucille','12345'),(23,'WALLABY_Wilhemina','12345'),(24,'FILEUR_Frédéric','12345'),(25,'HETRE_Hervé','12345'),(26,'SERRURIER_Souleymane','12345'),(27,'MONTAGNE_Maurice','12345'),(28,'TOURTEAU_Théodore','12345'),(29,'PATISSIER_Perceval','12345'),(30,'VANNIER_Vincent','12345'),(31,'KIWI_Katie','12345');

-- Conversion of parties table
CREATE TABLE parties (
                         idPartie INTEGER PRIMARY KEY AUTOINCREMENT,
                         dateHeurePartie DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         nbManches INTEGER NOT NULL
);

-- Insert data for parties
INSERT INTO parties VALUES (1,'2020-10-26 15:51:19',1),(2,'2020-10-25 03:27:19',1),(3,'2020-10-25 01:32:19',1),(4,'2020-10-22 05:32:19',1),(5,'2020-10-22 09:36:19',1),(6,'2020-10-24 16:15:19',1),(7,'2020-10-21 15:55:19',1);

-- Conversion of listes table
-- Conversion of listes table
CREATE TABLE listes (
                        idPartie INTEGER NOT NULL,
                        idJoueur INTEGER NOT NULL,
                        idCarte INTEGER NOT NULL,
                        numMot INTEGER NOT NULL,
                        mot TEXT DEFAULT NULL,
                        PRIMARY KEY (idPartie, idJoueur, idCarte, numMot),
                        FOREIGN KEY (idPartie) REFERENCES parties(idPartie) ON DELETE CASCADE,
                        FOREIGN KEY (idJoueur) REFERENCES joueurs(idJoueur) ON DELETE CASCADE,
                        FOREIGN KEY (idCarte) REFERENCES cartes(idCarte) ON DELETE CASCADE
);

--
-- Dumping data for table listes
--


INSERT INTO listes VALUES (1,7,1,1,'ours'),(1,7,1,2,'chien'),(1,7,1,3,'chat'),(1,7,1,4,'cheval'),(1,7,1,5,'vache'),(1,7,1,6,'poule'),(1,7,1,7,'coq'),(1,7,1,8,'hamster'),(1,14,1,1,'chat'),(1,14,1,2,'chien'),(1,14,1,3,'lapin'),(1,14,1,4,'furet'),(1,14,1,5,'hamster'),(1,14,1,6,'chinchilla'),(1,14,1,7,'oiseau'),(1,14,1,8,'poisson'),(1,21,1,1,'chat'),(1,21,1,2,'chien'),(1,21,1,3,'cheval'),(1,21,1,4,'vache'),(1,21,1,5,'cochon'),(1,21,1,6,'brebis'),(1,21,1,7,'chevre'),(1,21,1,8,'poulet'),(1,28,1,1,'chat'),(1,28,1,2,'chien'),(1,28,1,3,'vache'),(1,28,1,4,'canard'),(1,28,1,5,'oie'),(1,28,1,6,'poule'),(1,28,1,7,'poulet'),(1,28,1,8,'coq'),(2,1,1,1,'lion'),(2,1,1,2,'poussin'),(2,1,1,3,'chien'),(2,1,1,4,'poisson'),(2,1,1,5,'singe'),(2,1,1,6,'oiseau'),(2,1,1,7,'leopard'),(2,1,1,8,'tigre'),(2,8,1,1,'castor'),(2,8,1,2,'elephant'),(2,8,1,3,'loutre'),(2,8,1,5,'hermine'),(2,8,1,6,'furet'),(2,8,1,7,'loir'),(2,8,1,8,'renard'),(2,15,1,1,'chat'),(2,15,1,2,'chien'),(2,15,1,3,'lapin'),(2,15,1,4,'poisson'),(2,15,1,5,'aigle'),(2,15,1,6,'faucon'),(2,15,1,7,'vautour'),(2,15,1,8,'lièvre'),(2,22,1,1,'vache'),(2,22,1,2,'chien'),(2,22,1,3,'chat'),(2,22,1,4,'mouton'),(2,22,1,5,'souris'),(2,22,1,6,'poule'),(2,22,1,7,'loup'),(2,22,1,8,'crocodile'),(2,29,1,1,'lion'),(2,29,1,2,'poussin'),(2,29,1,3,'chien'),(2,29,1,4,'poisson'),(2,29,1,5,'singe'),(2,29,1,6,'lémurien'),(2,29,1,7,'loup'),(2,29,1,8,'loutre'),(3,2,1,1,'lion'),(3,2,1,2,'poussin'),(3,2,1,3,'chien'),(3,2,1,4,'poisson'),(3,2,1,5,'singe'),(3,2,1,6,'oiseau'),(3,2,1,7,'leopard'),(3,2,1,8,'souris'),(3,9,1,1,'chat'),(3,9,1,2,'serpent'),(3,9,1,3,'chien'),(3,9,1,4,'serpent'),(3,9,1,5,'hérisson'),(3,9,1,6,'grenouille'),(3,9,1,7,'crapaud'),(3,9,1,8,'singe'),(3,16,1,1,'chien'),(3,16,1,2,'chat'),(3,16,1,3,'loup'),(3,16,1,4,'escargot'),(3,16,1,5,'girafe'),(3,16,1,6,'lion'),(3,16,1,7,'singe'),(3,16,1,8,'poisson'),(3,23,1,1,'chien'),(3,23,1,2,'chat'),(3,23,1,3,'vache'),(3,23,1,4,'mouton'),(3,23,1,5,'souris'),(3,23,1,6,'cheval'),(3,23,1,7,'serpent'),(3,23,1,8,'araignée'),(3,30,1,1,'chat'),(3,30,1,2,'chien'),(3,30,1,3,'ornitorinque'),(3,30,1,4,'opossum'),(3,30,1,5,'drosophile'),(3,30,1,6,'pie'),(3,30,1,7,'pieuvre'),(3,30,1,8,'rascasse'),(4,3,1,1,'chat'),(4,3,1,2,'serpent'),(4,3,1,3,'chien'),(4,3,1,4,'hyene'),(4,3,1,5,'giraffe'),(4,3,1,6,'requin'),(4,3,1,7,'brebis'),(4,3,1,8,'kangourou'),(4,10,1,1,'chat'),(4,10,1,2,'serpent'),(4,10,1,3,'chien'),(4,10,1,4,'chacal'),(4,10,1,5,'musaraigne'),(4,10,1,6,'gerbille'),(4,10,1,7,'gervoise'),(4,10,1,8,'souris'),(4,17,1,1,'tigre'),(4,17,1,2,'chat'),(4,17,1,3,'chien'),(4,17,1,4,'dauphin'),(4,17,1,5,'souris'),(4,17,1,6,'rat'),(4,17,1,7,'oiseau'),(4,17,1,8,'elephant'),(4,24,1,1,'castor'),(4,24,1,2,'elephant'),(4,24,1,3,'chacal'),(4,24,1,4,'lion'),(4,24,1,5,'taureau'),(4,24,1,6,'zebre'),(4,24,1,7,'girafe'),(4,24,1,8,'hippotame'),(4,31,1,1,'lion'),(4,31,1,2,'poussin'),(4,31,1,3,'chien'),(4,31,1,4,'poisson'),(4,31,1,5,'singe'),(4,31,1,6,'oiseau'),(4,31,1,7,'cheval'),(4,31,1,8,'vache'),(5,4,1,1,'lion'),(5,4,1,2,'veau'),(5,4,1,3,'vache'),(5,4,1,4,'cochon'),(5,4,1,5,'chien'),(5,4,1,6,'chat'),(5,4,1,7,'CHEVRE'),(5,4,1,8,'dauphin'),(5,11,1,1,'cheval'),(5,11,1,2,'chat'),(5,11,1,3,'chien'),(5,11,1,4,'hamster'),(5,11,1,5,'dauphin'),(5,11,1,6,'tigre'),(5,11,1,7,'poisson'),(5,11,1,8,'rat'),(5,18,1,1,'lion'),(5,18,1,2,'tigre'),(5,18,1,3,'léopard'),(5,18,1,4,'guépard'),(5,18,1,5,'hyène'),(5,18,1,6,'hippopotame'),(5,18,1,7,'éléphant'),(5,18,1,8,'rhinocéros'),(5,25,1,1,'lion'),(5,25,1,2,'poussin'),(5,25,1,3,'chien'),(5,25,1,4,'poisson'),(5,25,1,5,'chat'),(5,25,1,6,'cheval'),(5,25,1,7,'souris'),(5,25,1,8,'moineau'),(6,5,1,1,'chat'),(6,5,1,2,'chien'),(6,5,1,3,'dauphin'),(6,5,1,4,'cheval'),(6,5,1,5,'cochon'),(6,5,1,6,'baleine'),(6,5,1,7,'vache'),(6,5,1,8,'poussin'),(6,12,1,1,'baleine'),(6,12,1,2,'chien'),(6,12,1,3,'chat'),(6,12,1,4,'koala'),(6,12,1,5,'lion'),(6,12,1,6,'tigre'),(6,12,1,7,'gazelle'),(6,12,1,8,'cheval'),(6,19,1,1,'chien'),(6,19,1,2,'chat'),(6,19,1,3,'canard'),(6,19,1,4,'poule'),(6,19,1,5,'éléphant'),(6,19,1,6,'lion'),(6,19,1,7,'tigre'),(6,19,1,8,'fourmi'),(6,26,1,1,'escargot'),(6,26,1,2,'panda'),(6,26,1,3,'pie'),(6,26,1,4,'aligator'),(6,26,1,5,'koala'),(6,26,1,6,'paresseux'),(6,26,1,7,'poisson'),(6,26,1,8,'hérisson'),(7,6,1,1,'castor'),(7,6,1,2,'gorille'),(7,6,1,3,'ouistiti'),(7,6,1,4,'babouin'),(7,6,1,5,'capucin'),(7,6,1,6,'oran-outang'),(7,6,1,7,'chimpanzé'),(7,6,1,8,'macaque'),(7,13,1,1,'ours'),(7,13,1,2,'chien'),(7,13,1,3,'chat'),(7,13,1,4,'rat'),(7,13,1,5,'lapin'),(7,13,1,6,'souris'),(7,13,1,7,'lion'),(7,13,1,8,'tigre'),(7,20,1,1,'chat'),(7,20,1,2,'chien'),(7,20,1,3,'girafe'),(7,20,1,4,'mouton'),(7,20,1,5,'chèvre'),(7,20,1,6,'lapin'),(7,20,1,7,'poule'),(7,20,1,8,'tortue'),(7,27,1,1,'castor'),(7,27,1,2,'elephant'),(7,27,1,3,'chacal'),(7,27,1,4,'lion'),(7,27,1,5,'taureau'),(7,27,1,6,'zebre'),(7,27,1,7,'girafe'),(7,27,1,8,'hipopotame');

--
-- Table structure for table parties
--



