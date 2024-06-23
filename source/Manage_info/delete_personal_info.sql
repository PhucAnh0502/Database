CREATE OR REPLACE FUNCTION delete_account(p_id INT)
RETURNS TEXT AS $$
DECLARE
    _customer_ID INT;
    _seller_ID INT;
    _product_IDs INT[];
    cart_IDs INT;
    o_id INT[];
    info_exists BOOLEAN;
BEGIN 
    
    SELECT EXISTS (SELECT 1 FROM personal_info WHERE personal_id = p_id) INTO info_exists;
    IF NOT info_exists THEN
        RETURN 'Error: Personal ID does not exist';
    END IF;
 
   
    SELECT seller_id INTO _seller_ID FROM sellers WHERE personal_id = p_id;
    SELECT cust_id INTO _customer_ID FROM customers WHERE personal_id = p_id;

    SELECT COALESCE(array_agg(prod_ID), '{}') INTO _product_IDs FROM products WHERE seller_ID = _seller_ID;
    
    SELECT cart_id INTO cart_IDs FROM carts WHERE cust_id = _customer_ID;
   
    SELECT COALESCE(array_agg(order_id), '{}') INTO o_id FROM orders WHERE cust_id = _customer_ID;

  
    BEGIN
		DELETE FROM comments WHERE cust_ID = _customer_ID;
        DELETE FROM comments WHERE prod_ID = ANY(_product_IDs);
        
        DELETE FROM order_detail WHERE prod_ID = ANY(_product_IDs);
        DELETE FROM order_detail WHERE order_id = ANY(o_id);
        
        DELETE FROM cart_product WHERE cart_id = cart_IDs;
        DELETE FROM cart_product WHERE prod_ID = ANY(_product_IDs);
        
        DELETE FROM products WHERE seller_ID = _seller_ID;
        
        DELETE FROM carts WHERE cust_ID = _customer_ID;
       
        DELETE FROM orders WHERE order_id = ANY(o_id);
       
        DELETE FROM customers WHERE cust_ID = _customer_ID;
        DELETE FROM sellers WHERE seller_ID = _seller_ID;
        
        DELETE FROM personal_info WHERE personal_id = p_id;
        
        RETURN 'Account deleted successfully';
    
    END;
END;
$$ LANGUAGE plpgsql;
