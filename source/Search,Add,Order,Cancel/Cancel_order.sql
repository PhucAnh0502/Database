CREATE OR REPLACE FUNCTION cancel_order(o_id INT)
RETURNS TEXT AS $$
DECLARE
    o_id_exists BOOLEAN;
BEGIN
    -- Kiểm tra xem order_id có tồn tại
    SELECT EXISTS (SELECT 1 FROM orders WHERE order_id = o_id) INTO o_id_exists;
    
    -- Nếu order_id không tồn tại, trả về thông báo lỗi
    IF NOT o_id_exists THEN
        RETURN 'Error: Order ID does not exist';
    END IF;
    -- Xóa các chi tiết đơn hàng từ bảng order_detail
    DELETE FROM order_detail
    WHERE order_id = o_id;

    -- Xóa đơn hàng từ bảng orders
    DELETE FROM orders
    WHERE order_id = o_id;
	return 'Cancel Successfully';
END;
$$ LANGUAGE plpgsql;
