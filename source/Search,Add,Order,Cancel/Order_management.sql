
CREATE OR REPLACE FUNCTION log_transaction_history()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO transaction_history (
            order_id, customer_id, product_id, quantity, price, discount_percent, action
        ) VALUES (
            NEW.order_id, (SELECT cust_id FROM orders WHERE order_id = NEW.order_id),
            NEW.prod_id, NEW.quantity,
            (SELECT price FROM products WHERE prod_id = NEW.prod_id),
            (SELECT discounts.dis_percent 
			 FROM discounts JOIN products ON products.dis_id = discounts.dis_id
			 WHERE prod_id = NEW.prod_id),
            'INSERT'
        );
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO transaction_history (
            order_id, customer_id, product_id, quantity, price, discount_percent, action
        ) VALUES (
            NEW.order_id, (SELECT cust_id FROM orders WHERE order_id = NEW.order_id),
            NEW.prod_id, NEW.quantity,
            (SELECT price FROM products WHERE prod_id = NEW.prod_id),
            (SELECT discounts.dis_percent 
			 FROM discounts JOIN products ON products.dis_id = discounts.dis_id
			 WHERE prod_id = NEW.prod_id),
            'UPDATE'
        );
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO transaction_history (
            order_id, customer_id, product_id, quantity, price, discount_percent, action
        ) VALUES (
            OLD.order_id, (SELECT cust_id FROM orders WHERE order_id = OLD.order_id),
            OLD.prod_id, OLD.quantity,
            (SELECT price FROM products WHERE prod_id = OLD.prod_id),
            (SELECT discounts.dis_percent 
			 FROM discounts JOIN products ON products.dis_id = discounts.dis_id
			 WHERE prod_id = OLD.prod_id),
            'DELETE');
    END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_log_transaction_history
AFTER INSERT OR UPDATE OR DELETE ON order_detail
FOR EACH ROW
EXECUTE FUNCTION log_transaction_history();
