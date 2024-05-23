DELIMITER $$
CREATE PROCEDURE sp_change_project_deliverable_status(
    IN deliverable_id CHAR(36),
    IN deliverable_status ENUM('Pending', 'Reviewing', 'Approved', 'Rejected')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF NOT is_valid_uuid(deliverable_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid deliverable_id format';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM project_deliverables WHERE id = deliverable_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliverable does not exist';
    END IF;

    START TRANSACTION;

    UPDATE project_deliverables
    SET status = deliverable_status
    WHERE id = deliverable_id;

    COMMIT;

    SELECT 1;

END $$
