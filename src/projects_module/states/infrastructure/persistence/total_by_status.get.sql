DELIMITER //
CREATE PROCEDURE sp_get_total_by_status(IN user_id CHAR(36), OUT total_projects INT)
BEGIN
    SET @admin_role = '26da04bb-fab9-11ee-94e0-0242ac110002';
    SET @is_admin = EXISTS(SELECT 1 FROM user_roles WHERE fk_user = user_id AND fk_role = '26da04bb-fab9-11ee-94e0-0242ac110002');

    IF @is_admin THEN
        SELECT COUNT(*) INTO total_projects FROM projects WHERE active = TRUE;

        SELECT status, COUNT(*) as total, MAX(created_at) as last_created
        FROM projects
        WHERE active = TRUE
        GROUP BY status;
    ELSE
        SELECT COUNT(*) INTO total_projects
        FROM projects
        WHERE active = TRUE
          AND (fk_assessor = user_id OR EXISTS (SELECT 1 FROM project_authors WHERE fk_project = projects.id AND fk_author = user_id));

        SELECT status, COUNT(*) as total, MAX(created_at) as last_created
        FROM projects
        WHERE active = TRUE
          AND (fk_assessor = user_id OR EXISTS (SELECT 1 FROM project_authors WHERE fk_project = projects.id AND fk_author = user_id))
        GROUP BY status;
    END IF;
END//
DELIMITER ;

CALL sp_get_total_by_status('b454ba98-fe4e-11ee-9a00-0242ac110002', @total_projects);

SELECT @total_projects;
