SELECT * FROM cities;
SELECT * FROM companies;

SET @city = '32a43022-fadd-11ee-94e0-0242ac110002';
SET @company = '6afca21c-fabb-11ee-94e0-0242ac110002';

INSERT INTO branches(id, fk_city, fk_company, name, normalize_name, description, avatar, address, email, phone_number, created_at, created_by)
VALUES(UUID(), @city, @company, 'Universidad de San Buenaventura Sede Medellín', 'UNIVERSIDAD_DE_SAN_BUENAVENTURA_SEDE_MEDELLIN', 'Universidad de San Buenaventura Sede Medellín', 'https://www.usbmed.edu.co/wp-content/uploads/2019/07/usbmed-logo.png', 'Carrera 51D #67B-90', 'support@usbmed.edu.co', '444 44 44', NOW(), USER());
