USE robotics_surgery_viktor_tsvyk;
DROP VIEW IF EXISTS v_patient_overview;
DROP VIEW IF EXISTS v_surgery_details;
DROP VIEW IF EXISTS v_surgeon_performance;
DROP VIEW IF EXISTS v_robot_utilization;
DROP VIEW IF EXISTS v_vital_signs_summary;
DROP VIEW IF EXISTS v_active_sessions;
DROP VIEW IF EXISTS v_maintenance_schedule;
DROP VIEW IF EXISTS v_complications_report;
DROP VIEW IF EXISTS v_instrument_usage;
DROP VIEW IF EXISTS v_operating_room_schedule;
DROP VIEW IF EXISTS v_robot_health_status;
DROP VIEW IF EXISTS v_anesthesia_log;
DROP VIEW IF EXISTS v_patient_full_history;
DROP VIEW IF EXISTS v_surgery_statistics;
DROP VIEW IF EXISTS v_device_events_summary;
CREATE VIEW v_patient_overview AS
SELECT patient_id,
    mrn,
    full_name,
    TIMESTAMPDIFF(YEAR, dob, CURDATE()) as age,
    sex,
    blood_type,
    CASE
        WHEN allergies IS NULL
        OR allergies = '' THEN 'Немає'
        ELSE allergies
    END as allergies,
    diagnosis
FROM patients;
CREATE VIEW v_surgery_details AS
SELECT ss.session_id,
    ss.scheduled_at,
    ss.started_at,
    ss.ended_at,
    TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at) as duration_minutes,
    p.full_name as patient_name,
    p.mrn as patient_mrn,
    p.blood_type,
    pr.name as procedure_name,
    pr.icd_code,
    s.full_name as surgeon_name,
    s.specialty as surgeon_specialty,
    sr.model as robot_model,
    sr.serial_no as robot_serial,
    oro.name as operating_room,
    oro.floor,
    ss.outcome,
    ss.notes
FROM surgery_sessions ss
    JOIN patients p ON ss.patient_id = p.patient_id
    JOIN procedures pr ON ss.procedure_id = pr.procedure_id
    JOIN surgeons s ON ss.surgeon_id = s.surgeon_id
    JOIN surgical_robots sr ON ss.robot_id = sr.robot_id
    JOIN operating_rooms oro ON ss.or_id = oro.or_id;
CREATE VIEW v_surgeon_performance AS
SELECT s.surgeon_id,
    s.full_name,
    s.specialty,
    s.experience_years,
    COUNT(ss.session_id) as total_surgeries,
    AVG(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as avg_duration_minutes,
    SUM(
        CASE
            WHEN ss.outcome = 'success' THEN 1
            ELSE 0
        END
    ) as successful_surgeries,
    COUNT(DISTINCT c.complication_id) as total_complications,
    ROUND(
        SUM(
            CASE
                WHEN ss.outcome = 'success' THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(ss.session_id), 0),
        2
    ) as success_rate_percent
FROM surgeons s
    LEFT JOIN surgery_sessions ss ON s.surgeon_id = ss.surgeon_id
    LEFT JOIN complications c ON ss.session_id = c.session_id
GROUP BY s.surgeon_id,
    s.full_name,
    s.specialty,
    s.experience_years;
CREATE VIEW v_robot_utilization AS
SELECT sr.robot_id,
    sr.model,
    sr.serial_no,
    sr.status,
    sr.install_date,
    COUNT(DISTINCT ss.session_id) as total_surgeries,
    COUNT(DISTINCT rm.module_id) as modules_count,
    COUNT(DISTINCT m.maintenance_id) as maintenances_count,
    MAX(m.performed_at) as last_maintenance,
    MAX(m.next_due_at) as next_maintenance_due
FROM surgical_robots sr
    LEFT JOIN surgery_sessions ss ON sr.robot_id = ss.robot_id
    LEFT JOIN robot_modules rm ON sr.robot_id = rm.robot_id
    LEFT JOIN maintenances m ON sr.robot_id = m.robot_id
GROUP BY sr.robot_id,
    sr.model,
    sr.serial_no,
    sr.status,
    sr.install_date;
CREATE VIEW v_vital_signs_summary AS
SELECT vs.session_id,
    COUNT(*) as measurements_count,
    AVG(vs.hr) as avg_heart_rate,
    MIN(vs.hr) as min_heart_rate,
    MAX(vs.hr) as max_heart_rate,
    AVG(vs.bp_syst) as avg_systolic_bp,
    AVG(vs.bp_diast) as avg_diastolic_bp,
    AVG(vs.spo2) as avg_oxygen_saturation,
    AVG(vs.temp) as avg_temperature,
    MIN(vs.temp) as min_temperature,
    MAX(vs.temp) as max_temperature,
    MIN(vs.timestamp) as first_measurement,
    MAX(vs.timestamp) as last_measurement
FROM vital_signs vs
GROUP BY vs.session_id;
CREATE VIEW v_active_sessions AS
SELECT ss.session_id,
    p.full_name as patient,
    pr.name as procedure_name,
    s.full_name as surgeon,
    ss.scheduled_at,
    ss.started_at,
    CASE
        WHEN ss.ended_at IS NOT NULL THEN 'Завершено'
        WHEN ss.started_at IS NOT NULL THEN 'В процесі'
        WHEN ss.scheduled_at > NOW() THEN 'Заплановано'
        ELSE 'Очікує початку'
    END as session_status,
    CASE
        WHEN ss.ended_at IS NOT NULL THEN TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
        WHEN ss.started_at IS NOT NULL THEN TIMESTAMPDIFF(MINUTE, ss.started_at, NOW())
        ELSE NULL
    END as elapsed_minutes,
    ss.outcome
FROM surgery_sessions ss
    JOIN patients p ON ss.patient_id = p.patient_id
    JOIN procedures pr ON ss.procedure_id = pr.procedure_id
    JOIN surgeons s ON ss.surgeon_id = s.surgeon_id;
CREATE VIEW v_maintenance_schedule AS
SELECT sr.model,
    sr.serial_no,
    sr.status,
    m.maintenance_id,
    m.performed_at,
    m.type as maintenance_type,
    m.engineer_name,
    m.next_due_at,
    DATEDIFF(m.next_due_at, NOW()) as days_until_next,
    CASE
        WHEN m.next_due_at < NOW() THEN 'ПРОСТРОЧЕНО'
        WHEN DATEDIFF(m.next_due_at, NOW()) <= 7 THEN 'ТЕРМІНОВО'
        WHEN DATEDIFF(m.next_due_at, NOW()) <= 14 THEN 'СКОРО'
        ELSE 'ЗАПЛАНОВАНО'
    END as priority
FROM maintenances m
    JOIN surgical_robots sr ON m.robot_id = sr.robot_id
WHERE m.next_due_at IS NOT NULL;
CREATE VIEW v_complications_report AS
SELECT c.complication_id,
    ss.session_id,
    p.full_name as patient_name,
    pr.name as procedure_name,
    s.full_name as surgeon_name,
    sr.model as robot_model,
    c.type as complication_type,
    c.severity,
    c.detected_at,
    c.resolved_at,
    CASE
        WHEN c.resolved_at IS NOT NULL THEN TIMESTAMPDIFF(MINUTE, c.detected_at, c.resolved_at)
        ELSE NULL
    END as resolution_time_minutes,
    CASE
        WHEN c.resolved_at IS NOT NULL THEN 'Вирішено'
        ELSE 'Активне'
    END as status,
    c.description
FROM complications c
    JOIN surgery_sessions ss ON c.session_id = ss.session_id
    JOIN patients p ON ss.patient_id = p.patient_id
    JOIN procedures pr ON ss.procedure_id = pr.procedure_id
    JOIN surgeons s ON ss.surgeon_id = s.surgeon_id
    JOIN surgical_robots sr ON ss.robot_id = sr.robot_id;
CREATE VIEW v_instrument_usage AS
SELECT i.instrument_id,
    i.name as instrument_name,
    i.instrument_type,
    i.manufacturer,
    COUNT(DISTINCT siu.session_id) as times_used,
    SUM(siu.uses_count) as total_uses,
    COUNT(DISTINCT siu.module_id) as compatible_modules,
    MAX(siu.attached_at) as last_used,
    i.sterile_reuse_limit,
    CASE
        WHEN SUM(siu.uses_count) >= i.sterile_reuse_limit THEN 'ПОТРЕБУЄ ЗАМІНИ'
        WHEN SUM(siu.uses_count) >= i.sterile_reuse_limit * 0.8 THEN 'СКОРО ПОТРЕБУЄ ЗАМІНИ'
        ELSE 'В ПОРЯДКУ'
    END as status
FROM instruments i
    LEFT JOIN session_instrument_uses siu ON i.instrument_id = siu.instrument_id
GROUP BY i.instrument_id,
    i.name,
    i.instrument_type,
    i.manufacturer,
    i.sterile_reuse_limit;
CREATE VIEW v_operating_room_schedule AS
SELECT oro.or_id,
    oro.name as room_name,
    oro.floor,
    oro.sterility_class,
    ss.session_id,
    ss.scheduled_at,
    ss.started_at,
    ss.ended_at,
    p.full_name as patient,
    pr.name as procedure_name,
    s.full_name as surgeon,
    CASE
        WHEN ss.ended_at IS NOT NULL THEN 'Завершено'
        WHEN ss.started_at IS NOT NULL THEN 'В процесі'
        ELSE 'Заплановано'
    END as status
FROM operating_rooms oro
    LEFT JOIN surgery_sessions ss ON oro.or_id = ss.or_id
    LEFT JOIN patients p ON ss.patient_id = p.patient_id
    LEFT JOIN procedures pr ON ss.procedure_id = pr.procedure_id
    LEFT JOIN surgeons s ON ss.surgeon_id = s.surgeon_id;
CREATE VIEW v_robot_health_status AS
SELECT sr.robot_id,
    sr.model,
    sr.serial_no,
    sr.status as robot_status,
    rm.module_id,
    rm.module_type,
    rm.position_no,
    rm.status as module_status,
    c.calibration_id,
    c.performed_at as last_calibration,
    c.result as calibration_result,
    c.tolerance_mm,
    CASE
        WHEN c.result = 'fail' THEN 'КРИТИЧНО'
        WHEN c.result = 'warn' THEN 'УВАГА'
        WHEN c.result = 'pass' THEN 'НОРМА'
        ELSE 'НЕВІДОМО'
    END as health_status
FROM surgical_robots sr
    LEFT JOIN robot_modules rm ON sr.robot_id = rm.robot_id
    LEFT JOIN (
        SELECT module_id,
            calibration_id,
            performed_at,
            result,
            tolerance_mm,
            ROW_NUMBER() OVER (
                PARTITION BY module_id
                ORDER BY performed_at DESC
            ) as rn
        FROM calibrations
    ) c ON rm.module_id = c.module_id
    AND c.rn = 1;
CREATE VIEW v_anesthesia_log AS
SELECT ar.an_record_id,
    ss.session_id,
    p.full_name as patient,
    pr.name as procedure_name,
    ar.anesthesiologist_name,
    ar.agent,
    ar.dosage,
    ar.route,
    ar.timestamp,
    ar.notes,
    ss.started_at as surgery_start,
    TIMESTAMPDIFF(MINUTE, ss.started_at, ar.timestamp) as minutes_from_start
FROM anesthesia_records ar
    JOIN surgery_sessions ss ON ar.session_id = ss.session_id
    JOIN patients p ON ss.patient_id = p.patient_id
    JOIN procedures pr ON ss.procedure_id = pr.procedure_id;
CREATE VIEW v_patient_full_history AS
SELECT p.patient_id,
    p.full_name,
    p.mrn,
    p.dob,
    TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) as age,
    p.blood_type,
    p.diagnosis,
    COUNT(DISTINCT ss.session_id) as total_surgeries,
    COUNT(DISTINCT c.complication_id) as total_complications,
    MAX(ss.scheduled_at) as last_surgery_date,
    GROUP_CONCAT(
        DISTINCT pr.name
        ORDER BY ss.scheduled_at SEPARATOR ', '
    ) as procedures_history
FROM patients p
    LEFT JOIN surgery_sessions ss ON p.patient_id = ss.patient_id
    LEFT JOIN complications c ON ss.session_id = c.session_id
    LEFT JOIN procedures pr ON ss.procedure_id = pr.procedure_id
GROUP BY p.patient_id,
    p.full_name,
    p.mrn,
    p.dob,
    p.blood_type,
    p.diagnosis;
CREATE VIEW v_surgery_statistics AS
SELECT pr.procedure_id,
    pr.name as procedure_name,
    pr.icd_code,
    COUNT(ss.session_id) as times_performed,
    AVG(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as avg_duration_minutes,
    MIN(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as min_duration_minutes,
    MAX(
        TIMESTAMPDIFF(MINUTE, ss.started_at, ss.ended_at)
    ) as max_duration_minutes,
    SUM(
        CASE
            WHEN ss.outcome = 'success' THEN 1
            ELSE 0
        END
    ) as successful_count,
    COUNT(DISTINCT c.complication_id) as complications_count,
    ROUND(
        SUM(
            CASE
                WHEN ss.outcome = 'success' THEN 1
                ELSE 0
            END
        ) * 100.0 / NULLIF(COUNT(ss.session_id), 0),
        2
    ) as success_rate_percent
FROM procedures pr
    LEFT JOIN surgery_sessions ss ON pr.procedure_id = ss.procedure_id
    LEFT JOIN complications c ON ss.session_id = c.session_id
WHERE ss.started_at IS NOT NULL
    AND ss.ended_at IS NOT NULL
GROUP BY pr.procedure_id,
    pr.name,
    pr.icd_code;
CREATE VIEW v_device_events_summary AS
SELECT sr.model,
    sr.serial_no,
    de.level,
    COUNT(*) as events_count,
    MAX(de.timestamp) as last_event,
    GROUP_CONCAT(
        DISTINCT de.code
        ORDER BY de.timestamp DESC SEPARATOR ', '
    ) as recent_codes
FROM device_events de
    JOIN surgical_robots sr ON de.robot_id = sr.robot_id
GROUP BY sr.robot_id,
    sr.model,
    sr.serial_no,
    de.level;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';
CREATE OR REPLACE VIEW v_robot_status AS
SELECT robot_id,
    model,
    serial_no,
    status
FROM surgical_robots;
CREATE OR REPLACE VIEW v_active_patients AS
SELECT patient_id,
    mrn,
    full_name,
    diagnosis
FROM patients
WHERE diagnosis IS NOT NULL WITH CHECK OPTION;
SELECT 'Всі представлення (Views) створено успішно!' as status;