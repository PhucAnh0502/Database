CREATE OR REPLACE FUNCTION add_to_cart(customer_id int, product_id name, prod_quantity int)
RETURNS TABLE(cart_id int, cust_id int, prod_name text, quantity int) AS $$
DECLARE
    v_cart_id int;
    v_prod_id int;
    v_quantity int;
BEGIN 
    -- Check if the product exists and get the product ID
    SELECT prod_id INTO v_prod_id
    FROM products p
    WHERE p.prod_id = product_id;

    -- Check if the customer has an existing cart
    SELECT carts.cart_id INTO v_cart_id
    FROM carts
    WHERE carts.cust_id = customer_id;
    
    IF v_cart_id IS NULL THEN
        -- Customer does not have a cart, create a new cart
        INSERT INTO carts (cust_id) VALUES (customer_id) RETURNING cart_id INTO v_cart_id;
    END IF;
    
    -- Check if the product is already in the cart
    SELECT cart_product.quantity INTO v_quantity
    FROM cart_product
    WHERE cart_product.cart_id = v_cart_id AND cart_product.prod_id = v_prod_id;
    
    IF v_quantity IS NULL THEN
        -- Product is not in the cart, add it
        INSERT INTO cart_product (cart_id, prod_id, quantity)
        VALUES (v_cart_id, v_prod_id, prod_quantity);
    ELSE
        -- Product is already in the cart, update the quantity
        UPDATE cart_product cp
        SET quantity = cp.quantity + prod_quantity
        WHERE cp.cart_id = v_cart_id AND cp.prod_id = v_prod_id;
    END IF;
    
    -- Return the updated cart details
    RETURN QUERY
    SELECT c.cart_id, c.cust_id, p.prod_name::text, cp.quantity
    FROM carts c
    JOIN cart_product cp ON c.cart_id = cp.cart_id
    JOIN products p ON cp.prod_id = p.prod_id
    WHERE c.cart_id = v_cart_id;
END;
$$ LANGUAGE plpgsql;
