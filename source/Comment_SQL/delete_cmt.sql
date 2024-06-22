CREATE OR REPLACE FUNCTION delete_comment(p_id INT, c_id INT)
RETURNS TEXT AS $$
DECLARE
    product_exists BOOLEAN;
    customer_exists BOOLEAN;
BEGIN
	-- Kiểm tra xem customerid có tồn tại
    SELECT EXISTS (SELECT 1 FROM customers WHERE cust_id = c_id) INTO customer_exists;
    IF NOT customer_exists THEN
        RETURN 'Error: Customer ID does not exist';
    END IF;

    -- Kiểm tra xem productid có tồn tại
    SELECT EXISTS (SELECT 1 FROM products WHERE prod_id = p_id) INTO product_exists;
    IF NOT product_exists THEN
        RETURN 'Error: Product ID does not exist';
    END IF;
	
	-- Xóa comment	
	DELETE FROM comments WHERE p_id = prod_id AND c_id = cust_id;
	RETURN 'Comment deleted successfully';
END;
$$
LANGUAGE plpgsql;
