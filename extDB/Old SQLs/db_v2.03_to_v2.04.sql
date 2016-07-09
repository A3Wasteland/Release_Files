-- This is for those who are running the A3W database v2.03

-- Changes: added LastServerID column to PlayerSave, added OwnerUID column to ServerObjects and ServerVehicles, added ServerTime table

USE `a3wasteland`; -- database name

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `PlayerSave` 
ADD COLUMN `LastServerID` INT UNSIGNED NULL AFTER `LastModified`,
ADD INDEX `fk_PlayerSave_ServerInstance_idx` (`LastServerID` ASC),
ADD CONSTRAINT `fk_PlayerSave_ServerInstance`
  FOREIGN KEY (`LastServerID`)
  REFERENCES `ServerInstance` (`ID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `ServerObjects` 
ADD COLUMN `OwnerUID` VARCHAR(32) NOT NULL DEFAULT '\"\"' AFTER `LastInteraction`;

ALTER TABLE `ServerVehicles` 
ADD COLUMN `OwnerUID` VARCHAR(32) NOT NULL DEFAULT '\"\"' AFTER `LastUsed`;

CREATE TABLE IF NOT EXISTS `ServerTime` (
  `ServerID` INT UNSIGNED NOT NULL,
  `MapID` INT UNSIGNED NOT NULL,
  `DayTime` FLOAT NULL,
  `Fog` FLOAT NULL,
  `Overcast` FLOAT NULL,
  `Rain` FLOAT NULL,
  `Wind` VARCHAR(128) NULL,
  INDEX `fk_ServerTime_ServerInstance_idx` (`ServerID` ASC),
  INDEX `fk_ServerTime_ServerMap_idx` (`MapID` ASC),
  UNIQUE INDEX `idx_ServerTime_uniquePair` (`ServerID` ASC, `MapID` ASC),
  CONSTRAINT `fk_ServerTime_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServerTime_ServerMap`
    FOREIGN KEY (`MapID`)
    REFERENCES `ServerMap` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


START TRANSACTION;

INSERT INTO DBInfo SET Name = 'Version', Value = '2.04' 
ON DUPLICATE KEY UPDATE Value = VALUES(Value);

COMMIT;
