CREATE TABLE IF NOT EXISTS `dealerships_creator_loans` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`dealership_id` INT(11) NULL DEFAULT NULL,
	`vehicle_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`plate` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`installment` INT(11) NOT NULL,
	`payment_dates` LONGTEXT NOT NULL COLLATE 'utf8mb4_bin',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `id` (`id`) USING BTREE,
	INDEX `fk_dc_loans_dc_admin_dealerships` (`dealership_id`) USING BTREE,
	CONSTRAINT `fk_dc_loans_dc_admin_dealerships` FOREIGN KEY (`dealership_id`) REFERENCES `dealerships_creator_dealerships` (`id`) ON UPDATE CASCADE ON DELETE SET NULL
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
