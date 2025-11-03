USE robotics_surgery_viktor_tsvyk;
SELECT '=== ПЕРЕВІРКА КАРДИНАЛЬНОСТІ ===' as '';
SELECT 'patients' as table_name,
    COUNT(*) as record_count,
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END as status
FROM patients
UNION ALL
SELECT 'surgeons',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END
FROM surgeons
UNION ALL
SELECT 'operating_rooms',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END
FROM operating_rooms
UNION ALL
SELECT 'surgical_robots',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END
FROM surgical_robots
UNION ALL
SELECT 'procedures',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END
FROM procedures
UNION ALL
SELECT 'instruments',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END
FROM instruments
UNION ALL
SELECT 'software_versions',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 5 THEN 'OK'
        ELSE 'ERROR'
    END
FROM software_versions;
SELECT '' as '';
SELECT 'surgery_sessions' as table_name,
    COUNT(*) as record_count,
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END as status
FROM surgery_sessions
UNION ALL
SELECT 'robot_modules',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM robot_modules
UNION ALL
SELECT 'vital_signs',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM vital_signs
UNION ALL
SELECT 'anesthesia_records',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM anesthesia_records
UNION ALL
SELECT 'imaging_data',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM imaging_data
UNION ALL
SELECT 'complications',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM complications
UNION ALL
SELECT 'maintenances',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM maintenances
UNION ALL
SELECT 'calibrations',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM calibrations
UNION ALL
SELECT 'device_events',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 15 THEN 'OK'
        ELSE 'ERROR'
    END
FROM device_events;
SELECT '' as '';
SELECT 'instrument_compatibilities' as table_name,
    COUNT(*) as record_count,
    CASE
        WHEN COUNT(*) = 8 THEN 'OK'
        ELSE 'ERROR'
    END as status
FROM instrument_compatibilities
UNION ALL
SELECT 'session_instrument_uses',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 8 THEN 'OK'
        ELSE 'ERROR'
    END
FROM session_instrument_uses
UNION ALL
SELECT 'robot_software_installs',
    COUNT(*),
    CASE
        WHEN COUNT(*) = 8 THEN 'OK'
        ELSE 'ERROR'
    END
FROM robot_software_installs;
SELECT '' as '';
SELECT '=== ПЕРЕВІРКА ЗОВНІШНІХ КЛЮЧІВ ===' as '';
SELECT 'surgery_sessions -> patients' as check_name,
    COUNT(*) as invalid_records
FROM surgery_sessions ss
    LEFT JOIN patients p ON ss.patient_id = p.patient_id
WHERE p.patient_id IS NULL;
SELECT 'surgery_sessions -> procedures' as check_name,
    COUNT(*) as invalid_records
FROM surgery_sessions ss
    LEFT JOIN procedures pr ON ss.procedure_id = pr.procedure_id
WHERE pr.procedure_id IS NULL;
SELECT 'surgery_sessions -> surgeons' as check_name,
    COUNT(*) as invalid_records
FROM surgery_sessions ss
    LEFT JOIN surgeons s ON ss.surgeon_id = s.surgeon_id
WHERE s.surgeon_id IS NULL;
SELECT 'surgery_sessions -> surgical_robots' as check_name,
    COUNT(*) as invalid_records
FROM surgery_sessions ss
    LEFT JOIN surgical_robots sr ON ss.robot_id = sr.robot_id
WHERE sr.robot_id IS NULL;
SELECT 'surgery_sessions -> operating_rooms' as check_name,
    COUNT(*) as invalid_records
FROM surgery_sessions ss
    LEFT JOIN operating_rooms oro ON ss.or_id = oro.or_id
WHERE oro.or_id IS NULL;
SELECT 'robot_modules -> surgical_robots' as check_name,
    COUNT(*) as invalid_records
FROM robot_modules rm
    LEFT JOIN surgical_robots sr ON rm.robot_id = sr.robot_id
WHERE sr.robot_id IS NULL;
SELECT 'session_instrument_uses -> instruments' as check_name,
    COUNT(*) as invalid_records
FROM session_instrument_uses siu
    LEFT JOIN instruments i ON siu.instrument_id = i.instrument_id
WHERE i.instrument_id IS NULL;
SELECT '' as '';
SELECT '=== ПЕРЕВІРКА УНІКАЛЬНОСТІ ===' as '';
SELECT 'patients.mrn uniqueness' as check_name,
    COUNT(*) - COUNT(DISTINCT mrn) as duplicates
FROM patients;
SELECT 'surgeons.license_no uniqueness' as check_name,
    COUNT(*) - COUNT(DISTINCT license_no) as duplicates
FROM surgeons;
SELECT 'surgical_robots.serial_no uniqueness' as check_name,
    COUNT(*) - COUNT(DISTINCT serial_no) as duplicates
FROM surgical_robots;
SELECT 'software_versions.version uniqueness' as check_name,
    COUNT(*) - COUNT(DISTINCT version) as duplicates
FROM software_versions;
SELECT '' as '';
SELECT '=== ПІДСУМОК ===' as '';
SELECT 'Загальна кількість таблиць: 19' as summary;
SELECT CONCAT(
        'Загальна кількість записів: ',
        (
            SELECT SUM(record_count)
            FROM (
                    SELECT COUNT(*) as record_count
                    FROM patients
                    UNION ALL
                    SELECT COUNT(*)
                    FROM surgeons
                    UNION ALL
                    SELECT COUNT(*)
                    FROM operating_rooms
                    UNION ALL
                    SELECT COUNT(*)
                    FROM surgical_robots
                    UNION ALL
                    SELECT COUNT(*)
                    FROM procedures
                    UNION ALL
                    SELECT COUNT(*)
                    FROM instruments
                    UNION ALL
                    SELECT COUNT(*)
                    FROM software_versions
                    UNION ALL
                    SELECT COUNT(*)
                    FROM surgery_sessions
                    UNION ALL
                    SELECT COUNT(*)
                    FROM robot_modules
                    UNION ALL
                    SELECT COUNT(*)
                    FROM vital_signs
                    UNION ALL
                    SELECT COUNT(*)
                    FROM anesthesia_records
                    UNION ALL
                    SELECT COUNT(*)
                    FROM imaging_data
                    UNION ALL
                    SELECT COUNT(*)
                    FROM complications
                    UNION ALL
                    SELECT COUNT(*)
                    FROM maintenances
                    UNION ALL
                    SELECT COUNT(*)
                    FROM calibrations
                    UNION ALL
                    SELECT COUNT(*)
                    FROM device_events
                    UNION ALL
                    SELECT COUNT(*)
                    FROM instrument_compatibilities
                    UNION ALL
                    SELECT COUNT(*)
                    FROM session_instrument_uses
                    UNION ALL
                    SELECT COUNT(*)
                    FROM robot_software_installs
                ) as counts
        )
    ) as summary;
SELECT '' as '';
SELECT 'Перевірка завершена!' as '';