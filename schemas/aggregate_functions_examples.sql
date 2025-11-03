USE robotics_surgery_viktor_tsvyk;
SELECT '=== 1. COUNT() - Підрахунок ===' as '';
SELECT COUNT(*) as total_patients
FROM patients;
SELECT COUNT(allergies) as patients_with_allergies
FROM patients
WHERE allergies IS NOT NULL
    AND allergies != '';
SELECT COUNT(DISTINCT blood_type) as unique_blood_types
FROM patients;
SELECT s.full_name,
    s.specialty,
    COUNT(ss.session_id) as total_surgeries
FROM surgeons s
    LEFT JOIN surgery_sessions ss ON s.surgeon_id = ss.surgeon_id
GROUP BY s.surgeon_id,
    s.full_name,
    s.specialty
ORDER BY total_surgeries DESC;
SELECT '' as '';
SELECT '=== 2. SUM() - Сума ===' as '';
SELECT SUM(uses_count) as total_instrument_uses
FROM session_instrument_uses;
SELECT i.name,
    i.instrument_type,
    SUM(siu.uses_count) as total_uses
FROM instruments i
    LEFT JOIN session_instrument_uses siu ON i.instrument_id = siu.instrument_id
GROUP BY i.instrument_id,
    i.name,
    i.instrument_type
ORDER BY total_uses DESC;
SELECT SUM(experience_years) as total_experience_years
FROM surgeons;
SELECT '' as '';
SELECT '=== 3. AVG() - Середнє значення ===' as '';
SELECT AVG(hr) as avg_heart_rate
FROM vital_signs;
SELECT AVG(bp_syst) as avg_systolic_bp,
    AVG(bp_diast) as avg_diastolic_bp,
    AVG(spo2) as avg_oxygen_saturation,
    AVG(temp) as avg_temperature
FROM vital_signs;
SELECT AVG(TIMESTAMPDIFF(MINUTE, started_at, ended_at)) as avg_duration_minutes
FROM surgery_sessions
WHERE started_at IS NOT NULL
    AND ended_at IS NOT NULL;
SELECT pr.name,
    COUNT(*) as operations_count,
    AVG(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as avg_duration_minutes,
    MIN(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as min_duration_minutes,
    MAX(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as max_duration_minutes
FROM surgery_sessions ss
    JOIN procedures pr ON ss.procedure_id = pr.procedure_id
WHERE ss.started_at IS NOT NULL
    AND ss.ended_at IS NOT NULL
GROUP BY pr.procedure_id,
    pr.name
ORDER BY avg_duration_minutes DESC;
SELECT specialty,
    COUNT(*) as surgeons_count,
    AVG(experience_years) as avg_experience,
    MIN(experience_years) as min_experience,
    MAX(experience_years) as max_experience
FROM surgeons
GROUP BY specialty;
SELECT '' as '';
SELECT '=== 4. MIN() і MAX() - Мінімум та максимум ===' as '';
SELECT MIN(dob) as oldest_patient_dob,
    MAX(dob) as youngest_patient_dob,
    TIMESTAMPDIFF(YEAR, MIN(dob), CURDATE()) as oldest_age,
    TIMESTAMPDIFF(YEAR, MAX(dob), CURDATE()) as youngest_age
FROM patients;
SELECT MIN(temp) as min_temperature,
    MAX(temp) as max_temperature,
    AVG(temp) as avg_temperature
FROM vital_signs;
SELECT MIN(scheduled_at) as first_surgery,
    MAX(scheduled_at) as last_surgery
FROM surgery_sessions;
SELECT MIN(tolerance_mm) as best_tolerance,
    MAX(tolerance_mm) as worst_tolerance,
    AVG(tolerance_mm) as avg_tolerance
FROM calibrations;
SELECT '' as '';
SELECT '=== 5. GROUP BY з HAVING ===' as '';
SELECT sr.model,
    sr.serial_no,
    COUNT(rm.module_id) as modules_count
FROM surgical_robots sr
    LEFT JOIN robot_modules rm ON sr.robot_id = rm.robot_id
GROUP BY sr.robot_id,
    sr.model,
    sr.serial_no
HAVING COUNT(rm.module_id) > 2
ORDER BY modules_count DESC;
SELECT ss.session_id,
    p.full_name,
    AVG(vs.hr) as avg_heart_rate,
    AVG(vs.bp_syst) as avg_bp_syst
FROM surgery_sessions ss
    JOIN patients p ON ss.patient_id = p.patient_id
    JOIN vital_signs vs ON ss.session_id = vs.session_id
GROUP BY ss.session_id,
    p.full_name
HAVING AVG(vs.hr) > 65
ORDER BY avg_heart_rate DESC;
SELECT s.full_name,
    s.specialty,
    COUNT(ss.session_id) as surgeries_count
FROM surgeons s
    JOIN surgery_sessions ss ON s.surgeon_id = ss.surgeon_id
GROUP BY s.surgeon_id,
    s.full_name,
    s.specialty
HAVING COUNT(ss.session_id) > 2
ORDER BY surgeries_count DESC;
SELECT '' as '';
SELECT '=== 6. Комбіновані агрегатні функції ===' as '';
SELECT ss.session_id,
    p.full_name as patient,
    pr.name as procedure,
    COUNT(vs.vital_id) as vital_measurements,
    AVG(vs.hr) as avg_hr,
    MIN(vs.hr) as min_hr,
    MAX(vs.hr) as max_hr,
    AVG(vs.bp_syst) as avg_systolic,
    AVG(vs.spo2) as avg_oxygen
FROM surgery_sessions ss
    JOIN patients p ON ss.patient_id = p.patient_id
    JOIN procedures pr ON ss.procedure_id = pr.procedure_id
    LEFT JOIN vital_signs vs ON ss.session_id = vs.session_id
GROUP BY ss.session_id,
    p.full_name,
    pr.name
ORDER BY ss.session_id;
SELECT sr.model,
    sr.serial_no,
    sr.status,
    COUNT(DISTINCT rm.module_id) as modules_count,
    COUNT(DISTINCT ss.session_id) as surgeries_performed,
    COUNT(DISTINCT m.maintenance_id) as maintenances_count
FROM surgical_robots sr
    LEFT JOIN robot_modules rm ON sr.robot_id = rm.robot_id
    LEFT JOIN surgery_sessions ss ON sr.robot_id = ss.robot_id
    LEFT JOIN maintenances m ON sr.robot_id = m.robot_id
GROUP BY sr.robot_id,
    sr.model,
    sr.serial_no,
    sr.status
ORDER BY surgeries_performed DESC;
SELECT '' as '';
SELECT '=== 7. GROUP_CONCAT() - Об\'єднання значень ===' as '';
SELECT ss.session_id,
    p.full_name as patient,
    GROUP_CONCAT(
        DISTINCT i.name
        ORDER BY i.name SEPARATOR ', '
    ) as instruments_used
FROM surgery_sessions ss
    JOIN patients p ON ss.patient_id = p.patient_id
    LEFT JOIN session_instrument_uses siu ON ss.session_id = siu.session_id
    LEFT JOIN instruments i ON siu.instrument_id = i.instrument_id
GROUP BY ss.session_id,
    p.full_name
ORDER BY ss.session_id;
SELECT sr.model,
    sr.serial_no,
    GROUP_CONCAT(
        DISTINCT rm.module_type
        ORDER BY rm.position_no SEPARATOR ', '
    ) as module_types
FROM surgical_robots sr
    LEFT JOIN robot_modules rm ON sr.robot_id = rm.robot_id
GROUP BY sr.robot_id,
    sr.model,
    sr.serial_no;
SELECT '' as '';
SELECT '=== 8. Складні запити з підзапитами ===' as '';
SELECT s.full_name,
    s.specialty,
    COUNT(ss.session_id) as surgeries_count
FROM surgeons s
    JOIN surgery_sessions ss ON s.surgeon_id = ss.surgeon_id
GROUP BY s.surgeon_id,
    s.full_name,
    s.specialty
ORDER BY surgeries_count DESC
LIMIT 1;
SELECT pr.name,
    pr.icd_code,
    AVG(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as avg_duration_minutes,
    COUNT(*) as times_performed
FROM procedures pr
    JOIN surgery_sessions ss ON pr.procedure_id = ss.procedure_id
WHERE ss.started_at IS NOT NULL
    AND ss.ended_at IS NOT NULL
GROUP BY pr.procedure_id,
    pr.name,
    pr.icd_code
ORDER BY avg_duration_minutes DESC
LIMIT 1;
SELECT sr.model,
    sr.serial_no,
    COUNT(m.maintenance_id) as maintenance_count,
    MIN(m.performed_at) as first_maintenance,
    MAX(m.performed_at) as last_maintenance
FROM surgical_robots sr
    LEFT JOIN maintenances m ON sr.robot_id = m.robot_id
GROUP BY sr.robot_id,
    sr.model,
    sr.serial_no
ORDER BY maintenance_count DESC
LIMIT 1;
SELECT '' as '';
SELECT '=== 9. Статистика по ускладненнях ===' as '';
SELECT severity,
    COUNT(*) as count,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT COUNT(*)
            FROM complications
        ),
        2
    ) as percentage
FROM complications
GROUP BY severity
ORDER BY FIELD(
        severity,
        'mild',
        'moderate',
        'severe',
        'critical'
    );
SELECT type,
    COUNT(*) as occurrences,
    AVG(TIMESTAMPDIFF(MINUTE, detected_at, resolved_at)) as avg_resolution_time_minutes
FROM complications
WHERE resolved_at IS NOT NULL
GROUP BY type
ORDER BY occurrences DESC;
SELECT '' as '';
SELECT '=== 10. Аналітичні запити ===' as '';
SELECT 'Total Patients' as metric,
    COUNT(*) as value
FROM patients
UNION ALL
SELECT 'Total Surgeons',
    COUNT(*)
FROM surgeons
UNION ALL
SELECT 'Total Robots',
    COUNT(*)
FROM surgical_robots
UNION ALL
SELECT 'Total Surgeries',
    COUNT(*)
FROM surgery_sessions
UNION ALL
SELECT 'Total Complications',
    COUNT(*)
FROM complications
UNION ALL
SELECT 'Total Maintenances',
    COUNT(*)
FROM maintenances;
SELECT sr.model,
    COUNT(DISTINCT ss.session_id) as total_surgeries,
    COUNT(DISTINCT c.complication_id) as complications_count,
    ROUND(
        (
            COUNT(DISTINCT ss.session_id) - COUNT(DISTINCT c.complication_id)
        ) * 100.0 / NULLIF(COUNT(DISTINCT ss.session_id), 0),
        2
    ) as success_rate_percent
FROM surgical_robots sr
    LEFT JOIN surgery_sessions ss ON sr.robot_id = ss.robot_id
    LEFT JOIN complications c ON ss.session_id = c.session_id
    AND c.severity IN ('severe', 'critical')
GROUP BY sr.robot_id,
    sr.model
HAVING COUNT(DISTINCT ss.session_id) > 0
ORDER BY success_rate_percent DESC;
SELECT oro.name,
    oro.floor,
    COUNT(ss.session_id) as surgeries_count,
    ROUND(
        COUNT(ss.session_id) * 100.0 / (
            SELECT COUNT(*)
            FROM surgery_sessions
        ),
        2
    ) as usage_percent
FROM operating_rooms oro
    LEFT JOIN surgery_sessions ss ON oro.or_id = ss.or_id
GROUP BY oro.or_id,
    oro.name,
    oro.floor
ORDER BY surgeries_count DESC;
SELECT '' as '';
SELECT '=== ПІДСУМОК АГРЕГАТНИХ ФУНКЦІЙ ===' as '';
SELECT 'COUNT() - Підрахунок кількості записів' as function_name
UNION ALL
SELECT 'SUM() - Сума числових значень'
UNION ALL
SELECT 'AVG() - Середнє арифметичне значення'
UNION ALL
SELECT 'MIN() - Мінімальне значення'
UNION ALL
SELECT 'MAX() - Максимальне значення'
UNION ALL
SELECT 'GROUP_CONCAT() - Об\'єднання рядків'
UNION ALL
SELECT 'GROUP BY - Групування даних'
UNION ALL
SELECT 'HAVING - Фільтрація згрупованих даних';
SELECT '' as '';
SELECT 'Всі приклади агрегатних функцій виконано успішно!' as '';