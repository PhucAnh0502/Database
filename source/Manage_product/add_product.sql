CREATE OR REPLACE FUNCTION add_product(
    p_categoryid INTEGER,
    p_description TEXT,
    p_productname VARCHAR(100),
    p_sellerid INTEGER,
	p_discountid INTEGER,
    p_price NUMERIC(10, 2),
    p_image TEXT
)
RETURNS TEXT AS $$
DECLARE
    new_productid INTEGER;
    category_exists BOOLEAN;
    seller_exists BOOLEAN;
BEGIN
    -- Kiểm tra xem categoryid có tồn tại
    SELECT EXISTS (SELECT 1 FROM categories WHERE category_id = p_categoryid) INTO category_exists;
    IF NOT category_exists THEN
        RETURN 'Error: Category ID does not exist';
    END IF;

    -- Kiểm tra xem sellerid có tồn tại
    SELECT EXISTS (SELECT 1 FROM sellers WHERE seller_id = p_sellerid) INTO seller_exists;
    IF NOT seller_exists THEN
        RETURN 'Error: Seller ID does not exist';
    END IF;

    -- Thêm sản phẩm mới nếu categoryid và sellerid hợp lệ
    INSERT INTO products (category_id, description, prod_name, seller_id, price, picture, dis_id)
    VALUES (p_categoryid, p_description, p_productname, p_sellerid, p_price, p_image, p_discountid)
    RETURNING prod_id INTO new_productid;

    RETURN 'Product added with ID: ' || new_productid;
END;
$$ LANGUAGE plpgsql;
