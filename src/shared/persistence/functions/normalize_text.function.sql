DELIMITER $$

CREATE FUNCTION normalize_text(input_text VARCHAR(255), to_upper BOOLEAN)
    RETURNS VARCHAR(255)
    DETERMINISTIC
BEGIN
    DECLARE normalized_text VARCHAR(255);
    SET normalized_text = input_text;

    SET normalized_text = REPLACE(normalized_text, ' ', '_');
    SET normalized_text = REPLACE(normalized_text, '.', '');
    SET normalized_text = REPLACE(normalized_text, ',', '');
    SET normalized_text = REPLACE(normalized_text, ';', '');
    SET normalized_text = REPLACE(normalized_text, ':', '');
    SET normalized_text = REPLACE(normalized_text, '?', '');
    SET normalized_text = REPLACE(normalized_text, '!', '');
    SET normalized_text = REPLACE(normalized_text, '@', '');
    SET normalized_text = REPLACE(normalized_text, '#', '');
    SET normalized_text = REPLACE(normalized_text, '$', '');
    SET normalized_text = REPLACE(normalized_text, '%', '');
    SET normalized_text = REPLACE(normalized_text, '^', '');
    SET normalized_text = REPLACE(normalized_text, '&', '');
    SET normalized_text = REPLACE(normalized_text, '*', '');
    SET normalized_text = REPLACE(normalized_text, '(', '');
    SET normalized_text = REPLACE(normalized_text, ')', '');
    SET normalized_text = REPLACE(normalized_text, '[', '');
    SET normalized_text = REPLACE(normalized_text, ']', '');
    SET normalized_text = REPLACE(normalized_text, '{', '');
    SET normalized_text = REPLACE(normalized_text, '}', '');
    SET normalized_text = REPLACE(normalized_text, '"', '');
    SET normalized_text = REPLACE(normalized_text, '''', '');
    SET normalized_text = REPLACE(normalized_text, '<', '');
    SET normalized_text = REPLACE(normalized_text, '>', '');
    SET normalized_text = REPLACE(normalized_text, '|', '');
    SET normalized_text = REPLACE(normalized_text, '/', '');
    SET normalized_text = REPLACE(normalized_text, '\\', '');

    IF to_upper THEN
        SET normalized_text = UPPER(normalized_text);
    ELSE
        SET normalized_text = LOWER(normalized_text);
    END IF;

    SET normalized_text = REPLACE(normalized_text, 'Á', 'A');
    SET normalized_text = REPLACE(normalized_text, 'É', 'E');
    SET normalized_text = REPLACE(normalized_text, 'Í', 'I');
    SET normalized_text = REPLACE(normalized_text, 'Ó', 'O');
    SET normalized_text = REPLACE(normalized_text, 'Ú', 'U');
    SET normalized_text = REPLACE(normalized_text, 'Ñ', 'N');
    SET normalized_text = REPLACE(normalized_text, 'á', 'A');
    SET normalized_text = REPLACE(normalized_text, 'é', 'E');
    SET normalized_text = REPLACE(normalized_text, 'í', 'I');
    SET normalized_text = REPLACE(normalized_text, 'ó', 'O');
    SET normalized_text = REPLACE(normalized_text, 'ú', 'U');
    SET normalized_text = REPLACE(normalized_text, 'ñ', 'N');

    RETURN normalized_text;
END$$

DELIMITER ;
