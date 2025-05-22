-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: Dec 16, 2024 at 02:06 PM
-- Server version: 10.8.8-MariaDB-1:10.8.8+maria~ubu2204
-- PHP Version: 8.2.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cw2-database`
--

-- --------------------------------------------------------

--
-- Table structure for table `Audit_Logging`
--

CREATE TABLE `Audit_Logging` (
  `Audit_ID` int(11) NOT NULL,
  `Officer_ID` int(11) DEFAULT NULL,
  `Table_Name` varchar(100) DEFAULT NULL,
  `Record_ID` int(11) DEFAULT NULL,
  `Action_Type` varchar(50) DEFAULT NULL,
  `Before_Changes` text DEFAULT NULL,
  `Timestamp` datetime DEFAULT current_timestamp(),
  `IP_Address` varchar(50) DEFAULT NULL,
  `Changes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Audit_Logging`
--

INSERT INTO `Audit_Logging` (`Audit_ID`, `Officer_ID`, `Table_Name`, `Record_ID`, `Action_Type`, `Before_Changes`, `Timestamp`, `IP_Address`, `Changes`) VALUES
(115, 2, 'Ownership', 0, 'UPDATE_FAILED', 'Attempted to update ownership for non-existent vehicle', '2024-12-14 22:32:55', '172.18.0.1', 'Vehicle plate not found: BM500XP'),
(116, 2, 'Ownership', 690, 'UPDATE', 'Previous Owner Details:\nName: James Smith\nLicense: SMITH92LDOFJJ82\nVehicle Plate: BM600X\nVehicle ID: 690', '2024-12-14 22:33:31', '172.18.0.1', 'New Owner Details:\nName: Xene Medora\nLicense: MEDORH914ANBB223\nVehicle Plate: BM600X\nVehicle ID: 690'),
(117, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-14 22:35:15', '172.18.0.1', 'User logged in successfully'),
(118, 3, 'Officer', 0, 'CREATE_FAILED', 'Attempted to create officer with duplicate badge number', '2024-12-14 23:13:45', '172.18.0.1', 'Duplicate badge number: 000000008'),
(119, 3, 'Vehicle', 692, 'CREATE', 'New vehicle entry', '2024-12-15 00:22:33', '172.18.0.1', 'Created new vehicle: G6OOX6 (Mercedes-Benz A-Class)'),
(120, 3, 'Ownership', 692, 'CREATE', 'Initial ownership assignment', '2024-12-15 00:22:33', '172.18.0.1', 'Assigned initial owner ID: 1 to new vehicle'),
(121, 3, 'Vehicle', 693, 'CREATE', 'New vehicle entry', '2024-12-15 00:38:27', '172.18.0.1', 'Created new vehicle: GX6006 (Mercedes-Benz A-Class)'),
(122, 3, 'Ownership', 693, 'CREATE', 'Initial ownership assignment', '2024-12-15 00:38:27', '172.18.0.1', 'Assigned initial owner ID: 1 to new vehicle'),
(123, 3, 'Ownership', 692, 'UPDATE', 'Previous Owner Details:\nName: James Smith\nLicense: SMITH92LDOFJJ82\nVehicle Plate: G6OOX6\nVehicle ID: 692', '2024-12-15 00:50:43', '172.18.0.1', 'New Owner Details:\nName: Alison Bates\nLicense: BATES84IJLQES74\nVehicle Plate: G6OOX6\nVehicle ID: 692'),
(124, 3, 'Vehicle', 694, 'CREATE', 'New vehicle entry', '2024-12-15 03:11:33', '172.18.0.1', 'Created new vehicle: GM360X (Renault A-Class)'),
(125, 3, 'Ownership', 694, 'UPDATE', 'Previous owners sharing vehicle: None', '2024-12-15 03:11:46', '172.18.0.1', 'Added Owner ID: 1 to existing vehicle'),
(126, 3, 'People', 560, 'CREATE', 'New person entry', '2024-12-15 03:11:58', '172.18.0.1', 'Created new person: Name: Nottingham, License: ExampleLicence24'),
(127, 1, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 10:42:44', '172.18.0.1', 'User logged in successfully'),
(128, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 10:59:04', '172.18.0.1', 'User logged in successfully'),
(129, 3, 'Officer', 10, 'CREATE', 'New officer registration', '2024-12-15 11:08:48', '172.18.0.1', 'Officer Details:\nName: manboy\nBadge: 000000005\nRank: unknown\nDepartment: unknown\nEmail: tstan13@gmail.com\nPhone: 07378807985\nRole: User'),
(130, 3, 'Officer', 10, 'DELETE_FAILED', 'Attempted to delete non-existent officer', '2024-12-15 11:11:40', '172.18.0.1', 'Officer ID 10 not found'),
(131, 3, 'Offence', 13, 'CREATE', 'New offence created', '2024-12-15 11:27:53', '172.18.0.1', 'Description: theft\nMax Fine: £5000\nMax Points: 6'),
(132, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 11:53:59', '172.18.0.1', 'User logged in successfully'),
(133, NULL, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 12:38:21', '172.18.0.1', 'Failed login attempt with username: kjkj'),
(134, NULL, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 12:39:11', '172.18.0.1', 'Failed login attempt with username: kjkj'),
(135, NULL, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 12:39:36', '172.18.0.1', 'Failed login attempt with username: kl'),
(136, NULL, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 15:02:52', '172.18.0.1', 'Failed login attempt with username: sdsqd'),
(137, 1, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 15:07:47', '172.18.0.1', 'User logged in successfully'),
(138, NULL, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 15:38:16', '172.18.0.1', 'Failed login attempt with username: mcnulty'),
(139, 1, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 16:08:53', '172.18.0.1', 'User logged in successfully'),
(140, 1, 'Ownership', 687, 'UPDATE_FAILED', 'Current owner verification failed', '2024-12-15 18:44:01', '172.18.0.1', 'Specified current owner not associated with vehicle: Plate BM500X, License ALLEN88K23KLR9B3'),
(141, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-15 19:42:34', '172.18.0.1', 'User logged in successfully'),
(142, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-16 05:05:46', '172.18.0.1', 'User logged in successfully'),
(143, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-16 06:09:44', '172.18.0.1', 'User logged in successfully'),
(144, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-16 11:24:33', '172.18.0.1', 'User logged in successfully'),
(145, 3, 'Fines', 40, 'CREATE_FAILED', 'Attempted to add fine to non-existent incident', '2024-12-16 11:46:52', '172.18.0.1', 'Incident ID not found: 40'),
(146, 3, 'Fines', 49, 'CREATE_FAILED', 'Points exceed maximum', '2024-12-16 11:47:49', '172.18.0.1', 'Points: 300, Maximum: 0'),
(147, 3, 'Fines', 48, 'CREATE_FAILED', 'Attempted to add fine to non-existent incident', '2024-12-16 11:49:22', '172.18.0.1', 'Incident ID not found: 48'),
(148, 3, 'Fines', 47, 'CREATE_FAILED', 'Attempted to add fine to non-existent incident', '2024-12-16 11:54:13', '172.18.0.1', 'Incident ID not found: 47'),
(149, 3, 'Fines', 47, 'CREATE_FAILED', 'Attempted to add fine to non-existent incident', '2024-12-16 11:54:17', '172.18.0.1', 'Incident ID not found: 47'),
(150, 3, 'Fines', 46, 'CREATE_FAILED', 'Attempted to add fine to non-existent incident', '2024-12-16 12:04:12', '172.18.0.1', 'Incident ID: 46 not found'),
(151, 3, 'Fines', 10, 'CREATE', 'New fine created', '2024-12-16 12:05:33', '172.18.0.1', 'Amount: £100\nPoints: 2\nIncident ID: 49'),
(152, 3, 'Fines', 11, 'CREATE', 'New fine created', '2024-12-16 12:06:18', '172.18.0.1', 'Amount: £100\nPoints: 2\nIncident ID: 49'),
(153, 3, 'Offence', 14, 'CREATE', 'New offence created', '2024-12-16 12:16:50', '172.18.0.1', 'Description: stealing\nMax Fine: £500\nMax Points: 5'),
(154, 3, 'Offence', 14, 'DELETE', 'Offence Details:\nID: 14\nDescription: stealing\nMax Fine: £500\nMax Points: 5', '2024-12-16 12:17:03', '172.18.0.1', 'Offence successfully deleted'),
(155, 3, 'Fines', 12, 'CREATE', 'New fine created', '2024-12-16 12:18:34', '172.18.0.1', 'Amount: £3\nPoints: 2\nIncident ID: 49'),
(156, 3, 'Fines', 10, 'DELETE', 'Fine details before deletion:\nAmount: £100\nPoints: 2\nIncident ID: 49', '2024-12-16 12:20:27', '172.18.0.1', 'Fine successfully deleted'),
(157, 3, 'Fines', 10, 'DELETE_FAILED', 'Attempted to delete non-existent fine', '2024-12-16 12:20:30', '172.18.0.1', 'Fine ID: 10 not found'),
(158, 3, 'Fines', 11, 'DELETE', 'Fine details before deletion:\nAmount: £100\nPoints: 2\nIncident ID: 49', '2024-12-16 12:20:33', '172.18.0.1', 'Fine successfully deleted'),
(159, 3, 'Ownership', 687, 'UPDATE', 'Previous owners sharing vehicle: 6,13', '2024-12-16 12:35:40', '172.18.0.1', 'Added Owner ID: 1 to existing vehicle'),
(160, 3, 'OfficerLogin', NULL, 'Login', NULL, '2024-12-16 12:42:56', '172.18.0.1', 'User logged in successfully'),
(161, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: Driving drunk on the wrong side of the road, Vehicle: None, License: ExampleLicence2, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:43:33', '172.18.0.1', 'Changes Made:\nReport changed from: \'Driving drunk on the wrong side of the road\' to: \'DRIVING INTOXICATED IN THE WRONG LANE\'\nVehicle changed from: None to: '),
(162, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: None, License: ExampleLicence2, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:43:52', '172.18.0.1', 'Changes Made:\nVehicle changed from: None to: '),
(163, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: None, License: ExampleLicence2, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:44:02', '172.18.0.1', 'Changes Made:\nVehicle changed from: None to: '),
(164, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: None, License: ExampleLicence2, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:44:25', '172.18.0.1', 'Changes Made:\nVehicle changed from: None to: AT73PT'),
(165, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: ExampleLicence2, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:44:41', '172.18.0.1', 'No changes made'),
(166, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: ExampleLicence2, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:45:01', '172.18.0.1', 'Changes Made:\nPerson License changed from: ExampleLicence2 to: ExampleLicence17'),
(167, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 06:55:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: ExampleLicence17, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:45:17', '172.18.0.1', 'Changes Made:\nTime changed from: 06:55:00 to: 09:59'),
(168, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-12-10, Time: 09:59:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: ExampleLicence17, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:45:37', '172.18.0.1', 'Changes Made:\nDate changed from: 2024-12-10 to: 2024-06-13'),
(169, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-06-13, Time: 09:59:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: ExampleLicence17, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:46:26', '172.18.0.1', 'No changes made'),
(171, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-06-13, Time: 09:59:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: None, License: None, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:53:03', '172.18.0.1', 'Changes Made:\nVehicle changed from: None to: AT73PT\nPerson License changed from: None to: SMITH92LDOFJJ82'),
(172, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-06-13, Time: 09:59:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: SMITH92LDOFJJ82, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:53:13', '172.18.0.1', 'No changes made'),
(173, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-06-13, Time: 09:59:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: SMITH92LDOFJJ82, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:53:33', '172.18.0.1', 'Changes Made:\nRole changed from: \'Driver\' to: \'Water Melon\''),
(174, 3, 'Incident', 49, 'UPDATE', 'Original State - Date: 2024-06-13, Time: 09:59:00, Report: DRIVING INTOXICATED IN THE WRONG LANE, Vehicle: AT73PT, License: SMITH92LDOFJJ82, Role: Water Melon\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 12:53:53', '172.18.0.1', 'Changes Made:\nVehicle changed from: AT73PT to: KD97HH'),
(175, 3, 'Incident', 63, 'CREATE', 'New incident filed', '2024-12-16 12:54:46', '172.18.0.1', 'New Incident Created:\nReport: 12:54 something late at night to do yeahh\nDate: 2024-12-10\nTime: 17:58\nOffence: Speeding\nVehicle: AC37OE\nPerson License: SMITH92LDOFJJ82\nPerson Name: James Smith\nRole: Driver'),
(176, 3, 'Incident', 49, 'DELETE', 'Deleted Incident Details - Report: DRIVING INTOXICATED IN THE WRONG LANE, Date: 2024-06-13, Time: 09:59:00, Role: Water Melon, Vehicle: KD97HH, License: SMITH92LDOFJJ82, Offence: None\nDeleted by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 13:04:08', '172.18.0.1', 'Incident successfully deleted'),
(177, 3, 'Ownership', 688, 'UPDATE', 'Previous owners sharing vehicle: None', '2024-12-16 13:05:17', '172.18.0.1', 'Added Owner ID: 6 to existing vehicle'),
(178, 3, 'Ownership', 690, 'UPDATE_FAILED', 'Current owner verification failed', '2024-12-16 13:05:28', '172.18.0.1', 'Specified current owner not associated with vehicle: Plate BM600X, License BECKE88UPR840F9R'),
(179, 3, 'Ownership', 688, 'UPDATE', 'Previous owners sharing vehicle: 6', '2024-12-16 13:17:26', '172.18.0.1', 'Added Owner ID: 1 to existing vehicle'),
(180, 3, 'People', 0, 'CREATE_FAILED', 'Attempted to create new person', '2024-12-16 13:18:25', '172.18.0.1', 'Failed: License number already exists: ExampleLicence1'),
(181, 3, 'People', 561, 'CREATE', 'New person entry', '2024-12-16 13:20:21', '172.18.0.1', 'Created new person: Name: Jiggle bells, License: ExampleLicence25'),
(182, 3, 'Incident', 64, 'CREATE', 'New incident filed', '2024-12-16 13:22:27', '172.18.0.1', 'New Incident Created:\nReport: The man on the moon on a difficult mission \nDate: 2024-11-28\nTime: 16:21\nOffence: Cycling on pavement\nVehicle: None\nPerson License: SMITH92LDOFJJ82\nPerson Name: James Smith\nRole: Driver'),
(183, 3, 'Offence', 15, 'CREATE', 'New offence created', '2024-12-16 13:36:51', '172.18.0.1', 'Description: Example1\nMax Fine: £1000\nMax Points: 5'),
(184, 3, 'Fines', 15, 'CREATE_FAILED', 'Attempted to add fine to non-existent incident', '2024-12-16 13:37:27', '172.18.0.1', 'Incident ID: 15 not found'),
(185, 3, 'Fines', 13, 'CREATE', 'New fine created', '2024-12-16 13:38:16', '172.18.0.1', 'Amount: £200\nPoints: 3\nIncident ID: 50'),
(186, 3, 'Fines', 14, 'CREATE', 'New fine created', '2024-12-16 13:38:20', '172.18.0.1', 'Amount: £200\nPoints: 3\nIncident ID: 50'),
(187, 3, 'Fines', 13, 'DELETE', 'Fine details before deletion:\nAmount: £200\nPoints: 3\nIncident ID: 50', '2024-12-16 13:44:36', '172.18.0.1', 'Fine successfully deleted'),
(188, 3, 'Fines', 13, 'DELETE_FAILED', 'Attempted to delete non-existent fine', '2024-12-16 13:44:49', '172.18.0.1', 'Fine ID: 13 not found'),
(189, 3, 'Fines', 50, 'CREATE_FAILED', 'Attempted to add duplicate fine', '2024-12-16 13:45:17', '172.18.0.1', 'Duplicate fine detected for Incident ID: 50'),
(190, 3, 'Incident', 65, 'CREATE', 'New incident filed', '2024-12-16 13:47:24', '172.18.0.1', 'New Incident Created:\nReport: The man on the moon on a difficult mission \nDate: 2024-11-28\nTime: 16:21\nOffence: Cycling on pavement\nVehicle: None\nPerson License: SMITH92LDOFJJ82\nPerson Name: James Smith\nRole: Driver'),
(191, 3, 'Incident', 51, 'UPDATE', 'Original State - Date: 2024-12-21, Time: 08:42:00, Report: sdasd, Vehicle: None, License: SULLI00PXGMWS63, Role: Driver\nModified by Officer: Daniels (ID: 3, Role: Administrator)', '2024-12-16 13:47:51', '172.18.0.1', 'Changes Made:\nVehicle changed from: None to: AD38UG');

-- --------------------------------------------------------

--
-- Table structure for table `Fines`
--

CREATE TABLE `Fines` (
  `Fine_ID` int(11) NOT NULL,
  `Fine_Amount` int(11) NOT NULL,
  `Fine_Points` int(11) NOT NULL,
  `Incident_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Fines`
--

INSERT INTO `Fines` (`Fine_ID`, `Fine_Amount`, `Fine_Points`, `Incident_ID`) VALUES
(14, 200, 3, 50);

-- --------------------------------------------------------

--
-- Table structure for table `Incident`
--

CREATE TABLE `Incident` (
  `Incident_ID` int(11) NOT NULL,
  `Vehicle_ID` int(11) DEFAULT NULL,
  `Incident_Date` date NOT NULL,
  `Incident_Time` time DEFAULT NULL,
  `Incident_Report` varchar(500) NOT NULL,
  `Offence_ID` int(11) DEFAULT NULL,
  `Officer_ID` int(11) DEFAULT NULL,
  `People_ID` int(11) DEFAULT NULL,
  `Role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Incident`
--

INSERT INTO `Incident` (`Incident_ID`, `Vehicle_ID`, `Incident_Date`, `Incident_Time`, `Incident_Report`, `Offence_ID`, `Officer_ID`, `People_ID`, `Role`) VALUES
(50, 549, '2024-12-27', '03:30:00', 'fwefwef', 2, 1, 31, 'Driver'),
(51, 511, '2024-12-21', '08:42:00', 'sdasd', 13, 1, 191, 'Driver'),
(61, 569, '2024-12-12', '02:20:00', 'Driving without a licence and armed with a gun', 10, 2, 1, 'Driver'),
(62, 688, '2024-12-04', '03:23:00', 'Driving in the wrong lane ', 10, 2, 1, 'Driver'),
(63, 521, '2024-12-10', '17:58:00', '12:54 something late at night to do yeahh', 1, 3, 1, 'Driver'),
(64, NULL, '2024-11-28', '16:21:00', 'The man on the moon on a difficult mission ', 8, 3, 1, 'Driver'),
(65, NULL, '2024-11-28', '16:21:00', 'The man on the moon on a difficult mission ', 8, 3, 1, 'Driver');

-- --------------------------------------------------------

--
-- Table structure for table `Offence`
--

CREATE TABLE `Offence` (
  `Offence_ID` int(11) NOT NULL,
  `Offence_description` varchar(50) NOT NULL,
  `Offence_maxFine` int(11) NOT NULL,
  `Offence_maxPoints` int(11) NOT NULL,
  `Officer_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Offence`
--

INSERT INTO `Offence` (`Offence_ID`, `Offence_description`, `Offence_maxFine`, `Offence_maxPoints`, `Officer_ID`) VALUES
(1, 'Speeding', 1000, 3, NULL),
(2, 'Speeding on a motorway', 2500, 6, NULL),
(3, 'Seat belt offence', 500, 4, NULL),
(4, 'Illegal parking', 500, 5, NULL),
(5, 'Drink driving', 10000, 11, NULL),
(6, 'Driving without a licence', 10000, 5, NULL),
(7, 'Traffic light offences', 1000, 3, NULL),
(8, 'Cycling on pavement', 500, 3, NULL),
(9, 'Failure to have control of vehicle', 1000, 3, NULL),
(10, 'Dangerous driving', 1000, 11, NULL),
(11, 'Careless driving', 5000, 6, NULL),
(12, 'Dangerous cycling', 2500, 8, NULL),
(13, 'theft', 5000, 6, 3),
(15, 'Example1', 1000, 5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Officer`
--

CREATE TABLE `Officer` (
  `Officer_ID` int(11) NOT NULL,
  `Officer_Name` varchar(50) NOT NULL,
  `Officer_BadgeNumber` varchar(10) NOT NULL,
  `Officer_Rank` varchar(50) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Officer`
--

INSERT INTO `Officer` (`Officer_ID`, `Officer_Name`, `Officer_BadgeNumber`, `Officer_Rank`, `Department`, `Email`, `Phone_Number`) VALUES
(1, 'Jimmy McNulty', 'MC12345', 'Detective', 'Criminal Investigation', 'mcnulty@police.uk', '+441234567890'),
(2, 'Cedric Moreland', 'CM67890', 'Inspector', 'Traffic', 'moreland@police.uk', '+441987654321'),
(3, 'Daniels', 'DN98765', 'Administrator', 'Administration', 'danielsNottingham@police.uk', '+441234567891');

-- --------------------------------------------------------

--
-- Table structure for table `OfficerLogin`
--

CREATE TABLE `OfficerLogin` (
  `Officer_ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Officer_role` varchar(20) DEFAULT 'User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `OfficerLogin`
--

INSERT INTO `OfficerLogin` (`Officer_ID`, `Username`, `Password`, `Officer_role`) VALUES
(1, 'mcnulty', 'plod123', NULL),
(2, 'moreland', 'fuzz42', NULL),
(3, 'daniels', 'copper99', 'Administrator');

-- --------------------------------------------------------

--
-- Table structure for table `ownership`
--

CREATE TABLE `ownership` (
  `People_ID` int(11) NOT NULL,
  `Vehicle_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ownership`
--

INSERT INTO `ownership` (`People_ID`, `Vehicle_ID`) VALUES
(1, 34),
(1, 687),
(1, 688),
(1, 693),
(1, 694),
(2, 14),
(5, 17),
(6, 18),
(6, 687),
(6, 688),
(9, 12),
(9, 16),
(9, 690),
(13, 687),
(41, 692);

-- --------------------------------------------------------

--
-- Table structure for table `People`
--

CREATE TABLE `People` (
  `People_ID` int(11) NOT NULL,
  `People_name` varchar(50) NOT NULL,
  `People_address` varchar(255) DEFAULT NULL,
  `People_licence` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `People`
--

INSERT INTO `People` (`People_ID`, `People_name`, `People_address`, `People_licence`) VALUES
(1, 'James Smith', '23 Barnsdale Road, Leicester', 'SMITH92LDOFJJ82'),
(3, 'John Myers', 'MYERS99JDW8REWL3', 'MYERS99JDW8REWL3'),
(5, 'Terry Brown', '7 Clarke Rd, Nottingham', 'BROWND3PJJ39DLFG'),
(6, 'Mary Adams', '38 Thurman St, Nottingham', 'ADAMSH9O3JRHH107'),
(7, 'Neil Becker', '6 Fairfax Close, Nottingham', 'BECKE88UPR840F9R'),
(8, 'Angela Smith', '30 Avenue Road, Grantham', 'SMITH222LE9FJ5DS'),
(9, 'Xene Medora', '22 House Drive, West Bridgford', 'MEDORH914ANBB223'),
(12, 'Jonathan Thomas', '94 Natasha isle, Wardhaven, CF2 8PX', 'BARBE31WYMSSD12'),
(13, 'Rosemary Willis', 'Studio 81, Webb squares, New Kathrynstad, RH9 4TJ', 'WILLI15LIQPUM13'),
(14, 'Sean Carter', 'Flat 34, Andrew walk, East Ireneberg, L9B 3FD', 'CARTE67TIPDPL47'),
(15, 'Megan Murray', '1 Mary vista, Abdulberg, WC91 7QR', 'MURRA33VTGVYJ21'),
(16, 'Kayleigh Payne', '1 Carter rapid, West Claireshire, DN0E 9XU', 'PAYNE64PQOMIR47'),
(17, 'Marc Wilkinson', '923 Stanley locks, Hussainbury, N96 3PS', 'WILKI11UJRAHZ97'),
(18, 'Jonathan Thomas', 'Flat 51r, Taylor landing, Johnstonton, M65 1AU', 'LEWIS01JNHAMH97'),
(19, 'Louise Nelson', 'Flat 5, Heather cliffs, Danielleland, HS75 0HL', 'NELSO43QGFPBO39'),
(20, 'Martin Martin', '800 Wilkinson lights, New Gerard, MK12 1YD', 'MARTI56HLLSLD68'),
(21, 'Matthew Jackson', '156 Marian isle, East Colin, KY5 9RG', 'JACKS54EZANKG07'),
(22, 'Richard Ellis', 'Studio 8, Richards circle, Toddfort, EX3X 2FE', 'ELLIS22SOHEGP64'),
(23, 'Tracey Jones', '9 Clark spurs, Hobbsville, W6 1FJ', 'JONES52NGTAAD02'),
(24, 'Eileen Smith', '7 Naomi mill, South Tobybury, E6 6RR', 'SMITH14OFJHDA81'),
(25, 'James Baker', '96 Hussain place, Campbellhaven, E8 2TE', 'BAKER59BNJNKO41'),
(26, 'Oliver Morgan', 'Flat 70R, Annette corner, Gilesmouth, SE9 8WY', 'MORGA48EMPWLB37'),
(27, 'Maria Jenkins', '6 Hussain fords, Elliottstad, EN3H 8JS', 'JENKI42ZWCAPB50'),
(28, 'Barry Preston', '62 Hughes inlet, West Kevin, RG0M 5SY', 'PREST58IHCYWW76'),
(29, 'Laura Bradshaw', '873 Fisher islands, Patelburgh, SM7V 5AU', 'BRADS95SMJLXD31'),
(30, 'Martin Wong', '10 Jacqueline fork, South Samuel, PA16 5EH', 'WONG52PQSAZN14'),
(31, 'Albert Smith', '6 Ball roads, Dominictown, S60 8NW', 'SMITH07MCVDMZ86'),
(32, 'Gavin Price', '679 Lynch cliffs, East Dorothyfort, NW38 1EQ', 'PRICE17BTJNPH92'),
(33, 'Catherine Charlton', '6 Smith common, Dixonstad, G91 4DL', 'CHARL15TOKUIJ79'),
(34, 'Arthur Webb', '9 Kenneth harbors, New Megan, CH1 0US', 'WEBB08PYVYEZ44'),
(35, 'Raymond Taylor', '74 Samuel branch, Hutchinsonmouth, TA71 8GD', 'TAYLO45JBTELG15'),
(36, 'Billy Powell', 'Studio 53, Raymond fork, Garyfurt, G6E 7DL', 'POWEL52HGUUXP75'),
(37, 'Shannon Birch', 'Studio 69, Barry burg, Robsonhaven, EH9 1PW', 'BIRCH48OTWFRG84'),
(38, 'Holly Moore', '2 McCarthy cove, Parsonsborough, DL7V 5XT', 'MOORE70LUGLDG48'),
(39, 'Billy Jones', '29 Marshall shoal, North Jeanland, N03 9TZ', 'JONES92XWCMDO81'),
(40, 'Jean Heath', 'Studio 9, Hannah extensions, Greenfurt, BA8R 1AU', 'HEATH38FQGGTJ93'),
(41, 'Alison Bates', '15 Leigh inlet, East Dean, RG2A 7RG', 'BATES84IJLQES74'),
(42, 'Elaine Jones', '20 Beth ridges, New Eileen, SO5M 8ST', 'JONES24XZCNWT25'),
(43, 'Danielle Bishop', '61 Cooper fork, Lake Jeremy, G2 9QS', 'BISHO03IKBGON61'),
(44, 'Tina Jones', 'Studio 4, Max avenue, New Abdulborough, L4 2GG', 'JONES20NJKUII02'),
(45, 'Pamela Baker', 'Flat 30, Hart inlet, East Chloe, TR82 1PF', 'BAKER66PBZOMI45'),
(46, 'Grace Howard', '3 Gould ville, Port Lawrence, HS7B 1BA', 'HOWAR69ELPLVF82'),
(47, 'Ross Wilson', '730 Brown field, Trevorland, M18 5ZZ', 'WILSO89BJWXIT50'),
(48, 'Benjamin Wilkins', 'Flat 24, Blake row, Coxfort, L3U 7HB', 'WILKI21CDNIZC58'),
(49, 'Nicole Payne', 'Flat 59, Edward forge, North Nicoletown, G90 4NG', 'PAYNE62SXPNBF55'),
(50, 'Ashleigh Jones', 'Flat 97n, Smith field, Aimeefurt, W7K 6UL', 'JONES67TOYXPR04'),
(51, 'Nicole Nicholson', 'Flat 34I, Davis mill, Lake Trevormouth, G5 6YL', 'NICHO19IJPDIM25'),
(52, 'Lucy Austin', 'Flat 33T, Franklin ferry, North Dorothychester, PE6 6ZN', 'AUSTI72HORMSC92'),
(53, 'Leslie Holland', 'Flat 00j, Tucker neck, Stephenton, B6U 7HG', 'HOLLA12NDHGJJ27'),
(54, 'Oliver Taylor', '91 Jones park, South Marc, S7 7UR', 'TAYLO96PHZJSQ64'),
(55, 'Trevor Jones', 'Studio 24F, Jennifer track, New Kieran, E6G 2LX', 'JONES69MMXYOO56'),
(56, 'Elaine Gilbert', 'Studio 47, Taylor mission, North Jasonview, B2 7ZY', 'GILBE00NVNSVJ92'),
(57, 'Ian Bowen', 'Flat 75, King roads, Lake Gillianhaven, NP1P 5QW', 'BOWEN57XIQOGN91'),
(58, 'Guy Cook', 'Flat 52j, Bruce extensions, South Jasonmouth, G94 1FT', 'COOK85ZCIWWU45'),
(59, 'Stacey Hughes', 'Flat 90u, Sharon drive, South Joycefurt, LE6M 8YN', 'HUGHE47UUMEOK36'),
(60, 'Kayleigh Archer', '557 Hughes plaza, Amymouth, TS0V 2QQ', 'ARCHE79NISEEV11'),
(61, 'Donna Bradley', 'Flat 58Q, Nicholls forest, Port Graceside, DL63 1NT', 'BRADL92XVREAJ75'),
(62, 'Dominic Hall', '867 Harvey street, North Chelsea, LL94 0RN', 'HALL96NMVODY43'),
(63, 'Charlie Ball', 'Flat 3, Wright street, Kyleburgh, E0J 6YS', 'BALL68HYNQWV77'),
(64, 'Lewis Harding', '659 Williamson creek, Daviesview, L07 6ZR', 'HARDI83YMYWZC72'),
(65, 'Katherine Ahmed', '1 Stewart fields, South Hazel, W4T 8PX', 'AHMED02ZHTLXF00'),
(66, 'Ann Robinson', '56 Atkinson light, Lake Deborahfort, CH83 0ED', 'ROBIN75YJNYXW07'),
(67, 'Lawrence Thorpe', '76 Barber vista, Crossland, G2 5PQ', 'THORP89JFVZZA33'),
(68, 'Tracey Ward', 'Studio 00b, Booth stravenue, South Leighfurt, SS2N 0UB', 'WARD55TQAQFE45'),
(69, 'Clive Henderson', 'Studio 6, Perry station, Watkinsland, N55 1RP', 'HENDE20WMXKFC44'),
(70, 'Charles Barker', '232 Evans alley, North Shane, B71 1LG', 'BARKE03PKMSTQ87'),
(71, 'Owen Johnson', '47 Iain wells, East Terryberg, SA9R 0SD', 'JOHNS37QLPJLD17'),
(72, 'Sylvia Jones', 'Flat 2, Dawson prairie, Willisview, TW7N 3QD', 'JONES19CXZISQ61'),
(73, 'Yvonne Day', 'Flat 7, Perry falls, Port Henrymouth, M37 6DD', 'DAY93VPAXHH51'),
(74, 'Mohammed Bond', '608 Louise port, Brendaton, L3K 1LJ', 'BOND57KZNLVV72'),
(75, 'Henry Hayes', 'Flat 79, Lewis lodge, Benberg, E97 9ZH', 'HAYES27QXCMJY38'),
(76, 'Sam Andrews', 'Flat 65q, Freeman bypass, West Ben, L85 9NR', 'ANDRE94OQXCEI77'),
(77, 'Dylan Smith', '901 Myers loaf, West Juliastad, SK9 1YP', 'SMITH62UUDAPU71'),
(78, 'Geoffrey Fuller', 'Flat 96, Donnelly rest, Alexandershire, G2A 7JF', 'FULLE81VFXOHT87'),
(79, 'Trevor Todd', 'Studio 51s, Adrian isle, Youngfort, NP5 1EW', 'TODD43JTYDIL33'),
(80, 'Conor Wilson', '468 Davey haven, Juliashire, B17 9YH', 'WILSO95NCIBYV78'),
(81, 'Jane Walker', '7 Wilson lights, West Zoe, E25 9QN', 'WALKE16VMNGRG72'),
(82, 'Jonathan Thomas', '22 Shaw well, New Antony, W17 6JA', 'THOMA72IWAGIL19'),
(83, 'Cheryl Thompson', '306 Daly green, Howardburgh, M9 2YE', 'THOMP19FPMGVW82'),
(84, 'Roger Rose', 'Flat 2, Stewart tunnel, Lake Russell, B5S 6YB', 'ROSE69ETPDWY91'),
(85, 'John Allen', '52 McDonald plains, South Stuart, W64 2HE', 'ALLEN66SGJUCQ54'),
(86, 'Lorraine Ellis', 'Studio 90, Campbell trail, West Phillipshire, L84 8QU', 'ELLIS28BQIILX19'),
(87, 'Duncan Storey', 'Flat 6, Naylor key, Smithstad, G3 9TN', 'STORE10DDMXOM25'),
(88, 'Karen Hussain', '51 Smith path, Port Robin, B1 3HD', 'HUSSA82VKBENO57'),
(89, 'Ben Barnett', '730 Ward dale, Taylortown, G7T 2PQ', 'BARNE15IHQQIQ63'),
(90, 'Alison Swift', '2 Lynda street, Hughfort, IV0V 3NJ', 'SWIFT10WMTLIC53'),
(91, 'Beth Newman', '7 Rosie estates, West Jamie, EX66 7QT', 'NEWMA79OCOOOW48'),
(92, 'Molly Evans', '69 O\'Connor highway, Hopkinsmouth, IV5E 9PW', 'EVANS55BQNBXK45'),
(93, 'Henry Hutchinson', 'Flat 36w, Molly hills, Adamston, E0 6QQ', 'HUTCH36TARNTZ03'),
(94, 'Catherine Phillips', 'Flat 30G, Morley drive, North Gregorytown, G2S 5HJ', 'PHILL26ICYGEH68'),
(95, 'Dylan Sanders', '96 Parsons place, Hillmouth, SE4 0TR', 'SANDE17FBZSXB57'),
(96, 'Rita Wright', '5 Pratt ferry, Philliptown, L96 7NQ', 'WRIGH48MREPOW76'),
(97, 'Scott Jones', 'Studio 96, Emma isle, Greenwoodtown, B8 7SQ', 'JONES54JBTVLM17'),
(98, 'Zoe Cook', 'Flat 8, Leslie forge, Kingfort, WV06 1YS', 'COOK38JEBDNK54'),
(99, 'June Edwards', '20 Nicholson common, North Joanne, G7 1YS', 'EDWAR88SIQIGF08'),
(100, 'Yvonne Duffy', '8 Chan motorway, North Pamela, DL3W 9SR', 'DUFFY61AUTOQQ03'),
(101, 'Elliot Brown', '467 Dennis crest, Port Marcburgh, SG19 5PB', 'BROWN69SDOSGE67'),
(102, 'Lydia Black', '12 Goddard gardens, Harveychester, SW6A 2RB', 'BLACK04UCAJAN65'),
(103, 'Gordon James', '8 Timothy glens, Jessicashire, BH9 3RH', 'JAMES88DKSENM33'),
(104, 'Sylvia Price', 'Flat 73, Khan river, East Luke, WV9B 9ZD', 'PRICE64XWOMXV29'),
(105, 'Pauline Turnbull', 'Studio 04, Kate island, Clarkestad, CF92 8GR', 'TURNB67ETIBYO10'),
(106, 'Jean Roberts', 'Flat 1, Norman shoal, Lake Janetmouth, N47 5SQ', 'ROBER91EBVJKI94'),
(107, 'Ross Thompson', 'Studio 82O, Davey freeway, Port Stephenbury, W1 7NT', 'THOMP31FWIVFP52'),
(108, 'Oliver Watson', 'Studio 38, Greenwood highway, Henryside, N0 6QH', 'WATSO57UOJIWA40'),
(109, 'Jean Barton', 'Studio 2, Holly ford, Janetshire, PL0 8EG', 'BARTO65HWQLYI42'),
(110, 'Jean Palmer', 'Flat 91W, Pritchard way, West Suzanne, KT8 7DH', 'PALME51WRUPEB60'),
(111, 'Mohammad Edwards', '1 Stuart ferry, East Jonathan, WS6 8EE', 'EDWAR80MBPSWW71'),
(112, 'Ashleigh Gregory', '2 Fletcher club, Webstermouth, W0 2EH', 'GREGO58EEKNMK00'),
(113, 'Cameron Robson', 'Studio 75A, Benson stravenue, East Andrew, GU84 9GN', 'ROBSO91GBNQNW24'),
(114, 'Jake Talbot', 'Flat 2, Glenn valley, North Lindatown, L72 7BA', 'TALBO69BCRXFW66'),
(115, 'Eric Barnes', 'Flat 21P, Ben bypass, Bellhaven, M0 5ZP', 'BARNE38WBIXEY98'),
(116, 'Patricia Taylor', '2 Chloe summit, Juliaberg, KY60 4XB', 'TAYLO78NWNEMK77'),
(117, 'Benjamin Smith', '9 Leigh neck, Rosemarymouth, SP0 5XJ', 'SMITH36VZHWUA90'),
(118, 'Tom Williams', 'Flat 94h, Amelia crossing, South Marcfort, B4 9JX', 'WILLI82UBFVYM08'),
(119, 'Julia Smith', '91 Jamie union, East Martynton, M5S 4BQ', 'SMITH62VLKBWF59'),
(120, 'Irene Patterson', 'Flat 09, Willis fort, New Eric, M63 9JW', 'PATTE61BCDFOH23'),
(121, 'Terence Griffin', '78 McCarthy manor, South Rita, L9F 4YW', 'GRIFF37DAYIIE81'),
(122, 'Conor Lewis', 'Studio 45, Bentley stream, New Aimeeburgh, E8K 6HS', 'LEWIS93TASZFC64'),
(123, 'Thomas Griffiths', 'Flat 35, Shaw passage, Staceyborough, G09 9DD', 'GRIFF29DJRBFM12'),
(124, 'Ashleigh Short', '6 Bryan drives, North Charles, IM8 2YU', 'SHORT00MGOXYA60'),
(125, 'Joe Bell', '229 Luke view, Stephensonbury, G8 5LW', 'BELL10PYARNU83'),
(126, 'Leigh Williams', '36 Steele crossing, North Duncan, RM73 2AU', 'WILLI32VHCIEQ77'),
(127, 'Malcolm Bryant', 'Studio 49, Patricia trace, Elliotville, LE43 5WW', 'BRYAN57ZXAZUB16'),
(128, 'Rebecca Clarke', '960 Hunt village, West Charlesview, HX2R 1JJ', 'CLARK45MBHYFR99'),
(129, 'Alan Edwards', '675 Scott shores, South Davidmouth, HG1W 5XR', 'EDWAR78IAXRKU04'),
(130, 'Lewis Pritchard', 'Studio 63d, Pauline throughway, New Waynemouth, L54 1ZR', 'PRITC76CEKWBW25'),
(131, 'Mandy Watson', 'Flat 27A, Lewis ranch, Amandaberg, S8K 7TE', 'WATSO82YRIDWD62'),
(132, 'Leanne Andrews', 'Studio 32, Lane mall, Toddfurt, B72 1TP', 'ANDRE04CVRLOA15'),
(133, 'Ann Hawkins', '9 Naomi freeway, Foxburgh, SR6 3BU', 'HAWKI62ATIOXH19'),
(134, 'Kayleigh Lowe', '46 Cooper corners, Lake Owenside, BN9E 5PD', 'LOWE62IFDAEJ77'),
(135, 'Katie King', 'Studio 7, Wendy shoals, Barkerland, S4 4ER', 'KING81FOSXQG20'),
(136, 'Kyle Chamberlain', '5 Joshua walks, New Scott, L14 4EQ', 'CHAMB23UMHWJO05'),
(137, 'Jean Dale', 'Flat 6, Joel lodge, Adamsbury, LL56 2XJ', 'DALE30CZAWDJ92'),
(138, 'Joel Webb', '160 Lynch mountain, Nicolaton, S55 6TA', 'WEBB56ZRPLTC52'),
(139, 'Carole Ward', 'Studio 4, Cheryl parks, Lyndaburgh, W36 2TU', 'WARD36JUHIAT89'),
(140, 'Gillian Taylor', 'Studio 5, Simon garden, Lake Harrystad, NE90 6QS', 'TAYLO51FULOOO16'),
(141, 'Jane Kirby', '006 Charles way, New Nathanview, WN89 9ZN', 'KIRBY50NDLTVE63'),
(142, 'Abbie Ward', '080 Ahmed prairie, Johnview, M6 0FR', 'WARD67FRKJLP12'),
(143, 'Eleanor Hope', '5 Walker dale, North Lisaport, N71 0PG', 'HOPE72ZOYAGZ26'),
(144, 'Robert O\'Connor', 'Flat 88W, Doyle grove, Jeffreyfort, TW3 2ZY', 'O\'CON53GOZBCK75'),
(145, 'Marion Moss', '1 Jeffrey mountain, Lake Emilyview, KA1R 0TB', 'MOSS42GPCBJQ48'),
(146, 'Allan Mitchell', 'Flat 52, Edward creek, Watsonchester, B9 1GU', 'MITCH66GULUTB06'),
(147, 'Katherine Stevenson', 'Flat 24, Brown summit, Whitehaven, NW80 3QE', 'STEVE75BTCVZL50'),
(148, 'Carole Walker', 'Flat 34t, Max locks, Lake Luke, SG24 2AS', 'WALKE45HODWEQ30'),
(149, 'Valerie Kirby', '64 Ruth circles, Port Edwardport, DY8Y 5GU', 'KIRBY61EYXKLF50'),
(150, 'Raymond Moore', '6 Jane cliffs, Paigeberg, L01 3XD', 'MOORE53PLMNHB25'),
(151, 'Lorraine Pearson', 'Flat 79, Brown wall, Kayview, M9 8HX', 'PEARS44BRBBUZ76'),
(152, 'Catherine Harper', '10 Olivia ridge, Guymouth, WV4H 0HF', 'HARPE33ZWWNDD31'),
(153, 'Stewart King', '555 Peter isle, Stephaniehaven, L92 9FB', 'KING36FUBPRR86'),
(154, 'Margaret Harding', 'Studio 76, Jones overpass, Douglashaven, OX3 4GA', 'HARDI39JEOHLF53'),
(155, 'Howard Reed', 'Flat 37, Yates shoal, Connorfort, PL1R 4NZ', 'REED54FYUQXX10'),
(156, 'Sarah Moran', 'Flat 8, Toby creek, Whitechester, HG46 2QW', 'MORAN52CJIHBO79'),
(157, 'Donna Palmer', '97 Atkins cliffs, Cartershire, N9E 9UE', 'PALME76RBSEER32'),
(158, 'Abdul Richards', '9 Leigh meadow, North Lewis, N15 9SZ', 'RICHA27YJDMED51'),
(159, 'Sarah Holden', 'Studio 35v, Ward cliffs, South Williammouth, KT95 6UP', 'HOLDE63URSFBH83'),
(160, 'Sarah Jones', '7 Patricia stream, West June, S2 3YD', 'JONES71JGTSWU88'),
(161, 'Adrian Evans', 'Studio 0, Sullivan lakes, South Lewis, CT9 4DZ', 'EVANS80CGXOFJ18'),
(162, 'Lynda Smith', '5 Ferguson ports, Lake Brandonburgh, M1 2SD', 'SMITH75NGCILJ65'),
(163, 'Alison Morgan', '3 Davies cape, Lake Mitchellfurt, L76 3NY', 'MORGA09ZPBJRR33'),
(164, 'Fiona Harrison', 'Flat 61H, Wendy isle, Leehaven, GL61 7TG', 'HARRI95XUZUPQ86'),
(165, 'Melanie Skinner', '59 Hilary summit, Austinton, HD76 9YJ', 'SKINN77VITFEZ73'),
(166, 'Eileen Ward', 'Flat 1, Bethany center, South Vincent, L7E 1WW', 'WARD76DMDBKG59'),
(167, 'Hannah Parkes', '662 Danielle locks, North Craigstad, HP0X 8XP', 'PARKE08YYMZAS84'),
(168, 'Deborah Anderson', '740 Elliot spur, Alextown, E8 8XA', 'ANDER38CXGFXY10'),
(169, 'Jacob Bell', '221 Alexandra ramp, Hollieshire, G24 1WX', 'BELL08TZTYQE32'),
(170, 'Marion Rees', '569 Wright via, West Patrick, SK7 9WA', 'REES93EQLSWX74'),
(171, 'Shirley Lewis', 'Flat 90, Nicole oval, Lake Julian, S3 3QX', 'LEWIS84AXZWDM81'),
(172, 'Norman Patel', '85 Rita square, Sharpport, RG4V 9AD', 'PATEL46KEOKUT71'),
(173, 'Colin O\'Brien', '768 Stephen drive, Mossstad, TA8 4WX', 'O\'BRI45SWIRVD36'),
(174, 'Clifford Vincent', 'Studio 75, Mitchell neck, Joshuaview, YO46 8GW', 'VINCE20ZGYCSV82'),
(175, 'Jacqueline Coleman', 'Studio 39, Freeman ferry, South Alexander, M61 9QQ', 'COLEM82QUQEER11'),
(176, 'Clare Martin', '394 Daniel square, Port Lorraine, WN5P 0LX', 'MARTI92VRGNWN48'),
(177, 'Dale Mitchell', 'Flat 3, Warner centers, North Davidtown, BN7 1XE', 'MITCH72EFXNZI36'),
(178, 'Russell Walker', '2 Zoe junctions, Ronaldmouth, W60 7DT', 'WALKE32JUIOFI01'),
(179, 'Bruce Nelson', '0 Parker corners, Port Neilfort, PA5 0ZF', 'NELSO88OEBZHD35'),
(180, 'Jeremy Cunningham', 'Flat 3, Lisa lodge, Whitefurt, BL8V 4AQ', 'CUNNI45DQZYVY85'),
(181, 'Colin Berry', '98 Webb mountain, East Lucyfort, B8 3ZL', 'BERRY09KIJYAX80'),
(182, 'Denise Williams', '497 Geraldine lakes, Leesberg, W5 2AL', 'WILLI69FBJJRC78'),
(183, 'Jessica Nicholson', '502 Jeffrey underpass, Joyceland, N29 8BS', 'NICHO32OCNCYP70'),
(184, 'Paul Warren', 'Studio 4, Morris crossing, Philipmouth, SW1 6HZ', 'WARRE04LETAKM94'),
(185, 'Tracey Vincent', 'Flat 8, Max mill, New Royshire, W51 6AG', 'VINCE37FQYNXY72'),
(186, 'Lesley Rhodes', 'Flat 36M, Hayes points, East Jonathan, WD7 7AZ', 'RHODE58VUEKVC36'),
(187, 'Hannah Chapman', '56 Stewart pass, Port Lydiabury, W9D 6NZ', 'CHAPM73RNUVHU42'),
(188, 'Francesca Parker', 'Flat 25o, King plains, Hussainberg, KT4X 6ZQ', 'PARKE40DNZKGN73'),
(189, 'Matthew Lees', 'Flat 5, Savage mills, Khanville, HR9P 7QS', 'LEES19WZFCAR77'),
(190, 'Eileen Ball', '46 Cox plains, Christineland, S04 9US', 'BALL47QDHCHU15'),
(191, 'Alex Sullivan', 'Studio 27f, Robinson stream, Andreaborough, S7H 4YF', 'SULLI00PXGMWS63'),
(192, 'Toby Johnson', 'Studio 26N, Moore springs, Paulineview, N43 5HP', 'JOHNS20ANXKKH19'),
(193, 'Max Banks', '222 Jones skyway, Johnstad, UB32 2LE', 'BANKS62OHUCSC29'),
(194, 'Howard Jones', 'Studio 9, Stewart via, Allenside, SY1M 4BE', 'JONES54RPMXBB07'),
(195, 'Gillian Thomas', 'Flat 26, Price fields, Port Kirstymouth, G05 3QP', 'THOMA37HPATVT64'),
(196, 'Bethany Powell', '9 Paige oval, South Julia, B7A 1SE', 'POWEL45TIUDSR42'),
(197, 'Richard Perry', 'Flat 99v, Pritchard coves, Dickinsonborough, BR2 4NZ', 'PERRY50MZLBGF80'),
(198, 'Danny Bates', 'Flat 71, Naylor stravenue, Karenstad, BN66 8YT', 'BATES48ZGXAWA85'),
(199, 'Paige Watkins', '985 Ahmed springs, East Josephineburgh, LL49 2WF', 'WATKI61GSQJWK32'),
(200, 'Joe Austin', 'Studio 94B, Debra glens, Chanside, SK61 9GL', 'AUSTI07GKUHPY20'),
(201, 'Debra Andrews', '06 Yvonne plaza, Williamsfurt, M4G 0SD', 'ANDRE04OFBBYJ59'),
(202, 'Terry Armstrong', '94 Roger estates, East Joeland, B74 4UZ', 'ARMST79OIIIOH07'),
(203, 'Jordan Bevan', 'Studio 99, Bennett camp, Jonesberg, DA93 0JL', 'BEVAN82ZXSQMG29'),
(204, 'Alex Miah', '40 Kirsty spurs, Russellhaven, PH2X 7NP', 'MIAH96OKZMEE07'),
(205, 'Bethan Smith', 'Flat 8, Diana cliffs, Ashtonbury, CO8 4XZ', 'SMITH52YWHHRF73'),
(206, 'Katie Noble', 'Studio 56y, Glenn squares, Hiltonton, E7E 5FH', 'NOBLE51XRHFEZ60'),
(207, 'Tracey Parker', '24 McKenzie road, Tobyview, L1 4SP', 'PARKE47LLOBPC49'),
(208, 'Julian Lucas', '7 Cox port, Kenttown, PR9 6TW', 'LUCAS97CPKQTW70'),
(209, 'Bradley Robinson', 'Flat 98, Hill lodge, New Katie, WN3P 4DD', 'ROBIN76NTRJBV02'),
(210, 'Claire Spencer', 'Studio 5, Marie street, South Tinachester, SR6B 0QJ', 'SPENC70TNUFAL22'),
(211, 'Janice Carter', '40 Patricia squares, Bradleyside, CF6R 9PQ', 'CARTE29ZRGVZR86'),
(212, 'June Page', '41 Stephanie bridge, New Marion, W3U 3JJ', 'PAGE86HRIPUL49'),
(213, 'Francesca Henry', '59 Robinson freeway, Frostburgh, SM0 2AR', 'HENRY76NTGLQG48'),
(214, 'Maurice Atkinson', 'Studio 3, Chan brook, Gavinfort, LE4 6YS', 'ATKIN28XESNEO62'),
(215, 'Shane Booth', 'Studio 34k, Peter mission, Thomasfort, WD6E 3WT', 'BOOTH99JFNQIV61'),
(216, 'Denise Jones', '1 Dale cape, New Scottland, G1D 1YH', 'JONES83ERHODA30'),
(217, 'Simon Spencer', 'Flat 21, Lisa mills, Lake Gregory, CT42 3HD', 'SPENC66VFJHFA26'),
(218, 'Amelia Jones', 'Flat 4, Whittaker forest, Bensontown, WA6Y 0BT', 'JONES20BUHYRJ68'),
(219, 'Josephine Nicholson', 'Studio 05n, Pope hill, Robertmouth, KW0B 0ZW', 'NICHO70OMVJKK04'),
(220, 'Douglas Johnson', '67 Parkinson forge, Port Geraldineberg, CA2N 5WE', 'JOHNS71VJFYBP36'),
(221, 'Victoria Fry', '9 Chelsea bypass, Michellechester, CF4 6GW', 'FRY45PHOCNR90'),
(222, 'Amy Higgins', '55 Marshall green, North Aliceside, WV61 2NG', 'HIGGI68ZCFQTO96'),
(223, 'Jasmine Gibson', '279 Kim divide, South Jodie, S7 2JH', 'GIBSO89ZUSOSN99'),
(224, 'Lindsey Patel', 'Studio 93, Roberts orchard, Dorothyshire, WN53 6FU', 'PATEL07KYUPWN20'),
(225, 'Jeremy Nicholls', 'Flat 83c, Thomas fork, East Sallyshire, M73 8AR', 'NICHO31GSZMXO67'),
(226, 'Rebecca Walters', '9 Bell avenue, New Matthew, SS57 4RX', 'WALTE92BGOYEP42'),
(227, 'Gemma Hughes', '208 Jones mills, East Alanburgh, TW17 7BP', 'HUGHE02ILKBAQ39'),
(228, 'Carole Ward', '9 Nicole underpass, Lake Debraborough, HP94 4FD', 'WARD61YUJXKT68'),
(229, 'Anne Lee', 'Studio 76, Charlton street, Harrisonfort, N3 4XW', 'LEE90LUTRKL33'),
(230, 'Rosemary Parry', '1 Gibbs route, Lake Gregory, L1 9JU', 'PARRY47NDCHXZ40'),
(231, 'Simon Green', '84 Smith manor, Chelseashire, TW8 4BZ', 'GREEN96JDQLXY36'),
(232, 'Suzanne Collins', '43 Marie roads, Port Donnahaven, RM9 7NS', 'COLLI50KTQGRU57'),
(233, 'Holly Phillips', '9 Myers summit, Richardsmouth, B66 5BJ', 'PHILL67IHDAMH00'),
(234, 'Norman Mitchell', 'Studio 7, Maureen motorway, Port Katy, M92 5FQ', 'MITCH12MSVXJY63'),
(235, 'Jessica Perry', 'Studio 0, Khan tunnel, Wattsstad, HX4N 0UQ', 'PERRY16RTKMFU50'),
(236, 'Timothy Walsh', 'Studio 46y, Tom lights, South Jeremy, EH06 2EY', 'WALSH30FIOEFL68'),
(237, 'Francesca Jones', '7 Lewis causeway, Clarkechester, L32 2XL', 'JONES39SQSFCY90'),
(238, 'Lynne Pearson', 'Studio 07V, Woods square, Amberborough, L97 2SY', 'PEARS15PWMCVE62'),
(239, 'James Rose', '7 Gregory villages, Port Ianfort, CF0R 8AE', 'ROSE76GFHWOB44'),
(240, 'Vincent Clarke', 'Studio 81G, Godfrey dam, Liamport, E22 8BD', 'CLARK78KSEUGJ24'),
(241, 'Eric Williams', '550 Eric rue, Gerardtown, HA17 0TP', 'WILLI74BJDVYD50'),
(242, 'Beth Atkinson', '901 Brown inlet, East Michelle, TQ6W 6AA', 'ATKIN12NMDROT72'),
(243, 'Caroline Brown', '54 Henry extensions, Harryport, W2 0UQ', 'BROWN41EAPCDX81'),
(244, 'Tracy Morris', 'Studio 82B, Conor oval, South Guyton, ML2E 0HG', 'MORRI00QKJDAI47'),
(245, 'Naomi Davis', 'Flat 5, Shaw rest, New Markchester, SG9W 6ZF', 'DAVIS65AYIQYR19'),
(246, 'Valerie Burke', '10 Davey stream, East Shannon, L27 7UW', 'BURKE47JKPIGG23'),
(247, 'Bernard Saunders', 'Studio 83, Hudson union, Jacksonfurt, BD9P 5GX', 'SAUND11ZJWIZN17'),
(248, 'Ashleigh Scott', '9 Hartley groves, Lawrencemouth, W1 0DH', 'SCOTT60BEBAUI88'),
(249, 'Katie Coleman', '4 Grace glen, New Emmaland, N5J 7DA', 'COLEM21JKROZC27'),
(250, 'Charles Day', 'Studio 03, Ann brooks, Hancockton, SY3 8FR', 'DAY01SQKQYQ41'),
(251, 'Kathryn Henderson', '882 Justin island, New Mariehaven, L7B 0QX', 'HENDE60QQFXCC06'),
(252, 'Hazel Bailey', 'Flat 0, Arthur grove, South Victoria, PH6P 5RN', 'BAILE56VCQXCN78'),
(253, 'Donald Glover', '549 Suzanne knoll, Whitetown, S84 0LA', 'GLOVE10LLYIIA22'),
(254, 'Dorothy Griffiths', 'Studio 02g, West islands, Vanessashire, EC56 9TL', 'GRIFF51UTIZDP14'),
(255, 'Victor Connolly', '6 Ann port, Gracefort, SA90 4LP', 'CONNO19DITVAY49'),
(256, 'Lucy Cooper', '69 Kathleen crest, Lake Dawnhaven, HX0H 0RQ', 'COOPE63IGNYNP33'),
(257, 'Sharon Matthews', 'Studio 39X, Judith points, Vanessaport, CB80 5BF', 'MATTH42UBJWTG97'),
(258, 'Gemma Wilkinson', '14 Caroline mount, West Carolyn, SN5 7TH', 'WILKI44DROPDR56'),
(259, 'Marc Ball', '5 Justin fall, Bondfort, W2 2GB', 'BALL66EXGFJZ23'),
(260, 'Cameron Williams', '82 Martin street, Lake Frances, N39 2LL', 'WILLI70STQLTP46'),
(261, 'Ryan Ford', 'Flat 75D, Farmer mews, West Steven, N0K 0DE', 'FORD78BITAMT24'),
(262, 'Maurice Williams', '89 Baker park, Brooksport, B68 6TL', 'WILLI33AMETJI45'),
(263, 'Shaun Adams', '865 Edwards center, East Kathrynfurt, L11 7JY', 'ADAMS01JTZUIB47'),
(264, 'Nathan Johnson', 'Studio 7, Willis station, South Donald, E7D 2LP', 'JOHNS27NWJSWD96'),
(265, 'Alexander Carr', '49 Marsden union, Port Garethport, M8 6PN', 'CARR96XOICDO92'),
(266, 'Kelly Walsh', 'Flat 4, Poole lane, New Stephen, IP46 7TJ', 'WALSH03ZKONZM83'),
(267, 'Yvonne Rogers', 'Studio 46, Bailey mission, North Lynneshire, LL13 2HB', 'ROGER54CYNIDJ90'),
(268, 'Anne Archer', 'Flat 90d, Phillips mountains, Curtiston, CW5 0TF', 'ARCHE72XCEHLX41'),
(269, 'Charlotte Talbot', '3 Carol pine, Port Carol, S2 9HJ', 'TALBO51EEZGRZ05'),
(270, 'Clifford Singh', '321 Edward terrace, North Thomas, ME6 1ZZ', 'SINGH24YSWFRQ02'),
(271, 'Raymond Poole', 'Flat 4, Harry ferry, Jonesfort, FY84 4HY', 'POOLE66JXHLDX77'),
(272, 'Heather Vincent', '517 Gibson fork, Lake Tracey, HS8V 9EY', 'VINCE25NBUIKG46'),
(273, 'Amelia Morgan', '180 Rogers squares, West Joelmouth, CB0 3YH', 'MORGA92GJKUUY14'),
(274, 'Joanne Kerr', '600 Butler estates, West Helen, MK1N 9GA', 'KERR10XKAVSA56'),
(275, 'Natalie Wilkinson', 'Studio 0, Harriet keys, Smithport, N7 7BD', 'WILKI49OHWIHN51'),
(276, 'Nicole Bailey', '244 Beverley wall, Edwardsstad, DG8A 2HU', 'BAILE35FJKNNJ78'),
(277, 'Patricia Bishop', '2 Janice street, East Danielle, G0 9NB', 'BISHO19EZNGQU78'),
(278, 'Dylan Hawkins', '0 Bryant plaza, Port Victoriamouth, G2 6QB', 'HAWKI70BBYMKM52'),
(279, 'Dawn Day', '7 Evans mission, New Mandy, B2C 7DE', 'DAY15GSXHGK70'),
(280, 'Philip Robertson', 'Flat 35, Morgan place, West Damienbury, DN4B 2SH', 'ROBER58UWOVEM99'),
(281, 'Leanne Russell', 'Studio 7, Graham plaza, South Alexandermouth, S15 9AS', 'RUSSE72VNSSEL31'),
(282, 'Jacob Lewis', '131 Joan summit, Haynesside, M8 9WU', 'LEWIS94NNFVTX43'),
(283, 'Lawrence Burgess', '45 Rita fields, Leonhaven, N00 2YF', 'BURGE46TKMDYU44'),
(284, 'Sara Carter', 'Flat 99, Ian island, New Thomas, LL5R 4DU', 'CARTE54YMNMLR90'),
(285, 'Frederick Graham', 'Studio 87r, Sutton oval, South Sarah, SM4V 6QQ', 'GRAHA23NPNTPM23'),
(286, 'Dennis Tyler', 'Studio 92, Turner junction, South Declan, W0 3BW', 'TYLER79EIWQIW99'),
(287, 'Jodie Porter', 'Flat 7, Nathan mountains, Harttown, RG3V 6HU', 'PORTE97OFXNUI43'),
(288, 'Kate Holden', 'Studio 91L, Smith valley, Mitchellside, PO44 2RN', 'HOLDE69UPGPMK73'),
(289, 'Malcolm Parkinson', 'Studio 2, Sandra coves, Mollyport, DG0 2WD', 'PARKI07ILSZKZ57'),
(290, 'Christine Richards', 'Flat 1, Brian radial, Iainmouth, SS4 7FF', 'RICHA38IMOAFS18'),
(291, 'Gregory Patel', '6 Luke oval, North Allanfurt, CM6 2RP', 'PATEL05LTXTLO26'),
(292, 'Denise Fitzgerald', '628 Lesley burgs, Geoffreyfort, G1 9ZN', 'FITZG75ZEIBHA57'),
(293, 'Helen Taylor', 'Studio 91, Carol stravenue, South Karen, SY9H 2FP', 'TAYLO48DGGLMG38'),
(294, 'Sharon Owens', 'Studio 9, Yvonne points, Nigelstad, NP0Y 4DZ', 'OWENS72IPSSAI10'),
(295, 'Henry Schofield', '53 Payne extension, Hansonside, G5 9PL', 'SCHOF58LKGHOE28'),
(296, 'Gemma Burgess', 'Flat 1, Mark valley, Franktown, IP0 0DT', 'BURGE71HNDYQE55'),
(297, 'Luke Thomson', 'Studio 37, Evans crossing, North Angela, N21 6PX', 'THOMS71FQEBQM68'),
(298, 'Georgina Jones', 'Flat 59, Charlotte circle, New Neilfurt, M63 5TB', 'JONES13GKYMSS91'),
(299, 'Marie Riley', '7 Ferguson lake, Port Jayborough, DD21 6ZZ', 'RILEY89DZRPBC91'),
(300, 'Amanda Price', '3 Taylor squares, Stephaniebury, FY0E 8QN', 'PRICE54AXCBBS38'),
(301, 'Dale Nash', 'Studio 98p, Morris shoal, Leannefort, BH2 7QJ', 'NASH40IBBLHA51'),
(302, 'Jacqueline Marshall', '45 Richardson walks, Kellyport, WA1A 4JE', 'MARSH17YNBSVP26'),
(303, 'Carly Jennings', 'Flat 18, Rosemary trail, Heathfort, N65 4ZJ', 'JENNI39QBIZJY13'),
(304, 'Nicole Robson', 'Studio 7, Ball mall, Debraburgh, L3 6FB', 'ROBSO88FNWIUQ54'),
(305, 'Jane Powell', '7 Geoffrey flats, Wallismouth, SK09 8DH', 'POWEL42WRKPME35'),
(306, 'John Hudson', '6 Rosemary walk, New Rita, B56 4ND', 'HUDSO30PSFANA66'),
(307, 'Shirley Warren', '20 Liam corner, North Francis, NW97 9QN', 'WARRE32KSKHEM23'),
(308, 'Gillian Browne', '591 Georgia way, Lake Christineton, WV69 6TD', 'BROWN75TZOGYN83'),
(309, 'Diane Shaw', 'Flat 0, Johnson circle, Kennedyland, TR91 1UY', 'SHAW75IJAVNL36'),
(310, 'Elaine Russell', 'Flat 4, Grace forest, New Jason, WV7E 0YB', 'RUSSE55QTPDJH37'),
(311, 'Janet Smith', '65 Judith road, West Kieranchester, CM63 2BS', 'SMITH38DEGTHY19'),
(312, 'Heather Wood', '89 Wheeler meadow, Port Darrenview, SL20 6LA', 'WOOD81ZWQYVQ48'),
(313, 'Wayne Berry', 'Flat 6, Thomas radial, Huntshire, B6 1GN', 'BERRY09RSKWDU12'),
(314, 'Rosemary Carter', '1 Joyce river, Marionside, DY9W 4ZL', 'CARTE28CUXHAB75'),
(315, 'Kelly White', '19 Thompson crossroad, Kennethhaven, S84 2QT', 'WHITE97WHMQXC31'),
(316, 'Carly Hamilton', '66 Wood fork, Port Lynnemouth, PH7 7TU', 'HAMIL78KYYIXR70'),
(317, 'Grace Kay', '815 Donald orchard, Scotthaven, BT9 4NZ', 'KAY31MNIBBV84'),
(318, 'Guy Evans', 'Flat 00v, Allen brooks, South Grahamville, HG5Y 2DT', 'EVANS30POPJJR22'),
(319, 'Louise Evans', '6 Denis port, West Glenntown, BS3W 3EW', 'EVANS55MDUZLH90'),
(320, 'Reece Cooke', 'Studio 50, Max orchard, East Wayne, HP6Y 9BS', 'COOKE04YMUGFT72'),
(321, 'Iain Mills', '03 Lindsey parkway, North Holly, G6A 5DJ', 'MILLS07YYISMI23'),
(322, 'Dorothy Edwards', 'Flat 07P, Henry port, New Janethaven, BS2 3FZ', 'EDWAR56HDCYYG44'),
(323, 'Callum Barnes', 'Studio 2, Peter curve, West Jamie, KY4A 5ER', 'BARNE38QQGGNQ68'),
(324, 'Donna Robson', '913 Davey pike, Dalyberg, DG6 6LJ', 'ROBSO82FRDJAM10'),
(325, 'Adrian Davis', '757 Hugh path, West Jayne, HX9V 9DJ', 'DAVIS97NXLRDG48'),
(326, 'Jenna Mills', 'Studio 28j, Stokes way, Smithchester, N1 4LL', 'MILLS32VOPZRI80'),
(327, 'Pauline White', 'Studio 27y, Jennifer locks, North Eileen, M2G 9TH', 'WHITE84CURBLS34'),
(328, 'Melanie Scott', '269 Stokes unions, Garyton, LE4A 8HR', 'SCOTT40GKWYNP10'),
(329, 'Rebecca Kemp', '08 Thomas ranch, Port Connor, WC77 0YF', 'KEMP61LRTLFP52'),
(330, 'Marcus Fowler', '33 Daniels mill, Millermouth, B1 4XN', 'FOWLE16YKIHTX72'),
(331, 'Patrick Nolan', 'Studio 64S, Gerard roads, Port Kathleen, WS15 9YH', 'NOLAN44SXQUMG17'),
(332, 'Leslie Hart', 'Flat 92, Jennifer terrace, East Antony, SP5W 1PB', 'HART99WDZAEO73'),
(333, 'Paula Richards', '7 Lee circles, Port Jordan, TR6B 3YG', 'RICHA40PLJPMG27'),
(334, 'Pauline Dodd', '4 Oliver lane, Stevensonbury, S57 4WW', 'DODD92PQXECV89'),
(335, 'Damian Savage', 'Studio 2, Morgan track, Royton, L5W 3UP', 'SAVAG69TAIVED73'),
(336, 'Katie Cox', '2 Rosemary trace, Fisherchester, DE91 5HQ', 'COX25PWUDFW25'),
(337, 'Lauren Davies', '18 Wright course, Mandyhaven, ME34 0UG', 'DAVIE02ENOJKO80'),
(338, 'Beverley Brooks', 'Flat 7, David islands, Abigailside, SS6 7RG', 'BROOK46XCJGNO83'),
(339, 'Janet Lucas', '171 Ronald prairie, Jenningsmouth, SS0X 5QJ', 'LUCAS23FTQGVA58'),
(340, 'Rita Roberts', '65 Kevin plains, Pearcehaven, ZE32 3NN', 'ROBER85MTAWXZ42'),
(341, 'Molly Harris', 'Studio 72F, Moran harbors, New David, SS0 3PX', 'HARRI53SGEZHU71'),
(342, 'Stewart Gardner', '917 Ward extensions, North Philip, SW1B 3TE', 'GARDN94IGCTFL39'),
(343, 'Joshua Young', '6 Johnson parkway, Lake Marc, CT24 8DN', 'YOUNG53TBXJVZ35'),
(344, 'Leslie Page', '177 Yates roads, West Kimberley, N2 8EE', 'PAGE23DWBZTF78'),
(345, 'Chloe Fletcher', 'Studio 97q, Stanley curve, Dalefurt, CT3 2RJ', 'FLETC84NILCTV95'),
(346, 'Alison Roberts', '3 Day shore, Wendyport, PL4A 0AS', 'ROBER39ANVURV34'),
(347, 'Abigail Dixon', '6 Albert crescent, Lake Samuelmouth, NG2 7YZ', 'DIXON68KTAUTS57'),
(348, 'Nathan Heath', 'Flat 95w, Wright port, Millerville, WD9 0UA', 'HEATH37HGXVSH30'),
(349, 'Lisa Barry', 'Studio 03, Bailey tunnel, Port Louis, M5 3PL', 'BARRY91GCZQIE59'),
(350, 'Tracy Taylor', 'Flat 97, Frederick square, West Terencebury, DH6 5JT', 'TAYLO37AGSIPA10'),
(351, 'Marcus Fletcher', '100 Patel estate, Petermouth, M8H 5NU', 'FLETC41QXSLZY15'),
(352, 'Matthew Waters', '7 Swift camp, South Luke, DD80 6PN', 'WATER94TLVADX83'),
(353, 'Louise Thompson', '72 Booth springs, Josephinemouth, L0 0XS', 'THOMP16IBWUOZ25'),
(354, 'Jayne Davidson', 'Flat 95, Mitchell loaf, Mariechester, DD5H 2HD', 'DAVID85YHXPHR94'),
(355, 'Hannah Warren', 'Studio 77P, Lynne spurs, Harveyton, M69 9DN', 'WARRE25BTICJK76'),
(356, 'Marcus Graham', 'Studio 70U, Day summit, Robertstown, OX7W 8WH', 'GRAHA40WFTUMT63'),
(357, 'Deborah Wilkinson', 'Flat 32R, Wilkinson mission, East Scott, M01 4PJ', 'WILKI62QWPDEL09'),
(358, 'Jessica Taylor', '579 Garry trafficway, Johnsonville, TR98 9DS', 'TAYLO47MFMCBH68'),
(359, 'Joanna Brown', 'Flat 79W, Natasha drives, New Marcus, SY1 5EF', 'BROWN41SHKKGR35'),
(360, 'Kate Morgan', 'Studio 5, Ricky island, Woodtown, RG6P 3NB', 'MORGA06MOHTKM95'),
(361, 'Owen Holland', 'Flat 90t, Foster shore, Huntstad, W6G 3DY', 'HOLLA27CPSFMJ02'),
(362, 'Louis Charlton', '7 Matthew throughway, Hutchinsonborough, BB3 6TQ', 'CHARL25BHNIEU38'),
(363, 'Charlene Miller', '6 Price mountain, North Danielletown, BH1 9JH', 'MILLE39NVSLGD22'),
(364, 'Harriet Watson', 'Flat 35, Gerald club, Josephborough, W6D 2JX', 'WATSO41DMYDNN46'),
(365, 'Louise Hancock', 'Flat 0, Charlotte crossroad, Lake Christine, N2 0GE', 'HANCO35BUBAWN69'),
(366, 'Gerald James', '606 Jason gateway, Whitetown, HX9N 1UX', 'JAMES69QNYIPY99'),
(367, 'Kirsty Gibson', '34 Jill club, North Callumland, LS2 1NT', 'GIBSO76ZCBJSJ02'),
(368, 'Trevor Dale', 'Flat 20i, Kennedy place, North Hollie, OL7 8XR', 'DALE91CFGGHG37'),
(369, 'Denis Connolly', '54 Clark stream, Hammondburgh, L4G 7HF', 'CONNO02KKOKEI27'),
(370, 'Adrian Lee', '3 Chapman streets, Jillchester, G0 7YY', 'LEE55JEMDPX63'),
(371, 'Tracey Pickering', '8 Jacob walks, Watkinstown, TD5 5ET', 'PICKE44LWKPAK44'),
(372, 'Rachel Lewis', '426 Smith haven, Valeriefurt, B4S 9QG', 'LEWIS78YXFNWX84'),
(373, 'Martin Jones', '3 Thompson pine, Marybury, E7 5BE', 'JONES52RFVXZX77'),
(374, 'Maria Moore', '212 Jonathan cape, Lake Melanie, EX6 2EL', 'MOORE12BZLNFD71'),
(375, 'Joanna Wilson', '95 Whitehouse mall, Port Rosemary, B06 7QF', 'WILSO19NVYVSV88'),
(376, 'Alan Shaw', 'Flat 75y, Evans ferry, East Christine, NE72 8EL', 'SHAW72PWXRYV00'),
(377, 'Judith Robinson', '4 Ashleigh hills, New Jessica, N3 6PA', 'ROBIN27HJPBVG64'),
(378, 'Jean Riley', '84 Nathan loaf, Hartfort, HR0V 9NH', 'RILEY39GCMSJW12'),
(379, 'Rosemary Gilbert', 'Flat 01h, Paul center, West Russellmouth, IP5 4UB', 'GILBE68OXWEWA79'),
(380, 'Ian Morton', 'Studio 9, Danielle meadow, Lake Jemma, SO0 8TA', 'MORTO69BUYZGL36'),
(381, 'Natasha Powell', 'Flat 08, Clifford row, Colemouth, ZE2 2YR', 'POWEL46WILCNZ11'),
(382, 'Terence Fletcher', 'Studio 94Q, Perkins islands, Sheilashire, N72 9XE', 'FLETC48BZWYXQ01'),
(383, 'Katie Smith', 'Studio 77G, Carole stravenue, Tonymouth, W54 1LN', 'SMITH85JMDYJX38'),
(384, 'Hayley Jenkins', '27 Katherine shoal, O\'Brientown, S0 8TN', 'JENKI07HCQEYD39'),
(385, 'Ian Moran', 'Flat 5, Natasha vista, East Lucyfurt, G1 0QL', 'MORAN35YGHXUM62'),
(386, 'Leanne Smith', 'Studio 17f, Ben village, Port Joel, BS5 2GH', 'SMITH74MZLRTJ71'),
(387, 'Conor Begum', 'Studio 88, Moss keys, Claireland, S4 7QH', 'BEGUM59IILVDC94'),
(388, 'Frank Porter', 'Flat 15, Tony plaza, Mariashire, M6S 5SR', 'PORTE66SAVUQP55'),
(389, 'Rita Murphy', '8 Gary walk, New Deanfort, G5 3DX', 'MURPH53ZFWPFI10'),
(390, 'Anna Hooper', '4 Gail route, Jacksonstad, B6E 9UW', 'HOOPE15MQADAZ04'),
(391, 'Callum Williams', '450 Smart ways, Port Alexander, BD00 1XU', 'WILLI71CQEXXW96'),
(392, 'Lydia Dawson', '02 Flynn skyway, New Terencehaven, GY7M 6WG', 'DAWSO95KJTLRQ94'),
(393, 'Reece Riley', '41 Edwards path, West Declanfort, S1 4ZZ', 'RILEY11GRGFBQ77'),
(394, 'Anthony Cross', '9 Jones plaza, Port Ricky, N54 9PR', 'CROSS36SZJXJV40'),
(395, 'Marion Butler', 'Studio 06D, Glenn overpass, East Damienfurt, B70 2SX', 'BUTLE40NLEETO18'),
(396, 'Michael Evans', 'Studio 24, Payne course, West Kevinport, E6B 8HA', 'EVANS80ILDGUM58'),
(397, 'Tom Brooks', 'Flat 0, Lamb squares, Port Steven, HD0 0DN', 'BROOK11AASLTC48'),
(398, 'Kirsty Parkes', 'Studio 85, Russell viaduct, Port Clifford, IV9 4WT', 'PARKE32LLJUWM52'),
(399, 'Rita White', '70 Allan squares, South Barryburgh, B1 9GR', 'WHITE49CLHEFY73'),
(400, 'Amy Jones', 'Flat 6, Schofield street, West Trevorstad, CF5 9LP', 'JONES10AYDQZV35'),
(401, 'Bradley Moss', '3 Julie knolls, Staceyberg, BR7 3JH', 'MOSS05RERLPW76'),
(402, 'Charlotte Butler', 'Studio 42K, Brown skyway, Vincentmouth, GY7V 2GS', 'BUTLE72UXPRTO29'),
(403, 'Lucy Wallis', 'Flat 00F, Callum freeway, Herbertfurt, GU84 8SZ', 'WALLI33VITKTD88'),
(404, 'Julian Walker', 'Flat 38H, Griffiths row, Gilbertmouth, L69 3SY', 'WALKE12ZWQEEH01'),
(405, 'Deborah Hill', 'Flat 60D, Nicholson extension, North Aimeefurt, W0U 4LL', 'HILL45ZLTSFM61'),
(406, 'Louis Shepherd', '23 Jean forges, Ronaldport, B6 1AN', 'SHEPH62RMXAUQ77'),
(407, 'Abigail Brown', 'Studio 12u, Connor glens, Connorland, IM4E 6LQ', 'BROWN59NTAIPI17'),
(408, 'Leon Ward', '560 Lynda port, South Geraldine, CA80 0DT', 'WARD03DKNBVC16'),
(409, 'Keith Riley', '1 Holloway neck, Brandonville, W6 1EU', 'RILEY53LHEOMG89'),
(410, 'Owen Mistry', '86 Marilyn locks, Lake Benmouth, B7T 2RB', 'MISTR07YTVHEE15'),
(411, 'Jeffrey Morley', '6 Andrews cliff, Lake Francis, S0 1YN', 'MORLE37XWYGZX62'),
(412, 'Duncan Baker', 'Flat 2, Alexander crest, Meganburgh, CB19 5YX', 'BAKER20PEVLMD91'),
(413, 'Derek Collins', 'Flat 32t, Sean creek, New Georgina, M3D 1HL', 'COLLI37UGTAEY65'),
(414, 'Olivia Fitzgerald', '3 Jonathan rue, New Janet, M53 4EF', 'FITZG15PKYWEE45'),
(415, 'Jordan Campbell', '692 Clarke pines, East Rosemary, B4 7ZW', 'CAMPB23BVXBTL69'),
(416, 'Rosemary Moore', 'Flat 58R, Geoffrey ports, West Ameliaberg, CR16 5XH', 'MOORE64ZWYTHX54'),
(417, 'Abdul Gibbs', '19 Stone expressway, Port Geraldine, G5 2ZY', 'GIBBS41DHAYFI79'),
(418, 'Grace Ryan', 'Flat 18x, Lee parkway, Sophieport, RG8 0RS', 'RYAN10LRPUPX25'),
(419, 'Billy Shaw', 'Studio 11K, Robertson brooks, Matthewport, N4 3AJ', 'SHAW43SGPDEJ12'),
(420, 'James Atkins', '75 Hazel gateway, East Ireneland, CO4B 5YH', 'ATKIN53ZZFTYC87'),
(421, 'Gordon King', 'Flat 57, Rhys lane, West Catherineland, M3W 1NZ', 'KING27XNVEOL64'),
(422, 'Ashleigh Gill', '11 Jayne village, East Gemma, CF45 8AQ', 'GILL52TRPTBA90'),
(423, 'Denis Jackson', 'Flat 95, Jeffrey station, Rossfort, B9J 9LY', 'JACKS95MEJXEQ50'),
(424, 'Naomi Carter', '20 Elliott stream, Francesstad, WD4Y 6DU', 'CARTE74REGVWX61'),
(425, 'Chelsea Clarke', '06 Owen stream, Webbberg, SR9P 2FA', 'CLARK38LCCUPR20'),
(426, 'Adam Smith', '6 Begum point, Colinberg, E0C 5RE', 'SMITH76DEFVDF15'),
(427, 'Declan Wright', 'Flat 27r, Roger fall, Sandraton, G0W 0DF', 'WRIGH76MHCFFT08'),
(428, 'Elliott Hancock', 'Studio 03Q, Joshua ports, Reedview, BN9 9QD', 'HANCO93MSQOHG69'),
(429, 'Joyce Arnold', 'Flat 74w, Tom camp, East Matthew, ME1 7JS', 'ARNOL32JEDZAX61'),
(430, 'Elaine Lowe', '5 Teresa lock, Lake Damiantown, WN46 6GG', 'LOWE22QIFEBW89'),
(431, 'Jill Long', 'Flat 8, Brooks village, Lake Rosemary, GY3 3AX', 'LONG17JLZFDC28'),
(432, 'Caroline Savage', '516 Smith drive, Mitchellstad, LD07 1JP', 'SAVAG59LEAAQI70'),
(433, 'Daniel Chambers', 'Flat 41, Buckley spurs, Charlenefort, HA1 9TL', 'CHAMB81YSUTTO81'),
(434, 'Dawn Gill', '94 Lynne village, West Margaret, M0 1UL', 'GILL74NHVJTK00'),
(435, 'Amy Howard', '362 Bray lakes, Jenniferborough, E39 8ZU', 'HOWAR83YYUYCK01'),
(436, 'Jason Robertson', '68 Katy burg, Janetmouth, WR29 9JX', 'ROBER80PBPJJZ04'),
(437, 'Cameron Mellor', 'Flat 67, Shah crescent, North Cameron, PH4 7EF', 'MELLO88DLEABP14'),
(438, 'Lindsey Rose', 'Studio 1, Shane coves, Fordland, E8H 4RS', 'ROSE72SRMYWO87'),
(439, 'Nicole Kaur', 'Flat 61, David pines, New Adrianton, G82 4EP', 'KAUR80ZIZGGV65'),
(440, 'Tracy Chandler', 'Flat 11, Keith mountains, Taylorland, B3 6EY', 'CHAND27GFMHTK92'),
(441, 'Glen Carter', 'Flat 0, Lowe ville, Port Jay, B03 5YW', 'CARTE35YQNTHX18'),
(442, 'Mandy Stephens', '652 Angela views, Howeville, S2 2LN', 'STEPH47XVUGEP85'),
(443, 'Russell Arnold', 'Flat 90N, Joe forks, Johnsonshire, E7S 2ZE', 'ARNOL18WHBSFA00'),
(444, 'Carole Elliott', '36 Marcus cliff, Daviestown, TN5Y 0PE', 'ELLIO73MEQGBF27'),
(445, 'Steven Abbott', '688 Gibson fall, Samton, W1W 4LS', 'ABBOT62AXTHDN43'),
(446, 'Scott Taylor', 'Studio 2, Jill streets, East Janice, ME4 0QT', 'TAYLO94MHPLLS29'),
(447, 'Marie Wright', 'Flat 10d, Robinson shores, Humphriestown, E1W 1AJ', 'WRIGH41MAZDVP61'),
(448, 'Jill Potter', 'Flat 7, Spencer harbors, Williamsberg, CM1N 5UF', 'POTTE36SLTRQO46'),
(449, 'Tina Franklin', '258 Dobson ports, Stonemouth, L0 0GG', 'FRANK36ACQLXQ16'),
(450, 'Norman Knight', '162 Burrows mill, Shawberg, N9 5SS', 'KNIGH40RGKWMW81'),
(451, 'Howard Williams', 'Studio 30U, McCarthy trace, Port Gerardville, S5 2PQ', 'WILLI05VMIWHE74'),
(452, 'Josh Nolan', 'Studio 5, Williams tunnel, Bryantton, LU46 5NE', 'NOLAN59CGMLVT26'),
(453, 'Marilyn Hunter', '126 Walker forges, North Dean, HP27 7YQ', 'HUNTE08INYRVD06'),
(454, 'Julian Jones', '761 Joanne streets, Dobsonland, M3F 2LW', 'JONES58BUYHPN55'),
(455, 'Glen Spencer', 'Studio 23c, Amy forest, Williamstown, L69 8FR', 'SPENC67ADVJQM93'),
(456, 'Christine Thompson', 'Studio 58K, Jonathan loop, Singhmouth, B98 0JF', 'THOMP04DLTBYU86'),
(457, 'Hugh Norris', 'Flat 27J, Hollie plaza, Samuelburgh, M0D 0EQ', 'NORRI51DUOEXB11'),
(458, 'Gareth Hall', '3 Lynda bridge, Mannbury, WN8R 8GA', 'HALL46TVWHLV47'),
(459, 'Dennis Carter', 'Flat 84, Hughes mission, Melissaview, DH8 1AU', 'CARTE50IXEILJ83'),
(460, 'Norman Lawrence', 'Flat 0, Georgina ford, Louiseland, S5 2JU', 'LAWRE56PZMVMP33'),
(461, 'Howard Hughes', 'Studio 3, Joel orchard, Abbottberg, SR6X 5UE', 'HUGHE91MQWOBF06'),
(462, 'Beverley Lewis', 'Studio 0, Lewis station, South Gareth, B2 9HN', 'LEWIS08BBCILF39'),
(463, 'Amanda Rose', '70 Angela ports, South Harry, S3F 8RN', 'ROSE02CUZZVP84'),
(464, 'Gareth Bradshaw', '566 Amanda junction, South Malcolmshire, W2 6HY', 'BRADS04XZHRQG23'),
(465, 'Sarah Palmer', 'Studio 47, Scott rapid, Port Sylvia, S6 9LB', 'PALME47ZPIJNK20'),
(466, 'Suzanne Mitchell', 'Studio 70o, Stephens avenue, New Lorraine, ME4 1GP', 'MITCH71LBOTDN31'),
(467, 'Christian Taylor', '848 Amanda way, Leonardview, PO5V 4BG', 'TAYLO75UUWHCS36'),
(468, 'Mitchell Holden', 'Flat 21T, Austin expressway, West James, PO5 2YQ', 'HOLDE96HXPNRR62'),
(469, 'Jason Moore', '786 Hughes estate, South Joyce, M43 5XP', 'MOORE28JKAOFD90'),
(470, 'Sarah Clarke', '783 Moss alley, Lewisbury, CF10 0NS', 'CLARK59BGVKYG47'),
(471, 'Hugh Taylor', '1 Damian overpass, Antonyberg, AL3 2YP', 'TAYLO67AKHOGJ49'),
(472, 'Marian Richardson', 'Studio 43, Sean mill, Iainshire, W6E 1SD', 'RICHA08NORWOO61'),
(473, 'Stephen Browne', 'Studio 49W, McKenzie alley, Port Jane, E4 3ZQ', 'BROWN52TBPFDI98'),
(474, 'Oliver Clarke', '260 Nicholas parks, Smithfort, E6B 1BJ', 'CLARK51RGKUOR02'),
(475, 'Jason Hudson', 'Studio 66x, Barbara port, West Shaun, S40 2PE', 'HUDSO36FCYOFT07'),
(476, 'Aimee Pearson', 'Studio 69A, Skinner junctions, Iainport, M6K 1GL', 'PEARS39NFQEKK25'),
(477, 'Amy Owen', '9 Natalie flats, West Rossmouth, CO7X 8UQ', 'OWEN11AHAHCQ09'),
(478, 'Dawn Campbell', '06 Charles underpass, Manningbury, NP31 9AP', 'CAMPB88FLXBPN17'),
(479, 'Emily Fletcher', 'Studio 08R, Susan estates, Jeremyshire, TF6 3UF', 'FLETC37NCBPAT21'),
(480, 'Clare Kennedy', 'Flat 1, Hamilton brook, West Beverleyhaven, N00 1YN', 'KENNE18FUFFKL29'),
(481, 'Toby Graham', 'Studio 0, Hunt harbors, Whiteberg, M9J 2RX', 'GRAHA38ZPXZTW08'),
(482, 'Michelle Wood', 'Flat 8, Peter union, Mathewport, SW65 0LG', 'WOOD55QFNKRZ34'),
(483, 'Lauren Brown', '829 Williams bridge, Abigailchester, OL44 7SJ', 'BROWN98MPSAUB92'),
(484, 'Paul Williams', '42 Carol street, East Rachelville, CB9M 1BT', 'WILLI09IGVODK20'),
(485, 'Ann Armstrong', '2 Jade hollow, Lake Grace, TS36 8AF', 'ARMST09EMENXS12'),
(486, 'Tina Stewart', 'Studio 02i, Dylan plaza, Lake Edward, L22 1UX', 'STEWA37WHZECU15'),
(487, 'Luke Ford', '2 Watson forks, Port William, SN9 3FR', 'FORD80FMTRSA62'),
(488, 'Julia Kennedy', '43 Rosie light, New Gillian, S6K 0FY', 'KENNE51WKNSEU48'),
(489, 'Paul Turner', '9 Dorothy plaza, North Jayfurt, M2 5WG', 'TURNE80EIRLBB95'),
(490, 'Stuart Webb', '2 Callum spurs, North Duncanmouth, CV19 1WN', 'WEBB15YFPYSC90'),
(491, 'Jacqueline Davies', '8 Miah mountain, South Robin, M0 4UH', 'DAVIE57JSOEOI70'),
(492, 'Bernard Williams', '193 Mitchell cliffs, South Nigel, HD8H 6RB', 'WILLI03GHPYNO57'),
(493, 'Derek Bird', 'Studio 55f, Riley causeway, Harristown, B4 0WD', 'BIRD91JUBLEV20'),
(494, 'Henry Harris', '281 Joan isle, Middletontown, N5T 3LE', 'HARRI20CJLMEX75'),
(495, 'Lewis Lambert', 'Flat 9, Sylvia trail, Coopermouth, BB1E 8AP', 'LAMBE37KYWHLO97'),
(496, 'Kenneth Jones', '48 Jessica river, Goughbury, SA4 4FA', 'JONES28DFSFQQ42'),
(497, 'Dean Smith', '42 Rogers drives, Leonardburgh, BL59 6WE', 'SMITH74KPUYZR58'),
(498, 'Billy Gallagher', '159 Sarah mountains, Lake Malcolmland, CV52 0SG', 'GALLA51ZONWKS57'),
(499, 'Debra Bell', 'Studio 4, Lewis crescent, Wilkinsmouth, IG9B 9HF', 'BELL41CDAIRH60'),
(500, 'Clare Martin', 'Studio 99U, Sykes station, West Johnhaven, TN0 4BX', 'MARTI60UOSEED28'),
(501, 'Lorraine Smith', 'Studio 3, Jasmine way, Hughesburgh, DD3B 4ZR', 'SMITH32KQFDSB07'),
(502, 'Rita Houghton', 'Studio 27, Garry summit, Wilsonchester, B4 4FZ', 'HOUGH20PYJYND05'),
(503, 'Elliot Cook', 'Flat 84v, Jack brooks, East Karenborough, W6 9UY', 'COOK34WQDGKP59'),
(504, 'Sally White', '51 Francis brooks, Jennifermouth, WN68 3FS', 'WHITE82TDOGSJ86'),
(505, 'Callum Walker', '63 Smith street, Buckleyburgh, E0 4WG', 'WALKE51SDGXMC48'),
(506, 'Alex Ward', 'Studio 64k, Adrian lake, Naomiside, DE0 3TE', 'WARD00TXESID28'),
(507, 'Valerie Davis', '5 Derek way, New Charlene, TA9A 7UR', 'DAVIS50PIENNL76'),
(508, 'Simon Marsden', 'Flat 28n, Kate lights, Port Garry, TD91 3YL', 'MARSD15NLADKF16'),
(509, 'Sophie Evans', 'Studio 44V, White glens, Hayleyburgh, DG6 1XY', 'EVANS43NONSNF56'),
(510, 'Kathleen Rhodes', '115 Dominic plain, Daviesville, W7K 5AX', 'RHODE05ATHRWR93'),
(511, 'Dennis Harvey', 'Flat 9, Williams place, East Marcus, W9S 6UH', 'HARVE83MSGWXM01'),
(519, 'John Doe', '123 Main Street', 'LIC12345'),
(520, 'Jane Smith', '456 Elm Street', 'LIC45678'),
(548, 'Bradley Carter', '183 Seymour Villas', 'ExampleLicence1'),
(549, 'Brayton Mutendeni', '184 Seymour Villas', 'ExampleLicence2'),
(552, 'Meggie genius', '183 Seymour Villas', 'ExampleLicence5'),
(553, 'Joe Budden', '183 Seymour Villas', 'ExampleLicence7'),
(554, 'Bradley Carter', '183 Seymour Villas', 'BMARIR004JFS20TR'),
(555, 'Meggie henius', '183 Seymour Villas', 'ExampleLicence37'),
(556, 'Nottingham', '26 Devonshire Avenue, Nottingham', 'ExampleLicence17'),
(557, 'This man', '183 Seymour Villas', 'ExampleLicence10'),
(558, 'Joe Budden', '183 Seymour Villas', 'ExampleLicence18'),
(559, 'JingleBells', '183 Seymour Villas', 'ExampleLicence20'),
(560, 'Nottingham', '184 Seymour Villas', 'ExampleLicence24'),
(561, 'Jiggle bells', '183 Seymour Villas', 'ExampleLicence25');

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle`
--

CREATE TABLE `Vehicle` (
  `Vehicle_ID` int(11) NOT NULL,
  `Vehicle_make` varchar(50) DEFAULT NULL,
  `Vehicle_model` varchar(50) DEFAULT NULL,
  `Vehicle_colour` varchar(20) NOT NULL,
  `Vehicle_plate` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Vehicle`
--

INSERT INTO `Vehicle` (`Vehicle_ID`, `Vehicle_make`, `Vehicle_model`, `Vehicle_colour`, `Vehicle_plate`) VALUES
(111, 'Ford', 'Super Duty', 'White', 'DM06NR'),
(454, 'Toyota', 'Sequoia', 'Silver', 'US85JL'),
(455, 'Honda', 'Passport', 'Gold', 'MA08BE'),
(456, 'Nissan', 'Armada', 'Green', 'NR62AZ'),
(457, 'Ford', 'F-150', 'White', 'ZQ19YU'),
(458, 'Chevrolet', 'Silverado', 'Black', 'CA85SS'),
(459, 'Ram', '1500', 'Blue', 'VF23RS'),
(460, 'Toyota', 'Tundra', 'Red', 'RX54NL'),
(461, 'Ford', 'Super Duty', 'Silver', 'CL58FR'),
(462, 'Chevrolet', 'Tahoe', 'Gold', 'JF60EP'),
(463, 'GMC', 'Sierra', 'Green', 'RJ16MI'),
(464, 'Toyota', '4Runner', 'White', 'WI23GJ'),
(465, 'Honda', 'Ridgeline', 'Black', 'KR65AK'),
(466, 'Nissan', 'Frontier', 'Blue', 'PQ52TO'),
(467, 'Kia', 'Sportage', 'Red', 'UG76GV'),
(468, 'Hyundai', 'Tucson', 'Silver', 'EQ77NW'),
(469, 'Ford', 'Bronco', 'Gold', 'XC82YN'),
(470, 'Jeep', 'Wrangler', 'Green', 'YE43CI'),
(471, 'Subaru', 'Outback', 'White', 'NJ18NR'),
(472, 'Toyota', '4Runner', 'Black', 'KQ94QW'),
(473, 'Honda', 'Passport', 'Blue', 'UB37HU'),
(474, 'Nissan', 'Pathfinder', 'Red', 'UK71CZ'),
(475, 'Kia', 'Telluride', 'Silver', 'SM94LN'),
(476, 'Hyundai', 'Palisade', 'Gold', 'PM33QH'),
(477, 'Ford', 'Expedition', 'Green', 'JB56EG'),
(478, 'Chevrolet', 'Suburban', 'White', 'WZ77MA'),
(479, 'GMC', 'Yukon', 'Black', 'OL76OF'),
(480, 'Toyota', 'Sequoia', 'Blue', 'HH68WP'),
(481, 'Honda', 'Passport', 'Red', 'YZ76MJ'),
(482, 'Nissan', 'Armada', 'Silver', 'KD92FP'),
(483, 'Ford', 'F-150', 'Gold', 'YM73RJ'),
(484, 'Chevrolet', 'Silverado', 'Green', 'KI75BZ'),
(485, 'Ram', '1500', 'White', 'TP82IN'),
(486, 'Toyota', 'Tundra', 'Black', 'JR78QF'),
(487, 'Ford', 'Super Duty', 'Blue', 'FL46GG'),
(488, 'Chevrolet', 'Tahoe', 'Red', 'RP33WD'),
(489, 'GMC', 'Sierra', 'Silver', 'LR49BG'),
(490, 'Toyota', '4Runner', 'Gold', 'SJ71LY'),
(491, 'Honda', 'Ridgeline', 'Green', 'JO81ZP'),
(492, 'Nissan', 'Frontier', 'White', 'RD46VH'),
(493, 'Kia', 'Sportage', 'Black', 'YR18II'),
(494, 'Hyundai', 'Tucson', 'Blue', 'TD68DP'),
(495, 'Ford', 'Bronco', 'Red', 'JX02ZC'),
(496, 'Jeep', 'Wrangler', 'Silver', 'LR81UM'),
(497, 'Subaru', 'Outback', 'Gold', 'XT37JG'),
(498, 'Toyota', '4Runner', 'Green', 'SF45QA'),
(499, 'Honda', 'Passport', 'White', 'DS15LE'),
(500, 'Nissan', 'Pathfinder', 'Black', 'ZV72JE'),
(501, 'Kia', 'Telluride', 'Blue', 'XC63JT'),
(502, 'Hyundai', 'Palisade', 'Red', 'WD09VZ'),
(503, 'Ford', 'Expedition', 'Silver', 'ZU81BP'),
(504, 'Chevrolet', 'Suburban', 'Gold', 'XY42GX'),
(505, 'GMC', 'Yukon', 'Green', 'YR27HX'),
(506, 'Toyota', 'Sequoia', 'White', 'OY14DZ'),
(507, 'Honda', 'Passport', 'Black', 'OG39GI'),
(508, 'Nissan', 'Armada', 'Blue', 'FU64WN'),
(509, 'Ford', 'F-150', 'Red', 'LG65UY'),
(510, 'Chevrolet', 'Silverado', 'Silver', 'VG65ZZ'),
(511, 'Ram', '1500', 'Gold', 'AD38UG'),
(512, 'Toyota', 'Tundra', 'Green', 'VP70FD'),
(513, 'Ford', 'Super Duty', 'White', 'VS44PR'),
(514, 'Chevrolet', 'Tahoe', 'Black', 'IA17EF'),
(515, 'GMC', 'Sierra', 'Blue', 'JS82AL'),
(516, 'Toyota', '4Runner', 'Red', 'QF99UU'),
(517, 'Honda', 'Ridgeline', 'Silver', 'NC44NH'),
(518, 'Nissan', 'Frontier', 'Gold', 'QX78CA'),
(519, 'Kia', 'Sportage', 'Green', 'ZC93YO'),
(520, 'Hyundai', 'Tucson', 'White', 'RU37ZP'),
(521, 'Ford', 'Bronco', 'Black', 'AC37OE'),
(522, 'Jeep', 'Wrangler', 'Blue', 'AT73PT'),
(523, 'Subaru', 'Outback', 'Red', 'MI07JS'),
(524, 'Toyota', '4Runner', 'Silver', 'IB19EX'),
(525, 'Honda', 'Passport', 'Gold', 'UD02WF'),
(526, 'Nissan', 'Pathfinder', 'Green', 'JK87JI'),
(527, 'Kia', 'Telluride', 'White', 'VM84DT'),
(528, 'Hyundai', 'Palisade', 'Black', 'QK44FN'),
(529, 'Ford', 'Expedition', 'Blue', 'PK03SS'),
(530, 'Chevrolet', 'Suburban', 'Red', 'EO39DM'),
(531, 'GMC', 'Yukon', 'Silver', 'SP00SE'),
(532, 'Toyota', 'Sequoia', 'Gold', 'ST93IM'),
(533, 'Honda', 'Passport', 'Green', 'BS75RE'),
(534, 'Nissan', 'Armada', 'White', 'IW02WD'),
(535, 'Ford', 'F-150', 'Black', 'AC68SB'),
(536, 'Chevrolet', 'Silverado', 'Blue', 'YB84YY'),
(537, 'Ram', '1500', 'Red', 'UF38AG'),
(538, 'Toyota', 'Tundra', 'Silver', 'DS16LB'),
(539, 'Ford', 'Super Duty', 'Gold', 'WK26PN'),
(540, 'Chevrolet', 'Tahoe', 'Green', 'KR70RW'),
(541, 'GMC', 'Sierra', 'White', 'FE16JM'),
(542, 'Toyota', '4Runner', 'Black', 'JN04WY'),
(543, 'Honda', 'Ridgeline', 'Blue', 'VI84ZU'),
(544, 'Nissan', 'Frontier', 'Red', 'EE28ZI'),
(545, 'Kia', 'Sportage', 'Silver', 'II08GO'),
(546, 'Hyundai', 'Tucson', 'Gold', 'HL89DU'),
(547, 'Ford', 'Bronco', 'Green', 'JX80FC'),
(548, 'Jeep', 'Wrangler', 'White', 'OP52QA'),
(549, 'Subaru', 'Outback', 'Black', 'AV89MU'),
(550, 'Toyota', '4Runner', 'Blue', 'KD97HH'),
(551, 'Honda', 'Passport', 'Red', 'IK42NC'),
(552, 'Nissan', 'Pathfinder', 'Silver', 'KJ63QB'),
(553, 'Kia', 'Telluride', 'Gold', 'SA41UP'),
(554, 'Hyundai', 'Palisade', 'Green', 'SF75JL'),
(555, 'Ford', 'Expedition', 'White', 'WP72AW'),
(556, 'Chevrolet', 'Suburban', 'Black', 'SF89EC'),
(557, 'GMC', 'Yukon', 'Blue', 'LM14SS'),
(558, 'Toyota', 'Sequoia', 'Red', 'XI48MJ'),
(559, 'Honda', 'Passport', 'Silver', 'PK94CS'),
(560, 'Nissan', 'Armada', 'Gold', 'LH61TI'),
(561, 'Ford', 'F-150', 'Green', 'CU40UW'),
(562, 'Chevrolet', 'Silverado', 'White', 'SQ52DL'),
(563, 'Ram', '1500', 'Black', 'DX90VQ'),
(564, 'Toyota', 'Tundra', 'Blue', 'GZ64QQ'),
(565, 'Ford', 'Super Duty', 'Red', 'WE41WI'),
(566, 'Chevrolet', 'Tahoe', 'Silver', 'IE13SM'),
(567, 'GMC', 'Sierra', 'Gold', 'NN55PI'),
(568, 'Toyota', '4Runner', 'Green', 'LP25QJ'),
(569, 'Honda', 'Ridgeline', 'White', 'BZ20AG'),
(570, 'Nissan', 'Frontier', 'Black', 'BC62IM'),
(571, 'Kia', 'Sportage', 'Blue', 'FF28CF'),
(572, 'Hyundai', 'Tucson', 'Red', 'VN57DF'),
(573, 'Ford', 'Bronco', 'Silver', 'PP65UJ'),
(574, 'Jeep', 'Wrangler', 'Gold', 'OC83OG'),
(575, 'Subaru', 'Outback', 'Green', 'OF98CY'),
(576, 'Toyota', '4Runner', 'White', 'SI76XD'),
(577, 'Honda', 'Passport', 'Black', 'VN24IB'),
(578, 'Nissan', 'Pathfinder', 'Blue', 'AG85SZ'),
(579, 'Kia', 'Telluride', 'Red', 'XA12DH'),
(580, 'Hyundai', 'Palisade', 'Silver', 'WP88FC'),
(581, 'Ford', 'Expedition', 'Gold', 'EI69AC'),
(582, 'Chevrolet', 'Suburban', 'Green', 'IB81TR'),
(583, 'GMC', 'Yukon', 'White', 'LL12UU'),
(584, 'Toyota', 'Sequoia', 'Black', 'PP20EK'),
(585, 'Honda', 'Passport', 'Blue', 'UI68GI'),
(586, 'Nissan', 'Armada', 'Red', 'DF34JF'),
(587, 'Ford', 'F-150', 'Silver', 'VE06LX'),
(588, 'Chevrolet', 'Silverado', 'Gold', 'OF60UQ'),
(589, 'Ram', '1500', 'Green', 'PP80MD'),
(590, 'Toyota', 'Tundra', 'White', 'MF81MN'),
(591, 'Ford', 'Super Duty', 'Black', 'CE18XE'),
(592, 'Chevrolet', 'Tahoe', 'Blue', 'OI29LH'),
(687, 'Mercedes-Benz', 'A-Class', 'Black', 'BM500X'),
(688, 'Mercedes-Benz', 'A-Class', 'Black', 'GM350X'),
(689, 'Mercedes-Benz', 'A-Class', 'Black', 'GM500X'),
(690, 'Mercedes-Benz', 'A-Class', 'Black', 'BM600X'),
(691, 'Renault', 'Clio', 'Gray', 'GM250X'),
(692, 'Mercedes-Benz', 'A-Class', 'Black', 'G6OOX6'),
(694, 'Renault', 'A-Class', 'Black', 'GM360X');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Audit_Logging`
--
ALTER TABLE `Audit_Logging`
  ADD PRIMARY KEY (`Audit_ID`),
  ADD KEY `fk_audit_officer` (`Officer_ID`) USING BTREE COMMENT 'I have used - ON DELETE SET NULL is used to Keep the audit log even if the officer is removed from the OfficerLogin table. I have used ON UPDATE CASCADE to automatically update the Officer_ID in the Audit_Logging table if it changes in the OfficerLogin table';

--
-- Indexes for table `Fines`
--
ALTER TABLE `Fines`
  ADD PRIMARY KEY (`Fine_ID`),
  ADD UNIQUE KEY `unique_fine_id` (`Fine_ID`),
  ADD KEY `fk_fines_incident` (`Incident_ID`) USING BTREE COMMENT 'foreign key linking to incident table , contains on delete cascade';

--
-- Indexes for table `Incident`
--
ALTER TABLE `Incident`
  ADD PRIMARY KEY (`Incident_ID`),
  ADD KEY `fk_incident_offence` (`Offence_ID`),
  ADD KEY `fk_incident_vehicle` (`Vehicle_ID`),
  ADD KEY `fk_incident_Officer` (`Officer_ID`),
  ADD KEY `People_ID` (`People_ID`);

--
-- Indexes for table `Offence`
--
ALTER TABLE `Offence`
  ADD PRIMARY KEY (`Offence_ID`);

--
-- Indexes for table `Officer`
--
ALTER TABLE `Officer`
  ADD PRIMARY KEY (`Officer_ID`),
  ADD UNIQUE KEY `Officer_BadgeNumber` (`Officer_BadgeNumber`) USING BTREE COMMENT 'Unique constraint',
  ADD UNIQUE KEY `unique_officer_email` (`Email`) USING BTREE COMMENT 'Unique constraint';

--
-- Indexes for table `OfficerLogin`
--
ALTER TABLE `OfficerLogin`
  ADD PRIMARY KEY (`Officer_ID`),
  ADD UNIQUE KEY `Username` (`Username`) USING BTREE COMMENT 'Unique';

--
-- Indexes for table `ownership`
--
ALTER TABLE `ownership`
  ADD UNIQUE KEY `unique_ownership` (`People_ID`,`Vehicle_ID`),
  ADD KEY `fk_ownership_vehicle` (`Vehicle_ID`) USING BTREE COMMENT 'Foreign key',
  ADD KEY `fk_ownership_people` (`People_ID`) USING BTREE COMMENT 'Foreign key';

--
-- Indexes for table `People`
--
ALTER TABLE `People`
  ADD PRIMARY KEY (`People_ID`),
  ADD UNIQUE KEY `People_licence` (`People_licence`) USING BTREE COMMENT 'Unique';

--
-- Indexes for table `Vehicle`
--
ALTER TABLE `Vehicle`
  ADD PRIMARY KEY (`Vehicle_ID`),
  ADD UNIQUE KEY `Vehicle_plate` (`Vehicle_plate`) USING BTREE COMMENT 'Unique';

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Audit_Logging`
--
ALTER TABLE `Audit_Logging`
  MODIFY `Audit_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=192;

--
-- AUTO_INCREMENT for table `Fines`
--
ALTER TABLE `Fines`
  MODIFY `Fine_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `Incident`
--
ALTER TABLE `Incident`
  MODIFY `Incident_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `Offence`
--
ALTER TABLE `Offence`
  MODIFY `Offence_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `Officer`
--
ALTER TABLE `Officer`
  MODIFY `Officer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `OfficerLogin`
--
ALTER TABLE `OfficerLogin`
  MODIFY `Officer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `People`
--
ALTER TABLE `People`
  MODIFY `People_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=562;

--
-- AUTO_INCREMENT for table `Vehicle`
--
ALTER TABLE `Vehicle`
  MODIFY `Vehicle_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=695;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Audit_Logging`
--
ALTER TABLE `Audit_Logging`
  ADD CONSTRAINT `fk_audit_officer` FOREIGN KEY (`Officer_ID`) REFERENCES `OfficerLogin` (`Officer_ID`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Fines`
--
ALTER TABLE `Fines`
  ADD CONSTRAINT `fk_fines_incident` FOREIGN KEY (`Incident_ID`) REFERENCES `Incident` (`Incident_ID`) ON DELETE CASCADE;

--
-- Constraints for table `Incident`
--
ALTER TABLE `Incident`
  ADD CONSTRAINT `incident_ibfk_1` FOREIGN KEY (`People_ID`) REFERENCES `People` (`People_ID`),
  ADD CONSTRAINT `incident_ibfk_2` FOREIGN KEY (`Offence_ID`) REFERENCES `Offence` (`Offence_ID`);

--
-- Constraints for table `OfficerLogin`
--
ALTER TABLE `OfficerLogin`
  ADD CONSTRAINT `fk_officer_login` FOREIGN KEY (`Officer_ID`) REFERENCES `Officer` (`Officer_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
