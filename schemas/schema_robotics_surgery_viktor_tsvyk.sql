DROP DATABASE IF EXISTS robotics_surgery_viktor_tsvyk;
CREATE DATABASE robotics_surgery_viktor_tsvyk;
USE robotics_surgery_viktor_tsvyk;
CREATE TABLE patients (
  patient_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  mrn VARCHAR(32) UNIQUE,
  full_name VARCHAR(255) NOT NULL,
  dob DATE,
  sex VARCHAR(3),
  blood_type VARCHAR(3),
  allergies TEXT,
  diagnosis TEXT
);
CREATE TABLE surgeons (
  surgeon_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  specialty VARCHAR(255),
  license_no VARCHAR(64) UNIQUE,
  experience_years INT CHECK (experience_years >= 0)
);
CREATE TABLE operating_rooms (
  or_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  floor INT,
  sterility_class VARCHAR(255)
);
CREATE TABLE surgical_robots (
  robot_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  model VARCHAR(255) NOT NULL,
  serial_no VARCHAR(255) UNIQUE NOT NULL,
  install_date DATE,
  status ENUM('ok', 'ready', 'maintenance', 'offline') NOT NULL
);
CREATE TABLE robot_modules (
  module_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  robot_id BIGINT NOT NULL,
  module_type ENUM('arm', 'camera', 'console', 'other') NOT NULL,
  position_no INT,
  status VARCHAR(255),
  FOREIGN KEY (robot_id) REFERENCES surgical_robots(robot_id) ON DELETE CASCADE
);
CREATE TABLE instruments (
  instrument_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  instrument_type VARCHAR(255) NOT NULL,
  manufacturer VARCHAR(255),
  sterile_reuse_limit INT
);
CREATE TABLE instrument_compatibilities (
  module_id BIGINT NOT NULL,
  instrument_type VARCHAR(255) NOT NULL,
  PRIMARY KEY (module_id, instrument_type),
  FOREIGN KEY (module_id) REFERENCES robot_modules(module_id) ON DELETE CASCADE
);
CREATE TABLE procedures (
  procedure_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  icd_code VARCHAR(16),
  description TEXT
);
CREATE TABLE surgery_sessions (
  session_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  patient_id BIGINT NOT NULL,
  procedure_id BIGINT NOT NULL,
  surgeon_id BIGINT NOT NULL,
  robot_id BIGINT NOT NULL,
  or_id BIGINT NOT NULL,
  scheduled_at DATETIME,
  started_at DATETIME,
  ended_at DATETIME,
  outcome TEXT,
  notes TEXT,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (procedure_id) REFERENCES procedures(procedure_id),
  FOREIGN KEY (surgeon_id) REFERENCES surgeons(surgeon_id),
  FOREIGN KEY (robot_id) REFERENCES surgical_robots(robot_id),
  FOREIGN KEY (or_id) REFERENCES operating_rooms(or_id),
  CHECK (started_at <= ended_at)
);
CREATE TABLE session_instrument_uses (
  session_id BIGINT NOT NULL,
  instrument_id BIGINT NOT NULL,
  module_id BIGINT NULL,
  attached_at DATETIME NOT NULL,
  detached_at DATETIME NULL,
  uses_count INT DEFAULT 1 CHECK (uses_count >= 0),
  PRIMARY KEY (session_id, instrument_id, attached_at),
  FOREIGN KEY (session_id) REFERENCES surgery_sessions(session_id) ON DELETE CASCADE,
  FOREIGN KEY (instrument_id) REFERENCES instruments(instrument_id),
  FOREIGN KEY (module_id) REFERENCES robot_modules(module_id)
);
CREATE TABLE vital_signs (
  vital_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  session_id BIGINT NOT NULL,
  timestamp DATETIME NOT NULL,
  hr INT,
  bp_syst INT,
  bp_diast INT,
  spo2 INT,
  temp DECIMAL(4, 1),
  etco2 DECIMAL(5, 2),
  FOREIGN KEY (session_id) REFERENCES surgery_sessions(session_id) ON DELETE CASCADE
);
CREATE TABLE anesthesia_records (
  an_record_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  session_id BIGINT NOT NULL,
  anesthesiologist_name VARCHAR(255),
  agent VARCHAR(255),
  dosage VARCHAR(255),
  route VARCHAR(255),
  timestamp DATETIME NOT NULL,
  notes TEXT,
  FOREIGN KEY (session_id) REFERENCES surgery_sessions(session_id) ON DELETE CASCADE
);
CREATE TABLE imaging_data (
  image_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  session_id BIGINT NOT NULL,
  modality ENUM(
    'endoscope',
    'fluoro',
    'ultrasound',
    'ct',
    'other'
  ) NOT NULL,
  file_uri VARCHAR(255) NOT NULL,
  captured_at DATETIME,
  metadata_json JSON,
  FOREIGN KEY (session_id) REFERENCES surgery_sessions(session_id) ON DELETE CASCADE
);
CREATE TABLE complications (
  complication_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  session_id BIGINT NOT NULL,
  type VARCHAR(255) NOT NULL,
  severity ENUM('mild', 'moderate', 'severe', 'critical') NOT NULL,
  detected_at DATETIME,
  resolved_at DATETIME,
  description TEXT,
  FOREIGN KEY (session_id) REFERENCES surgery_sessions(session_id) ON DELETE CASCADE
);
CREATE TABLE maintenances (
  maintenance_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  robot_id BIGINT NOT NULL,
  performed_at DATETIME NOT NULL,
  type VARCHAR(255),
  engineer_name VARCHAR(255),
  notes TEXT,
  next_due_at DATETIME,
  FOREIGN KEY (robot_id) REFERENCES surgical_robots(robot_id) ON DELETE CASCADE
);
CREATE TABLE calibrations (
  calibration_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  module_id BIGINT NOT NULL,
  performed_at DATETIME NOT NULL,
  method VARCHAR(255),
  result VARCHAR(255),
  tolerance_mm DECIMAL(6, 3),
  FOREIGN KEY (module_id) REFERENCES robot_modules(module_id) ON DELETE CASCADE
);
CREATE TABLE software_versions (
  sw_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  version VARCHAR(255) UNIQUE NOT NULL,
  release_date DATE,
  vendor_notes TEXT
);
CREATE TABLE robot_software_installs (
  robot_id BIGINT NOT NULL,
  sw_id BIGINT NOT NULL,
  installed_at DATETIME NOT NULL,
  PRIMARY KEY (robot_id, sw_id, installed_at),
  FOREIGN KEY (robot_id) REFERENCES surgical_robots(robot_id) ON DELETE CASCADE,
  FOREIGN KEY (sw_id) REFERENCES software_versions(sw_id) ON DELETE RESTRICT
);
CREATE TABLE device_events (
  event_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  session_id BIGINT NULL,
  robot_id BIGINT NOT NULL,
  module_id BIGINT NULL,
  level ENUM('info', 'warning', 'error', 'critical') NOT NULL,
  code VARCHAR(255),
  message TEXT,
  timestamp DATETIME NOT NULL,
  FOREIGN KEY (session_id) REFERENCES surgery_sessions(session_id) ON DELETE
  SET NULL,
    FOREIGN KEY (robot_id) REFERENCES surgical_robots(robot_id) ON DELETE CASCADE,
    FOREIGN KEY (module_id) REFERENCES robot_modules(module_id) ON DELETE
  SET NULL
);