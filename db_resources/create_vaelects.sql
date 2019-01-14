-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema vaelects
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema vaelects
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vaelects` DEFAULT CHARACTER SET utf8 ;
USE `vaelects` ;

-- -----------------------------------------------------
-- Table `vaelects`.`offices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vaelects`.`offices` (
  `office_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`office_id`),
  UNIQUE INDEX `office_id_UNIQUE` (`office_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vaelects`.`parties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vaelects`.`parties` (
  `party_id` VARCHAR(50) NOT NULL,
  `party_name` VARCHAR(45) NULL,
  `website` VARCHAR(255) NULL,
  PRIMARY KEY (`party_id`),
  UNIQUE INDEX `party_id_UNIQUE` (`party_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vaelects`.`elections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vaelects`.`elections` (
  `election_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `district` INT NULL,
  `office_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`election_id`),
  UNIQUE INDEX `election_id_UNIQUE` (`election_id` ASC),
  INDEX `fk_elections_offices1_idx` (`office_id` ASC),
  CONSTRAINT `fk_elections_offices1`
    FOREIGN KEY (`office_id`)
    REFERENCES `vaelects`.`offices` (`office_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vaelects`.`candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vaelects`.`candidates` (
  `candidate_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `website` VARCHAR(255) NULL,
  `party_id` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`candidate_id`),
  INDEX `fk_candidates_parties1_idx` (`party_id` ASC),
  CONSTRAINT `fk_candidates_parties1`
    FOREIGN KEY (`party_id`)
    REFERENCES `vaelects`.`parties` (`party_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vaelects`.`election_candidates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vaelects`.`election_candidates` (
  `election_id` INT NOT NULL,
  `candidate_id` INT NOT NULL,
  PRIMARY KEY (`election_id`, `candidate_id`),
  INDEX `fk_elections_has_candidates_candidates1_idx` (`candidate_id` ASC),
  INDEX `fk_elections_has_candidates_elections_idx` (`election_id` ASC),
  CONSTRAINT `fk_elections_has_candidates_elections`
    FOREIGN KEY (`election_id`)
    REFERENCES `vaelects`.`elections` (`election_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_elections_has_candidates_candidates1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `vaelects`.`candidates` (`candidate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vaelects`.`election_results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vaelects`.`election_results` (
  `election_id` INT NOT NULL,
  `candidate_id` INT NOT NULL,
  `num_votes` INT NULL,
  `winner` INT NULL,
  PRIMARY KEY (`election_id`, `candidate_id`),
  INDEX `fk_election_results_elections1_idx` (`election_id` ASC),
  INDEX `fk_election_results_candidates1_idx` (`candidate_id` ASC),
  CONSTRAINT `fk_election_results_elections1`
    FOREIGN KEY (`election_id`)
    REFERENCES `vaelects`.`elections` (`election_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_election_results_candidates1`
    FOREIGN KEY (`candidate_id`)
    REFERENCES `vaelects`.`candidates` (`candidate_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `vaelects`.`offices`
-- -----------------------------------------------------
START TRANSACTION;
USE `vaelects`;
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('president');
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('governor');
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('ltgovernor');
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('ushouse');
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('ussenate');
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('vahouse');
INSERT INTO `vaelects`.`offices` (`office_id`) VALUES ('vasenate');

COMMIT;


-- -----------------------------------------------------
-- Data for table `vaelects`.`parties`
-- -----------------------------------------------------
START TRANSACTION;
USE `vaelects`;
INSERT INTO `vaelects`.`parties` (`party_id`, `party_name`, `website`) VALUES ('dem', 'Democratic', NULL);
INSERT INTO `vaelects`.`parties` (`party_id`, `party_name`, `website`) VALUES ('rep', 'Republican', NULL);
INSERT INTO `vaelects`.`parties` (`party_id`, `party_name`, `website`) VALUES ('lib', 'Libertarian', NULL);
INSERT INTO `vaelects`.`parties` (`party_id`, `party_name`, `website`) VALUES ('grn', 'Green', NULL);
INSERT INTO `vaelects`.`parties` (`party_id`, `party_name`, `website`) VALUES ('ind', 'Independent', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `vaelects`.`elections`
-- -----------------------------------------------------
START TRANSACTION;
USE `vaelects`;
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', NULL, 'president');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', NULL, 'ussenate');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 1, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 2, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 3, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 4, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 5, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 6, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 7, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 8, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 9, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 10, 'ushouse');
INSERT INTO `vaelects`.`elections` (`election_id`, `date`, `type`, `district`, `office_id`) VALUES (DEFAULT, '2020-11-3', 'general', 11, 'ushouse');

COMMIT;

