CREATE VIEW vw_deliverable_states AS
    SELECT id, name, normalize_name
    FROM deliverable_states
    WHERE active = 1;

SELECT * FROM vw_deliverable_states
