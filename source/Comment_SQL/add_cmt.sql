CREATE OR REPLACE FUNCTION add_comment(p_id INT, c_id INT,body TEXT)
RETURNS VOID AS $$
BEGIN
	INSERT INTO comments(prod_id, cust_id, comment_date, content)
	VALUES(p_id, c_id, current_timestamp, body);
END;
$$
LANGUAGE plpgsql;
