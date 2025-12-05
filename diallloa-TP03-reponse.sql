--Algassimou Pellel Diallo
--BDBUT2  tp01 date:05/12/2025


-- Question 1:

    /* Créer une procédure sp_DateDernierAchat(Nom_Produit) qui prend en paramètre un Nom de
        produit et affiche la dernière date d’achat du produit sous la forme « le produit X a pour
        dernière date d’achat
    */
    CREATE OR REPLACE PROCEDURE sp_DateDernierAchat(
        p_Nom_Produit IN VARCHAR2,
        p_out_Res OUT VARCHAR2
    )IS
        v_Produit_existe INT;
        v_date_dernier_achat DATE;
    BEGIN 
        -- JE VAIS VERIFIER QUE LE PRODUIT EXISTE
        SELECT  COUNT(*) INTO v_Produit_existe 
        FROM PRODUIT p WHERE p_Nom_Produit = P.nom_produit;
        IF  v_Produit_existe = 0 THEN
            p_out_Res := 'Le produit '|| p_Nom_Produit || ' n existe pas';
        ELSE
            -- JE VERIFIE QUE LE PRODUIT A ETE ACHETER SI OUI JEPREND LA DATE MAXIMALE SINON AFFICHE MESSAGE
            SELECT MAX(c.date_achat) INTO v_date_dernier_achat 
            FROM commande c
            JOIN ligne_commande lc ON lc.commande_id = c.id
            JOIN produit p ON p.id = lc.produit_id 
            WHERE p.nom_produit = p_Nom_Produit;
            IF v_date_dernier_achat IS NULL THEN
                p_out_Res := 'Le produit ' || p_Nom_Produit ||' n a jamais ete acheter';
            ELSE
                p_out_Res := 'le produit '|| p_Nom_Produit ||' a pour dernière date d’achat ' || TO_CHAR(v_date_dernier_achat, 'YYYY/MM/DD') ||'.';
            END IF;
        END IF;
    END sp_DateDernierAchat;

    -- TESTE De la question 1
    SET SERVEROUTPUT ON;
    DECLARE
        p_test_1 VARCHAR2(50);
        v_out_test_1 VARCHAR2(100);
    BEGIN
        p_test_1 := 'Produit53';
        sp_DateDernierAchat(p_test_1,  v_out_test_1);
        DBMS_OUTPUT.PUT_LINE(v_out_test_1);
    END;
    /      

--Question 2:
    /* Ajouter la colonne quantite_en_stock dans la table Produit. Vous pouvez initialisez la colonne
        avec une valeur > 0.
    */

    ALTER TABLE produit ADD quantite_en_stock INTEGER DEFAULT 50

-- QUESTION 3:
    /*
        Créer un trigger trg_GestionStock qui va permettre de gérer les stocks : avant qu’une nouvelle
        ligne de commande ne soit ajoutée, vérifiez que la quantite commandée <= quantite_stock du
        produit. Si c’est le cas, la ligne de commande est ajoutée et la quantite est mise à jour dans la
        table produit dans le cas contraire, une exception est levée.
        
    */

    CREATE OR REPLACE TRIGGER trg_GestionStock
    BEFORE INSERT ON ligne_commande 
    FOR EACH ROW
        -- Je declare ici les variable dont jaurais besoin 
       DECLARE v_quantite_en_stock INT;
    BEGIN
        --je recuperere la quantité existante
        SELECT quantite_en_stock INTO v_quantite_en_stock
        FROM produit
        WHERE id = :NEW.produit_id; -- OLD n’existe pas, car il n’y avait aucune ligne avant l’insertion.
        
        IF :NEW.quantite > v_quantite_en_stock THEN -- Vérifier si la quantité demandée est disponible
            RAISE_APPLICATION_ERROR(-20001, 'Stock insuffisant');
        ELSE
            UPDATE produit p
            SET p.quantite_en_stock =  p.quantite_en_stock - :NEW.quantite -- l'attribut quantité appratient à la table ligne de commande
            WHERE id = :NEW.produit_id;
        END IF;

    END trg_GestionStock;


    -- TESTE POUR LA QUESTION 3
        INSERT INTO ligne_commande VALUES(121, 48, 9, 100, 0); -- Retourne une erreur  car 100 est > à 50
        INSERT INTO ligne_commande VALUES(121, 48, 9, 10, 0); -- Retourne une erreur  car 100 est > à 50
        SELECT * FROM produit; -- le produi9 dois avoir un stoque de 40


        
-- QUESTION 4
    /*
        Ecrire le trigger trg_DeleteClient qui gère la suppression d’un client; lorsqu’un client est
        supprimé de la table client, toutes les commandes de ce client sont supprimées et toutes les
        lignes de commande supprimée.
    */

    CREATE OR REPLACE TRIGGER trg_DeleteClient
    BEFORE DELETE ON client
    FOR EACH ROW
    BEGIN 
        -- Je supprimer les ligne dans ligne ligne de commande 
        DELETE FROM ligne_commande lc 
        WHERE lc.commande_id IN(
            SELECT c.id FROM commande c WHERE client_id = :OLD.id
        );

        -- je supprime les ligne dans la table commande 
        DELETE FROM commande WHERE client_id = :OLD.id;

    END trg_DeleteClient;


    -- TEST QUESTION 4
        -- Voir sa liste de commade avant de le suprimer
        SELECT * FROM client c
        JOIN commande co on c.id = co.client_id 
        JOIN ligne_commande lc ON lc.commande_id = co.id 
        WHERE c.id = 13;
        -- On le supprimer
        DELETE FROM client WHERE id = 13;
        -- Voir sa liste de commade avant de le suprimer
        SELECT * FROM client c
        JOIN commande co on c.id = co.client_id 
        JOIN ligne_commande lc ON lc.commande_id = co.id 
        WHERE c.id = 13;

--Question 5:

    /*
        On souhaite conserver les informations des anciens clients. Créer une table Client_His qui a la 
        même structure que la table client.  
        Modifier le trigger de la question 4 : les informations du client en cours de suppression 
        doivent être stockées dans la table d’historisation.
    */

    -- Je cree dbord la table Client_His
    CREATE table Client_His(
        id INTEGER PRIMARY KEY,
        prenom VARCHAR2(50),
        nom VARCHAR2(50),
        email VARCHAR2(75),
        ville VARCHAR2(50)
    );

    CREATE OR REPLACE TRIGGER trg_DeleteClient
    BEFORE DELETE ON client
    FOR EACH ROW
    BEGIN 
        -- Je supprimer les ligne dans ligne ligne de commande 
        DELETE FROM ligne_commande lc 
        WHERE lc.commande_id IN(
            SELECT c.id FROM commande c WHERE client_id = :OLD.id
        );

        -- je supprime les ligne dans la table commande 
        DELETE FROM commande WHERE client_id = :OLD.id;

        -- Je place le client dans la table Client_His
        INSERT INTO Client_His VALUES(
            :OLD.id,
            :OLD.nom,
            :OLD.prenom,
            :OLD.email,
            :OLD.ville
        );

    END trg_DeleteClient;

    -- TEST QUESTION 5
        
        INSERT INTO Client VALUES (21, 'Valentin', 'WIEGZORECK', 'patatipatata@jeSuisUnconnard', 'ANUS');

            DELETE FROM Client WHERE id = 21;

            SELECT * FROM CLIENT_His 
