CREATE TABLE IF NOT EXISTS `dealerships_creator_dealerships` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`label` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`type` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`data` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`owner` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`stored_money` INT(11) NOT NULL DEFAULT '0',
	`employees_data` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`stock_vehicles` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	`models_prices` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
