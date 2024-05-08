INSERT INTO deliverable_states (id, name, normalize_name, created_at, created_by)
VALUES (UUID(), 'Completado', 'COMPLETADO', NOW(), USER()),
       (UUID(), 'En Revision', 'EN_REVISION', NOW(), USER()),
       (UUID(), 'Por Corregir', 'POR_CORREGIR', NOW(), USER()),
       (UUID(), 'Cancelado', 'CANCELADO', NOW(), USER()),
       (UUID(), 'Pendiente', 'PENDIENTE', NOW(), USER());

SELECT * FROM deliverable_states;
