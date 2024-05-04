INSERT INTO project_types (id, name, normalize_name, created_at, created_by)
VALUES (UUID(), 'Projecto de Grado', 'PROJECTO_DE_GRADO', NOW(), USER()),
       (UUID(), 'Proyecto de Investigación', 'PROYECTO_DE_INVESTIGACION', NOW(), USER()),
       (UUID(), 'Proyecto de Facultad', 'PROYECTO_DE_FACULTAD', NOW(), USER());

SELECT * FROM project_types;
