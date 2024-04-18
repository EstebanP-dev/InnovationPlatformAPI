DELIMITER $$

CREATE FUNCTION is_valid_uuid(input_uuid CHAR(36))
    RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    RETURN input_uuid REGEXP '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$';
END$$

DELIMITER ;
