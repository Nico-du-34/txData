CREATE TABLE IF NOT EXISTS `missions_creator_templates` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`label` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`description` LONGTEXT NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`options` LONGTEXT NOT NULL COLLATE 'latin1_swedish_ci',
	`stages` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `id` (`id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB;