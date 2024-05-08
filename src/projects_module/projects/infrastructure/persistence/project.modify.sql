DELIMITER $$
CREATE PROCEDURE sp_modify_project(
    IN project_id CHAR(36),
    IN assessor_id CHAR(36),
    IN project_type_id CHAR(36),
    IN project_title VARCHAR(255),
    IN project_description TEXT,
    IN project_status ENUM('Completado', 'En Progreso', 'En Espera', 'Pendiente'),
    IN project_authors_str TEXT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE autor_id CHAR(36);
    DECLARE autor_ids_length INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF project_authors_str IS NOT NULL THEN
        SET autor_ids_length = LENGTH(project_authors_str) - LENGTH(REPLACE(project_authors_str, ',', '')) + 1;

        WHILE i < autor_ids_length DO
            SET autor_id = SUBSTRING_INDEX(SUBSTRING_INDEX(project_authors_str, ',', i + 1), ',', -1);

            IF NOT is_valid_uuid(autor_id) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid author_id format';
            END IF;

            IF NOT EXISTS (SELECT 1 FROM project_authors WHERE fk_author = autor_id AND fk_project = project_id) THEN
                DELETE FROM project_authors WHERE fk_author = autor_id AND fk_project = project_id;
            END IF;

            SET i = i + 1;
        END WHILE;

        SET i = 0;
    END IF;


    IF NOT is_valid_uuid(assessor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid assessor_id format';
    END IF;

    IF NOT is_valid_uuid(project_type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_type_id format';
    END IF;

    UPDATE projects
        SET fk_assessor = IFNULL(assessor_id, fk_assessor),
            fk_type = IFNULL(project_type_id, fk_type),
            title = IFNULL(project_title, title),
            normalized_title = normalize_text(IFNULL(project_title, title), TRUE),
            description = IFNULL(project_description, description),
            status = IFNULL(project_status, status),
            updated_at = NOW(),
            updated_by = USER()
    WHERE id = project_id;

    COMMIT;
END $$

DELIMITER ;
