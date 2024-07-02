-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bhocwyptj1on57zm183p
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bhocwyptj1on57zm183p
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bhocwyptj1on57zm183p` DEFAULT CHARACTER SET utf8 ;
USE `bhocwyptj1on57zm183p` ;

-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`movies` (
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
-- Table `bhocwyptj1on57zm183p`.`actors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`actors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `gender` CHAR(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`users` (
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
-- Table `bhocwyptj1on57zm183p`.`directors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`directors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(20) NULL,
  `lname` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`cast`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`cast` (
  `movie_id` INT NOT NULL,
  `actor_id` INT NOT NULL,
  `role` VARCHAR(30) NULL,
  PRIMARY KEY (`movie_id`, `actor_id`),
  INDEX `fk_movie_has_actor_actor1_idx` (`actor_id` ASC) VISIBLE,
  INDEX `fk_movie_has_actor_movie_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_actor_movie`
    FOREIGN KEY (`movie_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_actor_actor1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`actors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`direction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`direction` (
  `movie_id` INT NOT NULL,
  `director_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `director_id`),
  INDEX `fk_movie_has_director_director1_idx` (`director_id` ASC) VISIBLE,
  INDEX `fk_movie_has_director_movie1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_director_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_director_director1`
    FOREIGN KEY (`director_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`directors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`reviewers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`reviewers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`rating` (
  `movie_id` INT NOT NULL,
  `reviewer_id` INT NOT NULL,
  `stars` INT NULL,
  `ratings` INT NULL,
  PRIMARY KEY (`movie_id`, `reviewer_id`),
  INDEX `fk_movie_has_reviewer_reviewer1_idx` (`reviewer_id` ASC) VISIBLE,
  INDEX `fk_movie_has_reviewer_movie1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_reviewer_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_reviewer_reviewer1`
    FOREIGN KEY (`reviewer_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`reviewers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`genres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`titles` (
  `movie_id` INT NOT NULL,
  `genres_id` INT NOT NULL,
  PRIMARY KEY (`movie_id`, `genres_id`),
  INDEX `fk_movie_has_genres_genres1_idx` (`genres_id` ASC) VISIBLE,
  INDEX `fk_movie_has_genres_movie1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_genres_movie1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_genres_genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`genres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bhocwyptj1on57zm183p`.`recommendations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bhocwyptj1on57zm183p`.`recommendations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `movies_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `recommendation_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `movies_id`, `users_id`),
  INDEX `fk_recommendations_movies1_idx` (`movies_id` ASC) VISIBLE,
  INDEX `fk_recommendations_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_recommendations_movies1`
    FOREIGN KEY (`movies_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recommendations_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `bhocwyptj1on57zm183p`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `bhocwyptj1on57zm183p`.`actors`
-- -----------------------------------------------------
START TRANSACTION;
USE `bhocwyptj1on57zm183p`;
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Keanu', 'Reeves', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Michael', 'Nyqvist', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Alfie', 'Allen', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Willem', 'Dafoe', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Dean', 'Winters', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Adrianne', 'Palicki', 'F');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Omer', 'Barnea', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'John', 'Leguizamo', 'M');
INSERT INTO `bhocwyptj1on57zm183p`.`actors` (`id`, `first_name`, `last_name`, `gender`) VALUES (DEFAULT, 'Bridget', 'Moynahan', 'F');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bhocwyptj1on57zm183p`.`directors`
-- -----------------------------------------------------
START TRANSACTION;
USE `bhocwyptj1on57zm183p`;
INSERT INTO `bhocwyptj1on57zm183p`.`directors` (`id`, `fname`, `lname`) VALUES (DEFAULT, 'David', 'Leitch');

COMMIT;


-- -----------------------------------------------------
-- Data for table `bhocwyptj1on57zm183p`.`genres`
-- -----------------------------------------------------
START TRANSACTION;
USE `bhocwyptj1on57zm183p`;
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Acción');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Aventura');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Catástrofe');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Ciencia Ficción');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Comedia');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Documentales');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Drama');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Fantasía');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Musicales');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Suspense');
INSERT INTO `bhocwyptj1on57zm183p`.`genres` (`id`, `title`) VALUES (DEFAULT, 'Terror');

COMMIT;

