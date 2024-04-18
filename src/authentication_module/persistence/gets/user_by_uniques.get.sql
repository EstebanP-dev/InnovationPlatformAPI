CREATE PROCEDURE sg_get_user_by_uniques(IN field VARCHAR(255))
BEGIN
    SELECT u.id, u.email, u.user_name, u.code, u.document_number, u.password_hash,
           dt.name AS document_type, g.name as gender, u.phone_number,
           m.birth_date, CONCAT(m.given_name, ' ', m.family_name) AS full_name,
           COALESCE(JSON_ARRAYAGG(JSON_OBJECT('id', r.id, 'name', r.name)), '[]') as roles
    FROM users u
    USE INDEX (`PRIMARY`, code, document_number, email, phone_number, user_name)
    INNER JOIN members m ON u.id = m.id
    INNER JOIN document_types dt ON m.fk_document_type = dt.id
    INNER JOIN genders g ON m.fk_gender = g.id
    INNER JOIN user_roles ur ON u.id = ur.fk_user
    INNER JOIN roles r ON ur.fk_role = r.id
    WHERE u.id = field OR u.email = field OR u.user_name = field OR u.code = field
          OR u.document_number = field OR u.phone_number = field
    GROUP BY u.id;
END;
