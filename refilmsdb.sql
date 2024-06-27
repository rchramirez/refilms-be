-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema refilmsdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema refilmsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `refilmsdb` DEFAULT CHARACTER SET utf8 ;
USE `refilmsdb` ;

-- -----------------------------------------------------
-- Table `refilmsdb`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NULL,
  `year` INT NULL,
  `time` INT NULL,
  `lang` VARCHAR(50) NULL,
  `resume` VARCHAR(150) NULL,
  `release_date` VARCHAR(45) NULL,
  `synopsis` TEXT NULL,
  `image` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`actors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `gender` CHAR(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`directors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(20) NULL,
  `lname` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`cast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`cast` (
  `movie_id` INT NOT NULL,
  `actor_id` INT NOT NULL,
  `role` VARCHAR(30) NULL,
  PRIMARY KEY (`movie_id`, `actor_id`),
  INDEX `fk_movie_has_actor_actor1_idx` (`actor_id` ASC) VISIBLE,
  INDEX `fk_movie_has_actor_movie_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_actor_movie`
    FOREIGN KEY (`movie_id`)
    REFERENCES `refilmsdb`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_actor_actor1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `refilmsdb`.`actors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`direction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`direction` (
  `movie_id` INT NOT NULL,
  `director_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `director_id`),
  INDEX `fk_movie_has_director_director1_idx` (`director_id` ASC) VISIBLE,
  INDEX `fk_movie_has_director_movie1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_director_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `refilmsdb`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_director_director1`
    FOREIGN KEY (`director_id`)
    REFERENCES `refilmsdb`.`directors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`reviewers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`reviewers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`rating` (
  `movie_id` INT NOT NULL,
  `reviewer_id` INT NOT NULL,
  `stars` INT NULL,
  `ratings` INT NULL,
  PRIMARY KEY (`movie_id`, `reviewer_id`),
  INDEX `fk_movie_has_reviewer_reviewer1_idx` (`reviewer_id` ASC) VISIBLE,
  INDEX `fk_movie_has_reviewer_movie1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_reviewer_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `refilmsdb`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_reviewer_reviewer1`
    FOREIGN KEY (`reviewer_id`)
    REFERENCES `refilmsdb`.`reviewers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`titles` (
  `movie_id` INT NOT NULL,
  `genres_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `genres_id`),
  INDEX `fk_movie_has_genres_genres1_idx` (`genres_id` ASC) VISIBLE,
  INDEX `fk_movie_has_genres_movie1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_genres_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `refilmsdb`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_genres_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `refilmsdb`.`genres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `refilmsdb`.`recommendations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `refilmsdb`.`recommendations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `movies_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `recommendation_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `movies_id`, `users_id`),
  INDEX `fk_recommendations_movies1_idx` (`movies_id` ASC) VISIBLE,
  INDEX `fk_recommendations_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_recommendations_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `refilmsdb`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recommendations_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `refilmsdb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `refilmsdb`.`actors`
-- -----------------------------------------------------
START TRANSACTION;
USE `refilmsdb`;
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Keanu', 'Reeves', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Michael', 'Nyqvist', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Alfie', 'Allen', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Willem', 'Dafoe', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Dean', 'Winters', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Adrianne', 'Palicki', 'F');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Omer', 'Barnea', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'John', 'Leguizamo', 'M');
INSERT INTO `refilmsdb`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Bridget', 'Moynahan', 'F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `refilmsdb`.`directors`
-- -----------------------------------------------------
START TRANSACTION;
USE `refilmsdb`;
INSERT INTO `refilmsdb`.`directors` (`id`, `fname`, `lname`) VALUES (DEFAULT, 'David', 'Leitch');

COMMIT;


-- -----------------------------------------------------
-- Data for table `refilmsdb`.`genres`
-- -----------------------------------------------------
START TRANSACTION;
USE `refilmsdb`;
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Acción');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Aventura');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Catástrofe');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Ciencia Ficción');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Comedia');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Documentales');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Drama');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Fantasía');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Musicales');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Suspense');
INSERT INTO `refilmsdb`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Terror');

COMMIT;

