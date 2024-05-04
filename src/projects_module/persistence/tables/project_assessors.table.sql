CREATE table project_assessors(
    id CHAR(36) NOT NULL,
    code CHAR(36) NOT NULL,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES members(id)
)
