-- MySQL dump 10.13  Distrib 8.0.23, for macos10.15 (x86_64)
--
-- Host: localhost    Database: restroom_finder
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Current Database: `restroom_finder`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `restroom_finder` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `restroom_finder`;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employees` (
  `employeeID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`employeeID`),
  UNIQUE KEY `unique_emp` (`firstName`,`lastName`,`emailAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Devin','Barger','bargerd@oregonstate.edu','2021-02-17 03:07:59'),(2,'Edward','Yeung','yeunge@oregonstate.edu','2021-02-17 03:07:59'),(3,'John','Doe','doejohn@oregonstate.edu','2021-02-17 03:07:59');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Locations` (
  `locationID` int NOT NULL AUTO_INCREMENT,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`locationID`),
  UNIQUE KEY `locationID` (`locationID`),
  UNIQUE KEY `unique_loc` (`street`,`city`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT INTO `Locations` VALUES (1,'1234 Fake St.','Charlotte','NC','US'),(2,'5678 Dreamville Ln.','Portland','OR','US'),(3,'2468 Fantasy Ave.',' San Francisco','CA','US');
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restrooms`
--

DROP TABLE IF EXISTS `Restrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Restrooms` (
  `restroomID` int NOT NULL AUTO_INCREMENT,
  `locationID` int NOT NULL,
  `openHour` varchar(50) DEFAULT NULL,
  `closeHour` varchar(50) DEFAULT NULL,
  `free` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`restroomID`),
  KEY `locationID` (`locationID`),
  CONSTRAINT `restrooms_ibfk_1` FOREIGN KEY (`locationID`) REFERENCES `Locations` (`locationID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restrooms`
--

LOCK TABLES `Restrooms` WRITE;
/*!40000 ALTER TABLE `Restrooms` DISABLE KEYS */;
INSERT INTO `Restrooms` VALUES (4,1,'09:00','23:00',1),(5,2,'06:00','18:00',0),(6,3,'10:00','20:00',1);
/*!40000 ALTER TABLE `Restrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RestroomsEmployees`
--

DROP TABLE IF EXISTS `RestroomsEmployees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RestroomsEmployees` (
  `restroomID` int NOT NULL,
  `employeeID` int NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `inspectedAt` datetime NOT NULL,
  UNIQUE KEY `inspectedAt` (`inspectedAt`),
  KEY `restroomID` (`restroomID`),
  KEY `employeeID` (`employeeID`),
  CONSTRAINT `restroomsemployees_ibfk_1` FOREIGN KEY (`restroomID`) REFERENCES `Restrooms` (`restroomID`) ON DELETE CASCADE,
  CONSTRAINT `restroomsemployees_ibfk_2` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RestroomsEmployees`
--

LOCK TABLES `RestroomsEmployees` WRITE;
/*!40000 ALTER TABLE `RestroomsEmployees` DISABLE KEYS */;
INSERT INTO `RestroomsEmployees` VALUES (5,2,'','2020-11-23 00:00:00'),(6,3,'','2021-01-03 00:00:00'),(4,1,'','2021-01-28 00:00:00');
/*!40000 ALTER TABLE `RestroomsEmployees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reviews` (
  `reviewID` int NOT NULL AUTO_INCREMENT,
  `overallRating` int NOT NULL,
  `cleanliness` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `restroomID` int NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`reviewID`),
  UNIQUE KEY `reviewID` (`reviewID`),
  KEY `restroomID` (`restroomID`),
  KEY `userID` (`userID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`restroomID`) REFERENCES `Restrooms` (`restroomID`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
INSERT INTO `Reviews` VALUES (4,4,'Pristine','Bathroom was clean and well kept','2021-01-28 00:00:00',4,1),(5,3,'Mediocre','3/5 needed to pay to use the restrooms','2020-11-23 00:00:00',5,2),(6,1,'Dirty','Restroom smelled, no toilet paper','2021-01-03 00:00:00',6,3);
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `ratingNum` int DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `unique_user` (`firstName`,`lastName`,`emailAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Devin','Barger','devinb2010@gmail.com',0,'2021-02-17 03:07:53'),(2,'Edward','Yeung','edwardnese@gmail.com',0,'2021-02-17 03:07:53'),(3,'John','Doe','jdoe456@gmail.com',0,'2021-02-17 03:07:53');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-16 22:20:44
