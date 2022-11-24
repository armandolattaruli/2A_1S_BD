-- phpMyAdmin SQL Dump
-- version 5.3.0-dev
-- https://www.phpmyadmin.net/
--
-- Host: 192.168.30.23
-- Generation Time: Nov 21, 2022 at 12:14 PM
-- Server version: 8.0.18
-- PHP Version: 7.4.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gare_lattaruli`
--

-- --------------------------------------------------------

--
-- Table structure for table `fondista`
--

CREATE TABLE `fondista` (
  `numero` int(11) PRIMARY KEY,
  `nome` text NOT NULL,
  `cognome` text NOT NULL,
  `nazionalità` text NOT NULL,
  `età` int(11) NOT NULL,
  `gara` int(11) NOT NULL,

  FOREIGN KEY (gara) REFERENCES gare(idGara)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------
INSERT INTO `fondista` (`numero`, `nome`, `cognome`, `nazionalità`, `età`, 'gara') VALUES
(1, "armando", "lattaruli", "italiana", 25, 1),
(2, "pippo", "pippo", "italiana", 30, 2),
(3, "pluto", "pluto", "italiana", 18, 1),
(4, "topolino", "topolino", "italiana", 10, 5),
(5, "minnie", "minnie", "italiana", 80, 3),
;
--
-- Table structure for table `gare`
--

CREATE TABLE `gare` (
  `idGara` int(11) PRIMARY KEY,
  `nome` text NOT NULL,
  `luogo` text NOT NULL,
  `nazione` text NOT NULL,
  `lunghezza` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `autori` (
    `codice` text(20) PRIMARY KEY,
    `nome` text(20) NOT NULL,
    `cognome` text(20) NOT NULL
);
--
-- Dumping data for table `gare`
--

INSERT INTO `gare` (`idGara`, `nome`, `luogo`, `nazione`, `lunghezza`) VALUES
(1, 'gara1', 'bari', 'italia', 100), 
(2, 'gara2', 'napoli', 'italia', 200), 
(3, 'gara3', 'catania', 'italia', 150), 
(4, 'gara4', 'cagliari', 'italia', 400), 
(5, 'gara5', 'milano', 'italia', 1000)
;



--
-- Indexes for dumped tables
--

--
-- Indexes for table `fondista`
--
ALTER TABLE `fondista`
  ADD PRIMARY KEY (`numero`),
  ADD KEY `gara` (`gara`);

--
-- Indexes for table `gare`
--
ALTER TABLE `gare`
  ADD PRIMARY KEY (`idGara`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fondista`
--
ALTER TABLE `fondista`
  ADD CONSTRAINT `fondista_ibfk_1` FOREIGN KEY (`gara`) REFERENCES `gare` (`idGara`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
