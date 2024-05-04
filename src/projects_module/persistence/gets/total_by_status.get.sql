SELECT * FROM project_states;

DELIMITER //
CREATE PROCEDURE sp_get_total_by_status(IN user_id CHAR(36), OUT total_projects INT)
BEGIN
    DECLARE user_role CHAR(36);

    SELECT fk_role INTO user_role
    FROM user_roles
    WHERE fk_user = user_id;

    IF user_role = '26da04bb-fab9-11ee-94e0-0242ac110002' THEN
        SELECT COUNT(*) INTO total_projects FROM projects;

        SELECT status, COUNT(*) as total, MAX(created_at) as last_created
        FROM projects
        GROUP BY status;
    ELSE
        SELECT COUNT(*) INTO total_projects FROM projects WHERE fk_assessor = user_id;

        SELECT status, COUNT(*) as total, MAX(created_at) as last_created
        FROM projects
        WHERE fk_assessor = user_id
        GROUP BY status;
    END IF;
END//
DELIMITER ;

CALL sp_get_total_by_status('b454ba98-fe4e-11ee-9a00-0242ac110002', @total_projects);

SELECT @total_projects;
