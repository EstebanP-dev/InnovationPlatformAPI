CREATE TABLE members(
    id CHAR(36) NOT NULL,
    fk_document_type CHAR(36) NOT NULL,
    fk_gender CHAR(36) NOT NULL,
    given_name VARCHAR(100) NOT NULL,
    family_name VARCHAR(100) NOT NULL,
    avatar VARCHAR(255),
    birth_date DATE NOT NULL,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (id),
    FOREIGN KEY (fk_document_type) REFERENCES document_types(id),
    FOREIGN KEY (fk_gender) REFERENCES genders(id)
);

CREATE TABLE member_member_types(
    fk_member CHAR(36) NOT NULL,
    fk_member_type CHAR(36) NOT NULL,
    active BIT DEFAULT 1,
    created_at DATETIME NOT NULL,
    created_by VARCHAR(50) NOT NULL,
    updated_at DATETIME,
    updated_by VARCHAR(50),

    PRIMARY KEY (fk_member, fk_member_type),
    FOREIGN KEY (fk_member) REFERENCES members(id),
    FOREIGN KEY (fk_member_type) REFERENCES member_types(id)
);
