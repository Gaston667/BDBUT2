--Algassimou Pellel Diallo
--BDBUT2  tp01 date:07/11/2025


-- 1- Mettre à jour la colonne Prix_total de la relation ligne_commande en implémentant la requête vue en TD.
    UPDATE ligne_commande lc
    SET prix_total = (SELECT p.prix_unitaire * lc.quantite
                        From PRODUIT p where lc.produit_id = p.id);
    

-- 2 Implémenter les requêtes du TD et exécuter les.
    -- TD Question 2:
       SET SERVEROUTPUT ON;
       DECLARE 
        v_prenom client.prenom %TYPE;
        v_nom CLIENT.nom %TYPE;
        BEGIN
            SELECT prenom, nom INTO v_prenom, v_nom
            From client where id = 1;
            DBMS_OUTPUT.PUT_LINE(v_prenom ||'  '|| v_nom);
        END;
        /

    -- TD Question 3:   Recuperer toutes les informations de la commande ayant l'id 1 en vous servant de %ROWTYPE et afficher les 
        SET SERVEROUTPUT ON;
        DECLARE 
            v_commande COMMANDE%ROWTYPE;
        BEGIN
            SELECT * INTO v_commande From commande where id = 1;
            DBMS_OUTPUT.PUT_LINE('Les informatios sont : '|| v_commande.id||' '|| v_commande.client_id||' ' || v_commande.date_achat||' ' || v_commande.reference);
        END;
        /
                    
    -- TD Question 4:  Crée un RECORD pour y stocker les informations des clients ayant l'id 1 et afficher les informations du produit.
        SET SERVEROUTPUT ON;
        DECLARE
            TYPE V_clientstruct IS RECORD (
                id      client.id%TYPE,
                prenom  client.prenom%TYPE,
                nom     client.nom%TYPE,
                email   client.email%TYPE,
                ville   client.ville%TYPE
            );

            vcs V_clientstruct;
        BEGIN
            SELECT id, prenom, nom, email, ville
            INTO vcs
            FROM client
            WHERE id = 1;

            DBMS_OUTPUT.PUT_LINE('--- Informations du client ---');
            DBMS_OUTPUT.PUT_LINE('ID      : ' || vcs.id);
            DBMS_OUTPUT.PUT_LINE('Prénom  : ' || vcs.prenom);
            DBMS_OUTPUT.PUT_LINE('Nom     : ' || vcs.nom);
            DBMS_OUTPUT.PUT_LINE('Email   : ' || vcs.email);
            DBMS_OUTPUT.PUT_LINE('Ville   : ' || vcs.ville);
        END;
        /

    -- TD Question 5: En utilis




