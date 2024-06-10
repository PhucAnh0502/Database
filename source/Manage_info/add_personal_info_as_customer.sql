CREATE OR REPLACE FUNCTION add_personal_info_as_customer(
    _first_name TEXT,
    _last_name TEXT,
    _email TEXT,
    _phone_number TEXT,
    _address TEXT,
    _city TEXT,
    _postal_code TEXT,
    _username TEXT,
    _password TEXT
)
RETURNS void AS $$
DECLARE
    _admin_ID INT;
    _personal_ID INT;
BEGIN
    -- Generate a random admin ID
    _admin_ID := FLOOR(RANDOM() * 1000 + 1)::INT;
    
    -- Insert into personal_info and return the generated personal_ID
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
    
    -- Insert into customers with the same personal_ID
    INSERT INTO customers (personal_ID, username, password)
    VALUES (
        _personal_ID,
        _username,
        _password
    );
END;
$$ LANGUAGE plpgsql;

