DELIMITER $$

CREATE PROCEDURE sp_get_projects(IN user_id CHAR(36))
BEGIN

    DECLARE is_admin BOOLEAN;
    SET is_admin = EXISTS(SELECT 1 FROM user_roles WHERE fk_user = user_id AND fk_role = '26da04bb-fab9-11ee-94e0-0242ac110002');

    SELECT
        p.id,
        p.status,
        p.title,
        p.description,
        pt.name AS type,
        JSON_OBJECT('id', m.id, 'full_name', CONCAT(m.given_name, ' ', m.family_name)) AS assessor,
        COALESCE(JSON_ARRAYAGG(JSON_OBJECT('type', dt.name, 'name', pd.name, 'url', pd.url, 'description', pd.description, 'created_at', pd.created_at, 'updated_at', pd.updated_at)), '[]') AS deliverables,
        COALESCE(JSON_ARRAYAGG(JSON_OBJECT('id', pa.id, 'full_name', CONCAT(ma.given_name, ' ', ma.family_name))), '[]') AS authors,
        p.created_at,
        p.updated_at
    FROM
        projects p
    RIGHT JOIN project_types pt ON p.fk_type = pt.id
    LEFT JOIN project_deliverables pd ON p.id = pd.fk_project
    LEFT JOIN deliverable_types dt ON pd.fk_type = dt.id
    RIGHT JOIN project_assessors ps ON p.fk_assessor = ps.id
    RIGHT JOIN members m ON ps.id = m.id
    RIGHT JOIN project_authors pa ON p.id = pa.fk_project
    LEFT JOIN members ma ON pa.fk_author = ma.id
    WHERE
        p.active = TRUE AND
        (is_admin OR m.id = user_id OR ma.id = user_id)
    GROUP BY
        p.id;

END$$

DELIMITER ;

SELECT * FROM project_types;

CALL sp_get_projects('b454ba98-fe4e-11ee-9a00-0242ac110002');
