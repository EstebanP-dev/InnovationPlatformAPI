INSERT INTO deliverable_types (id, abbreviation, extension, name, normalize_name, created_at, created_by)
VALUES (UUID(), 'PDF', 'pdf', 'Portable Document Format', 'PORTABLE_DOCUMENT_FORMAT', NOW(), USER()),
       (UUID(), 'DOCX', 'docx', 'Microsoft Word Document', 'MICROSOFT_WORD_DOCUMENT', NOW(), USER());

SELECT * FROM deliverable_types;
