INSERT INTO genders (id, abbreviation, name, normalized_name, created_at, created_by)
VALUES (UUID(), 'M', 'Masculino', 'MASCULINO', NOW(), USER()),
       (UUID(), 'F', 'Feminino', 'FEMININO', NOW(), USER()),
       (UUID(), 'O', 'Otro', 'OTRO', NOW(), USER());
