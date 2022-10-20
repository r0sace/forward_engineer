-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema swimmers medical
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema swimmers medical
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `swimmers medical` DEFAULT CHARACTER SET utf8 ;
USE `swimmers medical` ;

-- -----------------------------------------------------
-- Table `swimmers medical`.`Patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swimmers medical`.`Patients` (
  `idpatient` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(145) NOT NULL,
  `email` VARCHAR(245) NOT NULL,
  `phone` INT(10) NOT NULL,
  `insurance` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`idpatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swimmers medical`.`Doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swimmers medical`.`Doctors` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `specialty` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE INDEX `iddoctors_UNIQUE` (`doctor_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swimmers medical`.`appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swimmers medical`.`appointments` (
  `idappt` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `reason_for_appt` VARCHAR(245) NOT NULL,
  `date` DATETIME NOT NULL,
  `patient_id` INT UNSIGNED NOT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`idappt`),
  INDEX `fk_appointments_patients_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_appointments_doctors1_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointments_patients`
    FOREIGN KEY (`patient_id`)
    REFERENCES `swimmers medical`.`Patients` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointments_doctors1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `swimmers medical`.`Doctors` (`doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swimmers medical`.`Medications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swimmers medical`.`Medications` (
  `medication_id` INT NOT NULL AUTO_INCREMENT,
  `medication_name` VARCHAR(45) NOT NULL,
  `medication_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`medication_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swimmers medical`.`Prescriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swimmers medical`.`Prescriptions` (
  `idscript` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `meds` VARCHAR(145) NOT NULL,
  `descrip` VARCHAR(245) NOT NULL,
  `Medications_medication_id` INT NOT NULL,
  PRIMARY KEY (`idscript`, `Medications_medication_id`),
  INDEX `fk_Prescriptions_Medications1_idx` (`Medications_medication_id` ASC) VISIBLE,
  CONSTRAINT `fk_Prescriptions_Medications1`
    FOREIGN KEY (`Medications_medication_id`)
    REFERENCES `swimmers medical`.`Medications` (`medication_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `swimmers medical`.`Appts_has_Scripts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `swimmers medical`.`Appts_has_Scripts` (
  `appt_id` INT UNSIGNED NOT NULL,
  `script_id` INT UNSIGNED NULL,
  PRIMARY KEY (`appt_id`, `script_id`),
  INDEX `fk_appointments_has_prescriptions_prescriptions1_idx` (`script_id` ASC) VISIBLE,
  INDEX `fk_appointments_has_prescriptions_appointments1_idx` (`appt_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointments_has_prescriptions_appointments1`
    FOREIGN KEY (`appt_id`)
    REFERENCES `swimmers medical`.`appointments` (`idappt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointments_has_prescriptions_prescriptions1`
    FOREIGN KEY (`script_id`)
    REFERENCES `swimmers medical`.`Prescriptions` (`idscript`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
