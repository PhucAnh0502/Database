CREATE OR REPLACE FUNCTION update_comment(p_id INT, c_id INT, body TEXT)
RETURNS TEXT AS $$
BEGIN
	UPDATE comments
	SET comment_date = current_time,
		content = body
	WHERE p_id = prod_id AND c_id = cust_id;
	IF NOT FOUND THEN RAISE EXCEPTION 'This comment does not exist';
	END IF;
END;
$$
LANGUAGE plpgsql;
