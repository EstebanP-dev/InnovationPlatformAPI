DELIMITER $$

CREATE PROCEDURE sp_delete_project(
    IN project_id CHAR(36),
    IN force_delete BOOLEAN
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM projects WHERE id = project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Project not found';
    END IF;

    IF force_delete THEN
        DELETE FROM project_authors
        WHERE fk_project = project_id;

        DELETE FROM project_deliverables
        WHERE fk_project = project_id;

        DELETE FROM projects
        WHERE id = project_id;

        COMMIT;

        SELECT 1;
    END IF;

    UPDATE projects
        SET active = 0
    WHERE id = project_id;

    UPDATE project_deliverables
        SET active = 0
    WHERE fk_project = project_id;

    COMMIT;

    SELECT 1;
END $$
DELIMITER ;

select * from projects where id = '0380dc3d-7916-4aa6-862d-eb6f263c93ab';
