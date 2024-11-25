const resName = GetParentResourceName();

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
	$("#trackers-creator-version").text(version);

	loadTrackers();
	loadSettings(fullConfig);

    $("#trackers-creator").show()
}

function closeMenu() {
	// Resets current active tab
	$("#trackers-creator").find(".nav-link, .tab-pane").each(function() {
		if($(this).data("isDefault") == "1") {
			$(this).addClass(["active", "show"])
		} else {
			$(this).removeClass(["active", "show"])
		}
	})
	
    $("#trackers-creator").hide();

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
	}
});

/*
███████ ███████ ████████ ████████ ██ ███    ██  ██████  ███████ 
██      ██         ██       ██    ██ ████   ██ ██       ██      
███████ █████      ██       ██    ██ ██ ██  ██ ██   ███ ███████ 
     ██ ██         ██       ██    ██ ██  ██ ██ ██    ██      ██ 
███████ ███████    ██       ██    ██ ██   ████  ██████  ███████ 
*/

$("#settings-private-tracker-customize-blip-btn").click(async function() {
	let oldBlipData = $(this).data("privateTrackerBlipData");
	let newBlipData = await blipDialog(oldBlipData);
		
	$(this).data("privateTrackerBlipData", newBlipData);
})

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

function loadSettings(fullConfig) {

	// Language
	$("#settings-locale").val(fullConfig.locale);

	// Generic
	$("#settings-ace-permission").val(fullConfig.acePermission);
	$("#settings-enable-detailed-blip-sprite").prop("checked", fullConfig.enableDetailedBlipSprite);

	// Panic button
	$("#settings-panic-button-default-key").val(fullConfig.defaultPanicButton);
	$("#settings-panic-button-blip-sprite").val(fullConfig.panicButtonBlip.sprite);
	$("#settings-panic-button-blip-color").val(fullConfig.panicButtonBlip.color);
	$("#settings-panic-button-blip-scale").val(fullConfig.panicButtonBlip.scale);
	$("#settings-panic-button-blip-duration").val(fullConfig.panicButtonBlip.duration);
	$("#settings-panic-button-emits-sound").prop("checked", fullConfig.doesPanicButtonEmitsSound);
	$("#settings-panic-button-enable-hotkey").prop("checked", fullConfig.enablePanicButtonHotkey);

	// Private tracker
	$("#settings-private-tracker-enabled").prop("checked", fullConfig.privateTrackerOptions.isEnabled);
	$("#settings-private-tracker-use-roleplay-name-as-blip-name").prop("checked", fullConfig.privateTrackerOptions.useRoleplayNameAsBlipName);
	$("#settings-private-tracker-refresh-time").val(fullConfig.privateTrackerOptions.refreshTime);
	$("#settings-private-tracker-item-name").val(fullConfig.privateTrackerOptions.itemName);
	$("#settings-private-tracker-max-frequency").val(fullConfig.privateTrackerOptions.maxFrequency);
	$("#settings-private-tracker-customize-blip-btn").data("privateTrackerBlipData", fullConfig.privateTrackerOptions.blipData);

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
		defaultPanicButton: $("#settings-panic-button-default-key").val(),
		panicButtonBlip: {
			sprite: parseInt( $("#settings-panic-button-blip-sprite").val() ),
			color: parseInt( $("#settings-panic-button-blip-color").val() ),
			scale: parseInt( $("#settings-panic-button-blip-scale").val() ),
			duration: parseInt( $("#settings-panic-button-blip-duration").val() ),
		},
		doesPanicButtonEmitsSound: $("#settings-panic-button-emits-sound").prop("checked"),
		enablePanicButtonHotkey: $("#settings-panic-button-enable-hotkey").prop("checked"),
	}

	let sharedSettings = {
		locale: $("#settings-locale").val(),
		enableDetailedBlipSprite: $("#settings-enable-detailed-blip-sprite").prop("checked"),
	}

	let serverSettings = {
		// Generic
		acePermission: $("#settings-ace-permission").val(),

		// Discord logs
		areDiscordLogsActive: $("#settings-areDiscordLogsActive").prop("checked"),
		mainDiscordWebhook: $("#settings-mainDiscordWebhook").val(),
		specificWebhooks: getSeparatedDiscordWebhooks(),

		// Private tracker
		privateTrackerOptions: {
			isEnabled: $("#settings-private-tracker-enabled").prop("checked"),
			useRoleplayNameAsBlipName: $("#settings-private-tracker-use-roleplay-name-as-blip-name").prop("checked"),
			refreshTime: parseInt( $("#settings-private-tracker-refresh-time").val() ),
			itemName: $("#settings-private-tracker-item-name").val(),
			maxFrequency: parseInt( $("#settings-private-tracker-max-frequency").val() ),
			blipData: $("#settings-private-tracker-customize-blip-btn").data("privateTrackerBlipData"),
		}
	}

	$.post(`https://${resName}/saveSettings`, JSON.stringify({
		clientSettings: clientSettings,
		sharedSettings: sharedSettings,
		serverSettings: serverSettings,
	}));

	refreshTranslations(sharedSettings.locale);
});

/*
████████ ██████   █████   ██████ ██   ██ ███████ ██████  ███████
   ██    ██   ██ ██   ██ ██      ██  ██  ██      ██   ██ ██     
   ██    ██████  ███████ ██      █████   █████   ██████  ███████
   ██    ██   ██ ██   ██ ██      ██  ██  ██      ██   ██      ██
   ██    ██   ██ ██   ██  ██████ ██   ██ ███████ ██   ██ ███████
*/
let trackersDatatable = $("#trackers-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );

			editTracker(id);
		})
	},
});

let trackers = {};

function loadTrackers() {
	$.post(`https://${resName}/getAllTrackers`, {}, async function(rawTrackers) {

		// Manually create the table to avoid incompatibilities due table indexing
		trackers = {};

		for(const[k, trackerData] of Object.entries(rawTrackers)) {
			trackers[trackerData.id] = trackerData;
		}

		trackersDatatable.clear();

		for(const[id, trackerData] of Object.entries(trackers)) {
			trackersDatatable.row.add([
				id,
				trackerData.label,
			]);
		}

		trackersDatatable.draw();
	})
}

function setDefaultDataOfTracker() {
	$("#tracker-label").val("Default");
	$("#tracker-refresh-time").val(5);

	$("#tracker-send-options-requires-item").prop("checked", false).change();
	$("#tracker-receive-options-requires-item").prop("checked", false).change();
	$("#tracker-use-rp-name-as-blip-name").prop("checked", false).change();

	let trackerModal = $("#tracker-modal");
	trackerModal.data("blipData", getDefaultBlipCustomization());
	trackerModal.data("signalLostBlipData", getDefaultBlipCustomizationForSignalLost());
	setSendOptionsAllowedJobs(null);
	trackerModal.data("receiveOptionsAllowedJobs", null);
}

function setSendOptionsAllowedJobs(jobs) {
	$("#tracker-modal").data("sendOptionsAllowedJobs", jobs);

	const btnDiv = $("#tracker-send-options-can-use-panic-button-div");

	if(jobs) {
		btnDiv.show(jobs);
	} else {
		btnDiv.hide(jobs);
		$("#tracker-send-options-can-use-panic-button").prop("checked", false);
	}
}

$("#tracker-send-options-requires-item").change(function() {
	const enabled = $(this).prop("checked");

	$("#tracker-send-options-item-name").prop("disabled", !enabled).prop("required", enabled);
	$("#tracker-send-options-item-min-quantity").prop("disabled", !enabled).prop("required", enabled);
	$("#tracker-send-options-choose-item-btn").prop("disabled", !enabled);

	if(!enabled) {
		$("#tracker-send-options-item-name").val("");
		$("#tracker-send-options-item-min-quantity").val("");
	}

	// Signal lost 
	$("#signal-lost-div").toggle(enabled);

	if(!enabled) {
		$("#tracker-signal-lost-notification-enabled").prop("checked", false).change();
	}
});

$("#tracker-signal-lost-notification-enabled").change(function() {
	const enabled = $(this).prop("checked");

	$("#tracker-signal-lost-duration").prop("required", enabled).prop("disabled", !enabled);
	$("#tracker-signal-lost-customize-blip-btn").prop("disabled", !enabled);
});

$("#tracker-signal-lost-customize-blip-btn").click(async function() {
	let trackerModal = $("#tracker-modal");

	let oldBlipData = trackerModal.data("signalLostBlipData");
	let newBlipData = await blipDialog(oldBlipData);
		
	trackerModal.data("signalLostBlipData", newBlipData);
});

$("#tracker-send-options-choose-item-btn").click(async function() {
	const itemName = await itemsDialog();

	$("#tracker-send-options-item-name").val(itemName);
});

$("#tracker-receive-options-choose-item-btn").click(async function() {
	const itemName = await itemsDialog();

	$("#tracker-receive-options-item-name").val(itemName);
});

$("#tracker-receive-options-requires-item").change(function() {
	const enabled = $(this).prop("checked");

	$("#tracker-receive-options-item-name").prop("disabled", !enabled).prop("required", enabled);
	$("#tracker-receive-options-item-min-quantity").prop("disabled", !enabled).prop("required", enabled);
	$("#tracker-receive-options-choose-item-btn").prop("disabled", !enabled);

	if(!enabled) {
		$("#tracker-receive-options-item-name").val("");
		$("#tracker-receive-options-item-min-quantity").val("");
	}
});

$("#tracker-receive-options-allowed-jobs-btn").click(async function() {
	let trackerModal = $("#tracker-modal");

	let oldAllowedJobs = trackerModal.data("receiveOptionsAllowedJobs");
	let newAllowedJobs = await jobsDialog(oldAllowedJobs);

	trackerModal.data("receiveOptionsAllowedJobs", newAllowedJobs);
});

$("#tracker-send-options-allowed-jobs-btn").click(async function() {
	let trackerModal = $("#tracker-modal");

	let oldAllowedJobs = trackerModal.data("sendOptionsAllowedJobs");
	let newAllowedJobs = await jobsDialog(oldAllowedJobs);

	setSendOptionsAllowedJobs(newAllowedJobs);
});

$("#tracker-customize-blip-btn").click(async function() {
	let trackerModal = $("#tracker-modal");

	let oldBlipData = trackerModal.data("blipData");
	let newBlipData = await blipDialog(oldBlipData);
		
	trackerModal.data("blipData", newBlipData);
});

$("#new-tracker-btn").click(function() {
	let trackerModal = $("#tracker-modal");

	// Converts from edit modal to create modal
	trackerModal.data("action", "create");
	
	$("#delete-tracker-btn").hide();
	$("#save-tracker-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfTracker();

	trackerModal.modal("show");
});

function editTracker(id) {
	let trackerModal = $("#tracker-modal");

	// Converts from create modal to edit modal
	trackerModal.data("action", "edit");
	trackerModal.data("trackerId", id);

	$("#delete-tracker-btn").show();
	$("#save-tracker-btn").text( getLocalizedText("menu:save") );

	let trackerInfo = trackers[id];
	let trackerData = trackerInfo.data;

	$("#tracker-label").val(trackerInfo.label);
	$("#tracker-refresh-time").val(trackerData.refreshTime);
	$("#tracker-use-rp-name-as-blip-name").prop("checked", trackerData.useRoleplayNameAsBlipName).change();

	// Send signal
	$("#tracker-send-options-requires-item").prop("checked", trackerData.sendSignalOptions.requiredItem != null).change();
	if(trackerData.sendSignalOptions.requiredItem) {
		$("#tracker-send-options-item-name").val(trackerData.sendSignalOptions.requiredItem.name);
		$("#tracker-send-options-item-min-quantity").val(trackerData.sendSignalOptions.requiredItem.minQuantity);
	}

	$("#tracker-signal-lost-notification-enabled").prop("checked", trackerData.sendSignalOptions.hasSignalLostNotification).change();
	$("#tracker-signal-lost-duration").val(trackerData.sendSignalOptions.signalLostDuration);
	$("#tracker-send-options-can-use-panic-button").prop("checked", trackerData.sendSignalOptions.canUsePanicButton);

	// Receive signal
	$("#tracker-receive-options-requires-item").prop("checked", trackerData.receiveSignalOptions.requiredItem != null).change();
	if(trackerData.receiveSignalOptions.requiredItem) {
		$("#tracker-receive-options-item-name").val(trackerData.receiveSignalOptions.requiredItem.name);
		$("#tracker-receive-options-item-min-quantity").val(trackerData.receiveSignalOptions.requiredItem.minQuantity);
	}

	trackerModal.data("blipData", trackerData.blipData);
	trackerModal.data("signalLostBlipData", trackerData.sendSignalOptions.signalLostBlipData);
	setSendOptionsAllowedJobs(trackerData.sendSignalOptions.allowedJobs);
	trackerModal.data("receiveOptionsAllowedJobs", trackerData.receiveSignalOptions.allowedJobs);

	trackerModal.modal("show");
}

$("#tracker-form").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let trackerModal = $("#tracker-modal");
	let action = trackerModal.data("action");

	let trackerData = {
		label: $("#tracker-label").val(),
		data: {
			blipData: trackerModal.data("blipData") || [getDefaultBlipCustomization()],
			refreshTime: parseInt( $("#tracker-refresh-time").val() ),
			useRoleplayNameAsBlipName: $("#tracker-use-rp-name-as-blip-name").prop("checked"),

			sendSignalOptions: {
				allowedJobs: trackerModal.data("sendOptionsAllowedJobs") || null,
				requiredItem: $("#tracker-send-options-requires-item").prop("checked") ? {
					name: $("#tracker-send-options-item-name").val(),
					minQuantity: parseInt( $("#tracker-send-options-item-min-quantity").val() )
				} : null,
				hasSignalLostNotification: $("#tracker-signal-lost-notification-enabled").prop("checked"),
				signalLostDuration: parseInt( $("#tracker-signal-lost-duration").val() ),
				signalLostBlipData: trackerModal.data("signalLostBlipData") || [getDefaultBlipCustomizationForSignalLost()],
				canUsePanicButton: $("#tracker-send-options-can-use-panic-button").prop("checked")
			},

			receiveSignalOptions: {
				allowedJobs: trackerModal.data("receiveOptionsAllowedJobs") || null,
				requiredItem: $("#tracker-receive-options-requires-item").prop("checked") ? {
					name: $("#tracker-receive-options-item-name").val(),
					minQuantity: parseInt( $("#tracker-receive-options-item-min-quantity").val() )
				} : null
			}
			
		}
	}
	
	switch(action) {
		case "create": {
			$.post(`https://${resName}/createTracker`, JSON.stringify(trackerData), function(isSuccessful) {
				if(isSuccessful) {
					trackerModal.modal("hide");
					loadTrackers();
				}
			});

			break;
		}

		case "edit": {
			$.post(`https://${resName}/updateTracker`, JSON.stringify({trackerId: trackerModal.data("trackerId"), trackerData: trackerData}), function(isSuccessful) {
				if(isSuccessful) {
					trackerModal.modal("hide");
					loadTrackers();
				}
			});

			break;
		}
	}
})

$("#delete-tracker-btn").click(function() {
	let trackerModal = $("#tracker-modal");
	let trackerId = trackerModal.data("trackerId");

	$.post(`https://${resName}/deleteTracker`, JSON.stringify({trackerId: trackerId}), function(isSuccessful) {
		if(isSuccessful) {
			trackerModal.modal("hide");
			loadTrackers();
		}
	});
});