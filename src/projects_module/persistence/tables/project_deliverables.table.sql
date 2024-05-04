CREATE TABLE project_deliverables(
    id CHAR(36) NOT NULL,
    fk_type CHAR(36) NOT NULL,
    fk_project CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE,
    normalized_name VARCHAR(255) NOT NULL UNIQUE,
    url VARCHAR(255) NOT NULL,
    description TEXT,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY(id),
    FOREIGN KEY(fk_type) REFERENCES deliverable_types(id),
    FOREIGN KEY(fk_project) REFERENCES projects(id)
)
