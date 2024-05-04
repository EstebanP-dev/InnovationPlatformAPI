CREATE TABLE deliverable_types(
    id CHAR(36) NOT NULL,
    abbreviation CHAR(5) NOT NULL UNIQUE,
    extension CHAR(5) NOT NULL UNIQUE,
    name VARCHAR(60) NOT NULL UNIQUE,
    normalize_name VARCHAR(60) NOT NULL UNIQUE,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id)
);

SELECT * FROM deliverable_types;
