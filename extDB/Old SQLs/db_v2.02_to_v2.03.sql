-- This is for those who are running the A3W database v2.02

-- Changes: added BankTransferLog table, added "Deployable" column in ServerObjects, cleaned indexes and removed PKs on player UID columns to reduce extDB errors

USE `a3wasteland`; -- database name

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `PlayerInfo` 
CHANGE COLUMN `LastSide` `LastSide` VARCHAR(32) NULL DEFAULT NULL ;

ALTER TABLE `PlayerSave` 
ADD UNIQUE INDEX `idx_PlayerSave_uniquePlayer` (`PlayerUID` ASC, `MapID` ASC),
DROP PRIMARY KEY;

ALTER TABLE `ServerObjects` 
ADD COLUMN `Deployable` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 AFTER `Locked`,
DROP INDEX `ID_UNIQUE` ;

ALTER TABLE `ServerVehicles` 
DROP INDEX `ID_UNIQUE` ;

ALTER TABLE `PlayerStats` 
ADD UNIQUE INDEX `idx_PlayerStats_uniquePlayer` (`PlayerUID` ASC),
DROP PRIMARY KEY;

ALTER TABLE `PlayerStatsMap` 
ADD INDEX `fk_PlayerStatsMap_ServerMap_idx` (`MapID` ASC),
ADD INDEX `fk_PlayerStatsMap_ServerInstance_idx` (`ServerID` ASC),
ADD UNIQUE INDEX `idx_PlayerStatsMap_uniquePlayer` (`PlayerUID` ASC, `ServerID` ASC, `MapID` ASC),
DROP INDEX `fk_PlayerStatsMap_ServerInstance1_idx` ,
DROP INDEX `fk_PlayerStatsMap_ServerMap1_idx` ,
DROP PRIMARY KEY;

CREATE TABLE IF NOT EXISTS `BankTransferLog` (
  `ServerID` INT UNSIGNED NOT NULL,
  `Time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SenderName` VARCHAR(256) CHARACTER SET 'utf8' NOT NULL,
  `SenderUID` VARCHAR(32) NOT NULL,
  `SenderSide` VARCHAR(32) NULL DEFAULT NULL,
  `RecipientName` VARCHAR(256) CHARACTER SET 'utf8' NOT NULL,
  `RecipientUID` VARCHAR(32) NOT NULL,
  `RecipientSide` VARCHAR(32) NULL DEFAULT NULL,
  `Amount` FLOAT NOT NULL,
  `Fee` FLOAT NOT NULL,
  INDEX `fk_BankTransfers_ServerInstance_idx` (`ServerID` ASC),
  CONSTRAINT `fk_BankTransfers_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


START TRANSACTION;

INSERT INTO DBInfo SET Name = 'Version', Value = '2.03' 
ON DUPLICATE KEY UPDATE Value = VALUES(Value);

COMMIT;
