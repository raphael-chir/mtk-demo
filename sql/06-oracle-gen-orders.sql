-- Désactiver la substitution de variables pour éviter les prompts
SET DEFINE OFF;

DECLARE
    v_order_id NUMBER;
    v_line_id  NUMBER := 1;
    v_customer_id NUMBER;
    v_product_id NUMBER;
    v_quantity NUMBER;
    v_unit_price NUMBER;
    v_total_amount NUMBER;
    v_activity_log CLOB;
BEGIN
    -- Boucle sur les clients
    FOR c IN (SELECT customer_id FROM customers) LOOP
        v_customer_id := c.customer_id;

        -- Pour chaque client, générer 2 à 4 commandes
        FOR o IN 1..FLOOR(DBMS_RANDOM.VALUE(2,5)) LOOP
            v_total_amount := 0;
            v_activity_log := '';

            -- Insérer la commande
            INSERT INTO orders (order_id, customer_id, order_date, total_amount, activity_log)
            VALUES (orders_seq.NEXTVAL, v_customer_id, SYSDATE - DBMS_RANDOM.VALUE(1,100), NULL, NULL)
            RETURNING order_id INTO v_order_id;

            -- Générer 1 à 5 lignes de commande
            FOR l IN 1..FLOOR(DBMS_RANDOM.VALUE(1,6)) LOOP
                -- Choisir un produit aléatoire
                SELECT product_id, price INTO v_product_id, v_unit_price
                FROM (SELECT product_id, price FROM products ORDER BY DBMS_RANDOM.VALUE)
                WHERE ROWNUM = 1;

                -- Choisir une quantité aléatoire entre 1 et 3
                v_quantity := FLOOR(DBMS_RANDOM.VALUE(1,4));

                -- Insérer la ligne de commande
                INSERT INTO order_lines (line_id, order_id, product_id, quantity, unit_price)
                VALUES (order_lines_seq.NEXTVAL, v_order_id, v_product_id, v_quantity, v_unit_price);

                -- Calculer le total
                v_total_amount := v_total_amount + v_quantity * v_unit_price;

                -- Ajouter une ligne dans le activity_log
                v_activity_log := v_activity_log ||
                    TO_CHAR(SYSDATE - DBMS_RANDOM.VALUE(0,10), 'YYYY-MM-DD HH24:MI:SS') ||
                    ' - Added product ' || v_product_id || ' x' || v_quantity || CHR(10);
            END LOOP;

            -- Ajouter des étapes de suivi supplémentaires
            v_activity_log := v_activity_log ||
                TO_CHAR(SYSDATE - DBMS_RANDOM.VALUE(0,2), 'YYYY-MM-DD HH24:MI:SS') || ' - Order processed' || CHR(10) ||
                TO_CHAR(SYSDATE - DBMS_RANDOM.VALUE(0,1), 'YYYY-MM-DD HH24:MI:SS') || ' - Shipped via UPS' || CHR(10) ||
                TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || ' - Delivered' || CHR(10);

            -- Mettre à jour la commande avec total_amount et activity_log
            UPDATE orders
            SET total_amount = v_total_amount,
                activity_log = v_activity_log
            WHERE order_id = v_order_id;
        END LOOP;
    END LOOP;
    COMMIT;
END;
/
