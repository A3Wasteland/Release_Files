-- This is for those who setup the database using the initial v2.0 script

START TRANSACTION;
USE a3wasteland;

ALTER TABLE PlayerInfo 
CHANGE COLUMN Name Name VARCHAR(256) CHARACTER SET 'utf8' NULL;

ALTER TABLE AntihackLog 
ADD COLUMN AdminNote VARCHAR(4096) CHARACTER SET 'utf8' NULL;

INSERT INTO DBInfo SET Name = 'Version', Value = '2.01' 
ON DUPLICATE KEY UPDATE Value = VALUES(Value);

COMMIT;
