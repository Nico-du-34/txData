CREATE TABLE IF NOT EXISTS `missions_creator_statistics` (
	`template_id` INT(11) NOT NULL,
	`likes` INT(11) NOT NULL DEFAULT '0',
	`dislikes` INT(11) NOT NULL DEFAULT '0',
	`success_count` INT(11) NOT NULL DEFAULT '0',
	`fail_count` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`template_id`) USING BTREE,
	UNIQUE INDEX `template_id` (`template_id`) USING BTREE,
	CONSTRAINT `fk_mc_statistics_mc_templates` FOREIGN KEY (`template_id`) REFERENCES `missions_creator_templates` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COMMENT='Keeps tracks of the missions statisticks (likes, dislikes, success/fail count)'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
