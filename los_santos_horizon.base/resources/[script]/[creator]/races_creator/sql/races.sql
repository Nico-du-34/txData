CREATE TABLE IF NOT EXISTS `races_creator_races` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`label` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`data` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`identifier` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `id` (`id`) USING BTREE,
	CONSTRAINT `data` CHECK (json_valid(`data`))
)
COMMENT='Admin and player races'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;