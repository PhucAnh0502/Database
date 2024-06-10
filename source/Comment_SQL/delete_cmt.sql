CREATE OR REPLACE FUNCTION delete_comment(p_id INT, c_id INT)
RETURNS VOID AS $$
BEGIN
	DELETE FROM comments WHERE p_id = prod_id AND c_id = cust_id;
END;
$$
LANGUAGE plpgsql;
