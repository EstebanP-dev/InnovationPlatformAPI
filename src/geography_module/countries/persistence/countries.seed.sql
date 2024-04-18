INSERT INTO countries(id, name, normalized_name, abbreviation, zip_code, created_at, created_by)
VALUES (UUID(), 'Colombia', 'COLOMBIA', 'CO', '57', NOW(), USER());
