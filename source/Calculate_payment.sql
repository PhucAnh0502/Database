CREATE OR REPLACE FUNCTION calculate_payment(c_id INT)
RETURNS FLOAT AS $$
DECLARE
    _product_IDs INT[];
	o_id INT;
	d_id INT[];
	quan INT[];
	prices INT[];
	discount_percent INT[];
	s_date date[];
	e_date date[];
	i int;
    current_date date := CURRENT_DATE;
    array_size int ;
    sum float := 0.0;
BEGIN
	SELECT order_id INTO o_id FROM orders WHERE c_id=cust_id;
	SELECT array_agg(order_detail.prod_ID) INTO _product_IDs FROM order_detail WHERE order_ID = o_ID;
	SELECT array_agg(order_detail.dis_id) INTO d_id FROM order_detail WHERE order_ID = o_ID;
	SELECT array_agg(order_detail.quantity) INTO quan FROM order_detail WHERE order_ID = o_ID;
	SELECT array_agg(products.price) INTO prices FROM products WHERE prod_id = ANY(_product_IDs);
	SELECT array_agg(discounts.dis_percent) INTO discount_percent FROM discounts WHERE dis_id = ANY(d_id);
	SELECT array_agg(discounts.start_date) INTO s_date FROM discounts WHERE dis_id = ANY(d_id);
	SELECT array_agg(discounts.end_date) INTO e_date FROM discounts WHERE dis_id = ANY(d_id);
  	
	array_size := array_length( _product_IDs, 1);
	IF array_size is NULL THEN RAISE EXCEPTION 'This customer has 0 product';
	END IF;
 
    FOR i IN 1..array_size LOOP
        IF s_date[i] < current_date AND current_date < e_date[i] THEN
            sum := sum + prices[i] * quan[i] * (discount_percent[i]/100.0);
        ELSE
            sum := sum + prices[i] * quan[i];
        END IF;
    END LOOP;
    RETURN sum;
END;
$$ LANGUAGE plpgsql;
