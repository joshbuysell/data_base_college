USE robotics_surgery_viktor_tsvyk;
DROP PROCEDURE IF EXISTS GetAllPatients;
DROP PROCEDURE IF EXISTS GetPatientInfo;
DROP PROCEDURE IF EXISTS GetSurgeonStatistics;
DROP PROCEDURE IF EXISTS GetRobotStatus;
DROP PROCEDURE IF EXISTS ScheduleSurgery;
DROP PROCEDURE IF EXISTS AddVitalSigns;
DROP PROCEDURE IF EXISTS PerformMaintenance;
DROP PROCEDURE IF EXISTS GetSurgerySessionDetails;
DROP PROCEDURE IF EXISTS GetOperatingRoomSchedule;
DROP PROCEDURE IF EXISTS AddComplication;
DROP PROCEDURE IF EXISTS GetPatientHistory;
DELIMITER // CREATE PROCEDURE GetAllPatients() BEGIN
SELECT patient_id,
    mrn,
    full_name,
    dob,
    sex,
    blood_type,
    allergies,
    diagnosis
FROM patients
ORDER BY full_name;
END // DELIMITER;
DELIMITER // CREATE PROCEDURE GetPatientInfo(IN p_patient_id BIGINT) BEGIN
SELECT p.patient_id,
    p.mrn,
    p.full_name,
    p.dob,
    TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) as age,
    p.sex,
    p.blood_type,
    p.allergies,
    p.diagnosis,
    COUNT(ss.session_id) as total_surgeries
FROM patients p
    LEFT JOIN surgery_sessions ss ON p.patient_id = ss.patient_id
WHERE p.patient_id = p_patient_id
GROUP BY p.patient_id;
END // DELIMITER;
DELIMITER // CREATE PROCEDURE GetSurgeonStatistics(
    IN p_surgeon_id BIGINT,
    OUT total_surgeries INT,
    OUT avg_duration DECIMAL(10, 2),
    OUT complications_count INT
) BEGIN
SELECT COUNT(*) INTO total_surgeries
FROM surgery_sessions
WHERE surgeon_id = p_surgeon_id;
SELECT AVG(TIMESTAMPDIFF(MINUTE, started_at, ended_at)) INTO avg_duration
FROM surgery_sessions
WHERE surgeon_id = p_surgeon_id
    AND started_at IS NOT NULL
    AND ended_at IS NOT NULL;
SELECT COUNT(DISTINCT c.complication_id) INTO complications_count
FROM surgery_sessions ss
    JOIN complications c ON ss.session_id = c.session_id
WHERE ss.surgeon_id = p_surgeon_id;
END // DELIMITER;
DELIMITER // CREATE PROCEDURE GetRobotStatus(IN p_robot_id BIGINT) BEGIN
DECLARE robot_status VARCHAR(50);
DECLARE modules_count INT;
DECLARE status_message VARCHAR(255);
SELECT status INTO robot_status
FROM surgical_robots
WHERE robot_id = p_robot_id;
SELECT COUNT(*) INTO modules_count
FROM robot_modules
WHERE robot_id = p_robot_id;
IF robot_status = 'ready' THEN
SET status_message = 'Робот готовий до використання';
ELSEIF robot_status = 'ok' THEN
SET status_message = 'Робот в робочому стані';
ELSEIF robot_status = 'maintenance' THEN
SET status_message = 'Робот на технічному обслуговуванні';
ELSE
SET status_message = 'Невідомий статус';
END IF;
SELECT p_robot_id as robot_id,
    robot_status as status,
    modules_count as modules,
    status_message as message;
END // DELIMITER;
SELECT 'Всі збережені процедури створено успішно!' as status;