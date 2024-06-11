CREATE OR REPLACE FUNCTION update_product(
    p_productid INTEGER,
    p_categoryid INTEGER,
    p_description TEXT,
    p_productname VARCHAR(100),
    p_sellerid INTEGER,
    p_price NUMERIC(10, 2),
    p_image TEXT
)
RETURNS TEXT AS $$
DECLARE
    product_exists BOOLEAN;
BEGIN
    -- Kiểm tra xem productid có tồn tại
    SELECT EXISTS (SELECT 1 FROM products WHERE prod_id = p_productid) INTO product_exists;
    
    -- Nếu productid không tồn tại, trả về thông báo lỗi
    IF NOT product_exists THEN
        RETURN 'Error: Product ID does not exist';
    END IF;

    -- Cập nhật sản phẩm nếu productid tồn tại
    UPDATE products
    SET 
        category_id = COALESCE(p_categoryid, category_id),
        description = COALESCE(p_description, description),
        prod_name = COALESCE(p_productname, prod_name),
        seller_id = COALESCE(p_sellerid, seller_id),
        price = COALESCE(p_price, price),
        picture = COALESCE(p_image, picture)
    WHERE prod_id = p_productid;

    RETURN 'Product updated successfully';
END;
$$ LANGUAGE plpgsql;
