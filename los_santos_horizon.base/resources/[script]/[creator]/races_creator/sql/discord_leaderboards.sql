CREATE TABLE IF NOT EXISTS `races_creator_discord_leaderboards` (
	`message_id` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`race_id` INT(11) NOT NULL,
	PRIMARY KEY (`message_id`) USING BTREE,
	INDEX `message_id` (`message_id`) USING BTREE,
	INDEX `race_id_leaderboards` (`race_id`) USING BTREE,
	CONSTRAINT `race_id_leaderboards` FOREIGN KEY (`race_id`) REFERENCES `races_creator_races` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
