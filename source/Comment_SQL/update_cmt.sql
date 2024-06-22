CREATE OR REPLACE FUNCTION update_comment(p_id INT, c_id INT, body TEXT)
RETURNS TEXT AS $$
BEGIN
    UPDATE comments
    SET comment_date = current_date,
        content = body
    WHERE prod_id = p_id AND cust_id = c_id;
    
    IF NOT FOUND THEN
        RETURN 'This comment does not exist';
    END IF;
    
    RETURN 'Comment updated successfully';
END;
$$
LANGUAGE plpgsql;
