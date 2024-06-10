CREATE OR REPLACE FUNCTION update_comment(p_id INT, c_id INT, body TEXT)
RETURNS VOID AS $$
BEGIN
	UPDATE comments
	SET comment_date = current_time,
		content = body
	WHERE p_id = prod_id AND c_id = cust_id;
END;
$$
LANGUAGE plpgsql;
