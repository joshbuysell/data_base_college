-- MySQL dump 10.13  Distrib 9.3.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: robotics_surgery_viktor_tsvyk
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `robotics_surgery_viktor_tsvyk`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `robotics_surgery_viktor_tsvyk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `robotics_surgery_viktor_tsvyk`;

--
-- Table structure for table `anesthesia_records`
--

DROP TABLE IF EXISTS `anesthesia_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anesthesia_records` (
  `an_record_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` bigint NOT NULL,
  `anesthesiologist_name` varchar(255) DEFAULT NULL,
  `agent` varchar(255) DEFAULT NULL,
  `dosage` varchar(255) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `notes` text,
  PRIMARY KEY (`an_record_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `anesthesia_records_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `surgery_sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anesthesia_records`
--

LOCK TABLES `anesthesia_records` WRITE;
/*!40000 ALTER TABLE `anesthesia_records` DISABLE KEYS */;
INSERT INTO `anesthesia_records` VALUES (1,1,'Dr. Zenovii','Sevoflurane','150 mg','IV','2025-09-01 10:00:00','Stable 1'),(2,2,'Dr. Lidiia','Propofol','160 mg','Inhalation','2025-09-02 10:10:00','Stable 2'),(3,3,'Dr. Roman','Isoflurane','170 mg','IV','2025-09-03 10:20:00','Stable 3'),(4,4,'Dr. Zenovii','Sevoflurane','180 mg','IV','2025-09-04 10:30:00','Stable 4'),(5,5,'Dr. Lidiia','Propofol','190 mg','Inhalation','2025-09-05 10:00:00','Stable 5'),(6,6,'Dr. Roman','Isoflurane','150 mg','IV','2025-09-06 10:10:00','Stable 6'),(7,7,'Dr. Zenovii','Sevoflurane','160 mg','IV','2025-09-07 10:20:00','Stable 7'),(8,8,'Dr. Lidiia','Propofol','170 mg','Inhalation','2025-09-08 10:30:00','Stable 8'),(9,9,'Dr. Roman','Isoflurane','180 mg','IV','2025-09-09 10:00:00','Stable 9'),(10,10,'Dr. Zenovii','Sevoflurane','190 mg','IV','2025-09-10 10:10:00','Stable 10'),(11,11,'Dr. Lidiia','Propofol','150 mg','Inhalation','2025-09-11 10:20:00','Stable 11'),(12,12,'Dr. Roman','Isoflurane','160 mg','IV','2025-09-12 10:30:00','Stable 12'),(13,13,'Dr. Zenovii','Sevoflurane','170 mg','IV','2025-09-13 10:00:00','Stable 13'),(14,14,'Dr. Lidiia','Propofol','180 mg','Inhalation','2025-09-14 10:10:00','Stable 14'),(15,15,'Dr. Roman','Isoflurane','190 mg','IV','2025-09-15 10:20:00','Stable 15');
/*!40000 ALTER TABLE `anesthesia_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calibrations`
--

DROP TABLE IF EXISTS `calibrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calibrations` (
  `calibration_id` bigint NOT NULL AUTO_INCREMENT,
  `module_id` bigint NOT NULL,
  `performed_at` datetime NOT NULL,
  `method` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `tolerance_mm` decimal(6,3) DEFAULT NULL,
  PRIMARY KEY (`calibration_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `calibrations_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `robot_modules` (`module_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calibrations`
--

LOCK TABLES `calibrations` WRITE;
/*!40000 ALTER TABLE `calibrations` DISABLE KEYS */;
INSERT INTO `calibrations` VALUES (1,1,'2025-09-01 09:00:00','laser','pass',0.200),(2,2,'2025-09-02 09:00:00','fiducial','pass',0.250),(3,3,'2025-09-03 09:00:00','optical','pass',0.300),(4,4,'2025-09-04 09:00:00','laser','warn',0.350),(5,5,'2025-09-05 09:00:00','fiducial','fail',0.400),(6,6,'2025-09-06 09:00:00','optical','pass',0.450),(7,7,'2025-09-07 09:00:00','laser','pass',0.500),(8,8,'2025-09-08 09:00:00','fiducial','pass',0.200),(9,9,'2025-09-09 09:00:00','optical','warn',0.250),(10,10,'2025-09-10 09:00:00','laser','fail',0.300),(11,11,'2025-09-01 09:00:00','fiducial','pass',0.350),(12,12,'2025-09-02 09:00:00','optical','pass',0.400),(13,13,'2025-09-03 09:00:00','laser','pass',0.450),(14,14,'2025-09-04 09:00:00','fiducial','warn',0.500),(15,15,'2025-09-05 09:00:00','optical','fail',0.200);
/*!40000 ALTER TABLE `calibrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complications`
--

DROP TABLE IF EXISTS `complications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complications` (
  `complication_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` bigint NOT NULL,
  `type` varchar(255) NOT NULL,
  `severity` enum('mild','moderate','severe','critical') NOT NULL,
  `detected_at` datetime DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`complication_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `complications_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `surgery_sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complications`
--

LOCK TABLES `complications` WRITE;
/*!40000 ALTER TABLE `complications` DISABLE KEYS */;
INSERT INTO `complications` VALUES (1,1,'bleeding','mild','2025-09-01 10:30:00','2025-09-01 10:50:00','Note 1'),(2,2,'adhesion','moderate','2025-09-02 10:30:00','2025-09-02 10:50:00','Note 2'),(3,3,'equipment','severe','2025-09-03 10:30:00','2025-09-03 10:50:00','Note 3'),(4,4,'anesthesia','critical','2025-09-04 10:30:00','2025-09-04 10:50:00','Note 4'),(5,5,'none','mild','2025-09-05 10:30:00','2025-09-05 10:50:00','Note 5'),(6,6,'bleeding','mild','2025-09-06 10:30:00','2025-09-06 10:50:00','Note 6'),(7,7,'adhesion','moderate','2025-09-07 10:30:00','2025-09-07 10:50:00','Note 7'),(8,8,'equipment','severe','2025-09-08 10:30:00','2025-09-08 10:50:00','Note 8'),(9,9,'anesthesia','critical','2025-09-09 10:30:00','2025-09-09 10:50:00','Note 9'),(10,10,'none','mild','2025-09-10 10:30:00','2025-09-10 10:50:00','Note 10'),(11,11,'bleeding','mild','2025-09-11 10:30:00','2025-09-11 10:50:00','Note 11'),(12,12,'adhesion','moderate','2025-09-12 10:30:00','2025-09-12 10:50:00','Note 12'),(13,13,'equipment','severe','2025-09-13 10:30:00','2025-09-13 10:50:00','Note 13'),(14,14,'anesthesia','critical','2025-09-14 10:30:00','2025-09-14 10:50:00','Note 14'),(15,15,'none','mild','2025-09-15 10:30:00','2025-09-15 10:50:00','Note 15');
/*!40000 ALTER TABLE `complications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_events`
--

DROP TABLE IF EXISTS `device_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_events` (
  `event_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` bigint DEFAULT NULL,
  `robot_id` bigint NOT NULL,
  `module_id` bigint DEFAULT NULL,
  `level` enum('info','warning','error','critical') NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `message` text,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `session_id` (`session_id`),
  KEY `robot_id` (`robot_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `device_events_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `surgery_sessions` (`session_id`) ON DELETE SET NULL,
  CONSTRAINT `device_events_ibfk_2` FOREIGN KEY (`robot_id`) REFERENCES `surgical_robots` (`robot_id`) ON DELETE CASCADE,
  CONSTRAINT `device_events_ibfk_3` FOREIGN KEY (`module_id`) REFERENCES `robot_modules` (`module_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_events`
--

LOCK TABLES `device_events` WRITE;
/*!40000 ALTER TABLE `device_events` DISABLE KEYS */;
INSERT INTO `device_events` VALUES (1,1,1,1,'info','E001','Init','2025-09-01 10:00:00'),(2,2,2,2,'warning','E002','Latency spike','2025-09-02 10:02:00'),(3,3,3,3,'error','E003','Overheat','2025-09-03 10:04:00'),(4,4,4,4,'critical','E004','Calibration drift','2025-09-04 10:06:00'),(5,5,5,5,'info','E005','Init','2025-09-05 10:08:00'),(6,6,1,6,'warning','E006','Latency spike','2025-09-06 10:10:00'),(7,7,2,7,'error','E007','Overheat','2025-09-07 10:12:00'),(8,8,3,8,'critical','E008','Calibration drift','2025-09-08 10:14:00'),(9,9,4,9,'info','E009','Init','2025-09-09 10:16:00'),(10,10,5,10,'warning','E010','Latency spike','2025-09-10 10:18:00'),(11,11,1,11,'error','E011','Overheat','2025-09-11 10:20:00'),(12,12,2,12,'critical','E012','Calibration drift','2025-09-12 10:22:00'),(13,13,3,13,'info','E013','Init','2025-09-13 10:00:00'),(14,14,4,14,'warning','E014','Latency spike','2025-09-14 10:02:00'),(15,15,5,15,'error','E015','Overheat','2025-09-15 10:04:00');
/*!40000 ALTER TABLE `device_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imaging_data`
--

DROP TABLE IF EXISTS `imaging_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imaging_data` (
  `image_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` bigint NOT NULL,
  `modality` enum('endoscope','fluoro','ultrasound','ct','other') NOT NULL,
  `file_uri` varchar(255) NOT NULL,
  `captured_at` datetime DEFAULT NULL,
  `metadata_json` json DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `imaging_data_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `surgery_sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imaging_data`
--

LOCK TABLES `imaging_data` WRITE;
/*!40000 ALTER TABLE `imaging_data` DISABLE KEYS */;
INSERT INTO `imaging_data` VALUES (1,1,'endoscope','s3://bucket/session_1/img_001.mp4','2025-09-01 10:00:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(2,2,'ultrasound','s3://bucket/session_2/img_002.mp4','2025-09-02 10:03:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(3,3,'ct','s3://bucket/session_3/img_003.mp4','2025-09-03 10:06:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(4,4,'fluoro','s3://bucket/session_4/img_004.mp4','2025-09-04 10:09:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(5,5,'other','s3://bucket/session_5/img_005.mp4','2025-09-05 10:12:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(6,6,'endoscope','s3://bucket/session_6/img_006.mp4','2025-09-06 10:15:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(7,7,'ultrasound','s3://bucket/session_7/img_007.mp4','2025-09-07 10:18:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(8,8,'ct','s3://bucket/session_8/img_008.mp4','2025-09-08 10:21:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(9,9,'fluoro','s3://bucket/session_9/img_009.mp4','2025-09-09 10:24:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(10,10,'other','s3://bucket/session_10/img_010.mp4','2025-09-10 10:27:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(11,11,'endoscope','s3://bucket/session_11/img_011.mp4','2025-09-11 10:00:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(12,12,'ultrasound','s3://bucket/session_12/img_012.mp4','2025-09-12 10:03:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(13,13,'ct','s3://bucket/session_13/img_013.mp4','2025-09-13 10:06:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(14,14,'fluoro','s3://bucket/session_14/img_014.mp4','2025-09-14 10:09:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}'),(15,15,'other','s3://bucket/session_15/img_015.mp4','2025-09-15 10:12:00','{\"fps\": 60, \"codec\": \"H.264\", \"bitrate\": \"15Mbps\", \"resolution\": \"3840x2160\"}');
/*!40000 ALTER TABLE `imaging_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instrument_compatibilities`
--

DROP TABLE IF EXISTS `instrument_compatibilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instrument_compatibilities` (
  `module_id` bigint NOT NULL,
  `instrument_type` varchar(255) NOT NULL,
  PRIMARY KEY (`module_id`,`instrument_type`),
  CONSTRAINT `instrument_compatibilities_ibfk_1` FOREIGN KEY (`module_id`) REFERENCES `robot_modules` (`module_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instrument_compatibilities`
--

LOCK TABLES `instrument_compatibilities` WRITE;
/*!40000 ALTER TABLE `instrument_compatibilities` DISABLE KEYS */;
INSERT INTO `instrument_compatibilities` VALUES (1,'scissors'),(2,'forceps'),(3,'electrode'),(4,'clipper'),(5,'needle_driver'),(6,'scissors'),(7,'forceps'),(8,'electrode');
/*!40000 ALTER TABLE `instrument_compatibilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instruments`
--

DROP TABLE IF EXISTS `instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instruments` (
  `instrument_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `instrument_type` varchar(255) NOT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `sterile_reuse_limit` int DEFAULT NULL,
  PRIMARY KEY (`instrument_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instruments`
--

LOCK TABLES `instruments` WRITE;
/*!40000 ALTER TABLE `instruments` DISABLE KEYS */;
INSERT INTO `instruments` VALUES (1,'Endo Scissors','scissors','MedTech UA',20),(2,'Maryland Forceps','forceps','MedTech UA',25),(3,'Hook Electrode','electrode','NeuroSurg GmbH',15),(4,'Clip Applier','clipper','SuturePro',30),(5,'Needle Driver','needle_driver','SuturePro',40);
/*!40000 ALTER TABLE `instruments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenances` (
  `maintenance_id` bigint NOT NULL AUTO_INCREMENT,
  `robot_id` bigint NOT NULL,
  `performed_at` datetime NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `engineer_name` varchar(255) DEFAULT NULL,
  `notes` text,
  `next_due_at` datetime DEFAULT NULL,
  PRIMARY KEY (`maintenance_id`),
  KEY `robot_id` (`robot_id`),
  CONSTRAINT `maintenances_ibfk_1` FOREIGN KEY (`robot_id`) REFERENCES `surgical_robots` (`robot_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
INSERT INTO `maintenances` VALUES (1,1,'2025-09-01 09:00:00','full','Eng. Dmytro','Check #1','2025-10-01 09:00:00'),(2,2,'2025-09-02 09:00:00','routine','Eng. Halyna','Check #2','2025-10-02 09:00:00'),(3,3,'2025-09-03 09:00:00','sanity','Eng. Petro','Check #3','2025-10-03 09:00:00'),(4,4,'2025-09-04 09:00:00','full','Eng. Dmytro','Check #4','2025-10-04 09:00:00'),(5,5,'2025-09-05 09:00:00','routine','Eng. Halyna','Check #5','2025-10-05 09:00:00'),(6,1,'2025-09-06 09:00:00','sanity','Eng. Petro','Check #6','2025-10-06 09:00:00'),(7,2,'2025-09-07 09:00:00','full','Eng. Dmytro','Check #7','2025-10-07 09:00:00'),(8,3,'2025-09-08 09:00:00','routine','Eng. Halyna','Check #8','2025-10-08 09:00:00'),(9,4,'2025-09-09 09:00:00','sanity','Eng. Petro','Check #9','2025-10-09 09:00:00'),(10,5,'2025-09-10 09:00:00','full','Eng. Dmytro','Check #10','2025-10-10 09:00:00'),(11,1,'2025-09-11 09:00:00','routine','Eng. Halyna','Check #11','2025-10-11 09:00:00'),(12,2,'2025-09-12 09:00:00','sanity','Eng. Petro','Check #12','2025-10-12 09:00:00'),(13,3,'2025-09-13 09:00:00','full','Eng. Dmytro','Check #13','2025-10-13 09:00:00'),(14,4,'2025-09-14 09:00:00','routine','Eng. Halyna','Check #14','2025-10-14 09:00:00'),(15,5,'2025-09-15 09:00:00','sanity','Eng. Petro','Check #15','2025-10-15 09:00:00');
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operating_rooms`
--

DROP TABLE IF EXISTS `operating_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operating_rooms` (
  `or_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `floor` int DEFAULT NULL,
  `sterility_class` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`or_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operating_rooms`
--

LOCK TABLES `operating_rooms` WRITE;
/*!40000 ALTER TABLE `operating_rooms` DISABLE KEYS */;
INSERT INTO `operating_rooms` VALUES (1,'OR-1',2,'ISO-7'),(2,'OR-2',3,'ISO-7'),(3,'OR-3',2,'ISO-6'),(4,'OR-4',3,'ISO-7'),(5,'OR-5',2,'ISO-6');
/*!40000 ALTER TABLE `operating_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `patient_id` bigint NOT NULL AUTO_INCREMENT,
  `mrn` varchar(32) DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `blood_type` varchar(3) DEFAULT NULL,
  `allergies` text,
  `diagnosis` text,
  PRIMARY KEY (`patient_id`),
  UNIQUE KEY `mrn` (`mrn`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,'MRN0001','Ivan Petrenko','1988-03-15','M','O+','Penicillin','Cholelithiasis'),(2,'MRN0002','Olha Koval','1992-07-22','F','A-',NULL,'Appendicitis'),(3,'MRN0003','Mykola Shevchenko','1979-11-05','M','B+','Latex','Hernia'),(4,'MRN0004','Nastia Melnyk','1986-01-30','F','AB+','Iodine','Ovarian cyst'),(5,'MRN0005','Viktor Tsvyk','1996-02-09','M','O-','None','Cholecystitis');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedures`
--

DROP TABLE IF EXISTS `procedures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procedures` (
  `procedure_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icd_code` varchar(16) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`procedure_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedures`
--

LOCK TABLES `procedures` WRITE;
/*!40000 ALTER TABLE `procedures` DISABLE KEYS */;
INSERT INTO `procedures` VALUES (1,'Laparoscopic Cholecystectomy','K80.2','Gallbladder removal'),(2,'Appendectomy','K35.8','Appendix removal'),(3,'Inguinal Hernia Repair','K40.9','Hernia mesh repair'),(4,'Ovarian Cystectomy','N83.2','Ovarian cyst removal'),(5,'Prostatectomy','C61','Prostate removal');
/*!40000 ALTER TABLE `procedures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot_modules`
--

DROP TABLE IF EXISTS `robot_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_modules` (
  `module_id` bigint NOT NULL AUTO_INCREMENT,
  `robot_id` bigint NOT NULL,
  `module_type` enum('arm','camera','console','other') NOT NULL,
  `position_no` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`module_id`),
  KEY `robot_id` (`robot_id`),
  CONSTRAINT `robot_modules_ibfk_1` FOREIGN KEY (`robot_id`) REFERENCES `surgical_robots` (`robot_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot_modules`
--

LOCK TABLES `robot_modules` WRITE;
/*!40000 ALTER TABLE `robot_modules` DISABLE KEYS */;
INSERT INTO `robot_modules` VALUES (1,1,'arm',1,'ok'),(2,1,'camera',2,'calibrating'),(3,1,'console',3,'ok'),(4,2,'arm',1,'ok'),(5,2,'arm',2,'calibrating'),(6,2,'arm',3,'ok'),(7,3,'camera',1,'ok'),(8,3,'console',2,'calibrating'),(9,3,'arm',3,'ok'),(10,4,'arm',1,'ok'),(11,4,'arm',2,'calibrating'),(12,4,'camera',3,'ok'),(13,5,'console',1,'ok'),(14,5,'arm',2,'calibrating'),(15,5,'arm',3,'ok');
/*!40000 ALTER TABLE `robot_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot_software_installs`
--

DROP TABLE IF EXISTS `robot_software_installs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_software_installs` (
  `robot_id` bigint NOT NULL,
  `sw_id` bigint NOT NULL,
  `installed_at` datetime NOT NULL,
  PRIMARY KEY (`robot_id`,`sw_id`,`installed_at`),
  KEY `sw_id` (`sw_id`),
  CONSTRAINT `robot_software_installs_ibfk_1` FOREIGN KEY (`robot_id`) REFERENCES `surgical_robots` (`robot_id`) ON DELETE CASCADE,
  CONSTRAINT `robot_software_installs_ibfk_2` FOREIGN KEY (`sw_id`) REFERENCES `software_versions` (`sw_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot_software_installs`
--

LOCK TABLES `robot_software_installs` WRITE;
/*!40000 ALTER TABLE `robot_software_installs` DISABLE KEYS */;
INSERT INTO `robot_software_installs` VALUES (1,1,'2025-09-01 09:00:00'),(1,2,'2025-09-06 09:00:00'),(2,2,'2025-09-02 09:00:00'),(2,3,'2025-09-07 09:00:00'),(3,3,'2025-09-03 09:00:00'),(3,4,'2025-09-08 09:00:00'),(4,4,'2025-09-04 09:00:00'),(5,5,'2025-09-05 09:00:00');
/*!40000 ALTER TABLE `robot_software_installs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_instrument_uses`
--

DROP TABLE IF EXISTS `session_instrument_uses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_instrument_uses` (
  `session_id` bigint NOT NULL,
  `instrument_id` bigint NOT NULL,
  `module_id` bigint DEFAULT NULL,
  `attached_at` datetime NOT NULL,
  `detached_at` datetime DEFAULT NULL,
  `uses_count` int DEFAULT '1',
  PRIMARY KEY (`session_id`,`instrument_id`,`attached_at`),
  KEY `instrument_id` (`instrument_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `session_instrument_uses_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `surgery_sessions` (`session_id`) ON DELETE CASCADE,
  CONSTRAINT `session_instrument_uses_ibfk_2` FOREIGN KEY (`instrument_id`) REFERENCES `instruments` (`instrument_id`),
  CONSTRAINT `session_instrument_uses_ibfk_3` FOREIGN KEY (`module_id`) REFERENCES `robot_modules` (`module_id`),
  CONSTRAINT `session_instrument_uses_chk_1` CHECK ((`uses_count` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_instrument_uses`
--

LOCK TABLES `session_instrument_uses` WRITE;
/*!40000 ALTER TABLE `session_instrument_uses` DISABLE KEYS */;
INSERT INTO `session_instrument_uses` VALUES (1,1,1,'2025-09-01 10:00:00','2025-09-01 10:10:00',1),(2,2,2,'2025-09-02 10:02:00','2025-09-02 10:12:00',2),(3,3,3,'2025-09-03 10:04:00','2025-09-03 10:14:00',3),(4,4,4,'2025-09-04 10:06:00','2025-09-04 10:16:00',1),(5,5,5,'2025-09-05 10:08:00','2025-09-05 10:18:00',2),(6,1,6,'2025-09-06 10:10:00','2025-09-06 10:20:00',3),(7,2,7,'2025-09-07 10:12:00','2025-09-07 10:22:00',1),(8,3,8,'2025-09-08 10:14:00','2025-09-08 10:24:00',2);
/*!40000 ALTER TABLE `session_instrument_uses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `software_versions`
--

DROP TABLE IF EXISTS `software_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `software_versions` (
  `sw_id` bigint NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `release_date` date DEFAULT NULL,
  `vendor_notes` text,
  PRIMARY KEY (`sw_id`),
  UNIQUE KEY `version` (`version`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `software_versions`
--

LOCK TABLES `software_versions` WRITE;
/*!40000 ALTER TABLE `software_versions` DISABLE KEYS */;
INSERT INTO `software_versions` VALUES (1,'1.2.0','2024-03-01','Stability improvements'),(2,'1.3.0','2024-06-15','New kinematics solver'),(3,'1.3.1','2024-07-22','Hotfixes'),(4,'1.4.0','2024-10-05','Improved vision latency'),(5,'1.4.1','2024-12-18','Safety patches');
/*!40000 ALTER TABLE `software_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgeons`
--

DROP TABLE IF EXISTS `surgeons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgeons` (
  `surgeon_id` bigint NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `license_no` varchar(64) DEFAULT NULL,
  `experience_years` int DEFAULT NULL,
  PRIMARY KEY (`surgeon_id`),
  UNIQUE KEY `license_no` (`license_no`),
  CONSTRAINT `surgeons_chk_1` CHECK ((`experience_years` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgeons`
--

LOCK TABLES `surgeons` WRITE;
/*!40000 ALTER TABLE `surgeons` DISABLE KEYS */;
INSERT INTO `surgeons` VALUES (1,'Dr. Andrii Horobets','General Surgery','LIC00001',12),(2,'Dr. Iryna Bondar','Gynecology','LIC00002',9),(3,'Dr. Taras Sydorenko','Urology','LIC00003',15),(4,'Dr. Mariia Hrytsenko','Hepatobiliary','LIC00004',11),(5,'Dr. Oleh Kravets','Colorectal','LIC00005',8);
/*!40000 ALTER TABLE `surgeons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgery_sessions`
--

DROP TABLE IF EXISTS `surgery_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgery_sessions` (
  `session_id` bigint NOT NULL AUTO_INCREMENT,
  `patient_id` bigint NOT NULL,
  `procedure_id` bigint NOT NULL,
  `surgeon_id` bigint NOT NULL,
  `robot_id` bigint NOT NULL,
  `or_id` bigint NOT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `ended_at` datetime DEFAULT NULL,
  `outcome` text,
  `notes` text,
  PRIMARY KEY (`session_id`),
  KEY `patient_id` (`patient_id`),
  KEY `procedure_id` (`procedure_id`),
  KEY `surgeon_id` (`surgeon_id`),
  KEY `robot_id` (`robot_id`),
  KEY `or_id` (`or_id`),
  CONSTRAINT `surgery_sessions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`),
  CONSTRAINT `surgery_sessions_ibfk_2` FOREIGN KEY (`procedure_id`) REFERENCES `procedures` (`procedure_id`),
  CONSTRAINT `surgery_sessions_ibfk_3` FOREIGN KEY (`surgeon_id`) REFERENCES `surgeons` (`surgeon_id`),
  CONSTRAINT `surgery_sessions_ibfk_4` FOREIGN KEY (`robot_id`) REFERENCES `surgical_robots` (`robot_id`),
  CONSTRAINT `surgery_sessions_ibfk_5` FOREIGN KEY (`or_id`) REFERENCES `operating_rooms` (`or_id`),
  CONSTRAINT `surgery_sessions_chk_1` CHECK ((`started_at` <= `ended_at`))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgery_sessions`
--

LOCK TABLES `surgery_sessions` WRITE;
/*!40000 ALTER TABLE `surgery_sessions` DISABLE KEYS */;
INSERT INTO `surgery_sessions` VALUES (1,1,1,1,1,1,'2025-09-01 09:00:00','2025-09-01 10:00:00','2025-09-01 11:15:00','success','Session 1'),(2,2,2,2,2,2,'2025-09-02 09:00:00','2025-09-02 10:00:00','2025-09-02 11:15:00','success','Session 2'),(3,3,3,3,3,3,'2025-09-03 09:00:00','2025-09-03 10:00:00','2025-09-03 11:15:00','success','Session 3'),(4,4,4,4,4,4,'2025-09-04 09:00:00','2025-09-04 10:00:00','2025-09-04 11:15:00','minor_complication','Session 4'),(5,5,5,5,5,5,'2025-09-05 09:00:00','2025-09-05 10:00:00','2025-09-05 11:15:00','success','Session 5'),(6,1,1,1,1,1,'2025-09-06 09:00:00','2025-09-06 10:00:00','2025-09-06 11:15:00','success','Session 6'),(7,2,2,2,2,2,'2025-09-07 09:00:00','2025-09-07 10:00:00','2025-09-07 11:15:00','success','Session 7'),(8,3,3,3,3,3,'2025-09-08 09:00:00','2025-09-08 10:00:00','2025-09-08 11:15:00','success','Session 8'),(9,4,4,4,4,4,'2025-09-09 09:00:00','2025-09-09 10:00:00','2025-09-09 11:15:00','minor_complication','Session 9'),(10,5,5,5,5,5,'2025-09-10 09:00:00','2025-09-10 10:00:00','2025-09-10 11:15:00','success','Session 10'),(11,1,1,1,1,1,'2025-09-11 09:00:00','2025-09-11 10:00:00','2025-09-11 11:15:00','success','Session 11'),(12,2,2,2,2,2,'2025-09-12 09:00:00','2025-09-12 10:00:00','2025-09-12 11:15:00','success','Session 12'),(13,3,3,3,3,3,'2025-09-13 09:00:00','2025-09-13 10:00:00','2025-09-13 11:15:00','success','Session 13'),(14,4,4,4,4,4,'2025-09-14 09:00:00','2025-09-14 10:00:00','2025-09-14 11:15:00','minor_complication','Session 14'),(15,5,5,5,5,5,'2025-09-15 09:00:00','2025-09-15 10:00:00','2025-09-15 11:15:00','success','Session 15');
/*!40000 ALTER TABLE `surgery_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surgical_robots`
--

DROP TABLE IF EXISTS `surgical_robots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgical_robots` (
  `robot_id` bigint NOT NULL AUTO_INCREMENT,
  `model` varchar(255) NOT NULL,
  `serial_no` varchar(255) NOT NULL,
  `install_date` date DEFAULT NULL,
  `status` enum('ok','ready','maintenance','offline') NOT NULL,
  PRIMARY KEY (`robot_id`),
  UNIQUE KEY `serial_no` (`serial_no`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `surgical_robots`
--

LOCK TABLES `surgical_robots` WRITE;
/*!40000 ALTER TABLE `surgical_robots` DISABLE KEYS */;
INSERT INTO `surgical_robots` VALUES (1,'Aesclepius R1','SR-1000','2024-01-15','ready'),(2,'Aesclepius R2','SR-1001','2024-02-15','ok'),(3,'Aesclepius R1','SR-1002','2024-03-15','maintenance'),(4,'Aesclepius R3','SR-1003','2024-04-15','ok'),(5,'Aesclepius R2','SR-1004','2024-05-15','ready');
/*!40000 ALTER TABLE `surgical_robots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_active_patients`
--

DROP TABLE IF EXISTS `v_active_patients`;
/*!50001 DROP VIEW IF EXISTS `v_active_patients`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_active_patients` AS SELECT 
 1 AS `patient_id`,
 1 AS `mrn`,
 1 AS `full_name`,
 1 AS `diagnosis`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_active_sessions`
--

DROP TABLE IF EXISTS `v_active_sessions`;
/*!50001 DROP VIEW IF EXISTS `v_active_sessions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_active_sessions` AS SELECT 
 1 AS `session_id`,
 1 AS `patient`,
 1 AS `procedure_name`,
 1 AS `surgeon`,
 1 AS `scheduled_at`,
 1 AS `started_at`,
 1 AS `session_status`,
 1 AS `elapsed_minutes`,
 1 AS `outcome`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_anesthesia_log`
--

DROP TABLE IF EXISTS `v_anesthesia_log`;
/*!50001 DROP VIEW IF EXISTS `v_anesthesia_log`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_anesthesia_log` AS SELECT 
 1 AS `an_record_id`,
 1 AS `session_id`,
 1 AS `patient`,
 1 AS `procedure_name`,
 1 AS `anesthesiologist_name`,
 1 AS `agent`,
 1 AS `dosage`,
 1 AS `route`,
 1 AS `timestamp`,
 1 AS `notes`,
 1 AS `surgery_start`,
 1 AS `minutes_from_start`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_complications_report`
--

DROP TABLE IF EXISTS `v_complications_report`;
/*!50001 DROP VIEW IF EXISTS `v_complications_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_complications_report` AS SELECT 
 1 AS `complication_id`,
 1 AS `session_id`,
 1 AS `patient_name`,
 1 AS `procedure_name`,
 1 AS `surgeon_name`,
 1 AS `robot_model`,
 1 AS `complication_type`,
 1 AS `severity`,
 1 AS `detected_at`,
 1 AS `resolved_at`,
 1 AS `resolution_time_minutes`,
 1 AS `status`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_device_events_summary`
--

DROP TABLE IF EXISTS `v_device_events_summary`;
/*!50001 DROP VIEW IF EXISTS `v_device_events_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_device_events_summary` AS SELECT 
 1 AS `model`,
 1 AS `serial_no`,
 1 AS `level`,
 1 AS `events_count`,
 1 AS `last_event`,
 1 AS `recent_codes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_instrument_usage`
--

DROP TABLE IF EXISTS `v_instrument_usage`;
/*!50001 DROP VIEW IF EXISTS `v_instrument_usage`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_instrument_usage` AS SELECT 
 1 AS `instrument_id`,
 1 AS `instrument_name`,
 1 AS `instrument_type`,
 1 AS `manufacturer`,
 1 AS `times_used`,
 1 AS `total_uses`,
 1 AS `compatible_modules`,
 1 AS `last_used`,
 1 AS `sterile_reuse_limit`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_maintenance_schedule`
--

DROP TABLE IF EXISTS `v_maintenance_schedule`;
/*!50001 DROP VIEW IF EXISTS `v_maintenance_schedule`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_maintenance_schedule` AS SELECT 
 1 AS `model`,
 1 AS `serial_no`,
 1 AS `status`,
 1 AS `maintenance_id`,
 1 AS `performed_at`,
 1 AS `maintenance_type`,
 1 AS `engineer_name`,
 1 AS `next_due_at`,
 1 AS `days_until_next`,
 1 AS `priority`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_operating_room_schedule`
--

DROP TABLE IF EXISTS `v_operating_room_schedule`;
/*!50001 DROP VIEW IF EXISTS `v_operating_room_schedule`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_operating_room_schedule` AS SELECT 
 1 AS `or_id`,
 1 AS `room_name`,
 1 AS `floor`,
 1 AS `sterility_class`,
 1 AS `session_id`,
 1 AS `scheduled_at`,
 1 AS `started_at`,
 1 AS `ended_at`,
 1 AS `patient`,
 1 AS `procedure_name`,
 1 AS `surgeon`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_patient_full_history`
--

DROP TABLE IF EXISTS `v_patient_full_history`;
/*!50001 DROP VIEW IF EXISTS `v_patient_full_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_patient_full_history` AS SELECT 
 1 AS `patient_id`,
 1 AS `full_name`,
 1 AS `mrn`,
 1 AS `dob`,
 1 AS `age`,
 1 AS `blood_type`,
 1 AS `diagnosis`,
 1 AS `total_surgeries`,
 1 AS `total_complications`,
 1 AS `last_surgery_date`,
 1 AS `procedures_history`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_patient_overview`
--

DROP TABLE IF EXISTS `v_patient_overview`;
/*!50001 DROP VIEW IF EXISTS `v_patient_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_patient_overview` AS SELECT 
 1 AS `patient_id`,
 1 AS `mrn`,
 1 AS `full_name`,
 1 AS `age`,
 1 AS `sex`,
 1 AS `blood_type`,
 1 AS `allergies`,
 1 AS `diagnosis`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_robot_health_status`
--

DROP TABLE IF EXISTS `v_robot_health_status`;
/*!50001 DROP VIEW IF EXISTS `v_robot_health_status`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_robot_health_status` AS SELECT 
 1 AS `robot_id`,
 1 AS `model`,
 1 AS `serial_no`,
 1 AS `robot_status`,
 1 AS `module_id`,
 1 AS `module_type`,
 1 AS `position_no`,
 1 AS `module_status`,
 1 AS `calibration_id`,
 1 AS `last_calibration`,
 1 AS `calibration_result`,
 1 AS `tolerance_mm`,
 1 AS `health_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_robot_status`
--

DROP TABLE IF EXISTS `v_robot_status`;
/*!50001 DROP VIEW IF EXISTS `v_robot_status`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_robot_status` AS SELECT 
 1 AS `robot_id`,
 1 AS `model`,
 1 AS `serial_no`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_robot_utilization`
--

DROP TABLE IF EXISTS `v_robot_utilization`;
/*!50001 DROP VIEW IF EXISTS `v_robot_utilization`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_robot_utilization` AS SELECT 
 1 AS `robot_id`,
 1 AS `model`,
 1 AS `serial_no`,
 1 AS `status`,
 1 AS `install_date`,
 1 AS `total_surgeries`,
 1 AS `modules_count`,
 1 AS `maintenances_count`,
 1 AS `last_maintenance`,
 1 AS `next_maintenance_due`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_surgeon_performance`
--

DROP TABLE IF EXISTS `v_surgeon_performance`;
/*!50001 DROP VIEW IF EXISTS `v_surgeon_performance`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_surgeon_performance` AS SELECT 
 1 AS `surgeon_id`,
 1 AS `full_name`,
 1 AS `specialty`,
 1 AS `experience_years`,
 1 AS `total_surgeries`,
 1 AS `avg_duration_minutes`,
 1 AS `successful_surgeries`,
 1 AS `total_complications`,
 1 AS `success_rate_percent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_surgery_details`
--

DROP TABLE IF EXISTS `v_surgery_details`;
/*!50001 DROP VIEW IF EXISTS `v_surgery_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_surgery_details` AS SELECT 
 1 AS `session_id`,
 1 AS `scheduled_at`,
 1 AS `started_at`,
 1 AS `ended_at`,
 1 AS `duration_minutes`,
 1 AS `patient_name`,
 1 AS `patient_mrn`,
 1 AS `blood_type`,
 1 AS `procedure_name`,
 1 AS `icd_code`,
 1 AS `surgeon_name`,
 1 AS `surgeon_specialty`,
 1 AS `robot_model`,
 1 AS `robot_serial`,
 1 AS `operating_room`,
 1 AS `floor`,
 1 AS `outcome`,
 1 AS `notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_surgery_statistics`
--

DROP TABLE IF EXISTS `v_surgery_statistics`;
/*!50001 DROP VIEW IF EXISTS `v_surgery_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_surgery_statistics` AS SELECT 
 1 AS `procedure_id`,
 1 AS `procedure_name`,
 1 AS `icd_code`,
 1 AS `times_performed`,
 1 AS `avg_duration_minutes`,
 1 AS `min_duration_minutes`,
 1 AS `max_duration_minutes`,
 1 AS `successful_count`,
 1 AS `complications_count`,
 1 AS `success_rate_percent`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_vital_signs_summary`
--

DROP TABLE IF EXISTS `v_vital_signs_summary`;
/*!50001 DROP VIEW IF EXISTS `v_vital_signs_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_vital_signs_summary` AS SELECT 
 1 AS `session_id`,
 1 AS `measurements_count`,
 1 AS `avg_heart_rate`,
 1 AS `min_heart_rate`,
 1 AS `max_heart_rate`,
 1 AS `avg_systolic_bp`,
 1 AS `avg_diastolic_bp`,
 1 AS `avg_oxygen_saturation`,
 1 AS `avg_temperature`,
 1 AS `min_temperature`,
 1 AS `max_temperature`,
 1 AS `first_measurement`,
 1 AS `last_measurement`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vital_signs`
--

DROP TABLE IF EXISTS `vital_signs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vital_signs` (
  `vital_id` bigint NOT NULL AUTO_INCREMENT,
  `session_id` bigint NOT NULL,
  `timestamp` datetime NOT NULL,
  `hr` int DEFAULT NULL,
  `bp_syst` int DEFAULT NULL,
  `bp_diast` int DEFAULT NULL,
  `spo2` int DEFAULT NULL,
  `temp` decimal(4,1) DEFAULT NULL,
  `etco2` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`vital_id`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `vital_signs_ibfk_1` FOREIGN KEY (`session_id`) REFERENCES `surgery_sessions` (`session_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vital_signs`
--

LOCK TABLES `vital_signs` WRITE;
/*!40000 ALTER TABLE `vital_signs` DISABLE KEYS */;
INSERT INTO `vital_signs` VALUES (1,1,'2025-09-01 10:00:00',60,110,70,95,36.5,35.00),(2,2,'2025-09-02 10:05:00',61,111,71,96,36.6,35.50),(3,3,'2025-09-03 10:10:00',62,112,72,97,36.7,36.00),(4,4,'2025-09-04 10:15:00',63,113,73,95,36.8,36.50),(5,5,'2025-09-05 10:20:00',64,114,74,96,36.9,37.00),(6,6,'2025-09-06 10:25:00',65,115,75,97,36.5,37.50),(7,7,'2025-09-07 10:00:00',66,116,76,95,36.6,38.00),(8,8,'2025-09-08 10:05:00',67,117,77,96,36.7,35.00),(9,9,'2025-09-09 10:10:00',68,118,78,97,36.8,35.50),(10,10,'2025-09-10 10:15:00',69,119,79,95,36.9,36.00),(11,11,'2025-09-11 10:20:00',70,120,80,96,36.5,36.50),(12,12,'2025-09-12 10:25:00',71,121,81,97,36.6,37.00),(13,13,'2025-09-13 10:00:00',72,122,82,95,36.7,37.50),(14,14,'2025-09-14 10:05:00',73,123,83,96,36.8,38.00),(15,15,'2025-09-15 10:10:00',74,124,84,97,36.9,35.00);
/*!40000 ALTER TABLE `vital_signs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'robotics_surgery_viktor_tsvyk'
--

--
-- Dumping routines for database 'robotics_surgery_viktor_tsvyk'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetAllPatients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPatients`()
BEGIN
    SELECT patient_id, mrn, full_name, dob, sex, blood_type, allergies, diagnosis
    FROM patients
    ORDER BY full_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPatientInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPatientInfo`(IN p_patient_id BIGINT)
BEGIN
    SELECT p.patient_id, p.mrn, p.full_name, p.dob,
           TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) as age,
           p.sex, p.blood_type, p.allergies, p.diagnosis,
           COUNT(ss.session_id) as total_surgeries
    FROM patients p
    LEFT JOIN surgery_sessions ss ON p.patient_id = ss.patient_id
    WHERE p.patient_id = p_patient_id
    GROUP BY p.patient_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRobotStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRobotStatus`(IN p_robot_id BIGINT)
BEGIN
    DECLARE robot_status VARCHAR(50);
    DECLARE modules_count INT;
    DECLARE status_message VARCHAR(255);
    
    SELECT status INTO robot_status FROM surgical_robots WHERE robot_id = p_robot_id;
    SELECT COUNT(*) INTO modules_count FROM robot_modules WHERE robot_id = p_robot_id;
    
    IF robot_status = 'ready' THEN
        SET status_message = 'Робот готовий до використання';
    ELSEIF robot_status = 'ok' THEN
        SET status_message = 'Робот в робочому стані';
    ELSEIF robot_status = 'maintenance' THEN
        SET status_message = 'Робот на технічному обслуговуванні';
    ELSE
        SET status_message = 'Невідомий статус';
    END IF;
    
    SELECT p_robot_id as robot_id, robot_status as status, modules_count as modules, status_message as message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSurgeonStatistics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSurgeonStatistics`(
    IN p_surgeon_id BIGINT,
    OUT total_surgeries INT,
    OUT avg_duration DECIMAL(10,2),
    OUT complications_count INT
)
BEGIN
    SELECT COUNT(*) INTO total_surgeries
    FROM surgery_sessions WHERE surgeon_id = p_surgeon_id;
    
    SELECT AVG(TIMESTAMPDIFF(MINUTE, started_at, ended_at)) INTO avg_duration
    FROM surgery_sessions
    WHERE surgeon_id = p_surgeon_id AND started_at IS NOT NULL AND ended_at IS NOT NULL;
    
    SELECT COUNT(DISTINCT c.complication_id) INTO complications_count
    FROM surgery_sessions ss
    JOIN complications c ON ss.session_id = c.session_id
    WHERE ss.surgeon_id = p_surgeon_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `robotics_surgery_viktor_tsvyk`
--

USE `robotics_surgery_viktor_tsvyk`;

--
-- Final view structure for view `v_active_patients`
--

/*!50001 DROP VIEW IF EXISTS `v_active_patients`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_active_patients` AS select `patients`.`patient_id` AS `patient_id`,`patients`.`mrn` AS `mrn`,`patients`.`full_name` AS `full_name`,`patients`.`diagnosis` AS `diagnosis` from `patients` where (`patients`.`diagnosis` is not null) */
/*!50002 WITH CASCADED CHECK OPTION */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_active_sessions`
--

/*!50001 DROP VIEW IF EXISTS `v_active_sessions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_active_sessions` AS select `ss`.`session_id` AS `session_id`,`p`.`full_name` AS `patient`,`pr`.`name` AS `procedure_name`,`s`.`full_name` AS `surgeon`,`ss`.`scheduled_at` AS `scheduled_at`,`ss`.`started_at` AS `started_at`,(case when (`ss`.`ended_at` is not null) then 'Завершено' when (`ss`.`started_at` is not null) then 'В процесі' when (`ss`.`scheduled_at` > now()) then 'Заплановано' else 'Очікує початку' end) AS `session_status`,(case when (`ss`.`ended_at` is not null) then timestampdiff(MINUTE,`ss`.`started_at`,`ss`.`ended_at`) when (`ss`.`started_at` is not null) then timestampdiff(MINUTE,`ss`.`started_at`,now()) else NULL end) AS `elapsed_minutes`,`ss`.`outcome` AS `outcome` from (((`surgery_sessions` `ss` join `patients` `p` on((`ss`.`patient_id` = `p`.`patient_id`))) join `procedures` `pr` on((`ss`.`procedure_id` = `pr`.`procedure_id`))) join `surgeons` `s` on((`ss`.`surgeon_id` = `s`.`surgeon_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_anesthesia_log`
--

/*!50001 DROP VIEW IF EXISTS `v_anesthesia_log`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_anesthesia_log` AS select `ar`.`an_record_id` AS `an_record_id`,`ss`.`session_id` AS `session_id`,`p`.`full_name` AS `patient`,`pr`.`name` AS `procedure_name`,`ar`.`anesthesiologist_name` AS `anesthesiologist_name`,`ar`.`agent` AS `agent`,`ar`.`dosage` AS `dosage`,`ar`.`route` AS `route`,`ar`.`timestamp` AS `timestamp`,`ar`.`notes` AS `notes`,`ss`.`started_at` AS `surgery_start`,timestampdiff(MINUTE,`ss`.`started_at`,`ar`.`timestamp`) AS `minutes_from_start` from (((`anesthesia_records` `ar` join `surgery_sessions` `ss` on((`ar`.`session_id` = `ss`.`session_id`))) join `patients` `p` on((`ss`.`patient_id` = `p`.`patient_id`))) join `procedures` `pr` on((`ss`.`procedure_id` = `pr`.`procedure_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_complications_report`
--

/*!50001 DROP VIEW IF EXISTS `v_complications_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_complications_report` AS select `c`.`complication_id` AS `complication_id`,`ss`.`session_id` AS `session_id`,`p`.`full_name` AS `patient_name`,`pr`.`name` AS `procedure_name`,`s`.`full_name` AS `surgeon_name`,`sr`.`model` AS `robot_model`,`c`.`type` AS `complication_type`,`c`.`severity` AS `severity`,`c`.`detected_at` AS `detected_at`,`c`.`resolved_at` AS `resolved_at`,(case when (`c`.`resolved_at` is not null) then timestampdiff(MINUTE,`c`.`detected_at`,`c`.`resolved_at`) else NULL end) AS `resolution_time_minutes`,(case when (`c`.`resolved_at` is not null) then 'Вирішено' else 'Активне' end) AS `status`,`c`.`description` AS `description` from (((((`complications` `c` join `surgery_sessions` `ss` on((`c`.`session_id` = `ss`.`session_id`))) join `patients` `p` on((`ss`.`patient_id` = `p`.`patient_id`))) join `procedures` `pr` on((`ss`.`procedure_id` = `pr`.`procedure_id`))) join `surgeons` `s` on((`ss`.`surgeon_id` = `s`.`surgeon_id`))) join `surgical_robots` `sr` on((`ss`.`robot_id` = `sr`.`robot_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_device_events_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_device_events_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_device_events_summary` AS select `sr`.`model` AS `model`,`sr`.`serial_no` AS `serial_no`,`de`.`level` AS `level`,count(0) AS `events_count`,max(`de`.`timestamp`) AS `last_event`,group_concat(distinct `de`.`code` order by `de`.`timestamp` DESC separator ', ') AS `recent_codes` from (`device_events` `de` join `surgical_robots` `sr` on((`de`.`robot_id` = `sr`.`robot_id`))) group by `sr`.`robot_id`,`sr`.`model`,`sr`.`serial_no`,`de`.`level` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_instrument_usage`
--

/*!50001 DROP VIEW IF EXISTS `v_instrument_usage`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_instrument_usage` AS select `i`.`instrument_id` AS `instrument_id`,`i`.`name` AS `instrument_name`,`i`.`instrument_type` AS `instrument_type`,`i`.`manufacturer` AS `manufacturer`,count(distinct `siu`.`session_id`) AS `times_used`,sum(`siu`.`uses_count`) AS `total_uses`,count(distinct `siu`.`module_id`) AS `compatible_modules`,max(`siu`.`attached_at`) AS `last_used`,`i`.`sterile_reuse_limit` AS `sterile_reuse_limit`,(case when (sum(`siu`.`uses_count`) >= `i`.`sterile_reuse_limit`) then 'ПОТРЕБУЄ ЗАМІНИ' when (sum(`siu`.`uses_count`) >= (`i`.`sterile_reuse_limit` * 0.8)) then 'СКОРО ПОТРЕБУЄ ЗАМІНИ' else 'В ПОРЯДКУ' end) AS `status` from (`instruments` `i` left join `session_instrument_uses` `siu` on((`i`.`instrument_id` = `siu`.`instrument_id`))) group by `i`.`instrument_id`,`i`.`name`,`i`.`instrument_type`,`i`.`manufacturer`,`i`.`sterile_reuse_limit` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_maintenance_schedule`
--

/*!50001 DROP VIEW IF EXISTS `v_maintenance_schedule`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_maintenance_schedule` AS select `sr`.`model` AS `model`,`sr`.`serial_no` AS `serial_no`,`sr`.`status` AS `status`,`m`.`maintenance_id` AS `maintenance_id`,`m`.`performed_at` AS `performed_at`,`m`.`type` AS `maintenance_type`,`m`.`engineer_name` AS `engineer_name`,`m`.`next_due_at` AS `next_due_at`,(to_days(`m`.`next_due_at`) - to_days(now())) AS `days_until_next`,(case when (`m`.`next_due_at` < now()) then 'ПРОСТРОЧЕНО' when ((to_days(`m`.`next_due_at`) - to_days(now())) <= 7) then 'ТЕРМІНОВО' when ((to_days(`m`.`next_due_at`) - to_days(now())) <= 14) then 'СКОРО' else 'ЗАПЛАНОВАНО' end) AS `priority` from (`maintenances` `m` join `surgical_robots` `sr` on((`m`.`robot_id` = `sr`.`robot_id`))) where (`m`.`next_due_at` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_operating_room_schedule`
--

/*!50001 DROP VIEW IF EXISTS `v_operating_room_schedule`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_operating_room_schedule` AS select `oro`.`or_id` AS `or_id`,`oro`.`name` AS `room_name`,`oro`.`floor` AS `floor`,`oro`.`sterility_class` AS `sterility_class`,`ss`.`session_id` AS `session_id`,`ss`.`scheduled_at` AS `scheduled_at`,`ss`.`started_at` AS `started_at`,`ss`.`ended_at` AS `ended_at`,`p`.`full_name` AS `patient`,`pr`.`name` AS `procedure_name`,`s`.`full_name` AS `surgeon`,(case when (`ss`.`ended_at` is not null) then 'Завершено' when (`ss`.`started_at` is not null) then 'В процесі' else 'Заплановано' end) AS `status` from ((((`operating_rooms` `oro` left join `surgery_sessions` `ss` on((`oro`.`or_id` = `ss`.`or_id`))) left join `patients` `p` on((`ss`.`patient_id` = `p`.`patient_id`))) left join `procedures` `pr` on((`ss`.`procedure_id` = `pr`.`procedure_id`))) left join `surgeons` `s` on((`ss`.`surgeon_id` = `s`.`surgeon_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_patient_full_history`
--

/*!50001 DROP VIEW IF EXISTS `v_patient_full_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_patient_full_history` AS select `p`.`patient_id` AS `patient_id`,`p`.`full_name` AS `full_name`,`p`.`mrn` AS `mrn`,`p`.`dob` AS `dob`,timestampdiff(YEAR,`p`.`dob`,curdate()) AS `age`,`p`.`blood_type` AS `blood_type`,`p`.`diagnosis` AS `diagnosis`,count(distinct `ss`.`session_id`) AS `total_surgeries`,count(distinct `c`.`complication_id`) AS `total_complications`,max(`ss`.`scheduled_at`) AS `last_surgery_date`,group_concat(distinct `pr`.`name` order by `ss`.`scheduled_at` ASC separator ', ') AS `procedures_history` from (((`patients` `p` left join `surgery_sessions` `ss` on((`p`.`patient_id` = `ss`.`patient_id`))) left join `complications` `c` on((`ss`.`session_id` = `c`.`session_id`))) left join `procedures` `pr` on((`ss`.`procedure_id` = `pr`.`procedure_id`))) group by `p`.`patient_id`,`p`.`full_name`,`p`.`mrn`,`p`.`dob`,`p`.`blood_type`,`p`.`diagnosis` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_patient_overview`
--

/*!50001 DROP VIEW IF EXISTS `v_patient_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_patient_overview` AS select `patients`.`patient_id` AS `patient_id`,`patients`.`mrn` AS `mrn`,`patients`.`full_name` AS `full_name`,timestampdiff(YEAR,`patients`.`dob`,curdate()) AS `age`,`patients`.`sex` AS `sex`,`patients`.`blood_type` AS `blood_type`,(case when ((`patients`.`allergies` is null) or (`patients`.`allergies` = '')) then 'Немає' else `patients`.`allergies` end) AS `allergies`,`patients`.`diagnosis` AS `diagnosis` from `patients` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_robot_health_status`
--

/*!50001 DROP VIEW IF EXISTS `v_robot_health_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_robot_health_status` AS select `sr`.`robot_id` AS `robot_id`,`sr`.`model` AS `model`,`sr`.`serial_no` AS `serial_no`,`sr`.`status` AS `robot_status`,`rm`.`module_id` AS `module_id`,`rm`.`module_type` AS `module_type`,`rm`.`position_no` AS `position_no`,`rm`.`status` AS `module_status`,`c`.`calibration_id` AS `calibration_id`,`c`.`performed_at` AS `last_calibration`,`c`.`result` AS `calibration_result`,`c`.`tolerance_mm` AS `tolerance_mm`,(case when (`c`.`result` = 'fail') then 'КРИТИЧНО' when (`c`.`result` = 'warn') then 'УВАГА' when (`c`.`result` = 'pass') then 'НОРМА' else 'НЕВІДОМО' end) AS `health_status` from ((`surgical_robots` `sr` left join `robot_modules` `rm` on((`sr`.`robot_id` = `rm`.`robot_id`))) left join (select `calibrations`.`module_id` AS `module_id`,`calibrations`.`calibration_id` AS `calibration_id`,`calibrations`.`performed_at` AS `performed_at`,`calibrations`.`result` AS `result`,`calibrations`.`tolerance_mm` AS `tolerance_mm`,row_number() OVER (PARTITION BY `calibrations`.`module_id` ORDER BY `calibrations`.`performed_at` desc )  AS `rn` from `calibrations`) `c` on(((`rm`.`module_id` = `c`.`module_id`) and (`c`.`rn` = 1)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_robot_status`
--

/*!50001 DROP VIEW IF EXISTS `v_robot_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_robot_status` AS select `surgical_robots`.`robot_id` AS `robot_id`,`surgical_robots`.`model` AS `model`,`surgical_robots`.`serial_no` AS `serial_no`,`surgical_robots`.`status` AS `status` from `surgical_robots` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_robot_utilization`
--

/*!50001 DROP VIEW IF EXISTS `v_robot_utilization`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_robot_utilization` AS select `sr`.`robot_id` AS `robot_id`,`sr`.`model` AS `model`,`sr`.`serial_no` AS `serial_no`,`sr`.`status` AS `status`,`sr`.`install_date` AS `install_date`,count(distinct `ss`.`session_id`) AS `total_surgeries`,count(distinct `rm`.`module_id`) AS `modules_count`,count(distinct `m`.`maintenance_id`) AS `maintenances_count`,max(`m`.`performed_at`) AS `last_maintenance`,max(`m`.`next_due_at`) AS `next_maintenance_due` from (((`surgical_robots` `sr` left join `surgery_sessions` `ss` on((`sr`.`robot_id` = `ss`.`robot_id`))) left join `robot_modules` `rm` on((`sr`.`robot_id` = `rm`.`robot_id`))) left join `maintenances` `m` on((`sr`.`robot_id` = `m`.`robot_id`))) group by `sr`.`robot_id`,`sr`.`model`,`sr`.`serial_no`,`sr`.`status`,`sr`.`install_date` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_surgeon_performance`
--

/*!50001 DROP VIEW IF EXISTS `v_surgeon_performance`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_surgeon_performance` AS select `s`.`surgeon_id` AS `surgeon_id`,`s`.`full_name` AS `full_name`,`s`.`specialty` AS `specialty`,`s`.`experience_years` AS `experience_years`,count(`ss`.`session_id`) AS `total_surgeries`,avg(timestampdiff(MINUTE,`ss`.`started_at`,`ss`.`ended_at`)) AS `avg_duration_minutes`,sum((case when (`ss`.`outcome` = 'success') then 1 else 0 end)) AS `successful_surgeries`,count(distinct `c`.`complication_id`) AS `total_complications`,round(((sum((case when (`ss`.`outcome` = 'success') then 1 else 0 end)) * 100.0) / nullif(count(`ss`.`session_id`),0)),2) AS `success_rate_percent` from ((`surgeons` `s` left join `surgery_sessions` `ss` on((`s`.`surgeon_id` = `ss`.`surgeon_id`))) left join `complications` `c` on((`ss`.`session_id` = `c`.`session_id`))) group by `s`.`surgeon_id`,`s`.`full_name`,`s`.`specialty`,`s`.`experience_years` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_surgery_details`
--

/*!50001 DROP VIEW IF EXISTS `v_surgery_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_surgery_details` AS select `ss`.`session_id` AS `session_id`,`ss`.`scheduled_at` AS `scheduled_at`,`ss`.`started_at` AS `started_at`,`ss`.`ended_at` AS `ended_at`,timestampdiff(MINUTE,`ss`.`started_at`,`ss`.`ended_at`) AS `duration_minutes`,`p`.`full_name` AS `patient_name`,`p`.`mrn` AS `patient_mrn`,`p`.`blood_type` AS `blood_type`,`pr`.`name` AS `procedure_name`,`pr`.`icd_code` AS `icd_code`,`s`.`full_name` AS `surgeon_name`,`s`.`specialty` AS `surgeon_specialty`,`sr`.`model` AS `robot_model`,`sr`.`serial_no` AS `robot_serial`,`oro`.`name` AS `operating_room`,`oro`.`floor` AS `floor`,`ss`.`outcome` AS `outcome`,`ss`.`notes` AS `notes` from (((((`surgery_sessions` `ss` join `patients` `p` on((`ss`.`patient_id` = `p`.`patient_id`))) join `procedures` `pr` on((`ss`.`procedure_id` = `pr`.`procedure_id`))) join `surgeons` `s` on((`ss`.`surgeon_id` = `s`.`surgeon_id`))) join `surgical_robots` `sr` on((`ss`.`robot_id` = `sr`.`robot_id`))) join `operating_rooms` `oro` on((`ss`.`or_id` = `oro`.`or_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_surgery_statistics`
--

/*!50001 DROP VIEW IF EXISTS `v_surgery_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_surgery_statistics` AS select `pr`.`procedure_id` AS `procedure_id`,`pr`.`name` AS `procedure_name`,`pr`.`icd_code` AS `icd_code`,count(`ss`.`session_id`) AS `times_performed`,avg(timestampdiff(MINUTE,`ss`.`started_at`,`ss`.`ended_at`)) AS `avg_duration_minutes`,min(timestampdiff(MINUTE,`ss`.`started_at`,`ss`.`ended_at`)) AS `min_duration_minutes`,max(timestampdiff(MINUTE,`ss`.`started_at`,`ss`.`ended_at`)) AS `max_duration_minutes`,sum((case when (`ss`.`outcome` = 'success') then 1 else 0 end)) AS `successful_count`,count(distinct `c`.`complication_id`) AS `complications_count`,round(((sum((case when (`ss`.`outcome` = 'success') then 1 else 0 end)) * 100.0) / nullif(count(`ss`.`session_id`),0)),2) AS `success_rate_percent` from ((`procedures` `pr` left join `surgery_sessions` `ss` on((`pr`.`procedure_id` = `ss`.`procedure_id`))) left join `complications` `c` on((`ss`.`session_id` = `c`.`session_id`))) where ((`ss`.`started_at` is not null) and (`ss`.`ended_at` is not null)) group by `pr`.`procedure_id`,`pr`.`name`,`pr`.`icd_code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_vital_signs_summary`
--

/*!50001 DROP VIEW IF EXISTS `v_vital_signs_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_vital_signs_summary` AS select `vs`.`session_id` AS `session_id`,count(0) AS `measurements_count`,avg(`vs`.`hr`) AS `avg_heart_rate`,min(`vs`.`hr`) AS `min_heart_rate`,max(`vs`.`hr`) AS `max_heart_rate`,avg(`vs`.`bp_syst`) AS `avg_systolic_bp`,avg(`vs`.`bp_diast`) AS `avg_diastolic_bp`,avg(`vs`.`spo2`) AS `avg_oxygen_saturation`,avg(`vs`.`temp`) AS `avg_temperature`,min(`vs`.`temp`) AS `min_temperature`,max(`vs`.`temp`) AS `max_temperature`,min(`vs`.`timestamp`) AS `first_measurement`,max(`vs`.`timestamp`) AS `last_measurement` from `vital_signs` `vs` group by `vs`.`session_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-31  3:59:58
