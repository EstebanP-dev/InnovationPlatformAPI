SET FOREIGN_KEY_CHECKS = 0;

SELECT CONCAT('DROP TABLE IF EXISTS `', table_name, '`;')
FROM information_schema.tables
WHERE table_schema = 'innovation_platform'
INTO OUTFILE '/tmp/drop_all_tables.sql';

SOURCE /tmp/drop_all_tables.sql;

SET FOREIGN_KEY_CHECKS = 1;
