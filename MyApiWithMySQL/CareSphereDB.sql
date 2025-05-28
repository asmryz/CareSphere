-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: CareSphereDB
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Current Database: `CareSphereDB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `CareSphereDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `CareSphereDB`;

--
-- Table structure for table `Appointments`
--

DROP TABLE IF EXISTS `Appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointments` (
  `AppointmentID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int DEFAULT NULL,
  `DoctorID` int DEFAULT NULL,
  `DateTime` datetime DEFAULT NULL,
  `CheckupType` enum('Routine','Emergency','Follow-up') DEFAULT NULL,
  `Status` enum('Scheduled','Completed','Cancelled') DEFAULT NULL,
  `BookingMethod` enum('Manual','Chatbot') DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `PatientID` (`PatientID`),
  KEY `DoctorID` (`DoctorID`),
  CONSTRAINT `Appointments_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`) ON DELETE CASCADE,
  CONSTRAINT `Appointments_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `Doctors` (`DoctorID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Appointments`
--

LOCK TABLES `Appointments` WRITE;
/*!40000 ALTER TABLE `Appointments` DISABLE KEYS */;
INSERT INTO `Appointments` VALUES (1,101,201,'2025-05-27 09:00:00','Routine','Scheduled','Manual'),(2,102,202,'2025-05-27 09:30:00','Emergency','Completed','Chatbot'),(3,103,201,'2025-05-27 10:00:00','Follow-up','Cancelled','Manual'),(4,104,202,'2025-05-27 10:30:00','Routine','Scheduled','Chatbot'),(5,105,201,'2025-05-27 11:00:00','Routine','Completed','Manual'),(6,106,202,'2025-05-27 11:30:00','Emergency','Scheduled','Chatbot'),(7,107,201,'2025-05-27 12:00:00','Follow-up','Completed','Manual'),(8,108,202,'2025-05-27 12:30:00','Routine','Scheduled','Chatbot'),(9,109,201,'2025-05-27 13:00:00','Emergency','Cancelled','Manual'),(10,110,202,'2025-05-27 13:30:00','Routine','Scheduled','Chatbot');
/*!40000 ALTER TABLE `Appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `DoctorProfileView`
--

DROP TABLE IF EXISTS `DoctorProfileView`;
/*!50001 DROP VIEW IF EXISTS `DoctorProfileView`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `DoctorProfileView` AS SELECT 
 1 AS `DoctorName`,
 1 AS `Specialty`,
 1 AS `City`,
 1 AS `Email`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Doctors`
--

DROP TABLE IF EXISTS `Doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Doctors` (
  `DoctorID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Specialty` varchar(100) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DoctorID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Doctors_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctors`
--

LOCK TABLES `Doctors` WRITE;
/*!40000 ALTER TABLE `Doctors` DISABLE KEYS */;
INSERT INTO `Doctors` VALUES (201,1003,'Dr. Charlie','Cardiology','New York'),(202,1007,'Dr. George','Dermatology','Los Angeles');
/*!40000 ALTER TABLE `Doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `PatientAgeSummary`
--

DROP TABLE IF EXISTS `PatientAgeSummary`;
/*!50001 DROP VIEW IF EXISTS `PatientAgeSummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `PatientAgeSummary` AS SELECT 
 1 AS `City`,
 1 AS `TotalPatients`,
 1 AS `AvgAge`,
 1 AS `Oldest`,
 1 AS `Youngest`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `PatientHistory`
--

DROP TABLE IF EXISTS `PatientHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PatientHistory` (
  `HistoryID` int NOT NULL AUTO_INCREMENT,
  `PatientID` int DEFAULT NULL,
  `DoctorID` int DEFAULT NULL,
  `AppointmentID` int DEFAULT NULL,
  `SymptomDescription` text,
  `Diagnosis` text,
  `Prescriptions` text,
  `FollowUpRequired` tinyint(1) DEFAULT NULL,
  `CheckupDate` date DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`HistoryID`),
  KEY `PatientID` (`PatientID`),
  KEY `DoctorID` (`DoctorID`),
  KEY `AppointmentID` (`AppointmentID`),
  CONSTRAINT `PatientHistory_ibfk_1` FOREIGN KEY (`PatientID`) REFERENCES `Patients` (`PatientID`),
  CONSTRAINT `PatientHistory_ibfk_2` FOREIGN KEY (`DoctorID`) REFERENCES `Doctors` (`DoctorID`),
  CONSTRAINT `PatientHistory_ibfk_3` FOREIGN KEY (`AppointmentID`) REFERENCES `Appointments` (`AppointmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PatientHistory`
--

LOCK TABLES `PatientHistory` WRITE;
/*!40000 ALTER TABLE `PatientHistory` DISABLE KEYS */;
INSERT INTO `PatientHistory` VALUES (1,101,201,1,'Headache','Migraine','Painkillers',1,'2025-05-27','Review in 1 week'),(2,101,201,1,'Fatigue','Anemia','Iron supplements',0,'2025-05-27','Take with meals'),(3,102,202,2,'High fever','Infection','Antibiotics',1,'2025-05-27','Blood test advised'),(4,102,202,2,'Cough','Bronchitis','Cough syrup',0,'2025-05-27','Rest recommended'),(5,103,201,3,'Stomach pain','Gastritis','Antacids',1,'2025-05-27','Avoid spicy food'),(6,103,201,3,'Nausea','Food poisoning','Hydration',0,'2025-05-27','Monitor symptoms'),(7,104,202,4,'Back pain','Strain','Physiotherapy',1,'2025-05-27','Avoid lifting heavy objects'),(8,104,202,4,'Neck pain','Poor posture','Exercise',0,'2025-05-27','Ergonomic advice given'),(9,105,201,5,'Skin rash','Allergy','Antihistamines',1,'2025-05-27','Follow-up in 5 days'),(10,105,201,5,'Itching','Dermatitis','Ointment',0,'2025-05-27','Avoid harsh soaps'),(11,106,202,6,'Chest pain','Muscle strain','Rest and gel',1,'2025-05-27','ECG normal'),(12,106,202,6,'Breathing issues','Asthma','Inhaler',0,'2025-05-27','Use daily'),(13,107,201,7,'Toothache','Cavity','Dental referral',1,'2025-05-27','Appointment booked'),(14,107,201,7,'Gum swelling','Gingivitis','Mouthwash',0,'2025-05-27','Brush twice daily'),(15,108,202,8,'Eye redness','Conjunctivitis','Eye drops',1,'2025-05-27','Avoid touching eyes'),(16,108,202,8,'Blurred vision','Dry eye','Artificial tears',0,'2025-05-27','Use computer glasses'),(17,109,201,9,'Joint pain','Arthritis','Pain relievers',1,'2025-05-27','X-ray suggested'),(18,109,201,9,'Leg swelling','Water retention','Diuretics',0,'2025-05-27','Reduce salt intake'),(19,110,202,10,'Ear pain','Ear infection','Antibiotics',1,'2025-05-27','Check again in 3 days'),(20,110,202,10,'Hearing loss','Wax blockage','Ear drops',0,'2025-05-27','Follow up if needed');
/*!40000 ALTER TABLE `PatientHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patients`
--

DROP TABLE IF EXISTS `Patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Patients` (
  `PatientID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `Patients_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patients`
--

LOCK TABLES `Patients` WRITE;
/*!40000 ALTER TABLE `Patients` DISABLE KEYS */;
INSERT INTO `Patients` VALUES (101,1001,'Alice Smith',29,'New York'),(102,1002,'Bob Johnson',42,'Los Angeles'),(103,1003,'Charlie Brown',35,'Chicago'),(104,1004,'Diana Prince',27,'Houston'),(105,1005,'Ethan Hunt',50,'Phoenix'),(106,1006,'Fiona Apple',33,'Philadelphia'),(107,1007,'George Martin',38,'San Antonio'),(108,1008,'Hannah Lee',24,'San Diego'),(109,1009,'Ian Wright',41,'Dallas'),(110,1010,'Jane Doe',30,'San Jose');
/*!40000 ALTER TABLE `Patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `Role` enum('Patient','Doctor','Admin') NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1001,'alice@example.com','hash1abcdef1234567890','Patient'),(1002,'bob@example.com','hash2abcdef1234567890','Patient'),(1003,'drcharlie@example.com','hash3abcdef1234567890','Doctor'),(1004,'diana@example.com','hash4abcdef1234567890','Patient'),(1005,'ethan@example.com','hash5abcdef1234567890','Patient'),(1006,'fiona@example.com','hash6abcdef1234567890','Patient'),(1007,'george@example.com','hash7abcdef1234567890','Doctor'),(1008,'hannah@example.com','hash8abcdef1234567890','Patient'),(1009,'ian@example.com','hash9abcdef1234567890','Patient'),(1010,'jane@example.com','hash10abcdef1234567890','Admin');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `CareSphereDB`
--

USE `CareSphereDB`;

--
-- Final view structure for view `DoctorProfileView`
--

/*!50001 DROP VIEW IF EXISTS `DoctorProfileView`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `DoctorProfileView` AS select `d`.`Name` AS `DoctorName`,`d`.`Specialty` AS `Specialty`,`d`.`City` AS `City`,`u`.`Email` AS `Email` from (`Doctors` `d` join `Users` `u` on((`d`.`UserID` = `u`.`UserID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PatientAgeSummary`
--

/*!50001 DROP VIEW IF EXISTS `PatientAgeSummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PatientAgeSummary` AS select `Patients`.`City` AS `City`,count(0) AS `TotalPatients`,avg(`Patients`.`Age`) AS `AvgAge`,max(`Patients`.`Age`) AS `Oldest`,min(`Patients`.`Age`) AS `Youngest` from `Patients` group by `Patients`.`City` */;
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

-- Dump completed on 2025-05-26 15:25:10
