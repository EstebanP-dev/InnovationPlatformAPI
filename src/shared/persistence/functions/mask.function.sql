DELIMITER $$
CREATE FUNCTION mask(unformatted_value BIGINT, format_string CHAR(32)) RETURNS CHAR(32) DETERMINISTIC
BEGIN
    DECLARE input_len TINYINT;
    DECLARE output_len TINYINT;
    DECLARE temp_char CHAR;

    SET input_len = LENGTH(unformatted_value);
    SET output_len = LENGTH(format_string);

    WHILE (output_len > 0) DO
            SET temp_char = SUBSTR(format_string, output_len, 1);
            IF (temp_char = '#') THEN
                IF (input_len > 0) THEN
                    SET format_string = INSERT(format_string, output_len, 1, SUBSTR(unformatted_value, input_len, 1));
                    SET input_len = input_len - 1;
                ELSE
                    SET format_string = INSERT(format_string, output_len, 1, '0');
                END IF;
            END IF;
            SET output_len = output_len - 1;
        END WHILE;

    RETURN format_string;
END $$
DELIMITER ;
