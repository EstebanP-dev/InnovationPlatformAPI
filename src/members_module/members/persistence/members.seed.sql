SELECT * FROM document_types;
SELECT * FROM genders;
SELECT * FROM branches;
SELECT * FROM roles;

SET @id = UUID();
SET @document_type = '14aa126f-faba-11ee-94e0-0242ac110002';
SET @gender = '698c7f5f-faba-11ee-94e0-0242ac110002';
SET @branch = 'be7ed35e-fadd-11ee-94e0-0242ac110002';
SET @role = '26da2498-fab9-11ee-94e0-0242ac110002';


INSERT INTO members(
    id,
    fk_document_type,
    fk_gender,
    given_name,
    family_name,
    birth_date,
    created_at,
    created_by)
VALUES(@id, @document_type, @gender, 'Trevor', 'Lawrell', '1997-07-07', NOW(), USER());

INSERT INTO users(id, fk_branch, code, user_name, email, password_hash, document_number, phone_number, created_at, created_by)
VALUES(@id, @branch, '30000012367', 'test_student', 'test_student@test.com', '$2b$12$IQ0BTHVB55wXnW.uQuv94u4eAsRHzvQvwP4/cY9wng8A.Hwsvg9cm', '3124567098', '3124567098', NOW(), USER());

INSERT INTO user_roles(id, fk_user, fk_role, created_at, created_by)
VALUES(UUID(), @id, @role, NOW(), USER());

INSERT INTO project_assessors(id, code, created_at, created_by)
VALUES (@id, '0987654321', NOW(), USER());

SELECT * FROM members; -- 8b5e597d-fadf-11ee-94e0-0242ac110002
SELECT * FROM users;
SELECT * FROM user_roles;
SELECT * FROM project_assessors;

DELETE FROM user_roles WHERE id = '0d6f25fc-fae0-11ee-94e0-0242ac110002';
