CREATE TABLE roles (
    id CHAR(36) NOT NULL,
    name VARCHAR(60) NOT NULL UNIQUE,
    normalized_name VARCHAR(60) NOT NULL UNIQUE,
    description VARCHAR(255),
    active BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id)
);
