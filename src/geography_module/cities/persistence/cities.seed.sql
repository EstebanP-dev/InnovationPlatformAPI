SELECT * FROM states;

SET @state = 'd41d5018-fadc-11ee-94e0-0242ac110002';

INSERT INTO cities (id, fk_state, name, normalized_name, abbreviation, created_at, created_by)
VALUES(UUID(), @state, 'Medellín', 'MEDELLIN', 'MED', NOW(), USER());
