CREATE OR REPLACE FUNCTION order_products(
	customer_id INT, 
	product_ids INT[], 
	prod_quantities INT[],
	d_id int, 
	paytype TEXT)
RETURNS TABLE(
	cust_id INT, 
	prod_name TEXT, 
	quantity INT, 
	order_date DATE,
	dis_percent int, 
	payment_type TEXT, 
	payment_date DATE) AS $$
DECLARE
    o_order_id INT;
    prod_id INT;
    prod_quantity INT;
BEGIN
    -- Kiểm tra độ dài của mảng product_ids và prod_quantities
    IF array_length(product_ids, 1) 
	IS DISTINCT FROM array_length(prod_quantities, 1) THEN
        RAISE EXCEPTION 'Product IDs and quantities must have the same length';
    END IF;

    -- Thêm vào bảng orders
    INSERT INTO orders (cust_id, order_date, payment_type, payment_date) 
    VALUES (customer_id, CURRENT_DATE, paytype, CURRENT_DATE)
    RETURNING order_id INTO o_order_id;

    -- Thêm các sản phẩm vào bảng order_detail
       FOR i IN 1..array_length(product_ids, 1) LOOP
        prod_id := product_ids[i];
        prod_quantity := prod_quantities[i];

        IF d_id IS NOT NULL THEN
            INSERT INTO order_detail (order_id, prod_id, dis_id, quantity)
            VALUES (o_order_id, prod_id, d_id, prod_quantity);
        ELSE
            INSERT INTO order_detail (order_id, prod_id, quantity)
            VALUES (o_order_id, prod_id, prod_quantity);
        END IF;
    END LOOP;

    -- Trả về bảng kết quả
    RETURN QUERY
    SELECT 	o.cust_id, 
			p.prod_name::text, 
			od.quantity, 
			o.order_date, 
			COALESCE(d.dis_percent, NULL) AS dis_percent,
			o.payment_type::text, 
			o.payment_date
    FROM order_detail od
    JOIN orders o ON o.order_id = od.order_id
    JOIN products p ON p.prod_id = od.prod_id
	LEFT JOIN discounts d ON d.dis_id = od.dis_id
    WHERE o.cust_id = customer_id
    AND o.order_id = o_order_id;
END;
$$ LANGUAGE plpgsql;

--SELECT * FROM order_products(702, ARRAY[101, 102, 103], ARRAY[2, 1, 4],6, 'credit_card');
