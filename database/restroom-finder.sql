-- MariaDB dump 10.18  Distrib 10.4.17-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_bargerd
-- ------------------------------------------------------
-- Server version	10.4.17-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `employeeID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `createdAt` timestamp NULL DEFAULT current_timestamp(),
  `lastLogin` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`employeeID`),
  UNIQUE KEY `unique_emp` (`firstName`,`lastName`,`emailAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Devin','Barger','bargerd@oregonstate.edu','2021-02-17 03:07:59','2021-03-05 03:31:31'),(2,'Edward','Yeung','yeunge@oregonstate.edu','2021-02-17 03:07:59','0000-00-00 00:00:00'),(3,'John','Doe','doejohn@oregonstate.edu','2021-02-17 03:07:59','2021-03-05 02:39:08'),(4,'Buster','Hodge','runbarkplay@doggos.com','2021-03-05 02:42:09','0000-00-00 00:00:00'),(5,'Buster','Barger','runbarkplay@doggos.com','2021-03-05 03:14:57','2021-03-05 03:14:57'),(6,'Devin','Barger','debarger@cisco.com','2021-03-05 03:32:06','2021-03-05 03:32:06'),(7,'Bill','Nye','billnye@scienceguy.org','2021-03-05 03:56:08','2021-03-05 03:56:08'),(8,'Kev','Mac','km@mail.com','2021-03-05 09:34:24','2021-03-05 09:34:24'),(9,'test','test','test@gmail.com','2021-03-07 18:07:57','2021-03-07 18:07:57'),(10,'Joe','Schmo','goschmo@email.com','2021-03-08 06:52:43','2021-03-08 07:11:01'),(11,'Devin','Barger','devinb2010@gmail.com','2021-03-09 03:11:58','2021-03-09 03:11:58');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Locations` (
  `locationID` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`locationID`),
  UNIQUE KEY `locationID` (`locationID`),
  UNIQUE KEY `unique_loc` (`street`,`city`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT INTO `Locations` VALUES (1,'1233 Fake St.','   Charlotte','   North Carolina','   US'),(2,'5678 Dreamville Ln.','Portland','Alabama','US'),(3,'2450 Fantasy St.','    Orlando','    Florida','    US'),(4,'1 Warriors Way','San Francisco','Alabama','US'),(6,'333 E Trade St','Charlotte','Alabama','US'),(7,'78 SW 7th St','   Miami','   Florida','   '),(8,'Karpen Hall Suite 200','Asheville','Alabama','US'),(9,'Karpen Hall Suite 201','Asheville','Alabama','US'),(10,'Karpen Hall Suite 300','Asheville','Alabama','US'),(11,'Thomas Jefferson Park 2180 1st Ave','    New York City','    New York','    '),(12,'2840 Eastway Dr','Charlotte','Alabama','US'),(13,'244 runway st 232','Jersey City','Alabama','United States'),(14,'1212 Flockers st 621','new york','Alabama','us'),(15,'1235 Flockers st 322','new york','Alabama','us'),(16,'453543 Off st 732','new york','Alabama','us'),(17,'12312 testing street 876','testville','Alabama','US'),(18,'456 Easton place','Cali','Alabama','US'),(19,'','gfdfgdsfg','Alabama',''),(20,'','Whitestone','Alabama',''),(22,'abc 123 1600 Pennsylvania Avenue','Seattle','Alabama',''),(23,'','','Alabama',''),(24,'asfdlskjfldskj 123134  fdsafd','fdsafds','Alabama','USA'),(25,'asdfasdf asdfasdf','asdfasdf','Alabama','asdfasdf'),(29,'asdfasdf asdfasdf','Corvallis','Alabama','USA'),(31,'fdsafdsafd hrerhzdfgdfg','fgdrga','Alabama','USA'),(32,'8001 Flushing Meadows Dr','Wake Forest','Alabama','US'),(34,'544 S Person St test','Raleigh','Alabama','United States'),(35,'gdfgfg fdgdfgdfg','fdgdfgdfg','Alabama',''),(36,'555 59th st','New york','Alabama','10001'),(37,'122 Blagden Alley NW','Washington','DC','US'),(39,'1601 14th St NW',' Washington',' DC',' US'),(40,'444 Map St','San Francisco','CA',''),(42,'test st test apt','','',''),(44,'609 Glen Creek St.','Brooklyn','New York','US');
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restrooms`
--

DROP TABLE IF EXISTS `Restrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Restrooms` (
  `restroomID` int(11) NOT NULL AUTO_INCREMENT,
  `locationID` int(11) NOT NULL,
  `openHour` varchar(50) DEFAULT NULL,
  `closeHour` varchar(50) DEFAULT NULL,
  `free` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`restroomID`),
  KEY `locationID` (`locationID`),
  CONSTRAINT `restrooms_ibfk_1` FOREIGN KEY (`locationID`) REFERENCES `Locations` (`locationID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restrooms`
--

LOCK TABLES `Restrooms` WRITE;
/*!40000 ALTER TABLE `Restrooms` DISABLE KEYS */;
INSERT INTO `Restrooms` VALUES (4,1,'09:00','23:00',0),(6,3,'01:00','23:00',1),(7,7,'15:00','21:00',0),(8,8,'00:00','00:00',0),(9,9,'00:00','00:00',0),(13,13,'','',0),(15,15,'','',0),(17,17,'','',0),(19,19,'','',0),(21,22,'23:37','21:39',0),(22,23,'','',0),(23,24,'22:50','08:53',0),(24,25,'asdf','asdf',0),(25,29,'9:00','23:00',0),(26,31,'13:19','22:23',0),(27,32,'09:00','22:30',0),(28,34,'14:36','14:36',0),(29,35,'','',0),(31,37,'16:00','22:00',0),(32,39,'14:30','22:00',0),(35,44,'10:00','22:00',0);
/*!40000 ALTER TABLE `Restrooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RestroomsEmployees`
--

DROP TABLE IF EXISTS `RestroomsEmployees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RestroomsEmployees` (
  `restroomID` int(11) NOT NULL,
  `employeeID` int(11) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `inspectedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  KEY `restroomID` (`restroomID`),
  KEY `employeeID` (`employeeID`),
  CONSTRAINT `restroomsemployees_ibfk_1` FOREIGN KEY (`restroomID`) REFERENCES `Restrooms` (`restroomID`) ON DELETE CASCADE,
  CONSTRAINT `restroomsemployees_ibfk_2` FOREIGN KEY (`employeeID`) REFERENCES `Employees` (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RestroomsEmployees`
--

LOCK TABLES `RestroomsEmployees` WRITE;
/*!40000 ALTER TABLE `RestroomsEmployees` DISABLE KEYS */;
INSERT INTO `RestroomsEmployees` VALUES (6,3,'Nothing magical about this place','2021-03-03 08:00:00'),(4,1,'Hard to find it at night. ','2021-01-21 08:00:00'),(7,3,'','2021-01-02 08:00:00'),(32,7,'Nice','2021-03-04 08:00:00'),(35,10,'','2021-03-08 07:01:12');
/*!40000 ALTER TABLE `RestroomsEmployees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reviews` (
  `reviewID` int(11) NOT NULL AUTO_INCREMENT,
  `overallRating` int(11) NOT NULL,
  `cleanliness` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `restroomID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`reviewID`),
  UNIQUE KEY `reviewID` (`reviewID`),
  KEY `restroomID` (`restroomID`),
  KEY `userID` (`userID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`restroomID`) REFERENCES `Restrooms` (`restroomID`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
INSERT INTO `Reviews` VALUES (6,1,'Pristine','Restroom smelled, no toilet paper','2021-01-03 00:00:00',6,3),(9,4,'Dirty','Did not smell','2021-02-25 00:00:00',7,1),(13,4,'Pristine','This is a test review by a student in the class. Just working on my review of your project so far! Hello!','2021-02-28 00:00:00',4,1),(20,4,'Mediocre','','2021-03-07 00:00:00',31,1);
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `emailAddress` varchar(255) NOT NULL,
  `ratingNum` int(11) DEFAULT 0,
  `createdAt` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`userID`),
  UNIQUE KEY `unique_user` (`firstName`,`lastName`,`emailAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Devin','Barger','devinb2010@gmail.com',0,'2021-02-17 03:07:53'),(2,'Edward','Yeung','edwardnese@gmail.com',0,'2021-02-17 03:07:53'),(3,'John','Doe','jdoe456@gmail.com',0,'2021-02-17 03:07:53'),(4,'eddy','yang','test@gmail.com',0,'2021-03-05 06:56:14'),(5,'\'test\'','\'testing\'','\'testing123@gmail.com\'',0,'2021-03-05 06:58:14'),(6,'edtest','tested','test@email.com',0,'2021-03-05 06:59:02'),(7,'Kev','Mac','km@mail.com',0,'2021-03-05 09:47:29'),(8,'terrence.paz@yahoo.com','Smith','terrence.paz@yahoo.com',0,'2021-03-07 09:50:50'),(9,'test','test','test@gmail.com',0,'2021-03-07 18:11:28'),(10,'Dustin','Walkup','walkupd@oregonstate.edu',0,'2021-03-07 21:44:54'),(11,'remus','lupin','moony@email.com',0,'2021-03-08 07:05:35'),(12,'test','test123','edwardnese@gmail.com',0,'2021-03-09 07:12:01'),(13,'guy','smith','sdf@ASDFM',0,'2021-03-11 00:15:00');
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

-- Dump completed on 2021-03-15 20:08:51
