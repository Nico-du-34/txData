CREATE TABLE IF NOT EXISTS `dealerships_creator_classes` (
	`id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`label` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COMMENT='Contains all vehicles classes'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;