DELIMITER $$

CREATE PROCEDURE sp_insert_project(
    IN assessor_id CHAR(36),
    IN project_id CHAR(36),
    IN project_type_id CHAR(36),
    IN project_title VARCHAR(255),
    IN project_description TEXT,
    IN project_status ENUM('Completado', 'En Progreso', 'En Espera', 'Pendiente'),
    IN project_authors TEXT,
    IN project_deliverables TEXT
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE autor_id CHAR(36);
    DECLARE autor_ids_length INT;
    DECLARE deliverable_data VARCHAR(1024);
    DECLARE deliverable_id CHAR(36);
    DECLARE deliverable_type_id CHAR(36);
    DECLARE deliverable_name VARCHAR(255);
    DECLARE deliverable_url VARCHAR(255);
    DECLARE deliverable_description TEXT;
    DECLARE deliverable_ids_length INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    SET project_id = IFNULL(project_id, UUID());

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT is_valid_uuid(assessor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid assessor_id format';
    END IF;

    IF NOT is_valid_uuid(project_type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_type_id format';
    END IF;

    INSERT INTO projects (id, fk_assessor, fk_type, title, normalized_title, description, status, created_at, created_by)
    VALUES (project_id, assessor_id, project_type_id, project_title, normalize_text(project_title, TRUE), project_description, project_status, NOW(), USER());

    SET autor_ids_length = LENGTH(project_authors) - LENGTH(REPLACE(project_authors, ',', '')) + 1;

    WHILE i < autor_ids_length DO
        SET autor_id = SUBSTRING_INDEX(SUBSTRING_INDEX(project_authors, ',', i + 1), ',', -1);

        IF NOT is_valid_uuid(autor_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid author_id format';
        END IF;

        INSERT INTO project_authors (id, fk_project, fk_author, created_at, created_by)
        VALUES (UUID(), project_id, autor_id, NOW(), USER());

        SET i = i + 1;
    END WHILE;

    SET i = 0;

    SET deliverable_ids_length = LENGTH(project_deliverables) - LENGTH(REPLACE(project_deliverables, ';', '')) + 1;

    WHILE i < deliverable_ids_length DO
        SET deliverable_data = SUBSTRING_INDEX(SUBSTRING_INDEX(project_deliverables, ';', i + 1), ';', -1);

        SET deliverable_id = SUBSTRING_INDEX(deliverable_data, ',', 1);
        SET deliverable_type_id = SUBSTRING_INDEX(SUBSTRING_INDEX(deliverable_data, ',', 2), ',', -1);
        SET deliverable_name = SUBSTRING_INDEX(SUBSTRING_INDEX(deliverable_data, ',', 3), ',', -1);
        SET deliverable_url = SUBSTRING_INDEX(SUBSTRING_INDEX(deliverable_data, ',', 4), ',', -1);
        SET deliverable_description = SUBSTRING_INDEX(deliverable_data, ',', 5);

        IF NOT is_valid_uuid(deliverable_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid deliverable_id format';
        END IF;

        IF NOT is_valid_uuid(deliverable_type_id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid deliverable_type_id format';
        END IF;

        INSERT INTO project_deliverables (id, fk_type, fk_project, name, normalized_name, url, description, active, created_at, created_by)
        VALUES (deliverable_id, deliverable_type_id, project_id, deliverable_name, normalize_text(deliverable_name, TRUE), deliverable_url, deliverable_description, 1, NOW(), USER());

        SET i = i + 1;
    END WHILE;

    COMMIT;
END$$

DELIMITER ;
