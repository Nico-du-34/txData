CREATE TABLE IF NOT EXISTS `trackers_creator_private_frequencies` (
	`identifier` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`last_frequency` INT(11) NOT NULL,
	PRIMARY KEY (`identifier`) USING BTREE,
	INDEX `identifier` (`identifier`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
