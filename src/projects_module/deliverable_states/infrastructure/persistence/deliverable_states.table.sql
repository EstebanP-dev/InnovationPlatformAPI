CREATE TABLE deliverable_states(
    id CHAR(36) NOT NULL,
    name VARCHAR(60) NOT NULL UNIQUE,
    normalize_name VARCHAR(60) NOT NULL UNIQUE,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id)
);
