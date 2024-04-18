SELECT * FROM countries;

SET @country_id = 'dafb2e40-fabb-11ee-94e0-0242ac110002'; -- COLOMBIA

INSERT INTO states(id, fk_country, name, normalized_name, abbreviation, created_at, created_by)
VALUES (UUID(), @country_id, 'Antioquia', 'ANTIOQUIA', 'ANT', NOW(), USER());
