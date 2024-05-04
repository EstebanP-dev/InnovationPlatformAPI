CREATE PROCEDURE sp_exist_user_by_uniques(IN field VARCHAR(255), OUT password_hash VARCHAR(255))
BEGIN
    DECLARE user_exists INT;
    DECLARE password_hash_temp VARCHAR(255);

    SELECT 1, u.password_hash INTO user_exists, password_hash_temp
    FROM users u
    USE INDEX (`PRIMARY`, code, document_number, email, phone_number, user_name)
    WHERE u.id = field OR u.email = field OR u.user_name = field OR u.code = field
       OR u.document_number = field OR u.phone_number = field;

    SET password_hash = password_hash_temp;

    SELECT user_exists;
END;

CALL sp_exist_user_by_uniques('jnavia', @password_hash);

SELECT *
FROM users
WHERE user_name = 'jnavia';
