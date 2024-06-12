CREATE OR REPLACE FUNCTION add_personal_info(
    _first_name TEXT,
    _last_name TEXT,
    _email TEXT,
    _phone_number TEXT,
    _address TEXT,
    _city TEXT,
    _postal_code TEXT,
    _username TEXT,
    _password TEXT,
	_is_seller BOOLEAN,
	_is_customer BOOLEAN,
    _shop_name TEXT DEFAULT NULL,
    _business_lisence TEXT DEFAULT NULL
)
RETURNS void AS $$
DECLARE
    _admin_ID INT;
    _personal_ID INT;
BEGIN
	IF (_is_seller is NOT TRUE AND _is_customer is NOT TRUE) THEN
   	RAISE EXCEPTION 'Can NOT insert if user is NOT customer or seller';
	END IF;
   
   	_admin_ID := FLOOR(RANDOM() * 1000 + 1)::INT;
    
    INSERT INTO personal_info (admin_ID, first_name, last_name, email, phone_number, address, city, postal_code)
    VALUES (
        _admin_ID,
        _first_name,
        _last_name,
        _email,
        _phone_number,
        _address,
        _city,
        _postal_code
    )
    RETURNING personal_ID INTO _personal_ID;
    
    IF _is_seller THEN
        INSERT INTO sellers (personal_ID, username, password, shop_name, business_lisence)
        VALUES (
            _personal_ID,
            _username,
            _password,
            _shop_name,
            _business_lisence 
        );
	END IF;
	
	IF _is_customer THEN
        INSERT INTO customers (personal_ID, username, password)
        VALUES (
            _personal_ID,
            _username,
            _password
        );
	END IF;	
END;
$$ LANGUAGE plpgsql;
