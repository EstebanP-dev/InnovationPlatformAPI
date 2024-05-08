CREATE VIEW vw_project_types AS
    SELECT id, name
    FROM project_types
    WHERE active = 1
