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

    CREATE OR REPLACE PROCEDURE sp_insert_ligne_commande(p_commande_id commande.id%TYPE, 
                    p_produit_id produit.id%TYPE, p_quantite INTEGER)
    IS 
        v_prix_total NUMBER := 0;
        v_commande_exist INTEGER := 0;
        v_produit_exist INTEGER := 0;
    BEGIN
        --  Verification que le produit existe
        SELECT count(*) INTO v_produit_exist From produit p WHERE p.id = p_produit_id; 
        SELECT count(*) INTO v_commande_exist From commande c WHERE c.id = p_commande_id; 
            A finir ya erreur
        IF v_commande_exist = 0 THEN
            DBMS_OUTPUT.PUT_LINE("La commande n'exite pas");
        ElSE IF v_produit_exist = 0 THEN 
            DBMS_OUTPUT.PUT_LINE("Le Produit n'existe pas");
        ElSE
            -- Je calcul le pris total
            SELECT p.prix_unitaire * p_quantite INTO v_prix_total
            FROM produit p WHERE p_produit_id = p.id;
            -- Je Fais la requuette pour l'insertion
            INSERT INTO ligne_commande VALUES (seq_tp.Nextval, p_commande_id, p_produit_id, p_quantite, v_prix_total);
        END IF;
    END sp_insert_ligne_commande /


    -- TEST de sp_insert_ligne_commande



-- Question 3 :  

    /*3- On souhaite calculer les frais de livraisons des commandes. Implémenter une procédure
        sp_frais_livraison (p_commande_id INT, p_frais_livraison OUT NUMBER) qui calcule
        les frais de livraison d’une commande.
        p_frais_livraison est un paramètre de sortie.
        Les frais de livraisons valent :
        ➢ 0 si commande>= 100 euros
        ➢ 4 si commande>= 50 euros et < 100euros
        ➢ 10 si commande < 50 euros.
    */

    CREATE OR REPLACE PROCEDURE sp_frais_livraison (p_commande_id INT, p_frais_livraison OUT NUMBER)
    IS 
        v_total_commande INTEGER := 0;
    BEGIN
        --  calculons le total de la commande
        SELECT SUM(lc.prix_total) INTO v_total_commande From ligne_commande lc WHERE lc.commande_id = p_commande_id; 
            
        -- Calculons les frais en fonction du total
        IF v_total_commande >= 100 THEN
            p_frais_livraison := 0;
        ElSE IF v_total_command >= 50 THEN 
           p_frais_livraison = 4
        ElSE
            p_frais_livraison := 10;
        END IF;
    END /

