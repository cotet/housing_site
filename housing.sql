SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `housing` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `housing` ;

-- -----------------------------------------------------
-- Table `housing`.`roles`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`campuses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`campuses` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `address` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`users`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_roles` INT NOT NULL ,
  `id_campus` INT NOT NULL ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `address` VARCHAR(45) NULL ,
  `email` VARCHAR(45) NULL ,
  `phone` VARCHAR(45) NULL ,
  `age` VARCHAR(45) NULL ,
  `year` VARCHAR(45) NULL ,
  `major` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_users_roles1_idx` (`id_roles` ASC) ,
  INDEX `fk_users_campuses1_idx` (`id_campus` ASC) ,
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`id_roles` )
    REFERENCES `housing`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_campuses1`
    FOREIGN KEY (`id_campus` )
    REFERENCES `housing`.`campuses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`location_types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`location_types` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`locations`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`locations` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `description` VARCHAR(225) NULL ,
  `id_location_type` INT NOT NULL ,
  `id_campuses` INT NOT NULL ,
  `active` TINYINT(1) NULL ,
  `address` VARCHAR(45) NULL ,
  `price` VARCHAR(45) NULL ,
  `status` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_locations_campuses1_idx` (`id_campuses` ASC) ,
  INDEX `fk_locations_location_types1_idx` (`id_location_type` ASC) ,
  CONSTRAINT `fk_locations_campuses1`
    FOREIGN KEY (`id_campuses` )
    REFERENCES `housing`.`campuses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locations_location_types1`
    FOREIGN KEY (`id_location_type` )
    REFERENCES `housing`.`location_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`associated_students`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`associated_students` (
  `id` INT NOT NULL ,
  `id_locations` INT NOT NULL ,
  `id_users` INT NOT NULL ,
  `current` TINYINT(1) NULL ,
  `dateFrom` DATETIME NULL ,
  `dateTo` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_associated_users_locations1_idx` (`id_locations` ASC) ,
  INDEX `fk_associated_users_users1_idx` (`id_users` ASC) ,
  CONSTRAINT `fk_associated_users_locations1`
    FOREIGN KEY (`id_locations` )
    REFERENCES `housing`.`locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_associated_users_users1`
    FOREIGN KEY (`id_users` )
    REFERENCES `housing`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`location_nesting`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`location_nesting` (
  `id` INT NOT NULL ,
  `id_parent` INT NOT NULL ,
  `id_child` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_sub_location_locations1_idx` (`id_parent` ASC) ,
  INDEX `fk_sub_location_locations2_idx` (`id_child` ASC) ,
  CONSTRAINT `fk_sub_location_locations1`
    FOREIGN KEY (`id_parent` )
    REFERENCES `housing`.`locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sub_location_locations2`
    FOREIGN KEY (`id_child` )
    REFERENCES `housing`.`locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`user_group_types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`user_group_types` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`groups`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`groups` (
  `id` INT NOT NULL ,
  `id_user_group_types` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `description` VARCHAR(45) NULL ,
  `status` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_groups_user_group_types1_idx` (`id_user_group_types` ASC) ,
  CONSTRAINT `fk_user_groups_user_group_types1`
    FOREIGN KEY (`id_user_group_types` )
    REFERENCES `housing`.`user_group_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`group_members`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`group_members` (
  `id` INT NOT NULL ,
  `id_groups` INT NOT NULL ,
  `id_users` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_group_relation_groups1_idx` (`id_groups` ASC) ,
  INDEX `fk_user_group_relation_users1_idx` (`id_users` ASC) ,
  CONSTRAINT `fk_user_group_relation_groups1`
    FOREIGN KEY (`id_groups` )
    REFERENCES `housing`.`groups` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_relation_users1`
    FOREIGN KEY (`id_users` )
    REFERENCES `housing`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`application`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`application` (
  `id` INT NOT NULL ,
  `id_user` INT NOT NULL ,
  `id_locations` INT NOT NULL ,
  `date` DATETIME NULL ,
  `status` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_application_locations1_idx` (`id_locations` ASC) ,
  INDEX `fk_application_users1_idx` (`id_user` ASC) ,
  CONSTRAINT `fk_application_locations1`
    FOREIGN KEY (`id_locations` )
    REFERENCES `housing`.`locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_application_users1`
    FOREIGN KEY (`id_user` )
    REFERENCES `housing`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`thread_types`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`thread_types` (
  `id` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`thread_participants`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`thread_participants` (
  `id` INT NOT NULL ,
  `id_user` INT NOT NULL ,
  `id_thread` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_thread_participant_users1_idx` (`id_user` ASC) ,
  INDEX `fk_thread_participants_threads1_idx` (`id_thread` ASC) ,
  CONSTRAINT `fk_thread_participant_users1`
    FOREIGN KEY (`id_user` )
    REFERENCES `housing`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_thread_participants_threads1`
    FOREIGN KEY (`id_thread` )
    REFERENCES `housing`.`threads` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`message_state`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`message_state` (
  `id` INT NOT NULL ,
  `id_user` INT NOT NULL ,
  `id_message` INT NOT NULL ,
  `read_date` DATETIME NULL ,
  `read` TINYINT(1) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_message_read_state_users1_idx` (`id_user` ASC) ,
  INDEX `fk_message_read_state_message1_idx` (`id_message` ASC) ,
  CONSTRAINT `fk_message_read_state_users1`
    FOREIGN KEY (`id_user` )
    REFERENCES `housing`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_read_state_message1`
    FOREIGN KEY (`id_message` )
    REFERENCES `housing`.`message` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`user_settings`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`user_settings` (
  `id` INT NOT NULL ,
  `id_user` INT NOT NULL ,
  `theme` VARCHAR(45) NULL ,
  `signature` VARCHAR(45) NULL ,
  `autosignin` VARCHAR(45) NULL ,
  `public` TINYINT(1) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_settings_users1_idx` (`id_user` ASC) ,
  CONSTRAINT `fk_user_settings_users1`
    FOREIGN KEY (`id_user` )
    REFERENCES `housing`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`feedback`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`feedback` (
  `id` INT NOT NULL ,
  `id_location` INT NOT NULL ,
  `date` DATETIME NULL ,
  `comments` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_feedback_locations1_idx` (`id_location` ASC) ,
  CONSTRAINT `fk_feedback_locations1`
    FOREIGN KEY (`id_location` )
    REFERENCES `housing`.`locations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housing`.`feedback_item`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `housing`.`feedback_item` (
  `id` INT NOT NULL ,
  `id_feedback` INT NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `value` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_feedback_item_feedback1_idx` (`id_feedback` ASC) ,
  CONSTRAINT `fk_feedback_item_feedback1`
    FOREIGN KEY (`id_feedback` )
    REFERENCES `housing`.`feedback` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `housing` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
