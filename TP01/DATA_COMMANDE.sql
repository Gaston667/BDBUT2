
--DROP TABLE ligne_commande ;
--DROP TABLE commande ;
--DROP TABLE client ;
--DROP TABLE produit;

--
-- Table structure for table client
--


	CREATE TABLE client (
	  id NUMBER(10)  NOT NULL ,
	  prenom varchar2(255) NOT NULL,
	  nom varchar2(255) NOT NULL,
	  email varchar2(255) NOT NULL,
	  ville varchar2(255) NOT NULL,
	  PRIMARY KEY (id)
	);


CREATE TABLE commande (
  id NUMBER(2)  NOT NULL ,
  client_id NUMBER(10) ,
  date_achat date NOT NULL,
  reference varchar2(255) NOT NULL,
  PRIMARY KEY (id)
);
ALTER TABLE commande ADD CONSTRAINTS fk_client FOREIGN KEY(client_id) REFERENCES client(id);

CREATE TABLE produit (
id NUMBER(2)	NOT NULL,
nom_produit varchar2(255) NOT NULL,
prix_unitaire NUMBER(10, 3) NOT NULL,
PRIMARY KEY(id)
);

-- la table ligne commande contient pour une commande donnée, tous les produits achetés lors de cette commande
CREATE TABLE ligne_commande (
  id NUMBER(10)  NOT NULL ,
  commande_id NUMBER(10) NOT NULL,
  produit_id NUMBER(2)	NOT NULL,
  quantite NUMBER(10) NOT NULL,
  prix_total NUMBER(10, 3)  NOT NULL,
  PRIMARY KEY (id)
);

--ALTER TABLE ligne_commande ADD CONSTRAINTS fk_commande FOREIGN KEY(commande_id) REFERENCES commande(id) on delete cascade;
ALTER TABLE ligne_commande ADD CONSTRAINTS fk_commande FOREIGN KEY(commande_id) REFERENCES commande(id);
ALTER TABLE ligne_commande ADD CONSTRAINT fk_produit FOREIGN KEY(produit_id) REFERENCES produit(id);


--
-- Dumping data for table client
--
REM INSERTING into client
SET DEFINE OFF;

INSERT INTO client (id, prenom, nom, email, ville) VALUES (1, 'Flavie', 'Da costa', 'f.da.costa@example.com', 'Pomoy');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (2, 'Valentin', 'Vespasien', 'valentin@example.com', 'Buvilly');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (3, 'Gustave', 'Collin', 'gust@example.com', 'Marseille');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (4, 'Emilien', 'Camus', 'emilien@example.com', 'Toulouse');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (5, 'Firmin', 'Marais', 'firmin.marais@example.com', 'Lyon');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (6, 'Olivier', 'Riou', 'olive.de.lugagnac@example.com', 'Lugagnac');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (7, 'Lucas', 'Jung', 'lucas.jung@example.com', 'Coulgens');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (8, 'Maurice', 'Huet', 'maurice.villemareuil@example.com', 'Villemareuil');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (9, 'Manon', 'Durand', 'm.durand.s.e@example.com', 'Saint-Etienne');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (10, 'Joachim', 'Leon', 'joachim@example.com', 'Longwy-sur-le-Doubs');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (11, 'Muriel', 'Dupuis', 'muriel@example.com', 'Paris');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (12, 'Christiane', 'Riou', 'chritianelesabrets@example.com', 'Les Abrets');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (13, 'Jacinthe', 'Langlois', 'jacinthe.langlois@example.com', 'Lagney');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (14, 'Amaury', 'Payet', 'amaury@example.com', 'Avermes');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (15, 'Maris', 'Buisson', 'maris@example.com', 'Le Havre');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (16, 'Fabrice', 'Foucher', 'fab.montlouis@example.com', 'Montlouis');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (17, 'Patrick', 'Saunier', 'patrick.saunier@example.com', 'Saligney');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (18, 'Emile', 'Ramos', 'emile@example.com', 'Arzay');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (19, 'Armel', 'Vigneron', 'armel.delain@example.com', 'Delain');
INSERT INTO client (id, prenom, nom, email, ville) VALUES (20, 'Arnaude', 'Vallee', 'armaude.vallee@example.com', 'Hostias');
COMMIT;

REM INSERTING into commande
SET DEFINE OFF;

INSERT INTO commande (id, client_id, date_achat, reference) VALUES (1, 20, TO_DATE('2019-01-01','YYYY-MM-DD'), '004214');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (2, 3, TO_DATE('2019-01-03','YYYY-MM-DD'), '007120');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (3, 11, TO_DATE('2019-01-04','YYYY-MM-DD'), '002957');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (4, 6, TO_DATE('2019-01-07','YYYY-MM-DD'), '003425');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (5, 17, TO_DATE('2019-01-08','YYYY-MM-DD'), '008255');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (6, 7, TO_DATE('2019-01-09','YYYY-MM-DD'), '000996');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (7, 2, TO_DATE('2019-01-10','YYYY-MM-DD'), '000214');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (8, 7, TO_DATE('2019-01-11','YYYY-MM-DD'), '008084');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (9, 12, TO_DATE('2019-01-11','YYYY-MM-DD'), '009773');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (10, 16, TO_DATE('2019-01-13','YYYY-MM-DD'), '004616');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (11, 4, TO_DATE('2019-01-14','YYYY-MM-DD'), '003757');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (12, 9, TO_DATE('2019-01-15','YYYY-MM-DD'), '004939');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (13, 14, TO_DATE('2019-01-16','YYYY-MM-DD'), '003421');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (14, 6, TO_DATE('2019-01-16','YYYY-MM-DD'), '002286');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (15, 3, TO_DATE('2019-01-17','YYYY-MM-DD'), '001167');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (16, 15, TO_DATE('2019-01-18','YYYY-MM-DD'), '008974');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (17, 9, TO_DATE('2019-01-19','YYYY-MM-DD'), '001369');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (18, 17, TO_DATE('2019-01-20','YYYY-MM-DD'), '009924');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (19, 3, TO_DATE('2019-01-21','YYYY-MM-DD'), '005510');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (20, 17, TO_DATE('2019-01-22','YYYY-MM-DD'), '007778');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (21, 17, TO_DATE('2019-01-23','YYYY-MM-DD'), '002359');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (22, 15, TO_DATE('2019-01-25','YYYY-MM-DD'), '008459');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (23, 4, TO_DATE('2019-01-27','YYYY-MM-DD'), '005217');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (24, 12, TO_DATE('2019-01-29','YYYY-MM-DD'), '000706');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (25, 9, TO_DATE('2019-02-01','YYYY-MM-DD'), '007879');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (26, 8, TO_DATE('2019-02-02','YYYY-MM-DD'), '007277');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (27, 11, TO_DATE('2019-02-02','YYYY-MM-DD'), '002745');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (28, 11, TO_DATE('2019-02-03','YYYY-MM-DD'), '001893');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (29, 20, TO_DATE('2019-02-04','YYYY-MM-DD'), '001230');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (30, 10, TO_DATE('2019-02-05','YYYY-MM-DD'), '000469');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (31, 7, TO_DATE('2019-02-05','YYYY-MM-DD'), '008653');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (32, 3, TO_DATE('2019-02-06','YYYY-MM-DD'), '001858');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (33, 14, TO_DATE('2019-02-07','YYYY-MM-DD'), '003330');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (34, 2, TO_DATE('2019-02-08','YYYY-MM-DD'), '001074');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (35, 5, TO_DATE('2019-02-08','YYYY-MM-DD'), '005379');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (36, 16, TO_DATE('2019-02-09','YYYY-MM-DD'), '003672');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (37, 10, TO_DATE('2019-02-09','YYYY-MM-DD'), '002220');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (38, 19, TO_DATE('2019-02-10','YYYY-MM-DD'), '000086');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (39, 8, TO_DATE('2019-02-11','YYYY-MM-DD'), '003770');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (40, 2, TO_DATE('2019-02-12','YYYY-MM-DD'), '008590');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (41, 2, TO_DATE('2019-02-12','YYYY-MM-DD'), '001639');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (42, 4, TO_DATE('2019-02-13','YYYY-MM-DD'), '002426');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (43, 13, TO_DATE('2019-02-14','YYYY-MM-DD'), '007209');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (44, 13, TO_DATE('2019-02-15','YYYY-MM-DD'), '008768');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (45, 7, TO_DATE('2019-02-16','YYYY-MM-DD'), '002213');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (46, 12, TO_DATE('2019-02-17','YYYY-MM-DD'), '004759');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (47, 19, TO_DATE('2019-02-18','YYYY-MM-DD'), '007155');
INSERT INTO commande (id, client_id, date_achat, reference) VALUES (48, 2, TO_DATE('2019-02-19','YYYY-MM-DD'), '001496');
COMMIT;

REM INSERTING into Produit
SET DEFINE OFF;
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (00, 'Produit0', 49.57);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (01, 'Produit1', 10.99);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (02, 'Produit2', 100.10);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (03, 'Produit3', 20);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (04, 'Produit4', 72.98);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (05, 'Produit5', 9);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (06, 'Produit6', 0.99);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (07, 'Produit7', 44.50);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (08, 'Produit8', 112);
INSERT INTO Produit(id, nom_produit, prix_unitaire)  VALUES (09, 'Produit9', 5);
COMMIT;

REM INSERTING into ligne_commande
SET DEFINE OFF;
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (1, 1, 01, 3, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (2, 1, 09, 1,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (3, 1, 06, 2,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (4, 2, 05, 4,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (5, 2, 07, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (6, 3, 09, 7,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (7, 4, 03, 8,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (8, 4, 04, 10, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (9, 4, 07, 4,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (10, 4, 08, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (11, 4, 09, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (12, 5, 00, 10, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (13, 5, 07, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (14, 6, 01, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (15, 7, 06, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (16, 7, 07, 7,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (17, 7, 09, 3, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (18, 8, 05, 9,  0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (19, 9, 07, 10, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (20, 10, 02, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (21, 10, 00, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (22, 10, 06, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (23, 10, 01, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (24, 11, 04, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (25, 12, 02, 1, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (26, 12, 09, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (27, 13, 03, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (28, 13, 00, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (29, 14, 01, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (30, 14, 00, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (31, 15, 07, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (32, 15, 02, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (33, 16, 02, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (34, 17, 03, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (35, 17, 06, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (36, 17, 04, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (37, 17, 01, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (38, 18, 04, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (39, 18, 01, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (40, 18, 03, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (41, 18, 02, 1, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (42, 19, 05, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (43, 20, 01, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (44, 20, 04, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (45, 20, 03, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (46, 21, 04, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (47, 21, 07, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (48, 22, 09, 3, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (49, 22, 01, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (50, 22, 02, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (51, 22, 06, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (52, 22, 09, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (53, 23, 00, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (54, 23, 08, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (55, 23, 09, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (56, 24, 09, 1, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (57, 24, 08, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (58, 24, 05, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (59, 25, 00, 1, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (60, 25, 06, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (61, 26, 07, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (62, 27, 01, 1, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (63, 27, 04, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (64, 28, 05, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (65, 28, 03, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (66, 29, 09, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (67, 29, 02, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (68, 29, 06, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (69, 30, 00, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (70, 31, 03, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (71, 31, 00, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (72, 32, 03, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (73, 32, 05, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (74, 32, 02, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (75, 32, 01, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (76, 33, 00, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (77, 33, 06, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (78, 33, 03, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (79, 34, 05, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (80, 35, 02, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (81, 36, 03, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (82, 37, 06, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (83, 37, 01, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (84, 38, 01, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (85, 38, 02, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (86, 39, 01, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (87, 39, 07, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (88, 40, 06, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (89, 40, 03, 3, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (90, 41, 08, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (91, 41, 06, 4, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (92, 42, 01, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (93, 42, 05, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (94, 43, 04, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (95, 43, 03, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (96, 44, 04, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (97, 44, 02, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (98, 44, 09, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (99, 44, 00, 3, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (100, 44, 06, 4,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (101, 45, 00, 3,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (102, 45, 06, 2,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (103, 45, 05, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (104, 45, 07, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (105, 46, 04, 3, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (106, 46, 09, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (107, 46, 05, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (108, 46, 03, 8, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (109, 46, 02, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (110, 47, 06, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (111, 47, 08, 6, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (112, 47, 09, 10,0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (113, 47, 01, 2, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (114, 47, 03, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (115, 48, 04, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (116, 48, 02, 5, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (117, 48, 03, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (118, 48, 05, 9, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (119, 48, 09, 7, 0);
INSERT INTO ligne_commande (id, commande_id, produit_id, quantite, prix_total) VALUES (120, 48, 06, 4, 0);
COMMIT;

