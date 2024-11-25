-- player_vehicles
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `in_garage` TINYINT(1) DEFAULT '1';
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `garage_id` VARCHAR(50) DEFAULT 'Legion Square';
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `job_vehicle` TINYINT(1) DEFAULT '0';
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `gang_vehicle` TINYINT(1) DEFAULT '0';
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `impound` INT(10) DEFAULT '0';
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `impound_retrievable` INT(10) DEFAULT '0';
ALTER TABLE `player_vehicles` ADD COLUMN IF NOT EXISTS `impound_data` LONGTEXT DEFAULT '';

-- player_priv_garages
CREATE TABLE IF NOT EXISTS `player_priv_garages` (
	`id` INT(11) unsigned NOT NULL AUTO_INCREMENT,
	`citizenid` VARCHAR(50),
	`name` VARCHAR(50),
	`type` VARCHAR(50),
	`x` INT(11),
	`y` INT(11),
	`z` INT(11),
	`h` INT(11),
	`distance` INT(11) DEFAULT '10',
	PRIMARY KEY (`id`)
);