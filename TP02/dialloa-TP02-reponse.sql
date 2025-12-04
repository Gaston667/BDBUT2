--Algassimou Pellel Diallo
--BDBUT2  tp01 date:21/11/2025

/* Question 1: Créer une séquence seq_tp ayant pour première valeur 121.
    Afficher sa valeur actuelle et la valeur suivante.
*/

    SET SERVEROUTPUT ON;
    CREATE SEQUENCE seq_tp
    START WITH 121
    -- BEGIN le bigin c'est du plsql donc si je l'utilise je dois faire un into
        SELECT seq_tp.CURRVAL, seq_tp.NEXTVAL FROM Dual; -- Ici j'ai un resltat où curr et next val la meme chose car next est prioritaire au curr
        SELECT seq_tp.Nextval, seq_tp.currval FROM Dual;
        -- ici ça marche je fais un curr puis un next 
        SELECT seq_tp.CURRVAL FROM Dual;
        SELECT seq_tp.NEXTVAL FROM Dual;
    --END;


/*  Question 2:
    Implémenter une procédure stockée sp_insert_ligne_commande(p_commande_id, 
    p_produit_id, p_quantite) qui permet d’insérer une ligne de commande dans la table 
    ligne_commande. Utiliser la séquence seq_tp créée précédemment pour l’id de la ligne de 
    commande. Le prix total doit être calculer dans la procédure.  
    Tester votre procédure avec un id de commande ou un id de produit qui n’existe pas. 
    Modifier la procédure précédente afin de gérer le cas où p_commande_id ou p_produit_id 
    n’existe pas. 
    NB : Une ligne de commande ne peut être insérée uniquement si la commande et le produit 
    existent déjà. 
*/

    CREATE OR REPLACE PROCEDURE sp_insert_ligne_commande(
        p_commande_id commande.id%TYPE, 
        p_produit_id  produit.id%TYPE, 
        p_quantite    INTEGER
    ) IS 
        v_prix_total      NUMBER := 0;
        v_commande_exist  INTEGER := 0;
        v_produit_exist   INTEGER := 0;
    BEGIN
        -- Vérification produit et commande
        SELECT COUNT(*) INTO v_produit_exist FROM produit p WHERE p.id = p_produit_id; 
        SELECT COUNT(*) INTO v_commande_exist FROM commande c WHERE c.id = p_commande_id; 

        IF v_commande_exist = 0 THEN
            DBMS_OUTPUT.PUT_LINE('La commande n existe pas'); -- ne pas utilise les ""
        ELSIF v_produit_exist = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('Le produit n existe pas');
        ELSE
            -- Calcul du prix total
            SELECT p.prix_unitaire * p_quantite 
            INTO v_prix_total
            FROM produit p 
            WHERE p.id = p_produit_id;

            -- Insertion de la ligne
            INSERT INTO ligne_commande 
            VALUES (seq_tp.NEXTVAL, p_commande_id, p_produit_id, p_quantite, v_prix_total);

            DBMS_OUTPUT.PUT_LINE('Ligne insérée avec succès.');
        END IF;

    END sp_insert_ligne_commande;
    /




-- Question 3 :  
   /*-----------------------------------------------------------
    Procédure : sp_frais_livraison
    Objectif  : Calculer les frais de livraison d'une commande
                en fonction du total de cette commande.
                
    Règles de calcul :
        - Total >= 100  → frais = 0 €
        - Total >= 50   → frais = 4 €
        - Total < 50    → frais = 10 €
    ------------------------------------------------------------*/
    CREATE OR REPLACE PROCEDURE sp_frais_livraison (
        p_commande_id      INT,        -- Identifiant de la commande
        p_frais_livraison  OUT NUMBER  -- Frais de livraison retournés
    ) IS
        v_total_commande NUMBER := 0;  -- Variable interne pour stocker le total
    BEGIN
        ------------------------------------------------------------
        -- 1) Calcul du total de la commande
        -- On additionne tous les prix_total des lignes associées
        -- à la commande passée en paramètre.
        ------------------------------------------------------------
        SELECT SUM(lc.prix_total)
        INTO v_total_commande
        FROM ligne_commande lc
        WHERE lc.commande_id = p_commande_id;

        ------------------------------------------------------------
        -- 2) Détermination des frais de livraison selon le total
        ------------------------------------------------------------
        IF v_total_commande >= 100 THEN
            -- Livraison gratuite
            p_frais_livraison := 0;

        ELSIF v_total_commande >= 50 THEN
            -- Tarif intermédiaire
            p_frais_livraison := 4;

        ELSE
            -- Petites commandes
            p_frais_livraison := 10;
        END IF;
    END sp_frais_livraison;
    /

-- Question 4 :  
    /*-----------------------------------------------------------
        Fonction : fn_frais_livraison
        Objectif  : Calculer les frais de livraison d'une commande
                    en fonction du total de cette commande.
                    
        Règles de calcul :
            - Total >= 100  → frais = 0 €
            - Total >= 50   → frais = 4 €
            - Total < 50    → frais = 10 €
        ------------------------------------------------------------*/
    CREATE OR REPLACE FUNCTION fn_frais_livraison (
        p_commande_id      INT        -- Identifiant de la commande
      
    )RETURN INTEGER AS 
        p_frais_livraison  OUT NUMBER; -- Frais de livraison retournés
        v_total_commande NUMBER := 0;  -- Variable interne pour stocker le total
    BEGIN
        ------------------------------------------------------------
        -- 1) Calcul du total de la commande
        -- On additionne tous les prix_total des lignes associées
        -- à la commande passée en paramètre.
        ------------------------------------------------------------
        SELECT SUM(lc.prix_total)
        INTO v_total_commande
        FROM ligne_commande lc
        WHERE lc.commande_id = p_commande_id;

        ------------------------------------------------------------
        -- 2) Détermination des frais de livraison selon le total
        ------------------------------------------------------------
        IF v_total_commande >= 100 THEN
            -- Livraison gratuite
            p_frais_livraison := 0;

        ELSIF v_total_commande >= 50 THEN
            -- Tarif intermédiaire
            p_frais_livraison := 4;

        ELSE
            -- Petites commandes
            p_frais_livraison := 10;
        END IF;
    END sp_frais_livraison;
    /


-- Question 5:
    /*-----------------------------------------------------------------------
        Fonction : fn_points_de_fidelite(id_clent)
        Objectif  : calculer les points de fidelite en fonction du nombre dachat efectuer

                    
        Règles de calcul :
            - Gestion des cas où le client n'existe pas
            - Gestion des cas où le client n'a pas fais de commande
            - Total achat = 10: +1
    -----------------------------------------------------------------------*/

    CREATE OR REPLACE FUNCTION fn_points_de_fidelite(
        p_id_clent    INT
    )RETURN INTEGER AS
        v_total_achat INT,
        v_total_point INT,
    BEGIN
        -- Verifions que le client existe
        SELECT COUNT(*) INTO v_total_achat
        FROM client c WHERE c.id = p_id_clent;
        IF v_total_achat = 0 THEN
            RETURN -1; -- Le client n'existe pas
        END IF;

        EXCEPTION -- Si on rancontre une exception on la gere ici
            WHEN NO_DATA_FOUND THEN
                RETURN -1; -- pas de data donc Le client n'existe pas
            WHEN OTHERS THEN
                RETURN -2; -- Une autre erreur est survenue
        END;

        -- Verifions que le client a fait des achats
        SELECT SUM(lc.prix_total) INTO v_total_achat
        FROM commande c JOIN ligne_commande lc ON c.id = lc.commande_id
        WHERE c.client_id = p_id_clent;

        IF v_total_achat IS NULL OR v_total_achat = 0 THEN
            RETURN 0; -- Le client n'a pas fait d'achat
        END IF;
        -- Calcul des points de fidelite
        v_total_point := FLOOR(v_total_achat / 10);
        RETURN v_total_point;

    END fn_points_de_fidelite;

    -- BLOC TEST DE LA FONCTION A LA QUESTION 5
    DECLARE
        v_points INTEGER;
        v_nom_client CLIENT.nom%TYPE;
    BEGIN
        v_points := fn_points_de_fidelite(1);
        SELECT nom INTO v_nom_client FROM client WHERE id = 1;
        DBMS_OUTPUT.PUT_LINE('Le client ' || v_nom_client || ' a ' || v_points || ' points de fidélité.');
    END;


-- Question 6:
    /*-----------------------------------------------------------------------
    Fonction : fn_Date_Dernier_Achat(Nom_produit)
    Objectif  : retourner la date du dernier achat d'un produit donné sous la
                forme d'une chaîne de caractères au format le produit X a pour dernière date d'achat yyyy/mm/dd.

    Programation Defensive :
        - Gestion des cas où le produit n'existe pas
        - Gestion des cas où le produit n'a jamais été acheté

    Logique :
        - Vérifier si le produit existe
        - Si le produit n'existe pas, retourner un message approprié
        - Si le produit existe, vérifier s'il a été acheté
        - Si le produit n'a jamais été acheté, retourner un message approprié
        - Si le produit a été acheté, récupérer la date du dernier achat et formater la chaîne de caractères de sortie

    -----------------------------------------------------------------------*/

    CREATE OR RAPLCE FUNCTION fn_Date_Dernier_Achat(
        p_Nom_produit    VARCHAR2
    )RETURN VARCHAR2 AS
        v_produit_exist   INTEGER := 0;
        v_date_dernier_achat DATE;
        v_out_resultat VARCHAR2(100);
    BEGIN
        -- Vérification si le produit existe
        SELECT CONT(*) INTO v_produit_exist
        FROM produit p WHERE p.nom = p_Nom_produit;
        IF v_produit_exist = 0 THEN
            RETURN 'Le produit ' || p_Nom_produit || ' n existe pas.';
        END IF;


        -- Vérification si le produit a été acheté
        SELECT MAX(c.date_commande) INTO v_date_dernier_achat
        FROM commande c 
        JOIN ligne_commande lc ON c.id = lc.commande_id
        JOIN produit p ON lc.produit_id = p.id
        WHERE p.nom = p_Nom_produit;
        IF v_date_dernier_achat IS NULL THEN
            RETURN 'Le produit ' || p_Nom_produit || ' n a jamais été acheté.';
        END IF;

        -- Formatage du résultat
        v_out_resultat := 'Le produit ' || p_Nom_produit || ' a pour dernière date d achat ' || TO_CHAR(v_date_dernier_achat, 'YYYY/MM/DD') || '.';
        RETURN v_out_resultat;
    END fn_Date_Dernier_Achat;

    -- BLOC TEST DE LA FONCTION A LA QUESTION 6
    DECLARE
    BEGIN
        DBMS_OUTPUT.PUT_LINE(fn_Date_Dernier_Achat('ICI'));
    END;