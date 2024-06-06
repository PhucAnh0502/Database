-- Doi "e_shop." thanh ten schema cua ban than truoc khi chay file, neu ko duoc thi xoa schema create lai cai moi co san quan he
ALTER TABLE IF EXISTS e_shop.admins
    ADD CONSTRAINT admin_id PRIMARY KEY (admin_id)
    INCLUDE (admin_id);


ALTER TABLE IF EXISTS e_shop.personal_info
    ADD CONSTRAINT personal_info_pkey PRIMARY KEY (personal_id)
    INCLUDE (personal_id);
ALTER TABLE IF EXISTS e_shop.personal_info
    ADD CONSTRAINT personal_info_admin_id_fkey FOREIGN KEY (admin_id)
    REFERENCES e_shop.admins (admin_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id)
    INCLUDE (category_id);


ALTER TABLE IF EXISTS e_shop.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (dis_id)
    INCLUDE (dis_id);
ALTER TABLE IF EXISTS e_shop.discounts
    ADD CONSTRAINT discounts_admin_id_fkey FOREIGN KEY (admin_id)
    REFERENCES e_shop.admins (admin_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (cust_id)
    INCLUDE (cust_id);
ALTER TABLE IF EXISTS e_shop.customers
    ADD CONSTRAINT customers_personal_id_fkey FOREIGN KEY (personal_id)
    REFERENCES e_shop.personal_info (personal_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (prod_id)
    INCLUDE (prod_id);
ALTER TABLE IF EXISTS e_shop.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES e_shop.categories (category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS e_shop.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id)
    REFERENCES e_shop.sellers (seller_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (prod_id, cust_id)
    INCLUDE (prod_id, cust_id);
ALTER TABLE IF EXISTS e_shop.comments
    ADD CONSTRAINT comments_cust_id_fkey FOREIGN KEY (cust_id)
    REFERENCES e_shop.customers (cust_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id)
    INCLUDE (order_id);
ALTER TABLE IF EXISTS e_shop.orders
    ADD CONSTRAINT orders_cust_id_fkey FOREIGN KEY (cust_id)
    REFERENCES e_shop.customers (cust_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.order_detail
    ADD CONSTRAINT order_detail_pkey PRIMARY KEY (order_detail_id)
    INCLUDE (order_detail_id);
ALTER TABLE IF EXISTS e_shop.order_detail
    ADD CONSTRAINT order_detail_dis_id_fkey FOREIGN KEY (dis_id)
    REFERENCES e_shop.discounts (dis_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS e_shop.order_detail
    ADD CONSTRAINT order_detail_order_id_fkey FOREIGN KEY (order_id)
    REFERENCES e_shop.orders (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS e_shop.order_detail
    ADD CONSTRAINT order_detail_prod_id_fkey FOREIGN KEY (prod_id)
    REFERENCES e_shop.products (prod_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id)
    INCLUDE (cart_id);
ALTER TABLE IF EXISTS e_shop.carts
    ADD CONSTRAINT carts_cust_id_fkey FOREIGN KEY (cust_id)
    REFERENCES e_shop.customers (cust_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS e_shop.cart_product
   ADD CONSTRAINT cart_product_pkey PRIMARY KEY (cart_id, prod_id)
        INCLUDE(cart_id, prod_id)
ALTER TABLE IF EXISTS e_shop.cart_product		
   ADD CONSTRAINT cart_product_prod_id_fkey FOREIGN KEY (prod_id)
        REFERENCES e_shop.products (prod_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)




