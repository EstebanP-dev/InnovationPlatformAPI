INSERT INTO project_states (id, name, normalize_name, created_at, created_by)
VALUES (UUID(), 'Completado', 'COMPLETADO', NOW(), USER()),
       (UUID(), 'En Progreso', 'EN_PROGRESO', NOW(), USER()),
       (UUID(), 'En Espera', 'EN_ESPERA', NOW(), USER()),
       (UUID(), 'Pendiente', 'PENDIENTE', NOW(), USER());

SELECT * FROM project_states;
