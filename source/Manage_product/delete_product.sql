CREATE OR REPLACE FUNCTION delete_product(p_productid INTEGER)
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

    -- Xóa sản phẩm nếu productid tồn tại
    DELETE FROM products WHERE prod_id = p_productid;

    RETURN 'Product deleted successfully';
END;
$$ LANGUAGE plpgsql;
