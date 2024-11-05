/*
	Only for ESX with "weight" for items
	For QBCore check documentation
*/

INSERT IGNORE `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('tracker_sender', 'Tracker sender', 1, 0, 1),
	('tracker_receiver', 'Receiver', 1, 0, 1),
	('private_tracker', 'Receiver', 1, 0, 1)
;