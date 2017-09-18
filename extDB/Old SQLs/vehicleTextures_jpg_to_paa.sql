-- In A3Wasteland v1.2, older JPG vehicle textures have been converted to PAA format in order to prevent vehicles from appearing black when far from the player. Also, some old filenames were also changed.
-- In order for painted saved vehicles to load correctly, the .JPG extensions in the database need to be converted to .PAA, so that players don't get "Cannot load texture" errors.
-- Only the textures included in vanilla A3W v1.1b are replaced by this query, if you had custom JPG textures and you've also converted all of them to PAA, then you can use the following statement instead:

-- UPDATE ServerVehicles SET Textures = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Textures,'\\camo_fuel.','\\swamp.'),'\\camo_fack.','\\camo_orange.'),'\\camo_deser.','\\camo_red.'),'\\camo_pank.','\\camo_pink.'),'.jpg','.paa') WHERE ID > 0;


USE `a3wasteland`; -- database name

START TRANSACTION;

UPDATE ServerVehicles SET Textures = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Textures,'\\nato.jpg','\\nato.paa'),'\\csat.jpg','\\csat.paa'),'\\aaf.jpg','\\aaf.paa'),'\\rainbow.jpg','\\rainbow.paa'),'\\carbon.jpg','\\carbon.paa'),'\\rusty.jpg','\\rusty.paa'),'\\denim.jpg','\\denim.paa'),'\\psych.jpg','\\psych.paa'),'\\leopard.jpg','\\leopard.paa'),'\\weed.jpg','\\weed.paa'),'\\murica.jpg','\\murica.paa'),'\\confederate.jpg','\\confederate.paa'),'\\unionjack.jpg','\\unionjack.paa'),'\\camo_fuel.jpg','\\swamp.paa'),'\\camo_fack.jpg','\\camo_orange.paa'),'\\camo_deser.jpg','\\camo_red.paa'),'\\camo_pank.jpg','\\camo_pink.paa') WHERE ID > 0;

COMMIT;
