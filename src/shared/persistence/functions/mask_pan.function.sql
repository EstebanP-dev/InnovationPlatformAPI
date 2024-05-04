DELIMITER $$

CREATE FUNCTION mask_pan_or_email(input VARCHAR(255))
    RETURNS VARCHAR(255)
    DETERMINISTIC
    NO SQL
BEGIN
    DECLARE is_email BOOL;
    DECLARE at_pos INT;
    DECLARE last_dot_pos INT;
    DECLARE first_part VARCHAR(255);
    DECLARE domain_part VARCHAR(255);
    DECLARE extension_part VARCHAR(255);
    DECLARE masked_email VARCHAR(255);

    SET is_email = (LOCATE('@', input) > 0) AND (LOCATE('.', input) > LOCATE('@', input));

    IF is_email THEN
        SET at_pos = LOCATE('@', input);
        SET last_dot_pos = LOCATE('.', REVERSE(input));
        SET first_part = LEFT(input, at_pos - 1);
        SET domain_part = SUBSTRING(input, at_pos + 1, LENGTH(input) - at_pos - last_dot_pos);
        SET extension_part = RIGHT(input, last_dot_pos - 1);

        SET masked_email = CONCAT(LEFT(first_part, 1), REPEAT('*', CHAR_LENGTH(first_part) - 1), '@', domain_part, '.', extension_part);

        RETURN masked_email;
    ELSE
        IF CHAR_LENGTH(input) < 2 THEN
            RETURN input;
        END IF;

        IF CHAR_LENGTH(input) < 7 THEN
            RETURN CONCAT(LEFT(input, 1), REPEAT('*', CHAR_LENGTH(input) - 1));
        END IF;

        RETURN CONCAT(REPEAT('*', CHAR_LENGTH(input) - 4), SUBSTRING(input, - 4));
    END IF;
END$$

DELIMITER ;

SELECT mask_pan_or_email('juan.navia211@tau.usbmed.edu.co');
