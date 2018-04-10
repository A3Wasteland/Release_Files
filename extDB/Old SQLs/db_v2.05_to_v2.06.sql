-- This is for those who are running the A3W database v2.05
-- current BankMoney is copied to all environments, after which each value will be independent, and current bounties are erased

USE `a3wasteland`; -- database name

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

ALTER TABLE `AntihackLog` 
ADD COLUMN `EntryID` INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (`EntryID`);

ALTER TABLE `PlayerSave` 
CHANGE COLUMN `Money` `Money` INT UNSIGNED NOT NULL DEFAULT 0 ;

CREATE TABLE IF NOT EXISTS `PlayerStatus` (
  `PlayerUID` VARCHAR(32) NOT NULL,
  `MapID` INT UNSIGNED NOT NULL,
  `CreationDate` TIMESTAMP NULL DEFAULT NULL,
  `LastModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `BankMoney` INT UNSIGNED NOT NULL DEFAULT 0,
  `Bounty` INT UNSIGNED NOT NULL DEFAULT 0,
  `BountyKills` VARCHAR(8192) NOT NULL DEFAULT '[]',
  INDEX `fk_PlayerStatus_PlayerInfo_idx` (`PlayerUID` ASC) ,
  INDEX `fk_PlayerStatus_ServerMap_idx` (`MapID` ASC) ,
  UNIQUE INDEX `idx_PlayerStatus_uniquePlayerMap` (`PlayerUID` ASC, `MapID` ASC) ,
  INDEX `idx_PlayerStatus_crossMap` (`PlayerUID` ASC, `LastModified` ASC) ,
  CONSTRAINT `fk_PlayerStatus_PlayerInfo`
    FOREIGN KEY (`PlayerUID`)
    REFERENCES `PlayerInfo` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerStatus_ServerMap`
    FOREIGN KEY (`MapID`)
    REFERENCES `ServerMap` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


START TRANSACTION;

INSERT INTO PlayerStatus (PlayerUID, MapID, CreationDate, BankMoney) 
SELECT pi.UID, sm.ID, CURRENT_TIMESTAMP, pi.BankMoney FROM PlayerInfo pi CROSS JOIN ServerMap sm;

INSERT INTO DBInfo SET Name = 'Version', Value = '2.06' 
ON DUPLICATE KEY UPDATE Value = VALUES(Value);

ALTER TABLE `PlayerInfo` 
DROP COLUMN `BountyKills`,
DROP COLUMN `Bounty`,
DROP COLUMN `BankMoney`;

COMMIT;
