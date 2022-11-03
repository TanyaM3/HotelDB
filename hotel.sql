-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hotel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8 ;
USE `hotel` ;

-- -----------------------------------------------------
-- Table `hotel`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`workers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`workers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`requests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `guestsNumber` INT NOT NULL,
  `class` VARCHAR(45) NOT NULL,
  `fromDate` DATE NOT NULL,
  `untilDate` DATE NOT NULL,
  `users_id` INT NOT NULL,
  `workers_id` INT NOT NULL,
  PRIMARY KEY (`id`, `workers_id`, `users_id`),
  INDEX `fk_requests_users_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_requests_workers1_idx` (`workers_id` ASC) VISIBLE,
  CONSTRAINT `fk_requests_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `hotel`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_requests_workers1`
    FOREIGN KEY (`workers_id`)
    REFERENCES `hotel`.`workers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `guestsNumber` INT NOT NULL,
  `price` DECIMAL(13,2) NOT NULL,
  `class` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`receipts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`receipts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `price` DECIMAL(13,2) NOT NULL,
  `rooms_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `workers_id` INT NOT NULL,
  `requests_id` INT NOT NULL,
  PRIMARY KEY (`id`, `rooms_id`, `users_id`, `workers_id`, `requests_id`),
  INDEX `fk_receipts_rooms1_idx` (`rooms_id` ASC) VISIBLE,
  INDEX `fk_receipts_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_receipts_workers1_idx` (`workers_id` ASC) VISIBLE,
  INDEX `fk_receipts_requests1_idx` (`requests_id` ASC) VISIBLE,
  CONSTRAINT `fk_receipts_rooms1`
    FOREIGN KEY (`rooms_id`)
    REFERENCES `hotel`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipts_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `hotel`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipts_workers1`
    FOREIGN KEY (`workers_id`)
    REFERENCES `hotel`.`workers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipts_requests1`
    FOREIGN KEY (`requests_id`)
    REFERENCES `hotel`.`requests` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`roles` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`state_of_room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`state_of_room` (
  `rooms_id` INT NOT NULL,
  `workers_id` INT NOT NULL,
  `booked` TINYINT(1) NULL,
  `reservationFrom` DATETIME NULL,
  `reservationUntil` DATETIME NULL,
  PRIMARY KEY (`rooms_id`, `workers_id`),
  INDEX `fk_state_of_room_rooms1_idx` (`rooms_id` ASC) VISIBLE,
  INDEX `fk_state_of_room_workers1_idx` (`workers_id` ASC) VISIBLE,
  CONSTRAINT `fk_state_of_room_rooms1`
    FOREIGN KEY (`rooms_id`)
    REFERENCES `hotel`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_state_of_room_workers1`
    FOREIGN KEY (`workers_id`)
    REFERENCES `hotel`.`workers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel`.`workers_has_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`workers_has_roles` (
  `workers_id` INT NOT NULL,
  `roles_id` INT NOT NULL,
  PRIMARY KEY (`workers_id`, `roles_id`),
  INDEX `fk_workers_has_roles_roles1_idx` (`roles_id` ASC) VISIBLE,
  INDEX `fk_workers_has_roles_workers1_idx` (`workers_id` ASC) VISIBLE,
  CONSTRAINT `fk_workers_has_roles_workers1`
    FOREIGN KEY (`workers_id`)
    REFERENCES `hotel`.`workers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_workers_has_roles_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `hotel`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
