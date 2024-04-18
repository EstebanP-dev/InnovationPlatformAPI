INSERT INTO companies(id, name, normalize_name, description, avatar, email, phone_number, created_at, created_by)
VALUES (
        UUID(),
        'Universidad de San Buenaventura',
        'UNIVERSIDAD_DE_SAN_BUENAVENTURA',
        'Universidad de San Buenaventura',
        'https://www.usbbog.edu.co/wp-content/uploads/2019/07/Logo-USB-2019.png',
        'soporte@usbmed.edu.co',
        '+57 4 448 83 88',
        NOW(),
        USER());
