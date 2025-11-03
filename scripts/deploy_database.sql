SOURCE / Users / joshbuysell / Desktop / Work / data_base_college / schemas / schema_robotics_surgery_viktor_tsvyk.sql;
SOURCE / Users / joshbuysell / Desktop / Work / data_base_college / schemas / import_data.sql;
SOURCE / Users / joshbuysell / Desktop / Work / data_base_college / schemas / views_examples.sql;
SOURCE / Users / joshbuysell / Desktop / Work / data_base_college / schemas / stored_procedures_examples.sql;
SOURCE / Users / joshbuysell / Desktop / Work / data_base_college / schemas / validate_data.sql;
SELECT '========================================' as '';
SELECT 'БАЗА ДАНИХ УСПІШНО РОЗГОРНУТА!' as status;
SELECT '========================================' as '';
USE robotics_surgery_viktor_tsvyk;
SELECT 'Таблиці' as object_type,
    COUNT(*) as count
FROM information_schema.tables
WHERE table_schema = 'robotics_surgery_viktor_tsvyk'
    AND table_type = 'BASE TABLE'
UNION ALL
SELECT 'Представлення (Views)',
    COUNT(*)
FROM information_schema.tables
WHERE table_schema = 'robotics_surgery_viktor_tsvyk'
    AND table_type = 'VIEW'
UNION ALL
SELECT 'Збережені процедури',
    COUNT(*)
FROM information_schema.routines
WHERE routine_schema = 'robotics_surgery_viktor_tsvyk'
    AND routine_type = 'PROCEDURE';
SELECT '========================================' as '';