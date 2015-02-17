-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 31, 2015 at 03:20 PM
-- Server version: 5.1.63
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `pizzaDb`
--

-- --------------------------------------------------------

--
-- Table structure for table `pizzaDb`
--

CREATE TABLE IF NOT EXISTS `pizzaDb` (
  `ProductName` varchar(40) DEFAULT NULL,
  `Thumbnail` BLOB DEFAULT NULL,
  `Image` BLOB DEFAULT NULL,
  `Description` TEXT (1000)  DEFAULT NULL,
  `id` int(50) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=50;

--
-- Dumping data for table `pizzaDb`
--

INSERT INTO `pizzaDb` (`ProductName`, `Thumbnail`, `Image`, `Descripton`, `id`) 
VALUES
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 1),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 2),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 3),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 4),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 5),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 6),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 7),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 8),
('Margherita', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 9),
('Quatitro Formaggi', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 10),
('Quatitro Formaggi', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 11),
('Quatitro Formaggi', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 12),
('Quatitro Formaggi', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 13),
('Quatitro Formaggi', 'images/PizzaMargheritaT.jpg', 'images/PizzaMargheritaT.jpg', 'Details about this Pizza', 14);




/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
