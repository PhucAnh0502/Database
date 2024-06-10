CREATE OR REPLACE FUNCTION delete_personal_info(p_id INTEGER)
RETURNS VOID AS $$
DECLARE
    _customer_ID INT;
	_seller_ID INT;
    _product_IDs INT[];
	
BEGIN 
    SELECT seller_id INTO _seller_ID FROM sellers WHERE personal_id = p_id;
    SELECT cust_id INTO _customer_ID FROM customers WHERE personal_id = p_id;
    SELECT array_agg(prod_ID) INTO _product_IDs FROM products WHERE seller_ID = _seller_ID;
    
    
    DELETE FROM order_detail WHERE prod_ID = ANY(_product_IDs);
    DELETE FROM cart_product WHERE prod_ID = ANY(_product_IDs);
    DELETE FROM products WHERE seller_ID = _seller_ID;
    DELETE FROM sellers WHERE seller_ID = _seller_ID;
	DELETE FROM customers WHERE cust_ID = _customer_ID;
	DELETE FROM orders WHERE cust_ID = _customer_ID;
	DELETE FROM comments WHERE cust_ID = _customer_ID;
	DELETE FROM carts WHERE cust_ID = _customer_ID;
	DELETE FROM personal_info WHERE personal_id = p_id;
END;

$$ LANGUAGE plpgsql;
select delete_personal_info(10001)