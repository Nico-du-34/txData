const resName = GetParentResourceName();
let hasDoorsCreator = null; // editing this is useless, don't do it

/* Forms stuff */
var forms = document.querySelectorAll('.needs-validation')

// Loop over them and prevent submission
Array.prototype.slice.call(forms)
.forEach(function (form) {
	form.addEventListener('submit', function (event) {

	event.preventDefault();

	form.classList.add('was-validated')
	}, false)
})

async function getJobLabel(jobName) {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getJobLabel`, JSON.stringify({jobName: jobName}), function(jobLabel) {
			resolve(jobLabel);
		})
	})
}

/* Color stuff */
function componentToHex(c) {
	var hex = c.toString(16);

	return hex.length == 1 ? "0" + hex : hex;
  }
  
function rgbToHex(r, g, b) {
	return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}  

function hexToRgb(hex) {
	var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);

	return result ? {
	  r: parseInt(result[1], 16),
	  g: parseInt(result[2], 16),
	  b: parseInt(result[3], 16)
	} : null;
}

/* Language stuff */
let TRANSLATIONS = {};
let ENGLISH_TRANSLATIONS = {};

function translateEverything() {
	$("body").find("[data-translation-id], [data-bs-toggle='tooltip']").each(function() {
		let translationId = $(this).data("translationId")

		if( $(this).data("bsToggle") == "tooltip" ) {
			$(this).prop("title", getLocalizedText(translationId));
			$(this).tooltip();
		} else {
			$(this).prop("innerHTML", getLocalizedText(translationId));
		}

	})
} 

async function refreshTranslations(locale) {
	let rawEnglishTranslations = await $.get("menu_translations/en.json");
	ENGLISH_TRANSLATIONS = typeof rawEnglishTranslations == "object" ? rawEnglishTranslations : JSON.parse(rawEnglishTranslations);

	let rawTranslations = await $.get(`menu_translations/${locale}.json`);
	TRANSLATIONS = typeof rawTranslations == "object" ? rawTranslations : JSON.parse(rawTranslations);

	translateEverything();
}

async function loadTranslations() {
	const locale = await $.post(`https://${resName}/getLocale`);

	refreshTranslations(locale);
} loadTranslations();

function getLocalizedText(text) {
	return TRANSLATIONS[text] || ENGLISH_TRANSLATIONS[text] || text;
}

/* Utils */

function getFramework() {
	return new Promise((resolve) => {
		$.post(`https://${resName}/getFramework`, {}, (framework) => {
			resolve(framework)
		})
	}) 
}
async function getCurrentCoords() {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getCurrentCoords`, {}, function(coords) {
			resolve(coords);
		})
	});
}

async function getCurrentCoordsAndHeading() {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getCurrentCoordsAndHeading`, {}, function(data) {
			resolve(data);
		})
	});
}

// Open/Close menu
function openMenu(version, fullConfig) {
	$("#races-creator-version").text(version);

	loadRaces();
	loadSettings(fullConfig);

    $("#races-creator").show()
}

function closeMenu() {
	// Resets current active tab
	$("#races-creator").find(".nav-link, .tab-pane").each(function() {
		if($(this).data("isDefault") == "1") {
			$(this).addClass(["active", "show"])
		} else {
			$(this).removeClass(["active", "show"])
		}
	})
	
    $("#races-creator").hide();

    $.post(`https://${resName}/close`, {})
}
$("#close-main-btn").click(closeMenu);

// Messages received by client
window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {

		case "openMenu": {
			openMenu(data.version, data.fullConfig);

			break;
		}

		case "showRaceHUD": {
			$("#race-hud").show();
			$("#app").show();
			break;
		}

		case "hideRaceHUD": {
			$("#race-hud").hide();
			$("#app").hide();
			break;
		}

		case "updateRacePositionHUD": {
			$("#race-hud-position").text(data.position);
			break;
		}

		case "updateRaceTimeHUD": {
			$("#race-hud-time").text(data.time);
			break;
		}

		case "updateRaceCheckpointHUD": {
			$("#race-hud-checkpoint").text(data.checkpoint);
			break;
		}

		case "updateRaceLapHUD": {
			$("#race-hud-lap").text(data.lap);
			break;
		}
	}
})

/*
███████ ███████ ████████ ████████ ██ ███    ██  ██████  ███████ 
██      ██         ██       ██    ██ ████   ██ ██       ██      
███████ █████      ██       ██    ██ ██ ██  ██ ██   ███ ███████ 
     ██ ██         ██       ██    ██ ██  ██ ██ ██    ██      ██ 
███████ ███████    ██       ██    ██ ██   ████  ██████  ███████ 
*/

/* Discord logs */
function toggleDiscordLogsInSettings(enable) {
	$("#settings-mainDiscordWebhook").prop("disabled", !enable);
	$("#settings-mainDiscordWebhook").prop("required", enable);
	
	$("#settings-specific-webooks-div").find(`.form-control`).prop("disabled", !enable);
}

$("#settings-areDiscordLogsActive").change(function() {
	let enabled = $(this).prop("checked");

	toggleDiscordLogsInSettings(enabled);
})

function getSeparatedDiscordWebhooks() {
	let webhooks = {};

	$("#settings-specific-webooks-div").find(".form-control").each(function(index, element) {
		let logType = $(element).data("logType");
		let webhook = $(element).val();

		if(webhook) {
			webhooks[logType] = webhook;
		}
	});

	return webhooks;
}
/* Discord logs END */

$("#settings-customize-checkpoint-blip-btn").click(async function() {
	const oldBlipData = $(this).data("blipData");
	const newBlipData = await blipDialog(oldBlipData);

	$(this).data("blipData", newBlipData);
})

async function getRaceLabel(raceId) {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getRaceLabel`, JSON.stringify({raceId: raceId}), (label) => {
			resolve(label);
		});
	});
}

async function addRaceLeaderboard(raceId, webhook) {
	let div = $(`
		<div class="input-group leaderboard-element my-3">
			<span class="input-group-text">${getLocalizedText("menu:race")}</span>
			<input type="text" class="form-control race-label" disabled>
			<button type="button" class="btn btn-secondary choose-race-btn"><i class="bi bi-list-ul"></i></button>	
			<span class="input-group-text ms-2">${getLocalizedText("menu:webhook")}</span>
			<input type="text" required class="form-control webhook-input" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:webhook:description")}" placeholder="https://discord.com/api/webhooks/USE_YOUR_WEBHOOK/YOUR_WEBHOOK">
			<button type="button" class="btn-close btn-close-white ms-2 my-auto delete-element-btn"></button>	
		</div>
	`);

	div.find(".choose-race-btn").click(async function() {
		const raceId = await racesDialog();

		if(raceId) {
			div.data("raceId", raceId);

			const raceLabel = await getRaceLabel(raceId);
			div.find(".race-label").val(raceLabel);
		}
	});

	div.find(".delete-element-btn").click(function() {
		div.remove();
	});

	div.find(".webhook-input").tooltip();

	if(raceId) {
		div.data("raceId", raceId);
		
		const raceLabel = await getRaceLabel(raceId);
		if(!raceLabel) return; // The race was deleted

		div.find(".race-label").val(raceLabel);

		div.find(".webhook-input").val(webhook);
	}

	$("#settings-leaderboard-list").append(div)
}

$("#settings-add-race-leaderboard-btn").click(function() {
	addRaceLeaderboard();
})

function getAllDiscordLeaderboards() {
	let leaderboards = {};

	$("#settings-leaderboard-list").find(".leaderboard-element").each(function(index, element) {
		let raceId = $(element).data("raceId");
		let webhook = $(element).find(".webhook-input").val();

		if(raceId && webhook) {
			leaderboards[raceId] = webhook;
		}
	});

	return leaderboards;
}

$("#settings-enable-players-race-command").change(function() {
	const enabled = $(this).prop("checked");

	$("#settings-players-race-command").prop("disabled", !enabled);
})

$("#settings-players-race-allowed-jobs-btn").click(async function() {
	const oldAllowedJobs = $(this).data("allowedJobs");
	const newAllowedJobs = await jobsDialog(oldAllowedJobs);

	$(this).data("allowedJobs", newAllowedJobs);
});

function loadSettings(fullConfig) {

	// Language
	$("#settings-locale").val(fullConfig.locale);

	// Generic
	$("#settings-ace-permission").val(fullConfig.acePermission);
	$("#settings-enable-players-race-command").prop("checked", fullConfig.enablePlayersRaceCommand).change();
	$("#settings-players-race-command").val(fullConfig.playersRaceCommand);
	$("#settings-players-race-allowed-jobs-btn").data("allowedJobs", fullConfig.playersRaceAllowedJobs);
	$("#settings-enable-boost-on-start").prop("checked", fullConfig.enableBoostOnStart);
	$("#settings-customize-checkpoint-blip-btn").data("blipData", fullConfig.checkpointBlipCustomization);
	$("#settings-enable-checkpoint-visual-effect").prop("checked", fullConfig.checkpointEffects.visual);
	$("#settings-enable-checkpoint-sound-effect").prop("checked", fullConfig.checkpointEffects.sound);
	$("#settings-seconds-before-kick-from-race").val(fullConfig.secondsBeforeKickFromRace);
	$("#settings-use-character-name-instead-of-nickname").prop("checked", fullConfig.useCharacterNameInsteadOfNickname);
	$("#settings-can-restart-from-checkpoint").prop("checked", fullConfig.canRestartFromCheckpoint);

	// Leaderboards
	$("#settings-leaderboard-list").empty();
	for(const [raceId, webhook] of Object.entries(fullConfig.discordLeaderboards || {})) {
		addRaceLeaderboard(raceId, webhook);
	}

	// Discord logs
	$("#settings-areDiscordLogsActive").prop("checked", fullConfig.areDiscordLogsActive);
	$("#settings-mainDiscordWebhook").val(fullConfig.mainDiscordWebhook);
	
	toggleDiscordLogsInSettings(fullConfig.areDiscordLogsActive);	

	for(const[logType, webhook] of Object.entries(fullConfig.specificWebhooks)) {
		$("#settings-specific-webooks-div").find(`[data-log-type="${logType}"]`).val(webhook);
	}
	// Discord logs - END

}

$("#settings").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let clientSettings = {
		// Generic
		enablePlayersRaceCommand: $("#settings-enable-players-race-command").prop("checked"),
		playersRaceCommand: $("#settings-players-race-command").val(),
		playersRaceAllowedJobs: $("#settings-players-race-allowed-jobs-btn").data("allowedJobs"),
		enableBoostOnStart: $("#settings-enable-boost-on-start").prop("checked"),
		checkpointBlipCustomization: $("#settings-customize-checkpoint-blip-btn").data("blipData"),
		checkpointEffects: {
			visual: $("#settings-enable-checkpoint-visual-effect").prop("checked"),
			sound: $("#settings-enable-checkpoint-sound-effect").prop("checked"),
		},
		secondsBeforeKickFromRace: $("#settings-seconds-before-kick-from-race").val(),
		canRestartFromCheckpoint: $("#settings-can-restart-from-checkpoint").prop("checked"),
	}

	let sharedSettings = {
		locale: $("#settings-locale").val(),
		
	}

	let serverSettings = {
		// Generic
		acePermission: $("#settings-ace-permission").val(),
		useCharacterNameInsteadOfNickname: $("#settings-use-character-name-instead-of-nickname").prop("checked"),

		// Discord logs
		areDiscordLogsActive: $("#settings-areDiscordLogsActive").prop("checked"),
		mainDiscordWebhook: $("#settings-mainDiscordWebhook").val(),
		specificWebhooks: getSeparatedDiscordWebhooks(),

		// Leaderboards
		discordLeaderboards: getAllDiscordLeaderboards()
	}

	$.post(`https://${resName}/saveSettings`, JSON.stringify({
		clientSettings: clientSettings,
		sharedSettings: sharedSettings,
		serverSettings: serverSettings,
	}));

	refreshTranslations(sharedSettings.locale);
});

/*
██████   █████   ██████ ███████ ███████ 
██   ██ ██   ██ ██      ██      ██      
██████  ███████ ██      █████   ███████ 
██   ██ ██   ██ ██      ██           ██ 
██   ██ ██   ██  ██████ ███████ ███████ 
*/

let racesDatatable = $("#races-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );

			editRace(id);
		})
	},
});

let races = {};

function loadRaces() {
	$.post(`https://${resName}/getAllRaces`, {}, async function(rawRaces) {

		// Manually create the table to avoid incompatibilities due table indexing
		races = {};

		for(const[k, raceData] of Object.entries(rawRaces)) {
			races[raceData.id] = raceData;
		}

		racesDatatable.clear();

		for(const[id, raceData] of Object.entries(races)) {
			if(raceData.identifier != "admin") continue;
			
			racesDatatable.row.add([
				id,
				raceData.label
			]);
		}

		racesDatatable.draw();
	})
}

function setDefaultDataOfRace() {
	let raceModal = $("#race-modal");

	// Generic
	$("#race-label").val("Default");
	$("#race-minimum-police").val(0);
	$("#race-minimum-players").val(2);
	$("#race-time-limit").val(60);
	$("#race-laps").val(1);
	$("#race-show-map-path").prop("checked", true);
	$("#race-alert-police-on-start").prop("checked", false);
	$("#race-is-arcade").prop("checked", false).change();
	setArcadeEffects(); // Set all to 0

	// Starting zone
	$("#race-starting-zone-x").val("");
	$("#race-starting-zone-y").val("");
	$("#race-starting-zone-z").val("");
	$("#race-starting-zone-size").val("");

	// Prize
	$("#race-entrance-fee").val(100);
	raceModal.find("input:radio[name='prize-distribution'][value='winner-takes-all']").prop("checked", true).change();
	$("#race-entrance-fee-account").val("bank");
		
	// Checkpoints
	$("#race-checkpoints-list").empty();

	// Other ?
	raceModal.data("blipData", getDefaultBlipCustomization());
	raceModal.data("markerData", getDefaultMarkerCustomization());
	raceModal.data("allowedJobs", null);
	raceModal.data("allowedVehicleClasses", null);
}

$("#new-race-btn").click(function() {
	let raceModal = $("#race-modal");

	// Converts from edit modal to create modal
	raceModal.data("action", "create");
	
	$("#delete-race-btn").hide();
	$("#save-race-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfRace();

	raceModal.modal("show");
});

$("#race-customize-blip-btn").click(async function() {
	let raceModal = $("#race-modal");
	
	const oldBlipData = raceModal.data("blipData");
	const newBlipData = await blipDialog(oldBlipData);

	raceModal.data("blipData", newBlipData);
});

$("#race-customize-marker-btn").click(async function() {
	let raceModal = $("#race-modal");
	
	const oldMarkerData = raceModal.data("markerData");
	const newMarkerData = await markerDialog(oldMarkerData);

	raceModal.data("markerData", newMarkerData);
});

$("#race-allowed-jobs-btn").click(async function() {
	let raceModal = $("#race-modal");

	const oldAllowedJobs = raceModal.data("allowedJobs");
	const newAllowedJobs = await jobsDialog(oldAllowedJobs);

	raceModal.data("allowedJobs", newAllowedJobs);
});

$("#race-allowed-vehicle-classes-btn").click(async function() {
	let raceModal = $("#race-modal");

	const oldAllowedVehicleClasses = raceModal.data("allowedVehicleClasses");
	const newAllowedVehicleClasses = await vehicleClassesDialog(oldAllowedVehicleClasses);

	raceModal.data("allowedVehicleClasses", newAllowedVehicleClasses);
});

$("#race-choose-entrance-fee-account-btn").click(async function() {
	const accountName = await accountsDialog();

	if(accountName) {
		$("#race-entrance-fee-account").val(accountName);
	}
})

function editRace(id) {
	let raceModal = $("#race-modal");

	// Converts from create modal to edit modal
	raceModal.data("action", "edit");
	raceModal.data("raceId", id);

	$("#delete-race-btn").show();
	$("#save-race-btn").text( getLocalizedText("menu:save") );

	const raceInfo = races[id];
	const raceData = raceInfo.data;

	// Generic
	$("#race-label").val(raceInfo.label);
	$("#race-minimum-police").val(raceData.minimumPolice);
	$("#race-minimum-players").val(raceData.minimumPlayers);
	$("#race-time-limit").val(raceData.timeLimit);
	$("#race-laps").val(raceData.laps);
	$("#race-alert-police-on-start").prop("checked", raceData.alertPoliceOnStart);
	$("#race-show-map-path").prop("checked", raceData.showMapPath);
	$("#race-is-arcade").prop("checked", raceData.isArcade).change();
	setArcadeEffects(raceData.arcadeEffects);

	raceModal.data("blipData", raceData.blipData);
	raceModal.data("markerData", raceData.markerData);
	raceModal.data("allowedJobs", raceData.allowedJobs);
	raceModal.data("allowedVehicleClasses", raceData.allowedVehicleClasses);

	// Starting zone
	$("#race-starting-zone-x").val(raceData.startingZone.coords.x);
	$("#race-starting-zone-y").val(raceData.startingZone.coords.y);
	$("#race-starting-zone-z").val(raceData.startingZone.coords.z);
	$("#race-starting-zone-size").val(raceData.startingZone.size);

	// Prize
	$("#race-entrance-fee").val(raceData.entranceFee);
	raceModal.find("input:radio[name='prize-distribution'][value='" + raceData.prizeDistribution + "']").prop("checked", true).change();
	$("#race-entrance-fee-account").val(raceData.entranceFeeAccount);

	// Checkpoints
	$("#race-checkpoints-list").empty();

	for(const checkpoint of raceData.checkpoints) {
		addCheckpointInRace(checkpoint);
	}


	raceModal.modal("show");
}

$("#race-choose-starting-zone-btn").click(function() {
	$("html").hide();

	$.post(`https://${resName}/chooseStartingZone`, {}, function(startingZone) {
		if(startingZone) {
			$("#race-starting-zone-x").val(startingZone.coords.x);
			$("#race-starting-zone-y").val(startingZone.coords.y);
			$("#race-starting-zone-z").val(startingZone.coords.z);
			$("#race-starting-zone-size").val(startingZone.size);
		}

		$("html").show();
	})
})

function addCheckpointInRace(checkpoint) {
	const checkpointIndex = $("#race-checkpoints-list").children().length + 1;

	let checkpointDiv = $(`
		<div class="row g-2 row-cols-auto align-items-center justify-content-center mb-3">
			<p class="fs-3 my-auto me-2 checkpoint-index">${checkpointIndex}</p>
			
			<div class="form-floating text-body col">
				<input type="number" step="0.01" class="form-control checkpoint-x" placeholder="X" required>
				<label>${getLocalizedText("menu:x")}</label>
			</div>

			<div class="form-floating text-body col">
				<input type="number" step="0.01" class="form-control checkpoint-y" placeholder="Y" required>
				<label>${getLocalizedText("menu:y")}</label>
			</div>

			<div class="form-floating text-body col">
				<input type="number" step="0.01" class="form-control checkpoint-z" placeholder="Z" required>
				<label>${getLocalizedText("menu:z")}</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto checkpoint-current-coords-btn" data-translation-id="menu:choose_starting_zone" data-bs-toggle="tooltip" data-bs-placement="top"><i class="bi bi-arrow-down-square"></i></button>

			<div class="form-floating text-body col-1 ms-2">
				<input type="number" step="0.01" class="form-control checkpoint-size" placeholder="Size" val="10.0" required>
				<label>${getLocalizedText("menu:size")}</label>
			</div>
			
			<button type="button" class="btn-close delete-checkpoint-btn"></button>	
		</div>
	`);

	checkpointDiv.find(".checkpoint-current-coords-btn").click(async function() {
		const coords = await getCurrentCoords();

		checkpointDiv.find(".checkpoint-x").val(coords.x);
		checkpointDiv.find(".checkpoint-y").val(coords.y);
		checkpointDiv.find(".checkpoint-z").val(coords.z);
	})

	checkpointDiv.find(".delete-checkpoint-btn").click(function() {
		checkpointDiv.remove();
		
		// Update checkpoint indexes
		$("#race-checkpoints-list").children().each(function(index) {
			$(this).find(".checkpoint-index").text(index + 1);
		});
	});

	if(checkpoint) {
		checkpointDiv.find(".checkpoint-x").val(checkpoint.coords.x);
		checkpointDiv.find(".checkpoint-y").val(checkpoint.coords.y);
		checkpointDiv.find(".checkpoint-z").val(checkpoint.coords.z);
		checkpointDiv.find(".checkpoint-size").val(checkpoint.size);
	}

	$("#race-checkpoints-list").append(checkpointDiv);
}
$("#race-add-checkpoint").click(function() {
	// If there are less than 99 checkpoints, add a new one
	if($("#race-checkpoints-list").children().length < 99) {
		addCheckpointInRace();
	}
});

function getRaceCheckpoints() {
	let checkpoints = [];

	$("#race-checkpoints-list").children().each(function() {
		checkpoints.push({
			coords: {
				x: parseFloat( $(this).find(".checkpoint-x").val() ),
				y: parseFloat( $(this).find(".checkpoint-y").val() ),
				z: parseFloat( $(this).find(".checkpoint-z").val() )
			},
			size: parseFloat( $(this).find(".checkpoint-size").val() )
		})
	});

	return checkpoints;
}

$("#race-setup-all-checkpoints").click(function() {
	$("html").hide();

	$.post(`https://${resName}/setupAllCheckpoints`, JSON.stringify({oldCheckpoints: getRaceCheckpoints()}), function(checkpoints) {
		if(checkpoints) {
			$("#race-checkpoints-list").empty();
	
			for(const checkpoint of checkpoints) {
				addCheckpointInRace(checkpoint);
			}
		}

		$("html").show();
	})
})

$("#race-is-arcade").change(function() {
	const enabled = $(this).prop("checked");

	$("#race-arcade-probabilities-div").toggle(enabled);
})

function getArcadeEffects() {
	let effects = [];

	$("#race-arcade-probabilities-div").find("input").each(function() {
		effects.push({
			name: $(this).data("effectName"),
			probability: parseInt( $(this).val() ) || 0
		})
	});

	return effects;
}

function setArcadeEffects(effects) {
	if(effects) {
		for(const effectData of effects) {
			$("#race-arcade-probabilities-div").find(`input[data-effect-name="${effectData.name}"]`).val(effectData.probability);
		}
	} else {
		$("#race-arcade-probabilities-div").find("input").val(0);
	}
}

$("#race-form").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let raceModal = $("#race-modal");
	let action = raceModal.data("action");

	let raceData = {
		label: $("#race-label").val(),
		data: {
			allowedJobs: raceModal.data("allowedJobs"),
			blipData: raceModal.data("blipData"),
			markerData: raceModal.data("markerData"),
			allowedVehicleClasses: raceModal.data("allowedVehicleClasses"),
			minimumPolice: parseInt( $("#race-minimum-police").val() ),
			minimumPlayers: parseInt( $("#race-minimum-players").val() ),
			timeLimit: parseInt( $("#race-time-limit").val() ),
			laps:  parseInt( $("#race-laps").val() ),
			alertPoliceOnStart: $("#race-alert-police-on-start").prop("checked"),
			showMapPath: $("#race-show-map-path").prop("checked"),
			isArcade: $("#race-is-arcade").prop("checked"),
			arcadeEffects: getArcadeEffects(),
			
			entranceFee: parseInt( $("#race-entrance-fee").val() ),
			entranceFeeAccount: $("#race-entrance-fee-account").val(),
			prizeDistribution: $("input:radio[name='prize-distribution']:checked").val(),
			startingZone: {
				coords: {
					x: parseFloat( $("#race-starting-zone-x").val() ),
					y: parseFloat( $("#race-starting-zone-y").val() ),
					z: parseFloat( $("#race-starting-zone-z").val() )
				},

				size: parseFloat( $("#race-starting-zone-size").val() )
			},
			checkpoints: getRaceCheckpoints()
		}
	}
	
	switch(action) {
		case "create": {
			$.post(`https://${resName}/createRace`, JSON.stringify(raceData), function(isSuccessful) {
				if(isSuccessful) {
					raceModal.modal("hide");
					loadRaces();
				}
			});

			break;
		}

		case "edit": {
			$.post(`https://${resName}/updateRace`, JSON.stringify({raceId: raceModal.data("raceId"), raceData: raceData}), function(isSuccessful) {
				if(isSuccessful) {
					raceModal.modal("hide");
					loadRaces();
				}
			});

			break;
		}
	}
})

$("#delete-race-btn").click(function() {
	let raceModal = $("#race-modal");
	let raceId = raceModal.data("raceId");

	$.post(`https://${resName}/deleteRace`, JSON.stringify({raceId: raceId}), function(isSuccessful) {
		if(isSuccessful) {
			raceModal.modal("hide");
			loadRaces();
		}
	});
});