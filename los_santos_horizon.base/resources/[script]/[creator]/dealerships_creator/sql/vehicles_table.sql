CREATE TABLE IF NOT EXISTS `dealerships_creator_vehicles` (
	`spawn_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`label` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`class` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`type` VARCHAR(50) NOT NULL COMMENT 'Used in external scripts' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`spawn_name`) USING BTREE,
	INDEX `fk_dc_vehicles_dc_classes` (`class`) USING BTREE,
	CONSTRAINT `fk_dc_vehicles_dc_classes` FOREIGN KEY (`class`) REFERENCES `dealerships_creator_classes` (`id`) ON UPDATE CASCADE ON DELETE SET NULL
)
COMMENT='Contains all vehicles that can be used by Dealerships Creator'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;