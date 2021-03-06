-- DB update 2021_04_11_06 -> 2021_04_11_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_11_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_11_06 2021_04_11_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1617661090934443600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617661090934443600');

UPDATE `creature_template` SET `InhabitType` = 3 WHERE (`entry` IN (1018, 1019, 1140));

DELETE FROM `creature` WHERE (`id` = 1018) AND (`guid` IN (9981));
INSERT INTO `creature` VALUES
(9981, 1018, 0, 0, 0, 1, 1, 180, 0, -3112.84, -3252.45, 65.1154, 5.6466, 300, 0, 0, 896, 0, 0, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
