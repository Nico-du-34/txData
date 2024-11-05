/*
	Only for ESX with "limit" for items
	For QBCore check documentation
*/

INSERT IGNORE `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('tracker_sender', 'Tracker sender', 100, 0, 1),
	('tracker_receiver', 'Receiver', 100, 0, 1),
	('private_tracker', 'Receiver', 100, 0, 1)
;