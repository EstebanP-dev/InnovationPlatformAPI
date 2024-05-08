DELIMITER $$

CREATE PROCEDURE sp_insert_project_deliverable(
    IN project_id CHAR(36),
    IN type_id CHAR(36),
    IN deliverable_id CHAR(36),
    IN deliverable_name VARCHAR(255),
    IN deliverable_description TEXT,
    IN deliverable_url VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT is_valid_uuid(type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT is_valid_uuid(deliverable_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM projects WHERE id = project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Project does not exist';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM deliverable_types WHERE id = type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliverable type does not exist';
    END IF;

    IF deliverable_name IS NOT NULL OR deliverable_name = '' OR deliverable_name = ' ' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliverable name cannot be empty';
    END IF;

    START TRANSACTION;

    INSERT INTO project_deliverables (id, fk_type, fk_project, name, normalized_name, url, description, created_at, created_by)
    VALUES (deliverable_id, type_id, project_id, deliverable_name, normalize_text(deliverable_name, true), deliverable_url, deliverable_description, NOW(), USER());

    COMMIT;

END $$
