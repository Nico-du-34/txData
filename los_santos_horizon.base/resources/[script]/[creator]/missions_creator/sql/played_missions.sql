CREATE TABLE IF NOT EXISTS `missions_creator_played_missions` (
	`identifier` VARCHAR(46) NOT NULL COLLATE 'utf8mb4_general_ci',
	`template_id` INT(11) NOT NULL,
	`last_played` INT(11) NOT NULL,
	`completed` BIT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`identifier`, `template_id`) USING BTREE,
	INDEX `fk_mc_played_missions_mc_templates` (`template_id`) USING BTREE,
	CONSTRAINT `fk_mc_played_missions_mc_templates` FOREIGN KEY (`template_id`) REFERENCES `missions_creator_templates` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;