DELIMITER $$

CREATE PROCEDURE sp_exists_deliverable_type(IN deliverable_type_id CHAR(36))
BEGIN
    SELECT EXISTS(SELECT 1 FROM deliverable_types WHERE id = deliverable_type_id);
END $$;

CALL sp_exists_deliverable_type('123e4567-e89b-12d3-a456-426614174000');
