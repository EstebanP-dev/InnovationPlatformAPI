ALTER VIEW vw_member_information AS
    SELECT u.id, u.code, u.user_name, u.email,
           u.document_number, u.phone_number,
           r.name as role_name, m.avatar,
           m.given_name, m.family_name, m.birth_date,
           dt.name as document_type, g.name as gender
    FROM user_roles ur
             INNER JOIN roles r ON ur.fk_role = r.id
             INNER JOIN users u ON ur.fk_user = u.id
             INNER JOIN members m ON u.id = m.id
             INNER JOIN document_types dt ON m.fk_document_type = dt.id
             INNER JOIN genders g ON m.fk_gender = g.id;

CREATE VIEW vw_authorial_members AS
    SELECT *
    FROM vw_member_information
    WHERE role_name NOT LIKE '%Assessor%' AND role_name NOT LIKE '%Admin%';

CREATE VIEW vw_assessor_members AS
    SELECT *
    FROM vw_member_information
    WHERE role_name LIKE '%Assessor%';

SELECT * FROM vw_authorial_members;
