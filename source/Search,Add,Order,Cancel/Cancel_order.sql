CREATE OR REPLACE FUNCTION cancel_order(o_id INT)
RETURNS VOID AS $$
BEGIN
    -- Xóa các chi tiết đơn hàng từ bảng order_detail
    DELETE FROM order_detail
    WHERE order_id = o_id;

    -- Xóa đơn hàng từ bảng orders
    DELETE FROM orders
    WHERE order_id = o_id;

    -- Kiểm tra xem đơn hàng đã được hủy thành công chưa
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Order ID % does not exist', o_id;
    END IF;
END;
$$ LANGUAGE plpgsql;
