CREATE TABLE personal_info (
	personal_ID serial,
	admin_ID integer NOT NULL,
	first_name varchar(20),
	last_name varchar(20),
	email varchar(50),
	phone_number varchar(30),
	address varchar(50),
	city varchar(30),
	postal_code varchar(20)
);

CREATE TABLE customers(
	cust_ID serial,
	personal_ID integer NOT NULL,
	username varchar(40),
	password varchar(40)
);

CREATE TABLE sellers(
	seller_ID serial,
	personal_ID integer NOT NULL,
	username varchar(40),
	password varchar(40),
	shop_name varchar(50),
	business_lisence varchar(200)
);

CREATE TABLE admins(
	admin_ID serial,
	admin_fname varchar(20),
	admin_lname varchar(20),
	password varchar(20)
);

CREATE TABLE carts(
	cart_ID serial,
	cust_ID integer NOT NULL
);

CREATE TABLE cart_product(
	cart_ID integer NOT NULL,
	prod_ID integer NOT NULL,
	quantity integer
);

CREATE TABLE categories(
	category_ID serial,
	category_name varchar(50),
	description text
);

CREATE TABLE orders(
	order_ID serial,
	cust_ID integer NOT NULL,
	order_date date,
	payment_type varchar(30),
	payment_date date
);

CREATE TABLE order_detail(
	order_detail_ID serial,
	order_ID integer NOT NULL,
	prod_ID integer NOT NULL,
	dis_ID integer,
	quantity integer
);

CREATE TABLE products(
	prod_ID serial,
	category_ID integer NOT NULL,
	seller_ID integer NOT NULL,
	prod_name varchar(50),
	description text,
	price integer,
	picture varchar(150)
);

CREATE TABLE comments(
	prod_ID integer NOT NULL,
	cust_ID integer NOT NULL,
	comment_date date,
	content text
);

CREATE TABLE discounts(
	dis_ID serial,
	admin_Id integer NOT NULL,
	start_date date,
	end_date date,
	dis_percent integer
);

