CREATE TABLE projects (
    id CHAR(36) NOT NULL,
    fk_assessor CHAR(36) NOT NULL,
    fk_type CHAR(36) NOT NULL,
    status ENUM('Completado', 'En Progreso', 'En Espera', 'Pendiente') NOT NULL DEFAULT 'Pendiente',
    title VARCHAR(255) NOT NULL UNIQUE,
    normalized_title VARCHAR(255) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id),
    FOREIGN KEY (fk_type) REFERENCES project_types(id),
    FOREIGN KEY (fk_assessor) REFERENCES project_assessors(id)
);

CREATE TABLE project_authors(
    id CHAR(36) NOT NULL,
    fk_project CHAR(36) NOT NULL,
    fk_author CHAR(36) NOT NULL,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (fk_project) REFERENCES projects(id),
    FOREIGN KEY (fk_author) REFERENCES members(id)
);


SELECT * FROM members;

CALL sp_get_projects('fbe535cf-fade-11ee-94e0-0242ac110002');
