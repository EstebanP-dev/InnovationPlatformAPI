create database if not exists innovation_platform;

create table if not exists companies
(
    id             char(36)         not null
        primary key,
    name           varchar(60)      not null,
    normalize_name varchar(60)      not null,
    description    varchar(255)     null,
    avatar         varchar(255)     null,
    email          varchar(100)     not null,
    phone_number   varchar(20)      not null,
    active         bit default b'1' null,
    created_at     datetime         not null,
    created_by     varchar(50)      not null,
    updated_at     datetime         null,
    updated_by     varchar(50)      null,
    constraint email
        unique (email),
    constraint name
        unique (name),
    constraint normalize_name
        unique (normalize_name),
    constraint phone_number
        unique (phone_number)
);

create table if not exists countries
(
    id              char(36)         not null
        primary key,
    name            varchar(60)      not null,
    normalized_name varchar(60)      not null,
    abbreviation    char(5)          not null,
    zip_code        char(8)          not null,
    active          bit default b'1' null,
    created_at      datetime         not null,
    created_by      varchar(50)      not null,
    updated_at      datetime         null,
    updated_by      varchar(50)      null,
    constraint name
        unique (name),
    constraint normalized_name
        unique (normalized_name),
    constraint zip_code
        unique (zip_code)
);

create table if not exists deliverable_types
(
    id             char(36)         not null
        primary key,
    abbreviation   char(5)          not null,
    extension      char(5)          not null,
    name           varchar(60)      not null,
    normalize_name varchar(60)      not null,
    active         bit default b'1' null,
    created_at     datetime         not null,
    created_by     varchar(50)      not null,
    updated_at     datetime         null,
    updated_by     varchar(50)      null,
    constraint abbreviation
        unique (abbreviation),
    constraint extension
        unique (extension),
    constraint name
        unique (name),
    constraint normalize_name
        unique (normalize_name)
);

create table if not exists document_types
(
    id              char(36)         not null
        primary key,
    abbreviation    char(5)          not null,
    name            varchar(60)      not null,
    normalized_name varchar(60)      not null,
    active          bit default b'1' null,
    created_at      datetime         not null,
    created_by      varchar(50)      not null,
    updated_at      datetime         null,
    updated_by      varchar(50)      null
);

create table if not exists genders
(
    id              char(36)         not null
        primary key,
    abbreviation    char(5)          not null,
    name            varchar(60)      not null,
    normalized_name varchar(60)      not null,
    active          bit default b'1' null,
    created_at      datetime         not null,
    created_by      varchar(50)      not null,
    updated_at      datetime         null,
    updated_by      varchar(50)      null
);

create table if not exists members
(
    id               char(36)         not null
        primary key,
    fk_document_type char(36)         not null,
    fk_gender        char(36)         not null,
    given_name       varchar(100)     not null,
    family_name      varchar(100)     not null,
    birth_date       date             not null,
    active           bit default b'1' null,
    created_at       datetime         not null,
    created_by       varchar(50)      not null,
    updated_at       datetime         null,
    updated_by       varchar(50)      null,
    avatar           varchar(255)     null,
    constraint members_ibfk_1
        foreign key (fk_document_type) references document_types (id),
    constraint members_ibfk_2
        foreign key (fk_gender) references genders (id)
);

create index fk_document_type
    on members (fk_document_type);

create index fk_gender
    on members (fk_gender);

create table if not exists project_assessors
(
    id         char(36)         not null
        primary key,
    code       char(36)         not null,
    active     bit default b'1' null,
    created_at datetime         not null,
    created_by varchar(50)      not null,
    updated_at datetime         null,
    updated_by varchar(50)      null,
    constraint project_assessors_ibfk_1
        foreign key (id) references members (id)
);

create table if not exists project_types
(
    id             char(36)         not null
        primary key,
    name           varchar(60)      not null,
    normalize_name varchar(60)      not null,
    active         bit default b'1' null,
    created_at     datetime         not null,
    created_by     varchar(50)      not null,
    updated_at     datetime         null,
    updated_by     varchar(50)      null,
    constraint name
        unique (name),
    constraint normalize_name
        unique (normalize_name)
);

create table if not exists projects
(
    id                    char(36)                                                                         not null
        primary key,
    fk_assessor           char(36)                                                                         not null,
    fk_type               char(36)                                                                         not null,
    status                enum ('Completado', 'En Progreso', 'En Espera', 'Pendiente') default 'Pendiente' not null,
    title                 varchar(255)                                                                     not null,
    normalized_title      varchar(255)                                                                     not null,
    description           text                                                                             not null,
    active                bit                                                          default b'1'        null,
    created_at            datetime                                                                         not null,
    created_by            varchar(50)                                                                      not null,
    updated_at            datetime                                                                         null,
    updated_by            varchar(50)                                                                      null,
    deliverable_folder_id char(36)                                                                         null,
    constraint normalized_title
        unique (normalized_title),
    constraint title
        unique (title),
    constraint projects_ibfk_1
        foreign key (fk_type) references project_types (id),
    constraint projects_ibfk_2
        foreign key (fk_assessor) references project_assessors (id)
);

create table if not exists project_authors
(
    id         char(36)    not null
        primary key,
    fk_project char(36)    not null,
    fk_author  char(36)    not null,
    created_at datetime    not null,
    created_by varchar(50) not null,
    constraint project_authors_ibfk_1
        foreign key (fk_project) references projects (id),
    constraint project_authors_ibfk_2
        foreign key (fk_author) references members (id)
);

create index fk_author
    on project_authors (fk_author);

create index fk_project
    on project_authors (fk_project);

create table if not exists project_deliverables
(
    id              char(36)                                                                not null
        primary key,
    status          enum ('Pending', 'Reviewing', 'Approved', 'Rejected') default 'Pending' null,
    fk_type         char(36)                                                                not null,
    fk_project      char(36)                                                                not null,
    name            varchar(255)                                                            not null,
    normalized_name varchar(255)                                                            not null,
    url             longtext                                                                not null,
    description     text                                                                    null,
    active          bit                                                   default b'1'      null,
    created_at      datetime                                                                not null,
    created_by      varchar(50)                                                             not null,
    updated_at      datetime                                                                null,
    updated_by      varchar(50)                                                             null,
    constraint project_deliverables_ibfk_1
        foreign key (fk_type) references deliverable_types (id),
    constraint project_deliverables_ibfk_2
        foreign key (fk_project) references projects (id)
);

create index fk_project
    on project_deliverables (fk_project);

create index fk_type
    on project_deliverables (fk_type);

create index fk_assessor
    on projects (fk_assessor);

create index fk_type
    on projects (fk_type);

create table if not exists roles
(
    id              char(36)         not null
        primary key,
    name            varchar(60)      not null,
    normalized_name varchar(60)      not null,
    description     varchar(255)     null,
    active          bit default b'1' not null,
    created_at      datetime         not null,
    created_by      varchar(50)      not null,
    updated_at      datetime         null,
    updated_by      varchar(50)      null,
    constraint name
        unique (name),
    constraint normalized_name
        unique (normalized_name)
);

create table if not exists states
(
    id              char(36)         not null
        primary key,
    fk_country      char(36)         not null,
    name            varchar(60)      not null,
    normalized_name varchar(60)      not null,
    abbreviation    char(5)          not null,
    active          bit default b'1' null,
    created_at      datetime         not null,
    created_by      varchar(50)      not null,
    updated_at      datetime         null,
    updated_by      varchar(50)      null,
    constraint abbreviation
        unique (abbreviation),
    constraint name
        unique (name),
    constraint normalized_name
        unique (normalized_name),
    constraint states_ibfk_1
        foreign key (fk_country) references countries (id)
);

create table if not exists cities
(
    id              char(36)         not null
        primary key,
    fk_state        char(36)         not null,
    name            varchar(60)      not null,
    normalized_name varchar(60)      not null,
    abbreviation    char(5)          not null,
    active          bit default b'1' null,
    created_at      datetime         not null,
    created_by      varchar(50)      not null,
    updated_at      datetime         null,
    updated_by      varchar(50)      null,
    constraint abbreviation
        unique (abbreviation),
    constraint name
        unique (name),
    constraint normalized_name
        unique (normalized_name),
    constraint cities_ibfk_1
        foreign key (fk_state) references states (id)
);

create table if not exists branches
(
    id             char(36)         not null
        primary key,
    fk_city        char(36)         not null,
    fk_company     char(36)         not null,
    name           varchar(60)      not null,
    normalize_name varchar(60)      not null,
    description    varchar(255)     null,
    avatar         varchar(255)     null,
    address        varchar(255)     null,
    email          varchar(100)     not null,
    phone_number   varchar(20)      not null,
    active         bit default b'1' null,
    created_at     datetime         not null,
    created_by     varchar(50)      not null,
    updated_at     datetime         null,
    updated_by     varchar(50)      null,
    constraint email
        unique (email),
    constraint phone_number
        unique (phone_number),
    constraint branches_ibfk_1
        foreign key (fk_city) references cities (id),
    constraint branches_ibfk_2
        foreign key (fk_company) references companies (id)
);

create index fk_city
    on branches (fk_city);

create index fk_company
    on branches (fk_company);

create index fk_state
    on cities (fk_state);

create index fk_country
    on states (fk_country);

create table if not exists users
(
    id              char(36)     not null
        primary key,
    fk_branch       char(36)     not null,
    code            varchar(20)  not null,
    user_name       varchar(50)  not null,
    email           varchar(100) not null,
    password_hash   varchar(60)  not null,
    document_number varchar(20)  not null,
    phone_number    varchar(20)  not null,
    created_at      datetime     not null,
    created_by      varchar(50)  not null,
    updated_at      datetime     null,
    updated_by      varchar(50)  null,
    constraint code
        unique (code),
    constraint document_number
        unique (document_number),
    constraint email
        unique (email),
    constraint phone_number
        unique (phone_number),
    constraint user_name
        unique (user_name),
    constraint users_ibfk_1
        foreign key (id) references members (id),
    constraint users_ibfk_2
        foreign key (fk_branch) references branches (id)
);

create table if not exists user_roles
(
    id         char(36)    not null
        primary key,
    fk_user    char(36)    not null,
    fk_role    char(36)    not null,
    created_at datetime    not null,
    created_by varchar(50) not null,
    updated_at datetime    null,
    updated_by varchar(50) null,
    constraint user_roles_ibfk_1
        foreign key (fk_user) references users (id),
    constraint user_roles_ibfk_2
        foreign key (fk_role) references roles (id)
);

create index fk_role
    on user_roles (fk_role);

create index fk_user
    on user_roles (fk_user);

create index fk_branch
    on users (fk_branch);

create definer = root@`%` view vw_assessor_members as
select `innovation_platform`.`vw_member_information`.`id`            AS `id`,
       `innovation_platform`.`vw_member_information`.`code`          AS `code`,
       `innovation_platform`.`vw_member_information`.`user_name`     AS `user_name`,
       `innovation_platform`.`vw_member_information`.`email`         AS `email`,
       `innovation_platform`.`vw_member_information`.`phone_number`  AS `phone_number`,
       `innovation_platform`.`vw_member_information`.`role_name`     AS `role_name`,
       `innovation_platform`.`vw_member_information`.`given_name`    AS `given_name`,
       `innovation_platform`.`vw_member_information`.`family_name`   AS `family_name`,
       `innovation_platform`.`vw_member_information`.`birth_date`    AS `birth_date`,
       `innovation_platform`.`vw_member_information`.`document_type` AS `document_type`,
       `innovation_platform`.`vw_member_information`.`gender`        AS `gender`
from `innovation_platform`.`vw_member_information`
where (`innovation_platform`.`vw_member_information`.`role_name` like '%Assessor%');

create definer = root@`%` view vw_authorial_members as
select `innovation_platform`.`vw_member_information`.`id`            AS `id`,
       `innovation_platform`.`vw_member_information`.`code`          AS `code`,
       `innovation_platform`.`vw_member_information`.`user_name`     AS `user_name`,
       `innovation_platform`.`vw_member_information`.`email`         AS `email`,
       `innovation_platform`.`vw_member_information`.`phone_number`  AS `phone_number`,
       `innovation_platform`.`vw_member_information`.`role_name`     AS `role_name`,
       `innovation_platform`.`vw_member_information`.`given_name`    AS `given_name`,
       `innovation_platform`.`vw_member_information`.`family_name`   AS `family_name`,
       `innovation_platform`.`vw_member_information`.`birth_date`    AS `birth_date`,
       `innovation_platform`.`vw_member_information`.`document_type` AS `document_type`,
       `innovation_platform`.`vw_member_information`.`gender`        AS `gender`
from `innovation_platform`.`vw_member_information`
where ((not ((`innovation_platform`.`vw_member_information`.`role_name` like '%Assessor%'))) and
       (not ((`innovation_platform`.`vw_member_information`.`role_name` like '%Admin%'))));

create definer = root@`%` view vw_member_information as
select `u`.`id`              AS `id`,
       `u`.`code`            AS `code`,
       `u`.`user_name`       AS `user_name`,
       `u`.`email`           AS `email`,
       `u`.`document_number` AS `document_number`,
       `u`.`phone_number`    AS `phone_number`,
       `r`.`name`            AS `role_name`,
       `m`.`avatar`          AS `avatar`,
       `m`.`given_name`      AS `given_name`,
       `m`.`family_name`     AS `family_name`,
       `m`.`birth_date`      AS `birth_date`,
       `dt`.`name`           AS `document_type`,
       `g`.`name`            AS `gender`
from (((((`innovation_platform`.`user_roles` `ur` join `innovation_platform`.`roles` `r`
          on ((`ur`.`fk_role` = `r`.`id`))) join `innovation_platform`.`users` `u`
         on ((`ur`.`fk_user` = `u`.`id`))) join `innovation_platform`.`members` `m`
        on ((`u`.`id` = `m`.`id`))) join `innovation_platform`.`document_types` `dt`
       on ((`m`.`fk_document_type` = `dt`.`id`))) join `innovation_platform`.`genders` `g`
      on ((`m`.`fk_gender` = `g`.`id`)));

create definer = root@`%` view vw_project_deliverable_types as
select `innovation_platform`.`deliverable_types`.`id`        AS `id`,
       `innovation_platform`.`deliverable_types`.`name`      AS `name`,
       `innovation_platform`.`deliverable_types`.`extension` AS `extension`
from `innovation_platform`.`deliverable_types`
where (`innovation_platform`.`deliverable_types`.`active` = 1);

create definer = root@`%` view vw_project_types as
select `innovation_platform`.`project_types`.`id` AS `id`, `innovation_platform`.`project_types`.`name` AS `name`
from `innovation_platform`.`project_types`
where (`innovation_platform`.`project_types`.`active` = 1);

create definer = root@`%` view vw_projects as
select `p`.`id`                                                                                                     AS `id`,
       `p`.`status`                                                                                                 AS `status`,
       `p`.`title`                                                                                                  AS `title`,
       `p`.`description`                                                                                            AS `description`,
       `pt`.`name`                                                                                                  AS `type`,
       json_object('id', `m`.`id`, 'full_name',
                   concat(`m`.`given_name`, ' ', `m`.`family_name`))                                                AS `assessor`,
       coalesce(json_arrayagg(json_object('id', `pd`.`id`, 'type', `dt`.`name`, 'status', `pd`.`status`, 'name',
                                          `pd`.`name`, 'url', `pd`.`url`, 'description', `pd`.`description`,
                                          'created_at', `pd`.`created_at`, 'updated_at', `pd`.`updated_at`)),
                '[]')                                                                                               AS `deliverables`,
       coalesce(json_arrayagg(json_object('id', `pa`.`id`, 'full_name',
                                          concat(`ma`.`given_name`, ' ', `ma`.`family_name`))),
                '[]')                                                                                               AS `authors`,
       `p`.`created_at`                                                                                             AS `created_at`,
       `p`.`updated_at`                                                                                             AS `updated_at`
from ((`innovation_platform`.`project_authors` `pa` left join (`innovation_platform`.`members` `m` left join (`innovation_platform`.`project_assessors` `ps` left join (((`innovation_platform`.`project_types` `pt` left join `innovation_platform`.`projects` `p`
                                                                                                                                                                          on ((`p`.`fk_type` = `pt`.`id`))) left join `innovation_platform`.`project_deliverables` `pd`
                                                                                                                                                                         on ((`p`.`id` = `pd`.`fk_project`))) left join `innovation_platform`.`deliverable_types` `dt`
                                                                                                                                                                        on ((`pd`.`fk_type` = `dt`.`id`)))
                                                                                                              on ((`p`.`fk_assessor` = `ps`.`id`)))
                                                               on ((`ps`.`id` = `m`.`id`)))
       on ((`p`.`id` = `pa`.`fk_project`))) left join `innovation_platform`.`members` `ma`
      on ((`pa`.`fk_author` = `ma`.`id`)))
where (`p`.`active` = true)
group by `p`.`id`;

create
    definer = root@`%` function is_valid_uuid(input_uuid char(36)) returns tinyint(1) deterministic
BEGIN
    RETURN input_uuid REGEXP '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$';
END;

create
    definer = root@`%` function mask(unformatted_value bigint, format_string char(32)) returns char(32) deterministic
BEGIN
    DECLARE input_len TINYINT;
    DECLARE output_len TINYINT;
    DECLARE temp_char CHAR;

    SET input_len = LENGTH(unformatted_value);
    SET output_len = LENGTH(format_string);

    WHILE (output_len > 0) DO
            SET temp_char = SUBSTR(format_string, output_len, 1);
            IF (temp_char = '#') THEN
                IF (input_len > 0) THEN
                    SET format_string = INSERT(format_string, output_len, 1, SUBSTR(unformatted_value, input_len, 1));
                    SET input_len = input_len - 1;
                ELSE
                    SET format_string = INSERT(format_string, output_len, 1, '0');
                END IF;
            END IF;
            SET output_len = output_len - 1;
        END WHILE;

    RETURN format_string;
END;

create
    definer = root@`%` function mask_pan_or_email(input varchar(255)) returns varchar(255) deterministic no sql
BEGIN
    DECLARE is_email BOOL;
    DECLARE at_pos INT;
    DECLARE last_dot_pos INT;
    DECLARE first_part VARCHAR(255);
    DECLARE domain_part VARCHAR(255);
    DECLARE extension_part VARCHAR(255);
    DECLARE masked_email VARCHAR(255);

    SET is_email = (LOCATE('@', input) > 0) AND (LOCATE('.', input) > LOCATE('@', input));

    IF is_email THEN
        SET at_pos = LOCATE('@', input);
        SET last_dot_pos = LOCATE('.', REVERSE(input));
        SET first_part = LEFT(input, at_pos - 1);
        SET domain_part = SUBSTRING(input, at_pos + 1, LENGTH(input) - at_pos - last_dot_pos);
        SET extension_part = RIGHT(input, last_dot_pos - 1);

        SET masked_email = CONCAT(LEFT(first_part, 1), REPEAT('*', CHAR_LENGTH(first_part) - 1), '@', domain_part, '.', extension_part);

        RETURN masked_email;
    ELSE
        IF CHAR_LENGTH(input) < 2 THEN
            RETURN input;
        END IF;

        IF CHAR_LENGTH(input) < 7 THEN
            RETURN CONCAT(LEFT(input, 1), REPEAT('*', CHAR_LENGTH(input) - 1));
        END IF;

        RETURN CONCAT(REPEAT('*', CHAR_LENGTH(input) - 4), SUBSTRING(input, - 4));
    END IF;
END;

create
    definer = root@`%` function normalize_text(input_text varchar(255), to_upper tinyint(1)) returns varchar(255)
    deterministic
BEGIN
    DECLARE normalized_text VARCHAR(255);
    SET normalized_text = input_text;

    SET normalized_text = REPLACE(normalized_text, ' ', '_');
    SET normalized_text = REPLACE(normalized_text, '.', '');
    SET normalized_text = REPLACE(normalized_text, ',', '');
    SET normalized_text = REPLACE(normalized_text, ';', '');
    SET normalized_text = REPLACE(normalized_text, ':', '');
    SET normalized_text = REPLACE(normalized_text, '?', '');
    SET normalized_text = REPLACE(normalized_text, '!', '');
    SET normalized_text = REPLACE(normalized_text, '@', '');
    SET normalized_text = REPLACE(normalized_text, '#', '');
    SET normalized_text = REPLACE(normalized_text, '$', '');
    SET normalized_text = REPLACE(normalized_text, '%', '');
    SET normalized_text = REPLACE(normalized_text, '^', '');
    SET normalized_text = REPLACE(normalized_text, '&', '');
    SET normalized_text = REPLACE(normalized_text, '*', '');
    SET normalized_text = REPLACE(normalized_text, '(', '');
    SET normalized_text = REPLACE(normalized_text, ')', '');
    SET normalized_text = REPLACE(normalized_text, '[', '');
    SET normalized_text = REPLACE(normalized_text, ']', '');
    SET normalized_text = REPLACE(normalized_text, '{', '');
    SET normalized_text = REPLACE(normalized_text, '}', '');
    SET normalized_text = REPLACE(normalized_text, '"', '');
    SET normalized_text = REPLACE(normalized_text, '''', '');
    SET normalized_text = REPLACE(normalized_text, '<', '');
    SET normalized_text = REPLACE(normalized_text, '>', '');
    SET normalized_text = REPLACE(normalized_text, '|', '');
    SET normalized_text = REPLACE(normalized_text, '/', '');
    SET normalized_text = REPLACE(normalized_text, '\\', '');

    IF to_upper THEN
        SET normalized_text = UPPER(normalized_text);
    ELSE
        SET normalized_text = LOWER(normalized_text);
    END IF;

    SET normalized_text = REPLACE(normalized_text, 'Á', 'A');
    SET normalized_text = REPLACE(normalized_text, 'É', 'E');
    SET normalized_text = REPLACE(normalized_text, 'Í', 'I');
    SET normalized_text = REPLACE(normalized_text, 'Ó', 'O');
    SET normalized_text = REPLACE(normalized_text, 'Ú', 'U');
    SET normalized_text = REPLACE(normalized_text, 'Ñ', 'N');
    SET normalized_text = REPLACE(normalized_text, 'á', 'A');
    SET normalized_text = REPLACE(normalized_text, 'é', 'E');
    SET normalized_text = REPLACE(normalized_text, 'í', 'I');
    SET normalized_text = REPLACE(normalized_text, 'ó', 'O');
    SET normalized_text = REPLACE(normalized_text, 'ú', 'U');
    SET normalized_text = REPLACE(normalized_text, 'ñ', 'N');

    RETURN normalized_text;
END;

create
    definer = root@`%` procedure sp_change_project_deliverable_status(IN deliverable_id char(36),
                                                                      IN deliverable_status enum ('Pending', 'Reviewing', 'Approved', 'Rejected'))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF NOT is_valid_uuid(deliverable_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid deliverable_id format';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM project_deliverables WHERE id = deliverable_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliverable does not exist';
    END IF;

    START TRANSACTION;

    UPDATE project_deliverables
    SET status = deliverable_status
    WHERE id = deliverable_id;

    COMMIT;

    SELECT 1;

END;

create
    definer = root@`%` procedure sp_delete_project(IN project_id char(36), IN force_delete tinyint(1))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM projects WHERE id = project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Project not found';
    END IF;

    IF force_delete THEN
        DELETE FROM project_authors
        WHERE fk_project = project_id;

        DELETE FROM project_deliverables
        WHERE fk_project = project_id;

        DELETE FROM projects
        WHERE id = project_id;

        COMMIT;

        SELECT 1;
    END IF;

    UPDATE projects
    SET active = 0
    WHERE id = project_id;

    UPDATE project_deliverables
    SET active = 0
    WHERE fk_project = project_id;

    COMMIT;

    SELECT 1;
END;

create
    definer = root@`%` procedure sp_exist_user_by_uniques(IN field varchar(255), OUT password_hash varchar(255))
BEGIN
    DECLARE user_exists INT;
    DECLARE password_hash_temp VARCHAR(255);

    SELECT 1, u.password_hash INTO user_exists, password_hash_temp
    FROM users u
             USE INDEX (`PRIMARY`, code, document_number, email, phone_number, user_name)
    WHERE u.id = field OR u.email = field OR u.user_name = field OR u.code = field
       OR u.document_number = field OR u.phone_number = field;

    SET password_hash = password_hash_temp;

    SELECT user_exists;
END;

create
    definer = root@`%` procedure sp_exists_deliverable_type(IN deliverable_type_id char(36))
BEGIN
    SELECT EXISTS(SELECT 1 FROM deliverable_types WHERE id = deliverable_type_id);
END;

create
    definer = root@`%` procedure sp_get_project(IN project_id char(36))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    SELECT *
    FROM vw_projects
    WHERE id = project_id;
END;

create
    definer = root@`%` procedure sp_get_projects(IN user_id char(36))
BEGIN

    DECLARE is_admin BOOLEAN;
    SET is_admin = EXISTS(SELECT 1 FROM user_roles WHERE fk_user = user_id AND fk_role = '26da04bb-fab9-11ee-94e0-0242ac110002');

    SELECT
        p.id,
        p.status,
        p.title,
        p.description,
        pt.name AS type,
        JSON_OBJECT('id', m.id, 'full_name', CONCAT(m.given_name, ' ', m.family_name)) AS assessor,
        COALESCE(JSON_ARRAYAGG(JSON_OBJECT('id', pd.id, 'type', dt.name, 'status', pd.status, 'name', pd.name, 'url', pd.url, 'description', pd.description, 'created_at', pd.created_at, 'updated_at', pd.updated_at)), '[]') AS deliverables,
        COALESCE(JSON_ARRAYAGG(JSON_OBJECT('id', pa.id, 'full_name', CONCAT(ma.given_name, ' ', ma.family_name))), '[]') AS authors,
        p.created_at,
        p.updated_at
    FROM
        projects p
    RIGHT JOIN project_types pt ON p.fk_type = pt.id
    LEFT JOIN project_deliverables pd ON p.id = pd.fk_project
    LEFT JOIN deliverable_types dt ON pd.fk_type = dt.id
    RIGHT JOIN project_assessors ps ON p.fk_assessor = ps.id
    RIGHT JOIN members m ON ps.id = m.id
    RIGHT JOIN project_authors pa ON p.id = pa.fk_project
    LEFT JOIN members ma ON pa.fk_author = ma.id
    WHERE
        p.active = TRUE AND
        (is_admin OR m.id = user_id OR ma.id = user_id)
    GROUP BY
        p.id;

END;

create
    definer = root@`%` procedure sp_get_total_by_status(IN user_id char(36), OUT total_projects int)
BEGIN
    DECLARE user_role CHAR(36);

    SELECT fk_role INTO user_role
    FROM user_roles
    WHERE fk_user = user_id;

    IF user_role = '26da04bb-fab9-11ee-94e0-0242ac110002' THEN
        SELECT COUNT(*) INTO total_projects FROM projects WHERE active = TRUE;

        SELECT status, COUNT(*) as total, MAX(created_at) as last_created
        FROM projects
        WHERE active = TRUE
        GROUP BY status;
    ELSE
        SELECT COUNT(*) INTO total_projects
        FROM projects
        WHERE active = TRUE
          AND (fk_assessor = user_id OR EXISTS (SELECT 1 FROM project_authors WHERE fk_project = projects.id AND fk_author = user_id));

        SELECT status, COUNT(*) as total, MAX(created_at) as last_created
        FROM projects
        WHERE active = TRUE
          AND (fk_assessor = user_id OR EXISTS (SELECT 1 FROM project_authors WHERE fk_project = projects.id AND fk_author = user_id))
        GROUP BY status;
    END IF;
END;

create
    definer = root@`%` procedure sp_get_user_by_uniques(IN field varchar(255))
BEGIN
    SELECT u.id, mask_pan_or_email(u.email) as email, mask_pan_or_email(u.user_name) as user_name, u.code, mask_pan_or_email(u.document_number) as document_number, u.password_hash,
           dt.name AS document_type, g.name as gender, mask_pan_or_email(u.phone_number) as phone_number,
           m.birth_date, CONCAT(m.given_name, ' ', m.family_name) AS full_name,
           COALESCE(JSON_ARRAYAGG(r.name), '[]') as roles
    FROM users u
             USE INDEX (`PRIMARY`, code, document_number, email, phone_number, user_name)
             INNER JOIN members m ON u.id = m.id
             INNER JOIN document_types dt ON m.fk_document_type = dt.id
             INNER JOIN genders g ON m.fk_gender = g.id
             INNER JOIN user_roles ur ON u.id = ur.fk_user
             INNER JOIN roles r ON ur.fk_role = r.id
    WHERE u.id = field OR u.email = field OR u.user_name = field OR u.code = field
       OR u.document_number = field OR u.phone_number = field
    GROUP BY u.id;
END;

create
    definer = root@`%` procedure sp_insert_project(IN assessor_id char(36), IN project_id char(36),
                                                   IN project_type_id char(36), IN project_title varchar(255),
                                                   IN project_description text,
                                                   IN project_deliverable_folder_id char(36),
                                                   IN project_status enum ('Completado', 'En Progreso', 'En Espera', 'Pendiente'),
                                                   IN project_authors text)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE autor_id CHAR(36);
    DECLARE autor_ids_length INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    SET project_id = IFNULL(project_id, UUID());

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT is_valid_uuid(assessor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid assessor_id format';
    END IF;

    IF NOT is_valid_uuid(project_type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_type_id format';
    END IF;

    INSERT INTO projects (id, fk_assessor, fk_type, title, normalized_title, description, deliverable_folder_id, status, created_at, created_by)
    VALUES (project_id, assessor_id, project_type_id, project_title, normalize_text(project_title, TRUE), project_description, project_deliverable_folder_id, project_status, NOW(), USER());

    SET autor_ids_length = LENGTH(project_authors) - LENGTH(REPLACE(project_authors, ',', '')) + 1;

    WHILE i < autor_ids_length DO
            SET autor_id = SUBSTRING_INDEX(SUBSTRING_INDEX(project_authors, ',', i + 1), ',', -1);

            IF NOT is_valid_uuid(autor_id) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid author_id format';
            END IF;

            INSERT INTO project_authors (id, fk_project, fk_author, created_at, created_by)
            VALUES (UUID(), project_id, autor_id, NOW(), USER());

            SET i = i + 1;
        END WHILE;

    SET i = 0;

    COMMIT;

    SELECT project_id;
END;

create
    definer = root@`%` procedure sp_insert_project_deliverable(IN project_id char(36), IN type_id char(36),
                                                               IN deliverable_id char(36),
                                                               IN deliverable_status enum ('Pending', 'Reviewing', 'Approved', 'Rejected'),
                                                               IN deliverable_name varchar(255),
                                                               IN deliverable_description text,
                                                               IN deliverable_url longtext)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT is_valid_uuid(type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT is_valid_uuid(deliverable_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM projects WHERE id = project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Project does not exist';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM deliverable_types WHERE id = type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliverable type does not exist';
    END IF;

    IF deliverable_name IS NULL OR deliverable_name = '' OR deliverable_name = ' ' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deliverable name cannot be empty';
    END IF;

    START TRANSACTION;

    INSERT INTO project_deliverables (id, status, fk_type, fk_project, name, normalized_name, url, description, created_at, created_by)
    VALUES (deliverable_id, deliverable_status, type_id, project_id, deliverable_name, normalize_text(deliverable_name, true), deliverable_url, deliverable_description, NOW(), USER());

    COMMIT;

    SELECT 1;

END;

create
    definer = root@`%` procedure sp_insert_user(IN branch_id char(36), IN document_type_id char(36),
                                                IN gender_id char(36), IN roles_ids varchar(255),
                                                IN user_code varchar(20), IN user_document_number varchar(20),
                                                IN user_email varchar(100), IN user_user_name varchar(50),
                                                IN user_password_hash varchar(60), IN user_phone_number varchar(20),
                                                IN user_birth_date date, IN user_given_name varchar(100),
                                                IN user_family_name varchar(100), IN user_avatar varchar(255),
                                                IN user_assessor_code varchar(20))
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE user_id CHAR(36);
    DECLARE assessor_role_id CHAR(36);
    DECLARE role_id CHAR(36);
    DECLARE role_ids_length INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    IF branch_id IS NULL OR document_type_id IS NULL OR gender_id IS NULL OR user_code IS NULL OR user_document_number IS NULL OR user_email IS NULL OR user_user_name IS NULL OR user_password_hash IS NULL OR user_phone_number IS NULL OR user_birth_date IS NULL OR user_given_name IS NULL OR user_family_name IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Los parámetros requeridos no pueden ser nulos.';
    END IF;

    START TRANSACTION;

    SET user_id = UUID();
    SET assessor_role_id = '26da26f7-fab9-11ee-94e0-0242ac110002';

    INSERT INTO members (id, fk_document_type, fk_gender, given_name, family_name,  avatar, birth_date, created_at, created_by)
    VALUES (user_id, document_type_id, gender_id, user_given_name, user_family_name, user_avatar, user_birth_date, NOW(), USER());

    INSERT INTO users (id, fk_branch, user_name, password_hash, email, phone_number, document_number, code, created_at, created_by)
    VALUES (user_id, branch_id, user_user_name, user_password_hash, user_email, user_phone_number, user_document_number, user_code, NOW(), USER());

    SET role_ids_length = LENGTH(roles_ids) - LENGTH(REPLACE(roles_ids, ',', '')) + 1;

    SET i = 0;

    WHILE i < role_ids_length DO
            SET role_id = SUBSTRING_INDEX(SUBSTRING_INDEX(roles_ids, ',', i + 1), ',', -1);

            IF NOT is_valid_uuid(role_id) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El id del rol no es válido.';
            END IF;

            INSERT INTO user_roles (id, fk_user, fk_role, created_at, created_by)
            VALUES (UUID(), user_id, role_id, NOW(), USER());

            IF role_id = assessor_role_id THEN

                IF user_assessor_code IS NULL THEN
                    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El código del asesor no puede ser nulo.';
                END IF;

                INSERT INTO project_assessors (id, code, created_at, created_by)
                VALUES (user_id, user_assessor_code, NOW(), USER());
            END IF;

            SET i = i + 1;
        END WHILE;

    COMMIT;

END;

create
    definer = root@`%` procedure sp_modify_project(IN project_id char(36), IN assessor_id char(36),
                                                   IN project_type_id char(36), IN project_title varchar(255),
                                                   IN project_description text,
                                                   IN project_status enum ('Completado', 'En Progreso', 'En Espera', 'Pendiente'),
                                                   IN project_authors_str text)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE autor_id CHAR(36);
    DECLARE autor_ids_length INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

    START TRANSACTION;

    IF NOT is_valid_uuid(project_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_id format';
    END IF;

    IF project_authors_str IS NOT NULL THEN
        SET autor_ids_length = LENGTH(project_authors_str) - LENGTH(REPLACE(project_authors_str, ',', '')) + 1;

        WHILE i < autor_ids_length DO
            SET autor_id = SUBSTRING_INDEX(SUBSTRING_INDEX(project_authors_str, ',', i + 1), ',', -1);

            IF NOT is_valid_uuid(autor_id) THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid author_id format';
            END IF;

            IF NOT EXISTS (SELECT 1 FROM project_authors WHERE fk_author = autor_id AND fk_project = project_id) THEN
                DELETE FROM project_authors WHERE fk_author = autor_id AND fk_project = project_id;
            END IF;

            SET i = i + 1;
        END WHILE;

        SET i = 0;
    END IF;


    IF NOT is_valid_uuid(assessor_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid assessor_id format';
    END IF;

    IF NOT is_valid_uuid(project_type_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid project_type_id format';
    END IF;

    UPDATE projects
        SET fk_assessor = IFNULL(assessor_id, fk_assessor),
            fk_type = IFNULL(project_type_id, fk_type),
            title = IFNULL(project_title, title),
            normalized_title = normalize_text(IFNULL(project_title, title), TRUE),
            description = IFNULL(project_description, description),
            status = IFNULL(project_status, status),
            updated_at = NOW(),
            updated_by = USER()
    WHERE id = project_id;

    SELECT 1;

    COMMIT;
END;

INSERT INTO innovation_platform.countries (id,name,normalized_name,abbreviation,zip_code,active,created_at,created_by,updated_at,updated_by) VALUES
    ('dafb2e40-fabb-11ee-94e0-0242ac110002','Colombia','COLOMBIA','CO','57',1,'2024-04-15 00:05:23','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.states (id,fk_country,name,normalized_name,abbreviation,active,created_at,created_by,updated_at,updated_by) VALUES
    ('d41d5018-fadc-11ee-94e0-0242ac110002','dafb2e40-fabb-11ee-94e0-0242ac110002','Antioquia','ANTIOQUIA','ANT',1,'2024-04-15 04:01:25','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.cities (id,fk_state,name,normalized_name,abbreviation,active,created_at,created_by,updated_at,updated_by) VALUES
    ('32a43022-fadd-11ee-94e0-0242ac110002','d41d5018-fadc-11ee-94e0-0242ac110002','Medellín','MEDELLIN','MED',1,'2024-04-15 04:04:03','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.countries (id,name,normalized_name,abbreviation,zip_code,active,created_at,created_by,updated_at,updated_by) VALUES
    ('dafb2e40-fabb-11ee-94e0-0242ac110002','Colombia','COLOMBIA','CO','57',1,'2024-04-15 00:05:23','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.branches (id,fk_city,fk_company,name,normalize_name,description,avatar,address,email,phone_number,active,created_at,created_by,updated_at,updated_by) VALUES
    ('be7ed35e-fadd-11ee-94e0-0242ac110002','32a43022-fadd-11ee-94e0-0242ac110002','6afca21c-fabb-11ee-94e0-0242ac110002','Universidad de San Buenaventura Sede Medellín','UNIVERSIDAD_DE_SAN_BUENAVENTURA_SEDE_MEDELLIN','Universidad de San Buenaventura Sede Medellín','https://www.usbmed.edu.co/wp-content/uploads/2019/07/usbmed-logo.png','Carrera 51D #67B-90','support@usbmed.edu.co','444 44 44',1,'2024-04-15 04:07:58','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.document_types (id,abbreviation,name,normalized_name,active,created_at,created_by,updated_at,updated_by) VALUES
                                                                                                                                             ('14aa126f-faba-11ee-94e0-0242ac110002','CC','Cédula de Ciudadanía','CEDULA_DE_CIUDADANIA',1,'2024-04-14 23:52:41','root@172.17.0.1',NULL,NULL),
                                                                                                                                             ('14aa209a-faba-11ee-94e0-0242ac110002','CE','Cédula de Extranjería','CEDULA_DE_EXTRANJERIA',1,'2024-04-14 23:52:41','root@172.17.0.1',NULL,NULL),
                                                                                                                                             ('14aa2204-faba-11ee-94e0-0242ac110002','PA','Pasaporte','PASAPORTE',1,'2024-04-14 23:52:41','root@172.17.0.1',NULL,NULL),
                                                                                                                                             ('14aa2248-faba-11ee-94e0-0242ac110002','RC','Registro Civil','REGISTRO_CIVIL',1,'2024-04-14 23:52:41','root@172.17.0.1',NULL,NULL),
                                                                                                                                             ('14aa226c-faba-11ee-94e0-0242ac110002','TI','Tarjeta de Identidad','TARJETA_DE_IDENTIDAD',1,'2024-04-14 23:52:41','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.genders (id,abbreviation,name,normalized_name,active,created_at,created_by,updated_at,updated_by) VALUES
                                                                                                                                      ('698c7f5f-faba-11ee-94e0-0242ac110002','M','Masculino','MASCULINO',1,'2024-04-14 23:55:03','root@172.17.0.1',NULL,NULL),
                                                                                                                                      ('698c8472-faba-11ee-94e0-0242ac110002','F','Feminino','FEMININO',1,'2024-04-14 23:55:03','root@172.17.0.1',NULL,NULL),
                                                                                                                                      ('698c8582-faba-11ee-94e0-0242ac110002','O','Otro','OTRO',1,'2024-04-14 23:55:03','root@172.17.0.1',NULL,NULL);

INSERT INTO innovation_platform.deliverable_types (id,abbreviation,extension,name,normalize_name,active,created_at,created_by,updated_at,updated_by) VALUES
                                                                                                                                                         ('3597dfe9-fb60-11ee-8265-0242ac110002','PDF','.pdf','Portable Document Format','PORTABLE_DOCUMENT_FORMAT',1,'2024-04-15 19:41:52','root@172.17.0.1',NULL,NULL),
                                                                                                                                                         ('3599b0fe-fb60-11ee-8265-0242ac110002','DOCX','.docx','Microsoft Word Document','MICROSOFT_WORD_DOCUMENT',1,'2024-04-15 19:41:52','root@172.17.0.1',NULL,NULL);

INSERT INTO innovation_platform.roles (id,name,normalized_name,description,active,created_at,created_by,updated_at,updated_by) VALUES
                                                                                                                                   ('26da04bb-fab9-11ee-94e0-0242ac110002','Admin','ADMIN','Administrator',1,'2024-04-14 23:46:02','root@172.17.0.1',NULL,NULL),
                                                                                                                                   ('26da2498-fab9-11ee-94e0-0242ac110002','Student','STUDENT','User',1,'2024-04-14 23:46:02','root@172.17.0.1',NULL,NULL),
                                                                                                                                   ('26da2683-fab9-11ee-94e0-0242ac110002','Teacher','TEACHER','Teacher',1,'2024-04-14 23:46:02','root@172.17.0.1',NULL,NULL),
                                                                                                                                   ('26da26f7-fab9-11ee-94e0-0242ac110002','Assessor','ASSESSOR','Assessor',1,'2024-04-14 23:46:02','root@172.17.0.1',NULL,NULL);
INSERT INTO innovation_platform.members (id,fk_document_type,fk_gender,given_name,family_name,birth_date,active,created_at,created_by,updated_at,updated_by,avatar) VALUES
                                                                                                                                                                        ('2f74d54f-1f8a-11ef-895b-0242ac190002','14aa126f-faba-11ee-94e0-0242ac110002','698c7f5f-faba-11ee-94e0-0242ac110002','Admin','Admin','1995-05-05',1,'2024-05-31 20:13:03','root@172.25.0.3',NULL,NULL,NULL);
INSERT INTO innovation_platform.users (id,fk_branch,code,user_name,email,password_hash,document_number,phone_number,created_at,created_by,updated_at,updated_by) VALUES
                                                                                                                                                                     ('2f74d54f-1f8a-11ef-895b-0242ac190002','be7ed35e-fadd-11ee-94e0-0242ac110002','7777777777','admin','admin@admin.com','$2b$12$elL2Tevv0LuWPgGcrMxjjuRH3lI5Jedag7uPWvOVJg3hrHCtDzIES','7777777770','3000000000','2024-05-31 20:13:03','root@172.25.0.3',NULL,NULL);
