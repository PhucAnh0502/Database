-- Tạo index cho các cột trong bảng orders
CREATE INDEX idx_orders_cust_id ON orders (cust_id);

-- Tạo index cho các cột trong bảng order_detail
CREATE INDEX idx_order_detail_order_id ON order_detail (order_id);
CREATE INDEX idx_order_detail_prod_id ON order_detail (prod_id);

-- Tạo index cho các cột trong bảng products
CREATE INDEX idx_products_prod_id ON products (prod_id);
CREATE INDEX idx_products_dis_id ON order_detail (dis_id);

-- Tạo index cho các cột trong bảng discounts
CREATE INDEX idx_discounts_dis_id ON discounts (dis_id);

-- Tạo index cho các cột trong bảng categories
CREATE INDEX idx_categories_dis_id ON products (category_id);
