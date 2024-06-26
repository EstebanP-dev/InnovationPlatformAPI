CREATE VIEW vw_projects AS
    SELECT
        p.id,
        p.status,
        p.title,
        p.description,
        pt.name AS type,
        JSON_OBJECT('id', m.id, 'full_name', CONCAT(m.given_name, ' ', m.family_name)) AS assessor,
        COALESCE(JSON_ARRAYAGG(JSON_OBJECT('id', pd.id, 'type', dt.name, 'status', pd.status, 'name', pd.name, 'url', pd.url, 'description', pd.description, 'created_at', pd.created_at, 'updated_at', pd.updated_at)), '[]') AS deliverables,
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
    WHERE p.active = TRUE
    GROUP BY
        p.id;


SELECT * FROM projects;
SELECT * FROM users;
