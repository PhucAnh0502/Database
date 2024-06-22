CREATE OR REPLACE FUNCTION get_order_sums(c_id INT)
RETURNS TABLE(order_id INT, order_sum FLOAT) AS $$
DECLARE
    rec RECORD;
    current_date DATE := CURRENT_DATE;
    array_size INT;
    i INT;
    sum FLOAT;
BEGIN
    FOR rec IN
        SELECT 
            orders.order_id AS o_id,
            array_agg(order_detail.prod_ID) AS _product_IDs,
            array_agg(order_detail.quantity) AS quan,
            array_agg(products.price) AS prices,
            array_agg(discounts.dis_percent) AS discount_percent,
            array_agg(discounts.start_date) AS s_date,
            array_agg(discounts.end_date) AS e_date
        FROM
            orders
        LEFT JOIN
            order_detail ON orders.order_id = order_detail.order_id
        LEFT JOIN
            products ON order_detail.prod_ID = products.prod_id
        LEFT JOIN
            discounts ON products.dis_id = discounts.dis_id
        WHERE
            orders.cust_id = c_id AND order_detail.prod_ID IS NOT NULL
        GROUP BY
            orders.order_id
    LOOP
        sum := 0.0;
        array_size := cardinality(rec._product_IDs);

        FOR i IN 1..array_size LOOP
            IF rec.s_date[i] IS NOT NULL AND rec.e_date[i] IS NOT NULL AND rec.s_date[i] < current_date AND current_date < rec.e_date[i] THEN
                sum := sum + rec.prices[i] * rec.quan[i] * (1 - rec.discount_percent[i] / 100.0);
            ELSE
                sum := sum + rec.prices[i] * rec.quan[i];
            END IF;
        END LOOP;
        order_id := rec.o_id;
        order_sum := sum;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
