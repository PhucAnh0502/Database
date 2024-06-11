CREATE OR REPLACE FUNCTION search_products_by_name(product_name TEXT)
RETURNS TABLE(prod_id INT, prod_name TEXT, category_name TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT p.prod_id, p.prod_name::text, c.category_name::text
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    WHERE p.prod_name ILIKE '%' || product_name || '%';
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_products_by_category(product_category_id INT)
returns table(prod_id INT, prod_name TEXT, category_name TEXT) AS $$
BEGIN
	return query
	select p.prod_id, p.prod_name::text, c.category_name::text
	from products p
	join categories c on p.category_id = c.category_id
	where c.category_id = product_category_id;
end;
$$ LANGUAGE plpgsql;

