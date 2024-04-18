CREATE TABLE branches(
    id CHAR(36) NOT NULL,
    fk_city CHAR(36) NOT NULL,
    fk_company CHAR(36) NOT NULL,
    name VARCHAR(60) NOT NULL,
    normalize_name VARCHAR(60) NOT NULL,
    description VARCHAR(255),
    avatar VARCHAR(255),
    address VARCHAR(255),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id),
    FOREIGN KEY (fk_city) REFERENCES cities(id),
    FOREIGN KEY (fk_company) REFERENCES companies(id)
);
