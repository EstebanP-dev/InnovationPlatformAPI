INSERT INTO document_types(id, abbreviation, name, normalized_name, created_at, created_by)
VALUES (UUID(), 'CC', 'Cédula de Ciudadanía', 'CEDULA_DE_CIUDADANIA', NOW(), USER()),
       (UUID(), 'CE', 'Cédula de Extranjería', 'CEDULA_DE_EXTRANJERIA', NOW(), USER()),
       (UUID(), 'PA', 'Pasaporte', 'PASAPORTE', NOW(), USER()),
       (UUID(), 'RC', 'Registro Civil', 'REGISTRO_CIVIL', NOW(), USER()),
       (UUID(), 'TI', 'Tarjeta de Identidad', 'TARJETA_DE_IDENTIDAD', NOW(), USER());
