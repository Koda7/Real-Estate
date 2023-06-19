-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: RealEstate
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `AGENT`
--
CREATE DATABASE RealEstate;
USE RealEstate;
DROP TABLE IF EXISTS `AGENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AGENT` (
  `Name` varchar(100) NOT NULL,
  `MobileNo` varchar(10) NOT NULL,
  `Salary` int NOT NULL,
  `Bonus` decimal(18,2) DEFAULT '0.00',
  `AgentID` int NOT NULL AUTO_INCREMENT,
  `SuperID` int DEFAULT NULL,
  PRIMARY KEY (`AgentID`),
  UNIQUE KEY `UC_AGENT` (`MobileNo`),
  KEY `SuperID` (`SuperID`),
  CONSTRAINT `AGENT_ForeignKey` FOREIGN KEY (`SuperID`) REFERENCES `AGENT` (`AgentID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `AGENT_MobileCheck` CHECK (regexp_like(`MobileNo`,_utf8mb4'^[0-9]{10}$'))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AGENT`
--

LOCK TABLES `AGENT` WRITE;
/*!40000 ALTER TABLE `AGENT` DISABLE KEYS */;
INSERT INTO `AGENT` VALUES ('Varuna  Hans','8250762377',320000,0.00,1,NULL),('Arav  Kata','4553352588',150000,939223.00,2,1),('Sara  Handa','4198051218',85000,138840.00,4,2),('Amma  Oak','8161464869',150000,0.00,5,1),('Jatin  Chandra','8992307156',85000,0.00,6,5),('Ran  Balay','7923841068',85000,151680.00,7,5),('Kamana  Gopal','8800704999',85000,0.00,8,5),('Archana  Pandit','9562003990',85000,0.00,9,2),('Jaganmata  Kulkarni','7764568872',85000,0.00,10,5),('Indra','6221234104',30000,0.00,13,NULL);
/*!40000 ALTER TABLE `AGENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AREACONVERSION`
--

DROP TABLE IF EXISTS `AREACONVERSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AREACONVERSION` (
  `AreaInSqFt` decimal(18,2) DEFAULT NULL,
  `AreaInAcres` int NOT NULL,
  PRIMARY KEY (`AreaInAcres`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AREACONVERSION`
--

LOCK TABLES `AREACONVERSION` WRITE;
/*!40000 ALTER TABLE `AREACONVERSION` DISABLE KEYS */;
INSERT INTO `AREACONVERSION` VALUES (43560.00,1),(87120.00,2),(958320.00,22);
/*!40000 ALTER TABLE `AREACONVERSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BANK`
--

DROP TABLE IF EXISTS `BANK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BANK` (
  `BankID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `BranchAddress` varchar(100) NOT NULL,
  PRIMARY KEY (`BankID`),
  UNIQUE KEY `BranchAddress` (`BranchAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BANK`
--

LOCK TABLES `BANK` WRITE;
/*!40000 ALTER TABLE `BANK` DISABLE KEYS */;
INSERT INTO `BANK` VALUES (2,'Union Bank of India (UK) Ltd','Senator House, 85 Queen Victoria St, London EC4V 4AB, United Kingdom'),(3,'TurkishBank UK','84-86 Borough High St, London SE1 1LN, United Kingdom'),(4,'Metro Bank','120 Cheapside, London EC2V 7JB, United Kingdom'),(5,'Bank of China','107 Shaftesbury Ave, Soho, London W1D 5DA, United Kingdom'),(6,'Bank Sepah International PLC','5-7, Eastcheap, Bridge, London EC3M 1JT, United Kingdom'),(7,'Barclays Bank','120 Moorgate, Finsbury, London EC2M 6UR, United Kingdom'),(8,'Handelsbanken London Holborn Branch','2, 1 Kingsway, Holborn, London WC2B 6AN, United Kingdom'),(9,'Deutsche Bank','10 Bishops Square, Spitalfields, London E1 6EG, United Kingdom'),(10,'Handelsbanken London West End Branch','3, 86 Jermyn St, St. James, London SW1Y 6JD, United Kingdom'),(12,'SBI','shahbad');
/*!40000 ALTER TABLE `BANK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BANKINTEREST`
--

DROP TABLE IF EXISTS `BANKINTEREST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BANKINTEREST` (
  `Name` varchar(100) NOT NULL,
  `InterestRate` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `BANKINTEREST_InterestRateCheck` CHECK (((`InterestRate` <= 100.00) and (`InterestRate` >= 0.00)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BANKINTEREST`
--

LOCK TABLES `BANKINTEREST` WRITE;
/*!40000 ALTER TABLE `BANKINTEREST` DISABLE KEYS */;
INSERT INTO `BANKINTEREST` VALUES ('Bank of China',6.70),('Bank Sepah International PLC',13.50),('Barclays Bank',5.60),('Deutsche Bank',4.70),('Handelsbanken London',11.30),('Metro Bank',10.00),('SBI',14.00),('TurkishBank UK',9.90),('Union Bank of India (UK) Ltd',12.50);
/*!40000 ALTER TABLE `BANKINTEREST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BUYER`
--

DROP TABLE IF EXISTS `BUYER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BUYER` (
  `Name` varchar(100) NOT NULL,
  `MobileNo` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `CreditScore` int NOT NULL,
  `Address` varchar(100) NOT NULL,
  `BankID` int DEFAULT NULL,
  `BuyerID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`BuyerID`),
  UNIQUE KEY `MobileNo` (`MobileNo`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Address` (`Address`),
  KEY `BankID` (`BankID`),
  CONSTRAINT `BUYER_ForeignKey` FOREIGN KEY (`BankID`) REFERENCES `BANK` (`BankID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `BUYER_MobileCheck` CHECK (regexp_like(`MobileNo`,_utf8mb4'^[0-9]{10}$')),
  CONSTRAINT `BUYER_EmailCheck` CHECK (regexp_like(`Email`,_utf8mb4'^(?=[A-Z0-9][A-Z0-9@.%+-]{5,253}+$)[A-Z0-9.%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+.)[A-Z0-9]++(?:-[A-Z0-9]++)*+.){1,8}+[A-Z]{2,63}+$')),
  CONSTRAINT `BUYER_CreditScoreCheck` CHECK (((`CreditScore` >= 300) and (`CreditScore` <= 800)))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BUYER`
--

LOCK TABLES `BUYER` WRITE;
/*!40000 ALTER TABLE `BUYER` DISABLE KEYS */;
INSERT INTO `BUYER` VALUES ('Sia Cooley','8870017519','petersko@msn.com',438,'G7 Mahalaxmi Ind Est, D C Rd, Delisle Road  Maharashtra',5,1),('Arianna Ahmed','7162917664','rgiersig@live.com',767,'276  Savita Sadan, V P Road, st Parsiwada, Girgaum, Maharashtra',2,2),('Ioan Ball','8276304328','hikoza@hotmail.com',671,'Shop No 2, Vijay Bhavan, Proctor Road, Grant Road  Maharashtra',NULL,3),('Amanda Bowen','6475472595','weazelman@aol.com',752,'23 , Pancheel Heights, Mahavir Nagar, Opp Woodland Hotel, Kandivli(w) Delhi',8,4),('Virgil Chase','6967217994','ahuillet@mac.com',782,'32 nd Floor, /, Jalan Bhavan, Kalbadevi Road, Badamwadi, Kalbadevi Patna',5,5),('Ishaq Dickerson','6549599252','ehood@live.com',648,'Plot No 4 & 5, Yeshwant Smruti, Kalyan Road, Near Hotel Janki,gopal Nagar, Dombivli (east) Hyderbad',4,6),('Stevie Sullivan','9630600480','epeeist@live.com',699,'Bldg No 6 Sec 10, Room No A 4, Grd Floor Nr Vijayabk, Vashi Kerala',9,7),('Malakai Mccullough','9889633771','arathi@outlook.com',481,'Admn Bldg, Sheva, J N P T, Navi Mumbai',5,8),('Camden Bravo','6001483839','bdthomas@outlook.com',439,'20 , Annapurna Co-op Society, Tp Road, Nardas Nagar, Bhandup(w) Ajmer',2,9),('Umayr Villanueva','8075963932','nwiger@att.net',343,'Door No. 106, Patel Building, S. V. P. Road, Chinch Bunder Jaipur',7,10),('arun Kumar','7654101234','abc123@gmail.com',750,'271,Bakerstreet',5,11),('Aditi','9876523451','Aditi@gmail.com',700,'vasant bihar',7,12);
/*!40000 ALTER TABLE `BUYER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CITYTOSTATE`
--

DROP TABLE IF EXISTS `CITYTOSTATE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CITYTOSTATE` (
  `State` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  PRIMARY KEY (`City`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CITYTOSTATE`
--

LOCK TABLES `CITYTOSTATE` WRITE;
/*!40000 ALTER TABLE `CITYTOSTATE` DISABLE KEYS */;
INSERT INTO `CITYTOSTATE` VALUES ('Punjab','Amritsar'),('Punjab','Barnala'),('Delhi','Delhi'),('Telangana','Hyderbad'),('Rajasthan','Jaipur'),('Uttarakhand','Khatima'),('UP','Lucknow'),('Maharashtra','Mumbai'),('Bihar','Patna'),('Maharashtra','Pune'),('Kerala','Thiruvanthpuram');
/*!40000 ALTER TABLE `CITYTOSTATE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMMERCIAL`
--

DROP TABLE IF EXISTS `COMMERCIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMMERCIAL` (
  `Floors` int NOT NULL,
  `Type` varchar(100) NOT NULL,
  `ParkingSpace` int NOT NULL,
  `YearBuilt` int NOT NULL,
  `PropertyID` int NOT NULL,
  PRIMARY KEY (`PropertyID`),
  CONSTRAINT `COMMERCIAL_ForeignKey` FOREIGN KEY (`PropertyID`) REFERENCES `PROPERTY` (`PropertyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `COMMERCIAL_YearCheck` CHECK (((`YearBuilt` <= 2020) and (`YearBuilt` >= 1000))),
  CONSTRAINT `COMMERCIAL_TypeCheck` CHECK ((`Type` in (_utf8mb4'shop',_utf8mb4'Shop',_utf8mb4'office',_utf8mb4'Office',_utf8mb4'godown',_utf8mb4'Godown')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMMERCIAL`
--

LOCK TABLES `COMMERCIAL` WRITE;
/*!40000 ALTER TABLE `COMMERCIAL` DISABLE KEYS */;
INSERT INTO `COMMERCIAL` VALUES (2,'Godown',0,2011,2),(4,'Office',3000,2010,7),(10,'Office',3000,2014,10),(3,'Shop',100,2014,23),(3,'Office',300,2010,24);
/*!40000 ALTER TABLE `COMMERCIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEPENDENT`
--

DROP TABLE IF EXISTS `DEPENDENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEPENDENT` (
  `Age` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `AgentId` int NOT NULL,
  `Gender` varchar(100) NOT NULL,
  `Relationship` varchar(100) NOT NULL,
  PRIMARY KEY (`Name`,`AgentId`),
  KEY `AgentId` (`AgentId`),
  CONSTRAINT `DEPENDENT_ForeignKey` FOREIGN KEY (`AgentId`) REFERENCES `AGENT` (`AgentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `DEPENDENT_GenderCheck` CHECK ((`Gender` in (_utf8mb4'Female',_utf8mb4'Male',_utf8mb4'male',_utf8mb4'female'))),
  CONSTRAINT `DEPENDENT_AgeCheck` CHECK ((`Age` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEPENDENT`
--

LOCK TABLES `DEPENDENT` WRITE;
/*!40000 ALTER TABLE `DEPENDENT` DISABLE KEYS */;
INSERT INTO `DEPENDENT` VALUES (35,'Eshan Gupta',9,'Male','Friend'),(65,'Keshav Bajaj',5,'Male','Uncle'),(45,'Mayank Goel',1,'Male','Uncle'),(20,'Mohit',13,'Male','Son');
/*!40000 ALTER TABLE `DEPENDENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERSON`
--

DROP TABLE IF EXISTS `PERSON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PERSON` (
  `PropertyID` int NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Gender` varchar(100) NOT NULL,
  `Occupation` varchar(100) NOT NULL,
  `Remarks` varchar(100) NOT NULL,
  PRIMARY KEY (`PropertyID`,`Name`),
  CONSTRAINT `PERSON_ForeignKey` FOREIGN KEY (`PropertyID`) REFERENCES `PROPERTY` (`PropertyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PERSON_GenderCheck` CHECK ((`Gender` in (_utf8mb4'Female',_utf8mb4'Male',_utf8mb4'male',_utf8mb4'female')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERSON`
--

LOCK TABLES `PERSON` WRITE;
/*!40000 ALTER TABLE `PERSON` DISABLE KEYS */;
INSERT INTO `PERSON` VALUES (1,'Modi','Male','Software Engineer','Well built'),(2,'Tanvi','Female','Businessman','Looked fondly to my time there'),(6,'Arun','Male','Doctor','happy to live there, Great view, '),(8,'Yash','Male','Transponster','happy to live there'),(9,'Amit','Male','Housewife','happy to live there'),(23,'Karun','Male','Doctor','Nice Shop'),(24,'Akhil','Male','BUsinessman','Middle of the city'),(26,'Monika','Female','Doctor','Helpful neighbours'),(26,'Rahul','Male','Politician','Good community');
/*!40000 ALTER TABLE `PERSON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PINCODETOCITY`
--

DROP TABLE IF EXISTS `PINCODETOCITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PINCODETOCITY` (
  `Pincode` varchar(6) NOT NULL,
  `City` varchar(100) NOT NULL,
  PRIMARY KEY (`Pincode`),
  CONSTRAINT `PINCODETOCITY_PincodeCheck` CHECK (regexp_like(`Pincode`,_utf8mb4'^[0-9]{6}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PINCODETOCITY`
--

LOCK TABLES `PINCODETOCITY` WRITE;
/*!40000 ALTER TABLE `PINCODETOCITY` DISABLE KEYS */;
INSERT INTO `PINCODETOCITY` VALUES ('148101','Barnala'),('230045','Delhi'),('300598','Jaipur'),('324005','Hyderabad'),('328895','Thiruvanthpuram'),('453110','Khatima'),('654879','Amritsar'),('654910','Lucknow'),('800001','Patna'),('800015','Patna'),('920008','Pune'),('920045','Pune'),('968004','Mumbai');
/*!40000 ALTER TABLE `PINCODETOCITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLOT`
--

DROP TABLE IF EXISTS `PLOT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLOT` (
  `FloorsAllowed` int NOT NULL,
  `AreaInAcres` int NOT NULL,
  `CostPerSqFt` decimal(18,2) NOT NULL,
  `BoundaryWall` varchar(100) NOT NULL,
  `PropertyID` int NOT NULL,
  PRIMARY KEY (`PropertyID`),
  CONSTRAINT `PLOT_ForeignKey` FOREIGN KEY (`PropertyID`) REFERENCES `PROPERTY` (`PropertyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PLOT_BoundaryWallCheck` CHECK ((`BoundaryWall` in (_utf8mb4'Yes',_utf8mb4'yes',_utf8mb4'No',_utf8mb4'no')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLOT`
--

LOCK TABLES `PLOT` WRITE;
/*!40000 ALTER TABLE `PLOT` DISABLE KEYS */;
INSERT INTO `PLOT` VALUES (10,2,7.96,'Yes',1),(7,1,6.59,'No',4),(22,30,7.52,'No',5);
/*!40000 ALTER TABLE `PLOT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROPERTY`
--

DROP TABLE IF EXISTS `PROPERTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROPERTY` (
  `SellerID` int DEFAULT NULL,
  `PropertyNo` varchar(100) NOT NULL,
  `StreetAddress` varchar(100) NOT NULL,
  `AvailableFrom` date NOT NULL,
  `FacingDirection` varchar(6) NOT NULL,
  `Cost` int NOT NULL,
  `PropertyID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`PropertyID`),
  UNIQUE KEY `StreetAddress` (`StreetAddress`),
  KEY `SellerId` (`SellerID`),
  CONSTRAINT `PROPERTY_ForeignKey` FOREIGN KEY (`SellerID`) REFERENCES `SELLER` (`SellerID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `PROPERTY_Direction` CHECK ((`FacingDirection` in (_utf8mb4'North',_utf8mb4'South',_utf8mb4'West',_utf8mb4'East',_utf8mb4'north',_utf8mb4'south',_utf8mb4'west',_utf8mb4'east')))
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROPERTY`
--

LOCK TABLES `PROPERTY` WRITE;
/*!40000 ALTER TABLE `PROPERTY` DISABLE KEYS */;
INSERT INTO `PROPERTY` VALUES (NULL,'143 B','Real Dad Road','2020-10-04','South',694200,1),(NULL,'8283 C3','Amar Corner, Hadapsar','1970-10-21','North',4206815,2),(1,'46','Bombay Talkies Compound, Malad','2004-12-12','West',287454,4),(5,'Plot No.58/c','Kattedan','1984-07-25','East',9834825,5),(NULL,'11 B','Canal Street','2012-09-19','North',489300,6),(NULL,'29 G','Conventery Street','2011-07-12','East',758400,7),(9,'37 H','Maiden Lane','2009-07-01','East',398600,8),(10,'2012','Houston Street','2019-08-09','South',934700,9),(6,'BXI/748','Dalal Street','2018-11-13','West',561200,10),(25,'6','32','2018-01-01','East',203451000,23),(26,'6','19','2019-01-01','North',3000000,24),(28,'5','221','2020-02-20','South',600000,26);
/*!40000 ALTER TABLE `PROPERTY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROPERTYDEAL`
--

DROP TABLE IF EXISTS `PROPERTYDEAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROPERTYDEAL` (
  `AgentID` int NOT NULL,
  `TransactionID` int NOT NULL AUTO_INCREMENT,
  `BuyerID` int NOT NULL,
  `SellerID` int NOT NULL,
  `PropertyID` int NOT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `BuyerID` (`BuyerID`),
  KEY `SellerID` (`SellerID`),
  KEY `AgentID` (`AgentID`),
  KEY `PropertyID` (`PropertyID`),
  CONSTRAINT `PROPERTYDEAL_FkBuyerID` FOREIGN KEY (`BuyerID`) REFERENCES `BUYER` (`BuyerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PROPERTYDEAL_FkSellerID` FOREIGN KEY (`SellerID`) REFERENCES `SELLER` (`SellerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PROPERTYDEAL_FkAgentID` FOREIGN KEY (`AgentID`) REFERENCES `AGENT` (`AgentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PROPERTYDEAL_FkPropertyID` FOREIGN KEY (`PropertyID`) REFERENCES `PROPERTY` (`PropertyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROPERTYDEAL`
--

LOCK TABLES `PROPERTYDEAL` WRITE;
/*!40000 ALTER TABLE `PROPERTYDEAL` DISABLE KEYS */;
INSERT INTO `PROPERTYDEAL` VALUES (2,1,2,3,2),(7,2,5,8,7),(4,3,5,2,1),(2,4,3,7,6);
/*!40000 ALTER TABLE `PROPERTYDEAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESIDENTIAL`
--

DROP TABLE IF EXISTS `RESIDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESIDENTIAL` (
  `ElectricityTime` int NOT NULL,
  `WaterTime` int NOT NULL,
  `CarpetAreaInSqFt` int NOT NULL,
  `LiftAvailibility` varchar(10) NOT NULL,
  `Type` varchar(100) NOT NULL,
  `BedRooms` int NOT NULL,
  `ReservedParking` int NOT NULL,
  `PropertyID` int NOT NULL,
  PRIMARY KEY (`PropertyID`),
  CONSTRAINT `RESIDENTIAL_ForeignKey` FOREIGN KEY (`PropertyID`) REFERENCES `PROPERTY` (`PropertyID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RESIDENTIAL_TypeCheck` CHECK ((`Type` in (_utf8mb4'Villa',_utf8mb4'villa',_utf8mb4'Flat',_utf8mb4'flat',_utf8mb4'Penthouse',_utf8mb4'penthouse'))),
  CONSTRAINT `RESIDENTIAL_ElectricityTimeCheck` CHECK (((`ElectricityTime` >= 0) and (`ElectricityTime` <= 24))),
  CONSTRAINT `RESIDENTIAL_WaterTimeCheck` CHECK (((`WaterTime` >= 0) and (`WaterTime` <= 24))),
  CONSTRAINT `RESIDENTIAL_LiftCheck` CHECK ((`LiftAvailibility` in (_utf8mb4'Yes',_utf8mb4'yes',_utf8mb4'No',_utf8mb4'no')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESIDENTIAL`
--

LOCK TABLES `RESIDENTIAL` WRITE;
/*!40000 ALTER TABLE `RESIDENTIAL` DISABLE KEYS */;
INSERT INTO `RESIDENTIAL` VALUES (18,24,250,'No','villa',3,2,6),(19,24,200,'No','villa',3,2,8),(24,22,150,'Yes','flat',1,1,9),(20,24,144,'Yes','Flat',2,50,26);
/*!40000 ALTER TABLE `RESIDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SELLER`
--

DROP TABLE IF EXISTS `SELLER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SELLER` (
  `Name` varchar(100) NOT NULL,
  `MobileNo` varchar(10) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `SellerID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`SellerID`),
  UNIQUE KEY `MobileNo` (`MobileNo`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Address` (`Address`),
  CONSTRAINT `SELLER_MobileCheck` CHECK (regexp_like(`MobileNo`,_utf8mb4'^[0-9]{10}$')),
  CONSTRAINT `SELLER_EmailCheck` CHECK (regexp_like(`Email`,_utf8mb4'^(?=[A-Z0-9][A-Z0-9@.%+-]{5,253}+$)[A-Z0-9.%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+.)[A-Z0-9]++(?:-[A-Z0-9]++)*+.){1,8}+[A-Z]{2,63}+$'))
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SELLER`
--

LOCK TABLES `SELLER` WRITE;
/*!40000 ALTER TABLE `SELLER` DISABLE KEYS */;
INSERT INTO `SELLER` VALUES ('Keshav Bajaj','8529778412','keshavb2712@gamil.com','22 BAKER STREET, LONDON, EUROPE',1),('Mayank Jain','1234567890','lala@dontcare.com','4144  Edsel Road, Fullerton, CA, California',2),('Komal Goyal','7147264158','KOMAL.GOYAL@YIPEE.COM','2438  Timberbrook Lane Denver Colorado',3),('Crystal D Whetstone','9703001132','4cctuaumwyu@temporarymail.net','3550  Oak Ridge Drive Cape Girardeau Missouri',4),('Barbara R Koons','3612861261','7atizuum56@temporarymail.net','1101  Duff Avenue Brattleboro Vermont',5),('Mark S Davidson','3612861161','sivot47109@javadoq.com','1016  Boone Street Tivoli Texas',6),('Allan C Ignacio','4145734928','sisdfasde@jasegaesq.com','2148  Woodlawn Drive New Berlin Wisconsin',7),('Gautam  Banerjee','2224978989','hnr76gibtxd@temporarymail.net','Nr Ganga Jamuna Cinema, 220 Tardeo Road, Grant Road  Mumbai  Maharashtra',8),('Mallika  Patil','2652422189','nvymitodwi@temporarymail.net','Opp. A.s.motors Salatwada, Opp. A.s.motors, Salatwada, Opp. A.s.motors, Salatwada  Vadodara  Gujarat',9),('Raktavira  Varghese','0222500766','kebpxg254u@lamo.net','133 , A, Ghatkopar Indl Est, L.b. Shastri Marg, Op Amrut Nagar Rd, Ghatkopar (west)  Maharashtra',10),('Rahul','9876543120','R12@gmail.com','DReamAcres',25),('Prakhar','9876543510','prab1234@gmail.com','351',26),('Indra','6225145678','cong@gmail.com','panbihar',28);
/*!40000 ALTER TABLE `SELLER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SERVICES`
--

DROP TABLE IF EXISTS `SERVICES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SERVICES` (
  `PropertyID` int NOT NULL,
  `ServiceDesc` varchar(100) NOT NULL,
  PRIMARY KEY (`PropertyID`,`ServiceDesc`),
  CONSTRAINT `SERVICES_ForeignKey` FOREIGN KEY (`PropertyID`) REFERENCES `COMMERCIAL` (`PropertyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SERVICES`
--

LOCK TABLES `SERVICES` WRITE;
/*!40000 ALTER TABLE `SERVICES` DISABLE KEYS */;
INSERT INTO `SERVICES` VALUES (2,'Youthful community, constant water and electricity supplies'),(7,'Near by airport'),(10,'Park and stadium near by'),(23,'Good Food'),(24,'Nearby Railway Station');
/*!40000 ALTER TABLE `SERVICES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STREETTOPINCODE`
--

DROP TABLE IF EXISTS `STREETTOPINCODE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STREETTOPINCODE` (
  `Pincode` varchar(6) NOT NULL,
  `StreetAddress` varchar(100) NOT NULL,
  PRIMARY KEY (`StreetAddress`),
  CONSTRAINT `STREETTOPINCODE_PincodeCheck` CHECK (regexp_like(`Pincode`,_utf8mb4'^[0-9]{6}$'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STREETTOPINCODE`
--

LOCK TABLES `STREETTOPINCODE` WRITE;
/*!40000 ALTER TABLE `STREETTOPINCODE` DISABLE KEYS */;
INSERT INTO `STREETTOPINCODE` VALUES ('453110','19'),('230045','221'),('654910','32'),('324005','Amar Corner, Hadapsar'),('148101','Bombay Talkies Compound, Malad'),('328895','Canal Street'),('920008','Conventry Street'),('800015','Dalal Street'),('968004','Govind Puri, Kalkaji'),('920045','Houston Street'),('654879','Kattedan'),('300598','Maiden Lane'),('800001','Real Dad Road');
/*!40000 ALTER TABLE `STREETTOPINCODE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-06  2:19:32
