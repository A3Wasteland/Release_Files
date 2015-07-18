-- This is for those who are running the A3W database v2.01

START TRANSACTION;
USE a3wasteland;

CREATE TABLE IF NOT EXISTS `a3wasteland`.`PlayerStatsMap` (
  `PlayerUID` VARCHAR(32) NOT NULL,
  `ServerID` INT UNSIGNED NOT NULL,
  `MapID` INT UNSIGNED NOT NULL,
  `LastModified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `PlayerKills` INT UNSIGNED NOT NULL DEFAULT 0,
  `AIKills` INT UNSIGNED NOT NULL DEFAULT 0,
  `TeamKills` INT UNSIGNED NOT NULL DEFAULT 0,
  `DeathCount` INT UNSIGNED NOT NULL DEFAULT 0,
  `ReviveCount` INT UNSIGNED NOT NULL DEFAULT 0,
  `CaptureCount` INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`PlayerUID`, `ServerID`, `MapID`),
  INDEX `fk_PlayerStatsMap_ServerMap1_idx` (`MapID` ASC),
  INDEX `fk_PlayerStatsMap_ServerInstance1_idx` (`ServerID` ASC),
  CONSTRAINT `fk_PlayerStatsMap_PlayerStats`
    FOREIGN KEY (`PlayerUID`)
    REFERENCES `a3wasteland`.`PlayerStats` (`PlayerUID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerStatsMap_ServerMap`
    FOREIGN KEY (`MapID`)
    REFERENCES `a3wasteland`.`ServerMap` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerStatsMap_ServerInstance`
    FOREIGN KEY (`ServerID`)
    REFERENCES `a3wasteland`.`ServerInstance` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO DBInfo SET Name = 'Version', Value = '2.02' 
ON DUPLICATE KEY UPDATE Value = VALUES(Value);

COMMIT;
