CREATE TABLE IF NOT EXISTS `races_creator_players_races_records` (
	`identifier` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`race_id` INT(11) NOT NULL,
	`nickname` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`best_time` INT(11) NULL DEFAULT NULL,
	`data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	PRIMARY KEY (`identifier`, `race_id`) USING BTREE,
	INDEX `identifier` (`identifier`) USING BTREE,
	INDEX `race_id` (`race_id`) USING BTREE,
	CONSTRAINT `race_id` FOREIGN KEY (`race_id`) REFERENCES `races_creator_races` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='Records of each player for the races'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
