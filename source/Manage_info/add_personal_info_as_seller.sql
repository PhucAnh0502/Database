CREATE OR REPLACE FUNCTION update_personal_info(
    _personal_ID INT,
    _first_name TEXT,
    _last_name TEXT,
    _email TEXT,
    _phone_number TEXT,
    _address TEXT,
    _city TEXT,
    _postal_code TEXT
)
RETURNS void AS $$
BEGIN
    UPDATE personal_info
    SET first_name = _first_name,
        last_name = _last_name,
        email = _email,
        phone_number = _phone_number,
        address = _address,
        city = _city,
        postal_code = _postal_code
    WHERE personal_ID = _personal_ID;
END;
$$ LANGUAGE plpgsql;

