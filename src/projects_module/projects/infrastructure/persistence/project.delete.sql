DELIMITER $$

CREATE PROCEDURE sp_delete_project(
    IN project_id CHAR(36)
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

    UPDATE projects
        SET active = 0
    WHERE id = project_id;

    UPDATE project_deliverables
        SET active = 0
    WHERE fk_project = project_id;

    COMMIT;
END $$
DELIMITER ;
