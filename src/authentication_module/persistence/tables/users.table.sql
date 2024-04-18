CREATE TABLE users(
    id CHAR(36) NOT NULL,
    fk_branch CHAR(36) NOT NULL,
    code VARCHAR(20) NOT NULL UNIQUE,
    user_name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(60) NOT NULL,
    document_number VARCHAR(20) NOT NULL UNIQUE,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES members(id),
    FOREIGN KEY (fk_branch) REFERENCES branches(id)
);

CREATE TABLE user_roles(
    id CHAR(36) NOT NULL,
    fk_user CHAR(36) NOT NULL,
    fk_role CHAR(36) NOT NULL,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id),
    FOREIGN KEY (fk_user) REFERENCES users(id),
    FOREIGN KEY (fk_role) REFERENCES roles(id)
);
