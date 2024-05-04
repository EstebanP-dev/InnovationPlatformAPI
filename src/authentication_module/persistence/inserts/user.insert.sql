DELIMITER $$

CREATE PROCEDURE sp_insert_user(
    IN branch_id CHAR(36),
    IN document_type_id CHAR(36),
    IN gender_id CHAR(36),
    IN roles_ids VARCHAR(255),
    IN user_code VARCHAR(20),
    IN user_document_number VARCHAR(20),
    IN user_email VARCHAR(100),
    IN user_user_name VARCHAR(50),
    IN user_password_hash VARCHAR(60),
    IN user_phone_number VARCHAR(20),
    IN user_birth_date DATE,
    IN user_given_name VARCHAR(100),
    IN user_family_name VARCHAR(100),
    IN user_avatar VARCHAR(255),
    IN user_assessor_code VARCHAR(20)
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE user_id CHAR(36);
    DECLARE assessor_role_id CHAR(36);
    DECLARE role_id CHAR(36);
    DECLARE role_ids_length INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF branch_id IS NULL OR document_type_id IS NULL OR gender_id IS NULL OR user_code IS NULL OR user_document_number IS NULL OR user_email IS NULL OR user_user_name IS NULL OR user_password_hash IS NULL OR user_phone_number IS NULL OR user_birth_date IS NULL OR user_given_name IS NULL OR user_family_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Los parámetros requeridos no pueden ser nulos.';
    END IF;

    START TRANSACTION;

    SET user_id = UUID();
    SET assessor_role_id = '26da26f7-fab9-11ee-94e0-0242ac110002';

    INSERT INTO members (id, fk_document_type, fk_gender, given_name, family_name,  avatar, birth_date, created_at, created_by)
    VALUES (user_id, document_type_id, gender_id, user_given_name, user_family_name, user_avatar, user_birth_date, NOW(), USER());

    INSERT INTO users (id, fk_branch, user_name, password_hash, email, phone_number, document_number, code, created_at, created_by)
    VALUES (user_id, branch_id, user_user_name, user_password_hash, user_email, user_phone_number, user_document_number, user_code, NOW(), USER());

    SET role_ids_length = LENGTH(roles_ids) - LENGTH(REPLACE(roles_ids, ',', '')) + 1;

    SET i = 0;

    WHILE i < role_ids_length DO
        SET role_id = SUBSTRING_INDEX(SUBSTRING_INDEX(roles_ids, ',', i + 1), ',', -1);

        IF NOT is_valid_uuid(role_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El id del rol no es válido.';
        END IF;

        INSERT INTO user_roles (id, fk_user, fk_role, created_at, created_by)
        VALUES (UUID(), user_id, role_id, NOW(), USER());

        IF role_id = assessor_role_id THEN

            IF user_assessor_code IS NULL THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El código del asesor no puede ser nulo.';
            END IF;

            INSERT INTO project_assessors (id, code, created_at, created_by)
            VALUES (user_id, user_assessor_code, NOW(), USER());
        END IF;

        SET i = i + 1;
    END WHILE;

    COMMIT;

END$$

DELIMITER ;
