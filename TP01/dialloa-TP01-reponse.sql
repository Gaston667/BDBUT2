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



-- Question 4: 
    /*  Ecrire une requête qui retourne le montant total dépensé par chaque client de la table    client ; le résultat rangé par ordre décroissant de montant_total dépensé.

    Logique:
        - Faire une jointure entre les tables client, commande et ligne_commande pour relier les clients à leurs commandes et aux lignes de commande associées.
        - Utiliser la fonction d'agrégation SUM pour calculer le montant total dépensé par chaque client en sommant les prix_totaux des lignes de commande.
        - Grouper les résultats par l'identifiant du client pour obtenir un total par client.
        - Trier les résultats par montant_total en ordre décroissant. 
    */

    -- Requête SQL:
    SELECT c.nom, c.prenom, SUM(lc.prix_total) AS montant_total 
    FROM client c 
    JOIN commande co on co.client_id = c.id 
    JOIN ligne_commande lc on lc.commande_id = co.id
    GROUP BY c.id, c.nom, c.prenom -- toute les colonnes non agrégées présentes dans le SELECT doivent être dans le GROUP BY mais aussi
    -- l'identifiant du client pour éviter les ambiguïtés avec les clients ayant le même nom et prénom
    ORDER BY montant_total DESC;