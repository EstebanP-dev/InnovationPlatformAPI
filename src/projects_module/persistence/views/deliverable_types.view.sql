CREATE VIEW vw_project_deliverable_types AS
    SELECT id, name, extension
    FROM deliverable_types
    WHERE active = 1
