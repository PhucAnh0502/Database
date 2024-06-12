-- Doi "public." thanh ten schema cua ban than truoc khi chay file, neu ko duoc thi xoa schema create lai cai moi co san quan he
ALTER TABLE IF EXISTS public.admins
    ADD CONSTRAINT admin_id PRIMARY KEY (admin_id)
    INCLUDE (admin_id);


ALTER TABLE IF EXISTS public.personal_info
    ADD CONSTRAINT personal_info_pkey PRIMARY KEY (personal_id)
    INCLUDE (personal_id);
ALTER TABLE IF EXISTS public.personal_info
    ADD CONSTRAINT personal_info_admin_id_fkey FOREIGN KEY (admin_id)
    REFERENCES public.admins (admin_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id)
    INCLUDE (category_id);


ALTER TABLE IF EXISTS public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (dis_id)
    INCLUDE (dis_id);
ALTER TABLE IF EXISTS public.discounts
    ADD CONSTRAINT discounts_admin_id_fkey FOREIGN KEY (admin_id)
    REFERENCES public.admins (admin_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (cust_id)
    INCLUDE (cust_id);
ALTER TABLE IF EXISTS public.customers
    ADD CONSTRAINT customers_personal_id_fkey FOREIGN KEY (personal_id)
    REFERENCES public.personal_info (personal_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.sellers
    ADD CONSTRAINT sellers_pkey PRIMARY KEY (seller_id)
    INCLUDE (seller_id);
ALTER TABLE IF EXISTS public.sellers
    ADD CONSTRAINT sellers_personal_id_fkey FOREIGN KEY (personal_id)
    REFERENCES public.personal_info (personal_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (prod_id)
    INCLUDE (prod_id);
ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES public.categories (category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id)
    REFERENCES public.sellers (seller_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (prod_id, cust_id)
    INCLUDE (prod_id, cust_id);
ALTER TABLE IF EXISTS public.comments
    ADD CONSTRAINT comments_cust_id_fkey FOREIGN KEY (cust_id)
    REFERENCES public.customers (cust_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS public.comments
    ADD FOREIGN KEY (prod_id)
    REFERENCES e_shop.products (prod_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id)
    INCLUDE (order_id);
ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT orders_cust_id_fkey FOREIGN KEY (cust_id)
    REFERENCES public.customers (cust_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_detail
    ADD CONSTRAINT order_detail_pkey PRIMARY KEY (order_detail_id)
    INCLUDE (order_detail_id);
ALTER TABLE IF EXISTS public.order_detail
    ADD CONSTRAINT order_detail_dis_id_fkey FOREIGN KEY (dis_id)
    REFERENCES public.discounts (dis_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS public.order_detail
    ADD CONSTRAINT order_detail_order_id_fkey FOREIGN KEY (order_id)
    REFERENCES public.orders (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
ALTER TABLE IF EXISTS public.order_detail
    ADD CONSTRAINT order_detail_prod_id_fkey FOREIGN KEY (prod_id)
    REFERENCES public.products (prod_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cart_id)
    INCLUDE (cart_id);
ALTER TABLE IF EXISTS public.carts
    ADD CONSTRAINT carts_cust_id_fkey FOREIGN KEY (cust_id)
    REFERENCES public.customers (cust_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.cart_product
   ADD CONSTRAINT cart_product_pkey PRIMARY KEY (cart_id, prod_id)
        INCLUDE(cart_id, prod_id);
ALTER TABLE IF EXISTS public.cart_product		
   ADD CONSTRAINT cart_product_prod_id_fkey FOREIGN KEY (prod_id)
        REFERENCES public.products (prod_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
ALTER TABLE IF EXISTS public.cart_product
    ADD FOREIGN KEY (cart_id)
    REFERENCES e_shop.carts (cart_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;	





