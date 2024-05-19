CREATE PROCEDURE sp_get_project(IN project_id CHAR(36))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    SELECT *
    FROM vw_projects
    WHERE id = project_id;
END;

SELECT * FROM projects WHERE id = '2888c4e1-ec05-4bb0-bfd2-b987cf9e96fe';

CALL sp_delete_project('2888c4e1-ec05-4bb0-bfd2-b987cf9e96fe')
