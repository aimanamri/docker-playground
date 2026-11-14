-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: May 15, 2023 at 08:09 PM
-- Server version: 8.0.33
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `school_db`;
USE `school_db`;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Buildings`
--

CREATE TABLE `Buildings` (
  `BuildingID` int NOT NULL,
  `BuildingName` varchar(45) DEFAULT NULL,
  `CollegeName` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Buildings`
--

INSERT INTO `Buildings` (`BuildingID`, `BuildingName`, `CollegeName`) VALUES
(1, 'Riverhead', 'SCCC'),
(2, 'Islip', 'SCCC'),
(3, 'South Hampton', 'SCCC'),
(4, 'Ammerman', 'SCCC'),
(5, 'Smithtown', 'SCCC');

-- --------------------------------------------------------

--
-- Table structure for table `Classrooms`
--

CREATE TABLE `Classrooms` (
  `RoomNumber` int NOT NULL,
  `HasProjector` varchar(3) DEFAULT NULL,
  `BuildingID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Classrooms`
--

INSERT INTO `Classrooms` (`RoomNumber`, `HasProjector`, `BuildingID`) VALUES
(201, 'Y', 1),
(202, 'N', 1),
(203, 'Y', 1),
(303, 'N', 5),
(304, 'Y', 5),
(305, 'N', 5);

-- --------------------------------------------------------

--
-- Table structure for table `College`
--

CREATE TABLE `College` (
  `CollegeName` varchar(50) NOT NULL,
  `CollegeTotalStudents` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `College`
--

INSERT INTO `College` (`CollegeName`, `CollegeTotalStudents`) VALUES
('SCCC', 26711);

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE `Course` (
  `CourseID` int NOT NULL,
  `CourseName` varchar(45) DEFAULT NULL,
  `TextbookISBN` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Course`
--

INSERT INTO `Course` (`CourseID`, `CourseName`, `TextbookISBN`) VALUES
(1, 'Computer Science I', 200),
(2, 'Computer Science II', 201),
(3, 'Computer Science III', 202),
(4, 'Data Structures', 203),
(5, 'Computer Assembly', 204),
(6, 'Intro To Networking', 205),
(7, 'Calculus I', 206),
(8, 'Calculus II', 207),
(9, 'Calculus III', 208),
(10, 'Differential Equations', 209),
(11, 'Linear Algebra', 210),
(12, 'Accounting I', 211),
(13, 'Accounting II', 212),
(14, 'Composition', 213),
(15, 'Literature', 214),
(16, 'Organic Chemistry I', 215),
(17, 'Organic Chemistry II', 216);

-- --------------------------------------------------------

--
-- Table structure for table `Faculty`
--

CREATE TABLE `Faculty` (
  `FacultyID` int NOT NULL,
  `FacultyTitle` varchar(45) DEFAULT NULL,
  `FacultySalary` int DEFAULT NULL,
  `FacultyName` varchar(45) DEFAULT NULL,
  `PersonID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Faculty`
--

INSERT INTO `Faculty` (`FacultyID`, `FacultyTitle`, `FacultySalary`, `FacultyName`, `PersonID`) VALUES
(1, 'Head Of Computer Science', 100000, 'Tanya Ferguson', 1),
(2, 'Head Of Mathematics', 90000, 'Guy O\'Neill', 2),
(3, 'Head Of English', 85000, 'Dennis Wilks', 3),
(4, 'Head Of Accounting', 80000, 'Kenneth Mason', 4),
(5, 'Head Of Life Sciences', 75000, 'Mike Briley', 5),
(6, 'Professor Of Computer Science', 60000, 'Mary George', 6),
(7, 'Professor Of Mathematics', 60000, 'June Walkters', 7),
(8, 'Professor Of English', 60000, 'Angela Mendez', 8),
(9, 'Professor Of Accounting', 60000, 'John Leak', 9),
(10, 'Professor Of Life Sciences', 60000, 'Carey Cochran', 10);

-- --------------------------------------------------------

--
-- Table structure for table `Interns`
--

CREATE TABLE `Interns` (
  `InternID` int NOT NULL,
  `PersonID` int DEFAULT NULL,
  `InternHourlyWage` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Interns`
--

INSERT INTO `Interns` (`InternID`, `PersonID`, `InternHourlyWage`) VALUES
(1, 21, 15),
(2, 22, 15),
(3, 23, 11);

-- --------------------------------------------------------

--
-- Table structure for table `Person`
--

CREATE TABLE `Person` (
  `PersonID` int NOT NULL,
  `PersonPhoneNumber` varchar(45) DEFAULT NULL,
  `PersonName` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Person`
--

INSERT INTO `Person` (`PersonID`, `PersonPhoneNumber`, `PersonName`) VALUES
(1, '635-448-6158', 'Tanya Ferguson'),
(2, '654-651-8521', 'Guy O\'Neill'),
(3, '687-846-5132', 'Dennis Wilks'),
(4, '876-263-4455', 'Kenneth Mason'),
(5, '184-846-4613', 'Mike Briley'),
(6, '184-618-4842', 'Mary George'),
(7, '618-476-4631', 'June Walkters'),
(8, '594-976-4326', 'Angela Mendez'),
(9, '459-487-9635', 'John Leak'),
(10, '111-526-8633', 'Carey Cochran'),
(11, '216-549-8633', 'Jerry Ryan'),
(12, '549-798-6568', 'Hugo Jurgens'),
(13, '654-849-9562', 'Anita Nelson'),
(14, '954-598-5456', 'Robert Arnold'),
(15, '108-865-6406', 'Helen Small'),
(16, '952-814-6546', 'Jason Leavitt'),
(17, '646-979-4626', 'Heather Vester'),
(18, '649-452-9488', 'Ivan Wright'),
(19, '959-561-2512', 'Norman Roberts'),
(20, '646-289-5849', 'James Neville'),
(21, '168-516-5213', 'Jamie Kurland'),
(22, '651-651-2383', 'Brenda Thornberry'),
(23, '651-468-4684', 'Tom Katz');

-- --------------------------------------------------------

--
-- Table structure for table `Section`
--

CREATE TABLE `Section` (
  `SectionID` int NOT NULL,
  `SectionDate` date DEFAULT NULL,
  `RoomNumber` int DEFAULT NULL,
  `CourseID` int DEFAULT NULL,
  `BuildingID` int DEFAULT NULL,
  `PersonID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Section`
--

INSERT INTO `Section` (`SectionID`, `SectionDate`, `RoomNumber`, `CourseID`, `BuildingID`, `PersonID`) VALUES
(100, '2017-12-27', 201, 3, 1, 1),
(101, '2017-12-27', 202, 7, 1, 2),
(102, '2017-12-27', 203, 12, 1, 3),
(103, '2017-12-27', 303, 15, 5, 4),
(104, '2017-12-27', 304, 17, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `StudentID` int NOT NULL,
  `StudentGPA` double(10,2) DEFAULT NULL,
  `StudentName` varchar(45) DEFAULT NULL,
  `PersonID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`StudentID`, `StudentGPA`, `StudentName`, `PersonID`) VALUES
(1, 4.00, 'Jerry Ryan', 11),
(2, 3.20, 'Hugo Jurgens', 12),
(3, 3.70, 'Anita Nelson', 13),
(4, 2.50, 'Robert Arnold', 14),
(5, 2.00, 'Helen Small', 15),
(6, 4.00, 'Jason Leavitt', 16),
(7, 3.30, 'Heather Vester', 17),
(8, 2.90, 'Ivan Wright', 18),
(9, 1.30, 'Norman Roberts', 19),
(10, 3.70, 'James Nelville', 20);

-- --------------------------------------------------------

--
-- Table structure for table `Textbook`
--

CREATE TABLE `Textbook` (
  `TextbookISBN` int NOT NULL,
  `TextbookTitle` varchar(45) DEFAULT NULL,
  `TextbookAuthor` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Textbook`
--

INSERT INTO `Textbook` (`TextbookISBN`, `TextbookTitle`, `TextbookAuthor`) VALUES
(200, 'Computer Science Illustrated', 'John Smith'),
(201, 'Liang Java', 'Daniel Liang'),
(202, 'Liang Java', 'Daniel Liang'),
(203, 'Data Structures & Algorithms', 'William Mcallister'),
(204, 'Machine Learning', 'John Smith'),
(205, 'Networking CCNA', 'Tom Smith'),
(206, 'Intro to Calculus', 'Isaac Newton'),
(207, 'Advanced Topics in Calculus', 'James Stewart'),
(208, 'Vectors and Matrices in Calculus', 'James Stewart'),
(209, 'Multivariable Calculus', 'James Stewart'),
(210, 'Math for Computer Science', 'James Hoy'),
(211, 'Fundamentals of Accounting', 'Nicholas Bosco'),
(212, 'Fundamentals of Accounting', 'Nicholas Bosco'),
(213, 'Short Stories', 'Daniel Linker'),
(214, 'Poems and Stories', 'William Burns'),
(215, 'Organic Chemistry Principles', 'Craig Johnson'),
(216, 'Organic Chemistry Principles', 'Craig Johnson');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Buildings`
--
ALTER TABLE `Buildings`
  ADD PRIMARY KEY (`BuildingID`),
  ADD UNIQUE KEY `BuildingID_UNIQUE` (`BuildingID`),
  ADD KEY `CollegeName_idx` (`CollegeName`);

--
-- Indexes for table `Classrooms`
--
ALTER TABLE `Classrooms`
  ADD PRIMARY KEY (`RoomNumber`),
  ADD UNIQUE KEY `RoomNumber_UNIQUE` (`RoomNumber`),
  ADD KEY `BuildingID_idx` (`BuildingID`);

--
-- Indexes for table `College`
--
ALTER TABLE `College`
  ADD PRIMARY KEY (`CollegeName`),
  ADD UNIQUE KEY `CollegeName_UNIQUE` (`CollegeName`);

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`CourseID`),
  ADD UNIQUE KEY `CourseID_UNIQUE` (`CourseID`),
  ADD KEY `TextbookISBN_idx` (`TextbookISBN`);

--
-- Indexes for table `Faculty`
--
ALTER TABLE `Faculty`
  ADD PRIMARY KEY (`FacultyID`),
  ADD UNIQUE KEY `FacultyID_UNIQUE` (`FacultyID`),
  ADD KEY `PersonID_idx` (`PersonID`);

--
-- Indexes for table `Interns`
--
ALTER TABLE `Interns`
  ADD PRIMARY KEY (`InternID`),
  ADD UNIQUE KEY `Level_UNIQUE` (`InternID`),
  ADD KEY `PersonID_idx` (`PersonID`);

--
-- Indexes for table `Person`
--
ALTER TABLE `Person`
  ADD PRIMARY KEY (`PersonID`),
  ADD UNIQUE KEY `PersonID_UNIQUE` (`PersonID`);

--
-- Indexes for table `Section`
--
ALTER TABLE `Section`
  ADD PRIMARY KEY (`SectionID`),
  ADD UNIQUE KEY `SectionID_UNIQUE` (`SectionID`),
  ADD KEY `RoomNumber_idx` (`RoomNumber`),
  ADD KEY `CourseID_idx` (`CourseID`),
  ADD KEY `BuildingID_idx` (`BuildingID`),
  ADD KEY `PersonID_idx` (`PersonID`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`StudentID`),
  ADD UNIQUE KEY `StudentID_UNIQUE` (`StudentID`),
  ADD KEY `PersonID_idx` (`PersonID`);

--
-- Indexes for table `Textbook`
--
ALTER TABLE `Textbook`
  ADD PRIMARY KEY (`TextbookISBN`),
  ADD UNIQUE KEY `TextbookISBN_UNIQUE` (`TextbookISBN`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Buildings`
--
ALTER TABLE `Buildings`
  ADD CONSTRAINT `FK_Buildings_CollegeName` FOREIGN KEY (`CollegeName`) REFERENCES `College` (`CollegeName`);

--
-- Constraints for table `Classrooms`
--
ALTER TABLE `Classrooms`
  ADD CONSTRAINT `FK_Classrooms_BuildingID` FOREIGN KEY (`BuildingID`) REFERENCES `Buildings` (`BuildingID`);

--
-- Constraints for table `Course`
--
ALTER TABLE `Course`
  ADD CONSTRAINT `FK_Course_TextbookISBN` FOREIGN KEY (`TextbookISBN`) REFERENCES `Textbook` (`TextbookISBN`);

--
-- Constraints for table `Faculty`
--
ALTER TABLE `Faculty`
  ADD CONSTRAINT `FK_Faculty_PersonID` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`);

--
-- Constraints for table `Interns`
--
ALTER TABLE `Interns`
  ADD CONSTRAINT `FK_Interns_PersonID` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`);

--
-- Constraints for table `Section`
--
ALTER TABLE `Section`
  ADD CONSTRAINT `FK_Section_BuildingID` FOREIGN KEY (`BuildingID`) REFERENCES `Buildings` (`BuildingID`),
  ADD CONSTRAINT `FK_Section_CourseID` FOREIGN KEY (`CourseID`) REFERENCES `Course` (`CourseID`),
  ADD CONSTRAINT `FK_Section_PersonID` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`),
  ADD CONSTRAINT `FK_Section_RoomNumber` FOREIGN KEY (`RoomNumber`) REFERENCES `Classrooms` (`RoomNumber`);

--
-- Constraints for table `Student`
--
ALTER TABLE `Student`
  ADD CONSTRAINT `FK_Student_PersonID` FOREIGN KEY (`PersonID`) REFERENCES `Person` (`PersonID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
