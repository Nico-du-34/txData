Config = Config or {}

Config.UsingPsHousing = false
Config.UsingDefaultQBApartments = true
Config.OnlyShowOnDuty = true

-- RECOMMENDED Fivemerr Images. DOES NOT EXPIRE. 
-- YOU NEED TO SET THIS UP FOLLOW INSTRUCTIONS BELOW.
-- Documents: https://docs.fivemerr.com/integrations/mdt-scripts/ps-mdt
Config.FivemerrMugShot = true

-- Discord webhook for images. NOT RECOMMENDED, IMAGES EXPIRE.
Config.MugShotWebhook = false
Config.UseCQCMugshot = true

-- Front, Back Side. Use 4 for both sides, we recommend leaving at 1 for default.
Config.MugPhotos = 1

-- If set to true = Fine gets automatically removed from bank automatically charging the player.
-- If set to false = The fine gets sent as an Invoice to their phone and it us to the player to pay for it, can remain unpaid and ignored.
Config.BillVariation = true

-- If set to false (default) = The fine amount is just being removed from the player's bank account
-- If set to true = The fine amount is beeing added to the society account after being removed from the player's bank account
Config.QBBankingUse = true

-- Set up your inventory to automatically retrieve images when a weapon is registered at a weapon shop or self-registered.
-- If you're utilizing lj-inventory's latest version from GitHub, no further modifications are necessary. 
-- However, if you're using a different inventory system, please refer to the "Inventory Edit | Automatic Add Weapons with images" section in ps-mdt's README.
Config.InventoryForWeaponsImages = "qb-inventory"

-- Only compatible with ox_inventory
Config.RegisterWeaponsAutomatically = true

-- Set to true to register all weapons that are added via AddItem in ox_inventory
Config.RegisterCreatedWeapons = true

-- "LegacyFuel", "lj-fuel", "ps-fuel"
Config.Fuel = "cdn-fuel"

-- Google Docs Link
Config.sopLink = {
    ['police'] = '',
    ['ambulance'] = '',
    ['sherif'] = '',
    ['doj'] = '',
    ['sast'] = '',
    ['sasp'] = '',
    ['doc'] = '',
    ['lssd'] = '',
    ['sapr'] = '',
}

-- Google Docs Link
Config.RosterLink = {
    ['police'] = '',
    ['ambulance'] = '',
    ['sherif'] = '',
    ['doj'] = '',
    ['sast'] = '',
    ['sasp'] = '',
    ['doc'] = '',
    ['lssd'] = '',
    ['sapr'] = '',	
}

Config.PoliceJobs = {
    ['police'] = true,
    ['lspd'] = true,
    ['sherif'] = true,
    ['sast'] = true,
    ['sasp'] = true,
    ['doc'] = true,
    ['lssd'] = true,
    ['sapr'] = true,
    ['pa'] = true
}

Config.AmbulanceJobs = {
    ['ambulance'] = true,
    ['doctor'] = true
}

Config.DojJobs = {
    ['lawyer'] = true,
    ['judge'] = true
}

-- This is a workaround solution because the qb-menu present in qb-policejob fills in an impound location and sends it to the event. 
-- If the impound locations are modified in qb-policejob, the changes must also be implemented here to ensure consistency.

Config.ImpoundLocations = {
    [1] = vector4(436.68, -1007.42, 27.32, 180.0),
    [2] = vector4(-436.14, 5982.63, 31.34, 136.0),
}

-- Support for Wraith ARS 2X. 

Config.UseWolfknightRadar = false
Config.WolfknightNotifyTime = 5000 -- How long the notification displays for in milliseconds (30000 = 30 seconds)
Config.PlateScanForDriversLicense = false -- If true, plate scanner will check if the owner of the scanned vehicle has a drivers license

-- IMPORTANT: To avoid making excessive database queries, modify this config to true 'CONFIG.use_sonorancad = true' setting in the configuration file located at 'wk_wars2x/config.lua'. 
-- Enabling this setting will limit plate checks to only those vehicles that have been used by a player.

Config.LogPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['sherif'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveIncidentPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['sherif'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveReportPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['sherif'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveWeaponsPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['sherif'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.PenalCodeTitles = {
    [1] = 'INFRACTIONS CONTRE LES PERSONNES',
    [2] = 'INFRACTIONS LIÉES AU VOL',
    [3] = 'INFRACTIONS LIÉES À LA FRAUDE',
    [4] = 'INFRACTIONS LIÉES AUX DÉGÂTS MATÉRIELS',
    [5] = 'INFRACTIONS CONTRE L’ADMINISTRATION PUBLIQUE',
    [6] = 'INFRACTIONS CONTRE L’ORDRE PUBLIC',
    [7] = 'INFRACTIONS CONTRE LA SANTÉ ET LES BONNES MOEURS',
    [8] = 'INFRACTIONS CONTRE LA SÉCURITÉ PUBLIQUE',
    [9] = 'INFRACTIONS LIÉES À LA CONDUITE D’UN VÉHICULE',
    [10] = 'INFRACTIONS LIÉES AU BIEN-ÊTRE DE LA FAUNE',
}

Config.PenalCode = {
    [1] = {
        [1] = {title = 'Agression simple', class = 'Délit', id = 'P.C. 1001', months = 7, fine = 500, color = 'green', description = 'Lorsqu’une personne provoque intentionnellement ou sciemment un contact physique avec une autre (sans arme)'},
        [2] = {title = 'Agression', class = 'Délit', id = 'P.C. 1002', months = 15, fine = 850, color = 'orange', description = 'Si une personne provoque intentionnellement ou sciemment des blessures à une autre (sans arme)'},
        [3] = {title = 'Agression aggravée', class = 'Crime', id = 'P.C. 1003', months = 20, fine = 1250, color = 'orange', description = 'Lorsqu’une personne provoque de manière imprudente et involontaire des blessures corporelles à une autre suite à une confrontation ET cause des blessures corporelles'},
        [4] = {title = 'Agression avec une arme mortelle', class = 'Crime', id = 'P.C. 1004', months = 30, fine = 3750, color = 'red', description = 'Lorsqu’une personne provoque intentionnellement, sciemment ou imprudemment des blessures corporelles à une autre personne ET provoque des blessures graves ou utilise/exhibe une arme mortelle'},
        [5] = {title = 'Homicide involontaire', class = 'Crime', id = 'P.C. 1005', months = 60, fine = 7500, color = 'red', description = 'Lorsqu’une personne provoque de manière imprudente et involontaire la mort d’une autre'},
        [6] = {title = 'Homicide involontaire avec un véhicule', class = 'Crime', id = 'P.C. 1006', months = 75, fine = 7500, color = 'red', description = 'Lorsqu’une personne provoque de manière imprudente et involontaire la mort d’une autre avec un véhicule'},
        [7] = {title = 'Tentative de meurtre sur un civil', class = 'Crime', id = 'P.C. 1007', months = 50, fine = 7500, color = 'red', description = 'Lorsqu’une personne non-gouvernementale attaque intentionnellement une autre avec l’intention de tuer'},
        [8] = {title = 'Meurtre au second degré', class = 'Crime', id = 'P.C. 1008', months = 100, fine = 15000, color = 'red', description = 'Tout meurtre intentionnel qui n’est pas prémédité ou planifié. Une situation où le tueur n’a l’intention que de causer de graves blessures corporelles.'},
        [9] = {title = 'Complice de meurtre au second degré', class = 'Crime', id = 'P.C. 1009', months = 50, fine = 5000, color = 'red', description = 'Être présent et/ou participer à l’acte lié à la charge principale'},
        [10] = {title = 'Meurtre au premier degré', class = 'Crime', id = 'P.C. 1010', months = 0, fine = 0, color = 'red', description = 'Tout meurtre intentionnel qui est volontaire, prémédité et avec malveillance.'},
        [11] = {title = 'Complice de meurtre au premier degré', class = 'Crime', id = 'P.C. 1011', months = 0, fine = 0, color = 'red', description = 'Être présent et/ou participer à l’acte lié à la charge principale'},
        [12] = {title = 'Meurtre d’un agent public ou d’un officier de paix', class = 'Crime', id = 'P.C. 1012', months = 0, fine = 0, color = 'red', description = 'Tout meurtre intentionnel perpétré contre un employé du gouvernement'},
        [13] = {title = 'Tentative de meurtre d’un agent public ou d’un officier de paix', class = 'Crime', id = 'P.C. 1013', months = 65, fine = 10000, color = 'red', description = 'Toute attaque perpétrée contre un employé du gouvernement avec l’intention de causer la mort'},
        [14] = {title = 'Complice du meurtre d’un agent public ou d’un officier de paix', class = 'Crime', id = 'P.C. 1014', months = 0, fine = 0, color = 'red', description = 'Être présent et/ou participer à l’acte lié à la charge principale'},
        [15] = {title = 'Séquestration illégale', class = 'Délit', id = 'P.C. 1015', months = 10, fine = 600, color = 'green', description = 'L’acte de retenir une autre personne contre son gré sur une période prolongée'},
        [16] = {title = 'Enlèvement', class = 'Crime', id = 'P.C. 1016', months = 15, fine = 900, color = 'orange', description = 'L’acte de retenir une autre personne contre son gré sur une courte période'},
        [17] = {title = 'Complice d’enlèvement', class = 'Crime', id = 'P.C. 1017', months = 7, fine = 450, color = 'orange', description = 'Être présent et/ou participer à l’acte lié à la charge principale'},
        [18] = {title = 'Tentative d’enlèvement', class = 'Crime', id = 'P.C. 1018', months = 10, fine = 450, color = 'orange', description = 'L’acte de tenter de retenir une personne contre son gré'},
        [19] = {title = 'Prise d’otage', class = 'Crime', id = 'P.C. 1019', months = 20, fine = 1200, color = 'orange', description = 'L’acte de retenir une autre personne contre son gré pour un gain personnel'},
        [20] = {title = 'Complice de prise d’otage', class = 'Crime', id = 'P.C. 1020', months = 10, fine = 600, color = 'orange', description = 'Être présent et/ou participer à l’acte lié à la charge principale'},
        [21] = {title = 'Séquestration illégale d’un agent public ou d’un officier de paix', class = 'Crime', id = 'P.C. 1021', months = 25, fine = 4000, color = 'orange', description = 'L’acte de retenir un employé du gouvernement contre son gré sur une période prolongée'},
        [22] = {title = 'Menaces criminelles', class = 'Délit', id = 'P.C. 1022', months = 5, fine = 500, color = 'orange', description = 'L’acte de déclarer l’intention de commettre un crime contre une autre personne'},
        [23] = {title = 'Mise en danger imprudente', class = 'Délit', id = 'P.C. 1023', months = 10, fine = 1000, color = 'orange', description = 'L’acte d’ignorer la sécurité d’une autre personne, pouvant entraîner un danger de mort ou des blessures corporelles'},
        [24] = {title = 'Fusillade liée à un gang', class = 'Crime', id = 'P.C. 1024', months = 30, fine = 2500, color = 'red', description = 'L’acte de décharger une arme à feu en lien avec une activité de gang'},
        [25] = {title = 'Cannibalisme', class = 'Crime', id = 'P.C. 1025', months = 0, fine = 0, color = 'red', description = 'L’acte de consommer volontairement la chair d’une autre personne'},
        [26] = {title = 'Torture', class = 'Crime', id = 'P.C. 1026', months = 40, fine = 4500, color = 'red', description = 'L’acte de causer du tort à une autre personne pour obtenir des informations ou pour le plaisir personnel'},
    },
    [2] = {
        [1] = {title = 'Vol mineur', class = 'Infraction', id = 'P.C. 2001', months = 0, fine = 250, color = 'green', description = 'Vol de biens d’une valeur inférieure à 50 $'},
        [2] = {title = 'Vol qualifié', class = 'Contravention', id = 'P.C. 2002', months = 10, fine = 600, color = 'green', description = 'Vol de biens d’une valeur supérieure à 700 $'},
        [3] = {title = 'Vol de voiture A', class = 'Crime', id = 'P.C. 2003', months = 15, fine = 900, color = 'green', description = 'Vol d’un véhicule appartenant à quelqu’un d’autre sans autorisation'},
        [4] = {title = 'Vol de voiture B', class = 'Crime', id = 'P.C. 2004', months = 35, fine = 3500, color = 'green', description = 'Vol d’un véhicule appartenant à quelqu’un d’autre sans autorisation tout en étant armé'},
        [5] = {title = 'Vol de voiture avec violence', class = 'Crime', id = 'P.C. 2005', months = 30, fine = 2000, color = 'orange', description = 'Acte consistant à prendre de force un véhicule à ses occupants'},
        [6] = {title = 'Cambriolage', class = 'Contravention', id = 'P.C. 2006', months = 10, fine = 500, color = 'green', description = 'Entrée illégale dans un bâtiment dans le but de commettre un crime, en particulier un vol.'},
        [7] = {title = 'Vol à main armée', class = 'Crime', id = 'P.C. 2007', months = 25, fine = 2000, color = 'green', description = 'Action consistant à prendre des biens illégalement d’une personne ou d’un lieu par force ou menace de force.'},
        [8] = {title = 'Complice de vol à main armée', class = 'Crime', id = 'P.C. 2008', months = 12, fine = 1000, color = 'green', description = 'Être présent ou participer à l’acte du crime principal'},
        [9] = {title = 'Tentative de vol', class = 'Crime', id = 'P.C. 2009', months = 20, fine = 1000, color = 'green', description = 'Tentative de prendre des biens illégalement d’une personne ou d’un lieu par force ou menace de force.'},
        [10] = {title = 'Vol qualifié armé', class = 'Crime', id = 'P.C. 2010', months = 30, fine = 3000, color = 'orange', description = 'Vol de biens illégalement d’une personne ou d’un lieu par force ou menace de force tout en étant armé.'},
        [11] = {title = 'Complice de vol qualifié armé', class = 'Crime', id = 'P.C. 2011', months = 15, fine = 1500, color = 'orange', description = 'Être présent ou participer à l’acte du crime principal'},
        [12] = {title = 'Tentative de vol qualifié armé', class = 'Crime', id = 'P.C. 2012', months = 25, fine = 1500, color = 'orange', description = 'Tentative de prendre des biens illégalement d’une personne ou d’un lieu par force ou menace de force tout en étant armé.'},
        [13] = {title = 'Grand vol', class = 'Crime', id = 'P.C. 2013', months = 45, fine = 7500, color = 'orange', description = 'Vol de biens personnels d’une valeur supérieure à un montant légalement spécifié.'},
        [14] = {title = 'Fuir sans payer', class = 'Infraction', id = 'P.C. 2014', months = 0, fine = 500, color = 'green', description = 'Quitter un établissement sans payer pour le service fourni'},
        [15] = {title = 'Possession de monnaie illégale', class = 'Contravention', id = 'P.C. 2015', months = 10, fine = 750, color = 'green', description = 'Possession de monnaie volée'},
        [16] = {title = 'Possession d’objets émis par le gouvernement', class = 'Contravention', id = 'P.C. 2016', months = 15, fine = 1000, color = 'green', description = 'Possession d’objets uniquement accessibles aux employés du gouvernement'},
        [17] = {title = 'Possession d’objets utilisés dans la commission d’un crime', class = 'Contravention', id = 'P.C. 2017', months = 10, fine = 500, color = 'green', description = 'Possession d’objets ayant été utilisés pour commettre des crimes'},
        [18] = {title = 'Vente d’objets utilisés dans la commission d’un crime', class = 'Crime', id = 'P.C. 2018', months = 15, fine = 1000, color = 'orange', description = 'Vente d’objets ayant été utilisés pour commettre des crimes'},
        [19] = {title = 'Vol d’un aéronef', class = 'Crime', id = 'P.C. 2019', months = 20, fine = 1000, color = 'green', description = 'Vol d’un aéronef'},
    },
    [3] = {
        [1] = {title = 'Usurpation d’identité', class = 'Contravention', id = 'P.C. 3001', months = 15, fine = 1250, color = 'green', description = 'Action consistant à se faire passer pour une autre personne dans le but de tromper'},
        [2] = {title = 'Usurpation de fonction de fonctionnaire ou d\'officier de la paix', class = 'Crime', id = 'P.C. 3002', months = 25, fine = 2750, color = 'green', description = 'Action consistant à se faire passer pour un employé du gouvernement dans le but de tromper'},
        [3] = {title = 'Usurpation de fonction de juge', class = 'Crime', id = 'P.C. 3003', months = 0, fine = 0, color = 'green', description = 'Action consistant à se faire passer pour un juge dans le but de tromper'},
        [4] = {title = 'Possession d’identification volée', class = 'Contravention', id = 'P.C. 3004', months = 10, fine = 750, color = 'green', description = 'Posséder l’identification d’une autre personne sans son consentement'},
        [5] = {title = 'Possession d’identification gouvernementale volée', class = 'Contravention', id = 'P.C. 3005', months = 20, fine = 2000, color = 'green', description = 'Posséder l’identification d’un employé du gouvernement sans son consentement'},
        [6] = {title = 'Extorsion', class = 'Crime', id = 'P.C. 3006', months = 20, fine = 900, color = 'orange', description = 'Menacer ou causer des torts à une personne ou à des biens pour un gain financier'},
        [7] = {title = 'Fraude', class = 'Contravention', id = 'P.C. 3007', months = 10, fine = 450, color = 'green', description = 'Tromper une autre personne pour un gain financier'},
        [8] = {title = 'Faux documents', class = 'Contravention', id = 'P.C. 3008', months = 15, fine = 750, color = 'green', description = 'Falsifier des documents légaux pour un gain personnel'},
        [9] = {title = 'Blanchiment d\'argent', class = 'Crime', id = 'P.C. 3009', months = 0, fine = 0, color = 'red', description = 'Le traitement de l’argent volé en monnaie légale'},
    },
    [4] = {
        [1] = {title = 'Intrusion', class = 'Contravention', id = 'P.C. 4001', months = 10, fine = 450, color = 'green', description = 'Lorsqu’une personne se trouve dans les limites d’un endroit où elle n’est pas légalement autorisée à être'},
        [2] = {title = 'Intrusion criminelle', class = 'Crime', id = 'P.C. 4002', months = 15, fine = 1500, color = 'green', description = 'Lorsqu’une personne est entrée à plusieurs reprises dans les limites d’un endroit où elle sait qu’elle n’est pas légalement autorisée à être'},
        [3] = {title = 'Incendie criminel', class = 'Crime', id = 'P.C. 4003', months = 15, fine = 1500, color = 'orange', description = 'L’utilisation du feu et d’accélérateurs pour détruire intentionnellement et malicieusement, nuire ou causer la mort d’une personne ou de biens'},
        [4] = {title = 'Vandalisme', class = 'Contravention', id = 'P.C. 4004', months = 0, fine = 300, color = 'green', description = 'Destruction volontaire de biens'},
        [5] = {title = 'Vandalisme de biens publics', class = 'Crime', id = 'P.C. 4005', months = 20, fine = 1500, color = 'green', description = 'Destruction volontaire de biens publics'},
        [6] = {title = 'Jet de détritus', class = 'Contravention', id = 'P.C. 4006', months = 0, fine = 200, color = 'green', description = 'Jeter volontairement des déchets dans un endroit public, en dehors des poubelles désignées'},
    },
    [5] = {
        [1] = {title = 'Corruption d’un fonctionnaire', class = 'Crime', id = 'P.C. 5001', months = 20, fine = 3500, color = 'green', description = 'L’utilisation d’argent, de faveurs ou de biens pour obtenir les faveurs d’un fonctionnaire'},
        [2] = {title = 'Loi anti-masque', class = 'Contravention', id = 'P.C. 5002', months = 0, fine = 750, color = 'green', description = 'Porter un masque dans une zone interdite'},
        [3] = {title = 'Possession de contrebande dans un établissement gouvernemental', class = 'Crime', id = 'P.C. 5003', months = 25, fine = 1000, color = 'green', description = 'Être en possession d’objets illégaux dans un bâtiment gouvernemental'},
        [4] = {title = 'Possession criminelle de biens volés', class = 'Contravention', id = 'P.C. 5004', months = 10, fine = 500, color = 'green', description = 'Être en possession d’objets volés, sciemment ou non'},
        [5] = {title = 'Évasion', class = 'Crime', id = 'P.C. 5005', months = 10, fine = 450, color = 'green', description = 'L’action de quitter délibérément et sciemment la garde alors qu’une personne est légalement arrêtée, détenue ou en prison'},
        [6] = {title = 'Évasion de prison', class = 'Crime', id = 'P.C. 5006', months = 30, fine = 2500, color = 'orange', description = 'L’action de quitter la garde d’un établissement de détention d’État ou de comté'},
        [7] = {title = 'Complice d’évasion de prison', class = 'Crime', id = 'P.C. 5007', months = 25, fine = 2000, color = 'orange', description = 'Être présent et/ou participer à l’évasion d’une prison'},
        [8] = {title = 'Tentative d’évasion de prison', class = 'Crime', id = 'P.C. 5008', months = 20, fine = 1500, color = 'orange', description = 'La tentative délibérée et intentionnelle de s’échapper d’un établissement de détention d’État ou de comté'},
        [9] = {title = 'Parjure', class = 'Crime', id = 'P.C. 5009', months = 0, fine = 0, color = 'green', description = 'L’action de déclarer des faussetés tout en étant légalement tenu de dire la vérité'},
        [10] = {title = 'Violation d’une ordonnance de restriction', class = 'Crime', id = 'P.C. 5010', months = 20, fine = 2250, color = 'green', description = 'L’infraction délibérée et consciente d’une ordonnance de protection rendue par un tribunal'},
        [11] = {title = 'Détournement de fonds', class = 'Crime', id = 'P.C. 5011', months = 45, fine = 10000, color = 'green', description = 'Le transfert délibéré et sciemment de fonds d’un compte bancaire non personnel vers un compte personnel à des fins personnelles'},
        [12] = {title = 'Exercice illégal', class = 'Crime', id = 'P.C. 5012', months = 15, fine = 1500, color = 'orange', description = 'L’action d’exercer un service sans licence légale et approbation appropriée'},
        [13] = {title = 'Mauvais usage des systèmes d’urgence', class = 'Contravention', id = 'P.C. 5013', months = 0, fine = 600, color = 'orange', description = 'Utilisation d’équipements d’urgence gouvernementaux à des fins non prévues'},
        [14] = {title = 'Conspiration', class = 'Contravention', id = 'P.C. 5014', months = 10, fine = 450, color = 'green', description = 'L’acte de planifier un crime mais sans l’avoir encore commis'},
        [15] = {title = 'Violation d’une ordonnance du tribunal', class = 'Contravention', id = 'P.C. 5015', months = 0, fine = 0, color = 'orange', description = 'L’infraction d’une ordonnance judiciaire'},
        [16] = {title = 'Non-comparution', class = 'Contravention', id = 'P.C. 5016', months = 0, fine = 0, color = 'orange', description = 'Lorsqu’une personne, légalement tenue de comparaître devant le tribunal, ne le fait pas'},
        [17] = {title = 'Outrage au tribunal', class = 'Crime', id = 'P.C. 5017', months = 0, fine = 0, color = 'orange', description = 'Le trouble des procédures judiciaires dans une salle d’audience alors que l’audience est en cours (décision judiciaire)'},
        [18] = {title = 'Opposition à l’arrestation', class = 'Contravention', id = 'P.C. 5018', months = 5, fine = 300, color = 'orange', description = 'L’acte de ne pas permettre aux forces de l’ordre de vous appréhender volontairement'},
    },
    [6] = {
        [1] = {title = 'Désobéissance à un agent de la paix', class = 'Contravention', id = 'P.C. 6001', months = 0, fine = 750, color = 'green', description = 'Ignorer délibérément un ordre légal'},
        [2] = {title = 'Comportement désordonné', class = 'Contravention', id = 'P.C. 6002', months = 0, fine = 250, color = 'green', description = 'Agir de manière à créer une condition dangereuse ou physiquement offensante par tout acte qui ne sert aucun but légitime de l’acteur'},
        [3] = {title = 'Troubler l’ordre public', class = 'Contravention', id = 'P.C. 6003', months = 0, fine = 350, color = 'green', description = 'Agir de manière à provoquer des troubles et à perturber l’ordre public'},
        [4] = {title = 'Fausse déclaration', class = 'Contravention', id = 'P.C. 6004', months = 10, fine = 750, color = 'green', description = 'Le fait de signaler un crime qui n’a pas eu lieu'},
        [5] = {title = 'Harcèlement', class = 'Contravention', id = 'P.C. 6005', months = 10, fine = 500, color = 'orange', description = 'La perturbation répétée ou les attaques verbales envers une autre personne'},
        [6] = {title = 'Entrave à la justice (contravention)', class = 'Contravention', id = 'P.C. 6006', months = 10, fine = 500, color = 'green', description = 'Agir de manière à entraver le processus judiciaire ou les enquêtes légales'},
        [7] = {title = 'Entrave à la justice (crime)', class = 'Crime', id = 'P.C. 6007', months = 15, fine = 900, color = 'green', description = 'Agir de manière à entraver le processus judiciaire ou les enquêtes légales en utilisant la violence'},
        [8] = {title = 'Incitation à une émeute', class = 'Crime', id = 'P.C. 6008', months = 25, fine = 1000, color = 'orange', description = 'Provoquer des troubles civils pour inciter un groupe à nuire aux personnes ou aux biens'},
        [9] = {title = 'Flâner sur des propriétés gouvernementales', class = 'Contravention', id = 'P.C. 6009', months = 0, fine = 500, color = 'green', description = 'Lorsqu’une personne est présente sur une propriété gouvernementale pendant une période prolongée'},
        [10] = {title = 'Falsification', class = 'Contravention', id = 'P.C. 6010', months = 10, fine = 500, color = 'green', description = 'Le fait d’interférer délibérément, sciemment et indirectement avec les points clés d’une enquête légale'},
        [11] = {title = 'Falsification de véhicule', class = 'Contravention', id = 'P.C. 6011', months = 15, fine = 750, color = 'green', description = 'Le fait d’interférer délibérément et sciemment avec le fonctionnement normal d’un véhicule'},
        [12] = {title = 'Falsification de preuves', class = 'Crime', id = 'P.C. 6012', months = 20, fine = 1000, color = 'green', description = 'Le fait d’interférer délibérément et sciemment avec des preuves d’une enquête légale'},
        [13] = {title = 'Falsification de témoin', class = 'Crime', id = 'P.C. 6013', months = 0, fine = 0, color = 'green', description = 'Le fait de manipuler ou de contraindre un témoin dans le cadre d’une enquête légale'},
        [14] = {title = 'Non-présentation d’une identification', class = 'Contravention', id = 'P.C. 6014', months = 15, fine = 1500, color = 'green', description = 'Le fait de ne pas présenter une pièce d’identité lorsqu’on y est légalement tenu'},
        [15] = {title = 'Vigilantisme', class = 'Crime', id = 'P.C. 6015', months = 30, fine = 1500, color = 'orange', description = 'L’action de faire appliquer la loi sans en avoir l’autorité légale'},
        [16] = {title = 'Assemblée illégale', class = 'Contravention', id = 'P.C. 6016', months = 10, fine = 750, color = 'orange', description = 'Lorsqu’un grand groupe se réunit dans un lieu nécessitant une autorisation préalable'},
        [17] = {title = 'Corruption gouvernementale', class = 'Crime', id = 'P.C. 6017', months = 0, fine = 0, color = 'red', description = 'L’utilisation d’un poste politique et du pouvoir pour des gains personnels'},
        [18] = {title = 'Traque', class = 'Crime', id = 'P.C. 6018', months = 40, fine = 1500, color = 'orange', description = 'Lorsqu’une personne surveille une autre sans son consentement'},
        [19] = {title = 'Aide et complicité', class = 'Contravention', id = 'P.C. 6019', months = 15, fine = 450, color = 'orange', description = 'Aider quelqu’un à commettre un crime ou encourager quelqu’un à en commettre un'},
        [20] = {title = 'Cachette d’un fugitif', class = 'Contravention', id = 'P.C. 6020', months = 10, fine = 1000, color = 'green', description = 'Lorsqu’une personne cache délibérément quelqu’un qui est recherché par les autorités'},
    },
    [7] = {
        [1] = {title = 'Détention de Marijuana en Infraction', class = 'Infraction', id = 'P.C. 7001', months = 5, fine = 250, color = 'green', description = 'La détention d\'une quantité de marijuana inférieure à 4 blunts'},
        [2] = {title = 'Fabrication de Marijuana en Crime', class = 'Crime', id = 'P.C. 7002', months = 15, fine = 1000, color = 'red', description = 'La détention d\'une quantité de marijuana issue de la fabrication'},
        [3] = {title = 'Culture de Marijuana A', class = 'Infraction', id = 'P.C. 7003', months = 10, fine = 750, color = 'green', description = 'La détention de 4 ou moins de plantes de marijuana'},
        [4] = {title = 'Culture de Marijuana B', class = 'Crime', id = 'P.C. 7004', months = 30, fine = 1500, color = 'orange', description = 'La détention de 5 ou plus de plantes de marijuana'},
        [5] = {title = 'Détention de Marijuana avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7005', months = 30, fine = 3000, color = 'orange', description = 'La détention d\'une quantité de marijuana destinée à la distribution'},
        [6] = {title = 'Détention de Cocaïne en Infraction', class = 'Infraction', id = 'P.C. 7006', months = 7, fine = 500, color = 'green', description = 'La détention de cocaïne en petite quantité généralement pour un usage personnel'},
        [7] = {title = 'Fabrication de Cocaïne en Crime', class = 'Crime', id = 'P.C. 7007', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité de cocaïne issue de la fabrication'},
        [8] = {title = 'Détention de Cocaïne avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7008', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité de cocaïne destinée à la distribution'},
        [9] = {title = 'Détention de Méthamphétamine en Infraction', class = 'Infraction', id = 'P.C. 7009', months = 7, fine = 500, color = 'green', description = 'La détention de méthamphétamine en petite quantité généralement pour un usage personnel'},
        [10] = {title = 'Fabrication de Méthamphétamine en Crime', class = 'Crime', id = 'P.C. 7010', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité de méthamphétamine issue de la fabrication'},
        [11] = {title = 'Détention de Méthamphétamine avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7011', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité de méthamphétamine destinée à la distribution'},
        [12] = {title = 'Détention d\'Oxy / Vicodin en Infraction', class = 'Infraction', id = 'P.C. 7012', months = 7, fine = 500, color = 'green', description = 'La détention d\'oxy / vicodin en petite quantité généralement pour un usage personnel sans prescription'},
        [13] = {title = 'Fabrication d\'Oxy / Vicodin en Crime', class = 'Crime', id = 'P.C. 7013', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité d\'oxy / vicodin issue de la fabrication'},
        [14] = {title = 'Crime Possession d\'Oxy / Vicodin avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7014', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité d\'oxy / vicodin destinée à la distribution'},
        [15] = {title = 'Détention d\'Ecstasy en Infraction', class = 'Infraction', id = 'P.C. 7015', months = 7, fine = 500, color = 'green', description = 'La détention d\'ecstasy en petite quantité généralement pour un usage personnel'},
        [16] = {title = 'Fabrication d\'Ecstasy en Crime', class = 'Crime', id = 'P.C. 7016', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité d\'ecstasy issue de la fabrication'},
        [17] = {title = 'Détention d\'Ecstasy avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7017', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité d\'ecstasy destinée à la distribution'},
        [18] = {title = 'Détention d\'Opium en Infraction', class = 'Infraction', id = 'P.C. 7018', months = 7, fine = 500, color = 'green', description = 'La détention d\'opium en petite quantité généralement pour un usage personnel'},
        [19] = {title = 'Fabrication d\'Opium en Crime', class = 'Crime', id = 'P.C. 7019', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité d\'opium issue de la fabrication'},
        [20] = {title = 'Détention d\'Opium avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7020', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité d\'opium destinée à la distribution'},
        [21] = {title = 'Détention d\'Adderall en Infraction', class = 'Infraction', id = 'P.C. 7021', months = 7, fine = 500, color = 'green', description = 'La détention d\'adderall en petite quantité généralement pour un usage personnel sans prescription'},
        [22] = {title = 'Fabrication d\'Adderall en Crime', class = 'Crime', id = 'P.C. 7022', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité d\'adderall issue de la fabrication'},
        [23] = {title = 'Détention d\'Adderall avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7023', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité d\'adderall destinée à la distribution'},
        [24] = {title = 'Détention de Xanax en Infraction', class = 'Infraction', id = 'P.C. 7024', months = 7, fine = 500, color = 'green', description = 'La détention de xanax en petite quantité généralement pour un usage personnel sans prescription'},
        [25] = {title = 'Fabrication de Xanax en Crime', class = 'Crime', id = 'P.C. 7025', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité de xanax issue de la fabrication'},
        [26] = {title = 'Détention de Xanax avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7026', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité de xanax destinée à la distribution'},
        [27] = {title = 'Détention de Champignons (Shrooms) en Infraction', class = 'Infraction', id = 'P.C. 7027', months = 7, fine = 500, color = 'green', description = 'La détention de champignons (shrooms) en petite quantité généralement pour un usage personnel'},
        [28] = {title = 'Fabrication de Champignons (Shrooms) en Crime', class = 'Crime', id = 'P.C. 7028', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité de champignons (shrooms) issue de la fabrication'},
        [29] = {title = 'Détention de Champignons (Shrooms) avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7029', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité de champignons (shrooms) destinée à la distribution'},
        [30] = {title = 'Détention de Lean en Infraction', class = 'Infraction', id = 'P.C. 7030', months = 7, fine = 500, color = 'green', description = 'La détention de lean en petite quantité généralement pour un usage personnel'},
        [31] = {title = 'Fabrication de Lean en Crime', class = 'Crime', id = 'P.C. 7031', months = 25, fine = 1500, color = 'red', description = 'La détention d\'une quantité de lean issue de la fabrication'},
        [32] = {title = 'Détention de Lean avec Intention de Distribuer', class = 'Crime', id = 'P.C. 7032', months = 35, fine = 4500, color = 'orange', description = 'La détention d\'une quantité de lean destinée à la distribution'},
        [33] = {title = 'Vente d\'une substance contrôlée', class = 'Infraction', id = 'P.C. 7033', months = 10, fine = 1000, color = 'green', description = 'La vente d\'une substance contrôlée par la loi'},
        [34] = {title = 'Trafic de Drogues', class = 'Crime', id = 'P.C. 7034', months = 0, fine = 0, color = 'red', description = 'Le mouvement à grande échelle de drogues illégales'},
        [35] = {title = 'Profanation d\'un Cadavre Humain', class = 'Crime', id = 'P.C. 7035', months = 20, fine = 1500, color = 'orange', description = 'Lorsque quelqu\'un porte atteinte, perturbe ou détruit les restes d\'une autre personne'},
        [36] = {title = 'Ivresse en Public', class = 'Infraction', id = 'P.C. 7036', months = 0, fine = 500, color = 'green', description = 'Lorsque quelqu\'un est ivre au-delà de la limite légale en public'},
        [37] = {title = 'Indécence Publique', class = 'Infraction', id = 'P.C. 7037', months = 10, fine = 750, color = 'green', description = 'L\'acte de quelqu\'un qui s\'expose de manière à enfreindre la morale publique'},
    },
    [8] = {
        [1] = {title = 'Possession criminelle d\'arme de classe A', class = 'Crime', id = 'P.C. 8001', months = 10, fine = 500, color = 'green', description = 'Possession d\'une arme de classe A sans licence'},
        [2] = {title = 'Possession criminelle d\'arme de classe B', class = 'Crime', id = 'P.C. 8002', months = 15, fine = 1000, color = 'green', description = 'Possession d\'une arme de classe B sans licence'},
        [3] = {title = 'Possession criminelle d\'arme de classe C', class = 'Crime', id = 'P.C. 8003', months = 30, fine = 3500, color = 'green', description = 'Possession d\'une arme de classe C sans licence'},
        [4] = {title = 'Possession criminelle d\'arme de classe D', class = 'Crime', id = 'P.C. 8004', months = 25, fine = 1500, color = 'green', description = 'Possession d\'une arme de classe D sans licence'},
        [5] = {title = 'Vente criminelle d\'arme de classe A', class = 'Crime', id = 'P.C. 8005', months = 15, fine = 1000, color = 'orange', description = 'Vente d\'une arme de classe A sans licence'},
        [6] = {title = 'Vente criminelle d\'arme de classe B', class = 'Crime', id = 'P.C. 8006', months = 20, fine = 2000, color = 'orange', description = 'Vente d\'une arme de classe B sans licence'},
        [7] = {title = 'Vente criminelle d\'arme de classe C', class = 'Crime', id = 'P.C. 8007', months = 35, fine = 7000, color = 'orange', description = 'Vente d\'une arme de classe C sans licence'},
        [8] = {title = 'Vente criminelle d\'arme de classe D', class = 'Crime', id = 'P.C. 8008', months = 30, fine = 3000, color = 'orange', description = 'Vente d\'une arme de classe D sans licence'},
        [9] = {title = 'Utilisation criminelle d\'une arme', class = 'Contravention', id = 'P.C. 8009', months = 10, fine = 450, color = 'orange', description = 'Utilisation d\'une arme lors de la commission d\'un crime'},
        [10] = {title = 'Possession de modifications illégales d\'armes à feu', class = 'Contravention', id = 'P.C. 8010', months = 10, fine = 300, color = 'green', description = 'Possession illégale de modifications d\'armes à feu'},
        [11] = {title = 'Trafic d\'armes', class = 'Crime', id = 'P.C. 8011', months = 0, fine = 0, color = 'red', description = 'Transport d\'une grande quantité d\'armes d\'un endroit à un autre'},
        [12] = {title = 'Exhibition d\'une arme', class = 'Contravention', id = 'P.C. 8012', months = 15, fine = 500, color = 'orange', description = 'Action de rendre une arme visible intentionnellement'},
        [13] = {title = 'Insurrection', class = 'Crime', id = 'P.C. 8013', months = 0, fine = 0, color = 'red', description = 'Tentative de renverser le gouvernement par la violence'},
        [14] = {title = 'Vol dans un espace aérien restreint', class = 'Crime', id = 'P.C. 8014', months = 20, fine = 1500, color = 'green', description = 'Pilotage d\'un aéronef dans un espace aérien contrôlé par le gouvernement'},
        [15] = {title = 'Passage piéton illégal', class = 'Infraction', id = 'P.C. 8015', months = 0, fine = 150, color = 'green', description = 'Traversée d\'une route de manière dangereuse pour les véhicules motorisés'},
        [16] = {title = 'Utilisation criminelle d\'explosifs', class = 'Crime', id = 'P.C. 8016', months = 30, fine = 2500, color = 'orange', description = 'Utilisation d\'explosifs pour commettre un crime'},
    },
    [9] = {
        [1] = {title = 'Conduite en état d\'ivresse', class = 'Contravention', id = 'P.C. 9001', months = 5, fine = 300, color = 'green', description = 'Conduite d\'un véhicule à moteur sous l\'influence de l\'alcool'},
        [2] = {title = 'Fuite', class = 'Contravention', id = 'P.C. 9002', months = 5, fine = 400, color = 'green', description = 'Se cacher ou fuir une détention légale'},
        [3] = {title = 'Fuite imprudente', class = 'Crime', id = 'P.C. 9003', months = 10, fine = 800, color = 'orange', description = 'Ignorer imprudemment la sécurité et fuir une détention légale'},
        [4] = {title = 'Non-respect de la priorité pour un véhicule d\'urgence', class = 'Infraction', id = 'P.C. 9004', months = 0, fine = 600, color = 'green', description = 'Ne pas céder le passage aux véhicules d\'urgence'},
        [5] = {title = 'Non-respect des dispositifs de contrôle de la circulation', class = 'Infraction', id = 'P.C. 9005', months = 0, fine = 150, color = 'green', description = 'Ne pas suivre les dispositifs de sécurité de la route'},
        [6] = {title = 'Véhicule non fonctionnel', class = 'Infraction', id = 'P.C. 9006', months = 0, fine = 75, color = 'green', description = 'Avoir un véhicule qui n\'est plus fonctionnel sur la route'},
        [7] = {title = 'Conduite négligente', class = 'Infraction', id = 'P.C. 9007', months = 0, fine = 300, color = 'green', description = 'Conduire d\'une manière qui néglige involontairement la sécurité'},
        [8] = {title = 'Conduite imprudente', class = 'Contravention', id = 'P.C. 9008', months = 10, fine = 750, color = 'orange', description = 'Conduire d\'une manière qui néglige délibérément la sécurité'},
        [9] = {title = 'Excès de vitesse de troisième degré', class = 'Infraction', id = 'P.C. 9009', months = 0, fine = 225, color = 'green', description = 'Excès de vitesse de 15 au-dessus de la limite'},
        [10] = {title = 'Excès de vitesse de deuxième degré', class = 'Infraction', id = 'P.C. 9010', months = 0, fine = 450, color = 'green', description = 'Excès de vitesse de 35 au-dessus de la limite'},
        [11] = {title = 'Excès de vitesse de premier degré', class = 'Infraction', id = 'P.C. 9011', months = 0, fine = 750, color = 'green', description = 'Excès de vitesse de 50 au-dessus de la limite'},
        [12] = {title = 'Conduite sans permis', class = 'Infraction', id = 'P.C. 9012', months = 0, fine = 500, color = 'green', description = 'Conduire un véhicule à moteur sans permis valide'},
        [13] = {title = 'Virage illégal', class = 'Infraction', id = 'P.C. 9013', months = 0, fine = 75, color = 'green', description = 'Effectuer un virage là où il est interdit'},
        [14] = {title = 'Dépassement illégal', class = 'Infraction', id = 'P.C. 9014', months = 0, fine = 300, color = 'green', description = 'Doubler d\'autres véhicules d\'une manière interdite'},
        [15] = {title = 'Non-respect de la voie', class = 'Infraction', id = 'P.C. 9015', months = 0, fine = 300, color = 'green', description = 'Ne pas rester dans la voie correcte avec un véhicule'},
        [16] = {title = 'Virage illégal', class = 'Infraction', id = 'P.C. 9016', months = 0, fine = 150, color = 'green', description = 'Effectuer un virage là où il est interdit'},
        [17] = {title = 'Non-respect d\'un arrêt', class = 'Infraction', id = 'P.C. 9017', months = 0, fine = 600, color = 'green', description = 'Ne pas s\'arrêter lors d\'un arrêt légal ou d\'un dispositif de circulation'},
        [18] = {title = 'Stationnement non autorisé', class = 'Infraction', id = 'P.C. 9018', months = 0, fine = 300, color = 'green', description = 'Stationner un véhicule dans un endroit nécessitant une autorisation'},
        [19] = {title = 'Accident avec délit de fuite', class = 'Contravention', id = 'P.C. 9019', months = 10, fine = 500, color = 'green', description = 'Heurter une autre personne ou un véhicule et fuir les lieux'},
        [20] = {title = 'Conduite sans phares ou clignotants', class = 'Infraction', id = 'P.C. 9020', months = 0, fine = 300, color = 'green', description = 'Conduire un véhicule sans feux fonctionnels'},
        [21] = {title = 'Courses de rue', class = 'Crime', id = 'P.C. 9021', months = 15, fine = 1500, color = 'green', description = 'Conduite de véhicules à moteur dans une compétition'},
        [22] = {title = 'Pilotage sans permis adéquat', class = 'Crime', id = 'P.C. 9022', months = 20, fine = 1500, color = 'orange', description = 'Ne pas être en possession d\'une licence valide lors du pilotage d\'un aéronef'},
        [23] = {title = 'Utilisation illégale d\'un véhicule à moteur', class = 'Contravention', id = 'P.C. 9023', months = 10, fine = 750, color = 'green', description = 'Utilisation d\'un véhicule à moteur sans raison légale'},
    },
    [10] = {
        [1] = {title = 'Chasse dans des zones restreintes', class = 'Infraction', id = 'P.C. 10001', months = 0, fine = 450, color = 'green', description = 'Chasser dans des zones où cela est interdit'},
        [2] = {title = 'Chasse sans permis', class = 'Infraction', id = 'P.C. 10002', months = 0, fine = 450, color = 'green', description = 'Chasser sans le permis approprié'},
        [3] = {title = 'Cruauté envers les animaux', class = 'Contravention', id = 'P.C. 10003', months = 10, fine = 450, color = 'green', description = 'L\'acte de maltraiter un animal délibérément ou non'},
        [4] = {title = 'Chasse avec une arme non autorisée', class = 'Contravention', id = 'P.C. 10004', months = 10, fine = 750, color = 'green', description = 'Utiliser une arme qui n\'est pas légalement conçue ou fabriquée pour la chasse'},
        [5] = {title = 'Chasse en dehors des heures légales', class = 'Infraction', id = 'P.C. 10005', months = 0, fine = 750, color = 'green', description = 'Chasser en dehors des horaires spécifiés'},
        [6] = {title = 'Sur-chasse', class = 'Contravention', id = 'P.C. 10006', months = 10, fine = 1000, color = 'green', description = 'Capturer plus d\'animaux que la quantité légale autorisée'},
        [7] = {title = 'Braconnage', class = 'Crime', id = 'P.C. 10007', months = 20, fine = 1250, color = 'red', description = 'Chasser un animal qui est légalement protégé et non chassable'},
    }
}

Config.AllowedJobs = {}
for index, value in pairs(Config.PoliceJobs) do
    Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.AmbulanceJobs) do
    Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.DojJobs) do
    Config.AllowedJobs[index] = value
end

Config.ColorNames = {
    [0] = "Noir Métallique",
    [1] = "Noir Métallique Graphite",
    [2] = "Acier Noir Métallique",
    [3] = "Argent Métallique Sombre",
    [4] = "Argent Métallique",
    [5] = "Argent Métallique Bleu",
    [6] = "Gris Acier Métallique",
    [7] = "Argent Métallique Ombre",
    [8] = "Argent Métallique Pierre",
    [9] = "Argent Métallique Minuit",
    [10] = "Métal Gris Canon",
    [11] = "Gris Anthracite Métallique",
    [12] = "Noir Mat",
    [13] = "Gris Mat",
    [14] = "Gris Clair Mat",
    [15] = "Noir Utilitaire",
    [16] = "Noir Poly Utilitaire",
    [17] = "Argent Sombre Utilitaire",
    [18] = "Argent Utilitaire",
    [19] = "Canon Métal Utilitaire",
    [20] = "Argent Ombre Utilitaire",
    [21] = "Noir Vieilli",
    [22] = "Graphite Vieilli",
    [23] = "Gris Argent Vieilli",
    [24] = "Argent Vieilli",
    [25] = "Bleu Argent Vieilli",
    [26] = "Argent Ombre Vieilli",
    [27] = "Rouge Métallique",
    [28] = "Rouge Torino Métallique",
    [29] = "Rouge Formule Métallique",
    [30] = "Rouge Flamme Métallique",
    [31] = "Rouge Élégant Métallique",
    [32] = "Rouge Grenat Métallique",
    [33] = "Rouge Désert Métallique",
    [34] = "Rouge Cabernet Métallique",
    [35] = "Rouge Bonbon Métallique",
    [36] = "Orange Métallique Aube",
    [37] = "Or Métallique Classique",
    [38] = "Orange Métallique",
    [39] = "Rouge Mat",
    [40] = "Rouge Sombre Mat",
    [41] = "Orange Mat",
    [42] = "Jaune Mat",
    [43] = "Rouge Utilitaire",
    [44] = "Rouge Brillant Utilitaire",
    [45] = "Rouge Grenat Utilitaire",
    [46] = "Rouge Vieilli",
    [47] = "Rouge Or Vieilli",
    [48] = "Rouge Sombre Vieilli",
    [49] = "Vert Sombre Métallique",
    [50] = "Vert Course Métallique",
    [51] = "Vert Mer Métallique",
    [52] = "Olive Métallique",
    [53] = "Vert Métallique",
    [54] = "Essence Bleu-Vert Métallique",
    [55] = "Vert Citron Mat",
    [56] = "Vert Sombre Utilitaire",
    [57] = "Vert Utilitaire",
    [58] = "Vert Sombre Vieilli",
    [59] = "Vert Vieilli",
    [60] = "Lavage Mer Vieilli",
    [61] = "Bleu Minuit Métallique",
    [62] = "Bleu Sombre Métallique",
    [63] = "Bleu Saxony Métallique",
    [64] = "Bleu Métallique",
    [65] = "Bleu Marin Métallique",
    [66] = "Bleu Port Métallique",
    [67] = "Bleu Diamant Métallique",
    [68] = "Bleu Surf Métallique",
    [69] = "Bleu Nautique Métallique",
    [70] = "Bleu Brillant Métallique",
    [71] = "Bleu Violet Métallique",
    [72] = "Bleu Spinnaker Métallique",
    [73] = "Bleu Ultra Métallique",
    [74] = "Bleu Brillant Métallique",
    [75] = "Bleu Sombre Utilitaire",
    [76] = "Bleu Minuit Utilitaire",
    [77] = "Bleu Utilitaire",
    [78] = "Bleu Mousse Mer Utilitaire",
    [79] = "Bleu Éclair Utilitaire",
    [80] = "Maui Bleu Poly Utilitaire",
    [81] = "Bleu Brillant Utilitaire",
    [82] = "Bleu Sombre Mat",
    [83] = "Bleu Mat",
    [84] = "Bleu Minuit Mat",
    [85] = "Bleu Sombre Vieilli",
    [86] = "Bleu Vieilli",
    [87] = "Bleu Clair Vieilli",
    [88] = "Jaune Taxi Métallique",
    [89] = "Jaune Course Métallique",
    [90] = "Bronze Métallique",
    [91] = "Jaune Oiseau Métallique",
    [92] = "Citron Métallique",
    [93] = "Champagne Métallique",
    [94] = "Beige Pueblo Métallique",
    [95] = "Ivoire Sombre Métallique",
    [96] = "Choco Métallique",
    [97] = "Marron Or Métallique",
    [98] = "Marron Clair Métallique",
    [99] = "Beige Paille Métallique",
    [100] = "Marron Mousse Métallique",
    [101] = "Marron Biston Métallique",
    [102] = "Hêtre Métallique",
    [103] = "Hêtre Sombre Métallique",
    [104] = "Orange Choco Métallique",
    [105] = "Sable Plage Métallique",
    [106] = "Sable Blanchi Métallique",
    [107] = "Crème Métallique",
    [108] = "Marron Utilitaire",
    [109] = "Marron Moyen Utilitaire",
    [110] = "Marron Clair Utilitaire",
    [111] = "Blanc Métallique",
    [112] = "Blanc Gel Métallique",
    [113] = "Miel Beige Vieilli",
    [114] = "Marron Vieilli",
    [115] = "Marron Sombre Vieilli",
    [116] = "Beige Paille Vieilli",
    [117] = "Acier Brossé",
    [118] = "Acier Noir Brossé",
    [119] = "Aluminium Brossé",
    [120] = "Chrome",
    [121] = "Blanc Cassé Vieilli",
    [122] = "Blanc Cassé Utilitaire",
    [123] = "Orange Vieilli",
    [124] = "Orange Clair Vieilli",
    [125] = "Vert Securicor Métallique",
    [126] = "Jaune Taxi Vieilli",
    [127] = "Bleu Voiture de Police",
    [128] = "Vert Mat",
    [129] = "Marron Mat",
    [130] = "Orange Vieilli",
    [131] = "Blanc Mat",
    [132] = "Blanc Vieilli",
    [133] = "Vert Armée Olive Vieilli",
    [134] = "Blanc Pur",
    [135] = "Rose Fluo",
    [136] = "Rose Saumon",
    [137] = "Rose Vermillon Métallique",
    [138] = "Orange",
    [139] = "Vert",
    [140] = "Bleu",
    [141] = "Noir Bleu Métallique",
    [142] = "Noir Violet Métallique",
    [143] = "Noir Rouge Métallique",
    [144] = "Vert Chasseur",
    [145] = "Violet Métallique",
    [146] = "Violet Métallique V Bleu Sombre",
    [147] = "Noir MODSHOP 1",
    [148] = "Violet Mat",
    [149] = "Violet Sombre Mat",
    [150] = "Rouge Lave Métallique",
    [151] = "Vert Forêt Mat",
    [152] = "Olive Drab Mat",
    [153] = "Marron Désert Mat",
    [154] = "Tan Désert Mat",
    [155] = "Vert Feuillage Mat",
    [156] = "COULEUR ALLOY PAR DÉFAUT",
    [157] = "Bleu Epsilon",
    [158] = "Inconnu",
}


Config.ColorInformation = {
    [0] = "black",
    [1] = "black",
    [2] = "black",
    [3] = "darksilver",
    [4] = "silver",
    [5] = "bluesilver",
    [6] = "silver",
    [7] = "darksilver",
    [8] = "silver",
    [9] = "bluesilver",
    [10] = "darksilver",
    [11] = "darksilver",
    [12] = "matteblack",
    [13] = "gray",
    [14] = "lightgray",
    [15] = "black",
    [16] = "black",
    [17] = "darksilver",
    [18] = "silver",
    [19] = "utilgunmetal",
    [20] = "silver",
    [21] = "black",
    [22] = "black",
    [23] = "darksilver",
    [24] = "silver",
    [25] = "bluesilver",
    [26] = "darksilver",
    [27] = "red",
    [28] = "torinored",
    [29] = "formulared",
    [30] = "blazered",
    [31] = "gracefulred",
    [32] = "garnetred",
    [33] = "desertred",
    [34] = "cabernetred",
    [35] = "candyred",
    [36] = "orange",
    [37] = "gold",
    [38] = "orange",
    [39] = "red",
    [40] = "mattedarkred",
    [41] = "orange",
    [42] = "matteyellow",
    [43] = "red",
    [44] = "brightred",
    [45] = "garnetred",
    [46] = "red",
    [47] = "red",
    [48] = "darkred",
    [49] = "darkgreen",
    [50] = "racingreen",
    [51] = "seagreen",
    [52] = "olivegreen",
    [53] = "green",
    [54] = "gasolinebluegreen",
    [55] = "mattelimegreen",
    [56] = "darkgreen",
    [57] = "green",
    [58] = "darkgreen",
    [59] = "green",
    [60] = "seawash",
    [61] = "midnightblue",
    [62] = "darkblue",
    [63] = "saxonyblue",
    [64] = "blue",
    [65] = "blue",
    [66] = "blue",
    [67] = "diamondblue",
    [68] = "blue",
    [69] = "blue",
    [70] = "brightblue",
    [71] = "purpleblue",
    [72] = "blue",
    [73] = "ultrablue",
    [74] = "brightblue",
    [75] = "darkblue",
    [76] = "midnightblue",
    [77] = "blue",
    [78] = "blue",
    [79] = "lightningblue",
    [80] = "blue",
    [81] = "brightblue",
    [82] = "mattedarkblue",
    [83] = "matteblue",
    [84] = "matteblue",
    [85] = "darkblue",
    [86] = "blue",
    [87] = "lightningblue",
    [88] = "yellow",
    [89] = "yellow",
    [90] = "bronze",
    [91] = "yellow",
    [92] = "lime",
    [93] = "champagne",
    [94] = "beige",
    [95] = "darkivory",
    [96] = "brown",
    [97] = "brown",
    [98] = "lightbrown",
    [99] = "beige",
    [100] = "brown",
    [101] = "brown",
    [102] = "beechwood",
    [103] = "beechwood",
    [104] = "chocoorange",
    [105] = "yellow",
    [106] = "yellow",
    [107] = "cream",
    [108] = "brown",
    [109] = "brown",
    [110] = "brown",
    [111] = "white",
    [112] = "white",
    [113] = "beige",
    [114] = "brown",
    [115] = "brown",
    [116] = "beige",
    [117] = "steel",
    [118] = "blacksteel",
    [119] = "aluminium",
    [120] = "chrome",
    [121] = "wornwhite",
    [122] = "offwhite",
    [123] = "orange",
    [124] = "lightorange",
    [125] = "green",
    [126] = "yellow",
    [127] = "blue",
    [128] = "green",
    [129] = "brown",
    [130] = "orange",
    [131] = "white",
    [132] = "white",
    [133] = "darkgreen",
    [134] = "white",
    [135] = "pink",
    [136] = "pink",
    [137] = "pink",
    [138] = "orange",
    [139] = "green",
    [140] = "blue",
    [141] = "blackblue",
    [142] = "blackpurple",
    [143] = "blackred",
    [144] = "darkgreen",
    [145] = "purple",
    [146] = "darkblue",
    [147] = "black",
    [148] = "purple",
    [149] = "darkpurple",
    [150] = "red",
    [151] = "darkgreen",
    [152] = "olivedrab",
    [153] = "brown",
    [154] = "tan",
    [155] = "green",
    [156] = "silver",
    [157] = "blue",
    [158] = "black",
}

Config.ClassList = {
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorbike",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Van",
    [13] = "Bike",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}

function GetJobType(job)
	if Config.PoliceJobs[job] then
		return 'leo'
	elseif Config.AmbulanceJobs[job] then
		return 'ems'
	elseif Config.DojJobs[job] then
		return 'doj'
	else
		return nil
	end
end
