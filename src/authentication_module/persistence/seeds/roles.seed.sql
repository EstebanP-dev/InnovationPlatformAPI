INSERT INTO roles (id, name, normalized_name, description, created_at, created_by)
VALUES (UUID(), 'Admin', 'ADMIN', 'Administrator', NOW(), USER()),
       (UUID(), 'Student', 'USER', 'User', NOW(), USER()),
       (UUID(), 'Teacher', 'TEACHER', 'Teacher', NOW(), USER()),
       (UUID(), 'Assessor', 'ASSESSOR', 'Assessor', NOW(), USER());


SELECT * FROM roles;
