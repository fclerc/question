-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mar 04 Août 2015 à 20:48
-- Version du serveur: 5.6.12-log
-- Version de PHP: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `question`
--
CREATE DATABASE IF NOT EXISTS `question` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `question`;

-- --------------------------------------------------------

--
-- Structure de la table `account`
--

CREATE TABLE IF NOT EXISTS `account` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_Platform` int(11) NOT NULL,
  `AccountName` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Platform` (`ID_Platform`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `answer`
--

CREATE TABLE IF NOT EXISTS `answer` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Content` text,
  `ID_OriginQuestion` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_OriginQuestion` (`ID_OriginQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `ID_ParentCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_ParentCategory` (`ID_ParentCategory`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `platform`
--

CREATE TABLE IF NOT EXISTS `platform` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Platforms through which people can be contacted' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE IF NOT EXISTS `question` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Content` text,
  `ID_UserCreator` int(11) NOT NULL,
  `ID_ParentQuestion` int(11) NOT NULL,
  `ParentType` varchar(10) NOT NULL,
  `State` varchar(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_UserCreator` (`ID_UserCreator`),
  KEY `ID_ParentQuestion` (`ID_ParentQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `questionhistory`
--

CREATE TABLE IF NOT EXISTS `questionhistory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Content` text,
  `ID_ParentQuestion` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_ParentQuestion` (`ID_ParentQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `questionincategory`
--

CREATE TABLE IF NOT EXISTS `questionincategory` (
  `ID_Question` int(11) NOT NULL,
  `ID_Category` int(11) NOT NULL,
  PRIMARY KEY (`ID_Question`,`ID_Category`),
  KEY `ID_Question` (`ID_Question`),
  KEY `ID_Category` (`ID_Category`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Pseudo` varchar(30) NOT NULL,
  `BirthDate` date DEFAULT NULL,
  `Job` varchar(255) DEFAULT NULL,
  `Password` int(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `userhasaccount`
--

CREATE TABLE IF NOT EXISTS `userhasaccount` (
  `ID_User` int(11) NOT NULL,
  `ID_Account` int(11) NOT NULL,
  PRIMARY KEY (`ID_User`,`ID_Account`),
  KEY `ID_Account` (`ID_Account`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`ID_Platform`) REFERENCES `platform` (`ID`);

--
-- Contraintes pour la table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`ID_OriginQuestion`) REFERENCES `question` (`ID`);

--
-- Contraintes pour la table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`ID_ParentCategory`) REFERENCES `category` (`ID`);

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `question_ibfk_2` FOREIGN KEY (`ID_ParentQuestion`) REFERENCES `question` (`ID`),
  ADD CONSTRAINT `question_ibfk_1` FOREIGN KEY (`ID_UserCreator`) REFERENCES `user` (`ID`);

--
-- Contraintes pour la table `questionhistory`
--
ALTER TABLE `questionhistory`
  ADD CONSTRAINT `questionhistory_ibfk_1` FOREIGN KEY (`ID_ParentQuestion`) REFERENCES `question` (`ID`);

--
-- Contraintes pour la table `questionincategory`
--
ALTER TABLE `questionincategory`
  ADD CONSTRAINT `questionincategory_ibfk_2` FOREIGN KEY (`ID_Category`) REFERENCES `category` (`ID`),
  ADD CONSTRAINT `questionincategory_ibfk_1` FOREIGN KEY (`ID_Question`) REFERENCES `question` (`ID`);

--
-- Contraintes pour la table `userhasaccount`
--
ALTER TABLE `userhasaccount`
  ADD CONSTRAINT `userhasaccount_ibfk_2` FOREIGN KEY (`ID_Account`) REFERENCES `account` (`ID`),
  ADD CONSTRAINT `userhasaccount_ibfk_1` FOREIGN KEY (`ID_User`) REFERENCES `user` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
