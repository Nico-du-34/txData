const resName = GetParentResourceName();
let hasDoorsCreator = null; // editing this is useless, don't do it

// Open/Close menu
function openMenu(version, fullConfig) {
	$("#dealerships-creator-version").text(version);

	loadDealerships();
	loadSettings(fullConfig);

    $("#dealerships-creator").show()
}

function closeMenu() {
	// Resets current active tab
	$("#dealerships-creator").find(".nav-link, .tab-pane").each(function() {
		if($(this).data("isDefault") == "1") {
			$(this).addClass(["active", "show"])
		} else {
			$(this).removeClass(["active", "show"])
		}
	})
	
    $("#dealerships-creator").hide();

    $.post(`https://${resName}/close`)
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

		case "hasDoorsCreator": {
			hasDoorsCreator = data.hasDoorsCreator;

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
		let webhook = $(element).val();
		if(!webhook) return;
		
		let logType = $(element).data("logType");
		webhooks[logType] = webhook;
	});

	return webhooks;
}
/* Discord logs END */

function loadSettings(fullConfig) {
	// Generic
	$("#settings-locale").val(fullConfig.locale);
	$("#settings-ace-permission").val(fullConfig.acePermission);
	$("#settings-can-always-carry").prop("checked", fullConfig.canAlwaysCarryItem);

	// Help notification
	setTomSelectValue("#settings-help-notification-script", fullConfig.helpNotification)

	// Discord logs
	$("#settings-areDiscordLogsActive").prop("checked", fullConfig.areDiscordLogsActive);
	$("#settings-mainDiscordWebhook").val(fullConfig.mainDiscordWebhook);
	
	toggleDiscordLogsInSettings(fullConfig.areDiscordLogsActive);	

	for(const[logType, webhook] of Object.entries(fullConfig.specificWebhooks)) {
		$("#settings-specific-webooks-div").find(`[data-log-type="${logType}"]`).val(webhook);
	}
	// Discord logs - END

	// Player dealership
	$("#settings-minutes-to-receive-vehicle-after-order").val(fullConfig.minutesToReceiveVehicleAfterOrder);
}

$("#settings").submit(async function(event) {
	if(isThereAnyErrorInForm(event)) return;

	let clientSettings = {
		helpNotification: $("#settings-help-notification-script").val(),
	}

	let sharedSettings = {
		locale: $("#settings-locale").val(),
	}

	let serverSettings = {
		
		// Generic
		acePermission: $("#settings-ace-permission").val(),
		canAlwaysCarryItem: $("#settings-can-always-carry").prop("checked"),

		// Discord logs
		areDiscordLogsActive: $("#settings-areDiscordLogsActive").prop("checked"),
		mainDiscordWebhook: $("#settings-mainDiscordWebhook").val(),
		specificWebhooks: getSeparatedDiscordWebhooks(),

		// Player dealership
		minutesToReceiveVehicleAfterOrder: parseInt( $("#settings-minutes-to-receive-vehicle-after-order").val() ),
	}

	const response = await $.post(`https://${resName}/saveSettings`, JSON.stringify({
		clientSettings: clientSettings,
		serverSettings: serverSettings,
		sharedSettings: sharedSettings
	}));
	showServerResponse(response);

	refreshTranslations(sharedSettings.locale);
});

/*
 █████  ██████  ███    ███ ██ ███    ██     ██████  ███████  █████  ██      ███████ ██████  ███████ ██   ██ ██ ██████  ███████ 
██   ██ ██   ██ ████  ████ ██ ████   ██     ██   ██ ██      ██   ██ ██      ██      ██   ██ ██      ██   ██ ██ ██   ██ ██      
███████ ██   ██ ██ ████ ██ ██ ██ ██  ██     ██   ██ █████   ███████ ██      █████   ██████  ███████ ███████ ██ ██████  ███████ 
██   ██ ██   ██ ██  ██  ██ ██ ██  ██ ██     ██   ██ ██      ██   ██ ██      ██      ██   ██      ██ ██   ██ ██ ██           ██ 
██   ██ ██████  ██      ██ ██ ██   ████     ██████  ███████ ██   ██ ███████ ███████ ██   ██ ███████ ██   ██ ██ ██      ███████ 
*/
let dealershipsDatatable = $("#dealerships-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );
			editDealership(id);
		})
	},
});

let dealerships = {};

async function loadDealerships() {
	const rawDealerships = await $.post(`https://${resName}/getAllDealerships`);

	// Manually create the table to avoid incompatibilities due table indexing
	dealerships = {};

	for(const[k, dealershipData] of Object.entries(rawDealerships)) {
		dealerships[dealershipData.id] = dealershipData;
	}

	dealershipsDatatable.clear();

	for(const[id, dealershipData] of Object.entries(dealerships)) {
		dealershipsDatatable.row.add([
			id,
			dealershipData.label
		]);
	}

	dealershipsDatatable.draw();
}

function setDefaultDataOfDealership() {
	let dealershipModal = $("#dealership-modal");

	// Generic
	$(`input[name=dealership-type][value="auto"]`).prop("checked", true).change();

	$("#dealership-label").val("Default");
	dealershipModal.data("markerData", getDefaultMarkerCustomization());
	dealershipModal.data("blipData", getDefaultBlipCustomization());
	dealershipModal.data("vehiclesData", null);
	$("#dealership-account-name").val("");
	$("#dealership-account-name").val("bank");

 	// Coordinates
	$("#auto-dealership-coords-list").empty();

	// Spawn points
	$("#dealership-spawn-points-list").empty();

	// Showroom
	$("#dealership-showroom-coords-x").val("");
	$("#dealership-showroom-coords-y").val("");
	$("#dealership-showroom-coords-z").val("");
	$("#dealership-showroom-heading").val("");

	// Restrictions
	dealershipModal.data("jobsData", null);
	setRequiredLicenseForDealership(null);

	// Options
	$("#dealership-pay-with-society-money").prop("checked", false).change();
	$("#dealership-always-open").prop("checked", true).change();
	$("#dealership-minutes-before-prices-update").val(0);
	$("#dealership-is-resell-active").prop("checked", false).change();
	$("#dealership-resell-percentage").val("");
	dealershipModal.data("resellPointMarkerData", getDefaultResellCustomization());
	setSelectedSocietiesForDealership(false);

	// Resell points
	$("#dealership-resell-points-list").empty();

	// Test drive data
	$("#dealership-is-test-drive-active").prop("checked", false).change();
	$("#dealership-test-drive-duration").val("");
	$("#dealership-test-drive-change-routing-bucket").prop("checked", false);
	$("#dealership-test-drive-coords-x").val("");
	$("#dealership-test-drive-coords-y").val("");
	$("#dealership-test-drive-coords-z").val("");	

	// Player dealership
	$("#player-dealership-price").val("");
	$("#player-dealership-resell-percentage").val("");

	$("#player-dealership-coords-x").val("");
	$("#player-dealership-coords-y").val("");
	$("#player-dealership-coords-z").val("");

	$("#dealership-enter-showroom-coords-x").val("");
	$("#dealership-enter-showroom-coords-y").val("");
	$("#dealership-enter-showroom-coords-z").val("");

	// Display points
	$("#player-dealership-display-points-list").empty();
}

$("#new-dealership-btn").click(function() {
	let dealershipModal = $("#dealership-modal");

	// Converts from edit modal to create modal
	dealershipModal.data("action", "create");
	
	$("#delete-dealership-btn").hide();
	$("#save-dealership-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfDealership();

	dealershipModal.modal("show");
})

$("#dealership-customize-blip-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");

	let oldBlipData = dealershipModal.data("blipData");
	let blipData = await blipDialog(oldBlipData)

	dealershipModal.data("blipData", blipData);
});

$("#dealership-customize-marker-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");
	
	let oldMarkerData = dealershipModal.data("markerData");
	let markerData = await markerDialog(oldMarkerData)

	dealershipModal.data("markerData", markerData);
});

$("#dealership-choose-vehicles-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");

	let oldVehicles = dealershipModal.data("vehiclesData");
	let vehicles = await vehiclesDialog(oldVehicles, true);

	dealershipModal.data("vehiclesData", vehicles);
});

$("#dealership-choose-account-btn").click(async function() {
	const accountName = await accountsDialog();

	$("#dealership-account-name").val(accountName);
});

$("#dealership-choose-jobs-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");

	let oldJobs = dealershipModal.data("jobsData");
	let jobs = await jobsDialog(oldJobs);

	dealershipModal.data("jobsData", jobs);
})

function setRequiredLicenseForDealership(licenseType) {
	const btn = $("#dealership-choose-required-license-btn");
	if(licenseType) {
		btn.text(getLocalizedText("menu:license_required") + licenseType);
	} else {
		btn.text(getLocalizedText("menu:no_license_required"));
	}

	btn.data("licenseType", licenseType ? licenseType : null);
}

$("#dealership-choose-required-license-btn").click(async function() {
	const requiredLicenseType = await licensesDialog();
	setRequiredLicenseForDealership(requiredLicenseType);
});

$("#dealership-societies-to-send-money-to-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");

	let oldSocieties = dealershipModal.data("societiesData");
	let societies = await societiesDialog(oldSocieties);

	setSelectedSocietiesForDealership(societies);
})

async function setSelectedPayingSociety(jobName) {
	let dealershipModal = $("#dealership-modal");

	dealershipModal.data("payingSociety", jobName);

	const label = jobName ? await getJobLabel(jobName) : getLocalizedText("menu:none");
	$("#dealership-paying-society").val(label);
}

$("#dealership-pay-with-society-money").change(function() {
	let enabled = $(this).prop("checked");

	$("#dealership-choose-paying-society-btn").prop("disabled", !enabled);
	$("#dealership-account-name-div").toggle(!enabled);

	const loanInput = $("#dealership-loan-is-active");

	loanInput.prop("disabled", enabled)
	
	if(enabled) {
		loanInput.prop("checked", false).change();
	}

	if(!enabled) {
		setSelectedPayingSociety(null);
	}
})

$("#dealership-choose-paying-society-btn").click(async function() {
	let jobName = await singleJobDialog();
	setSelectedPayingSociety(jobName);
})

async function setSelectedSocietiesForDealership(societies) {
	let dealershipModal = $("#dealership-modal");
	dealershipModal.data("societiesData", societies);

	if(!societies) {
		$("#dealership-societies-to-send-money-to").val( getLocalizedText("menu:none") );
		return;
	}

	let jobNames = "";
	let isTheFirst = true;

	for(const [societyName, percentage] of Object.entries(societies)) {
		if(!isTheFirst) {
			jobNames += ", ";
		} else {
			isTheFirst = false;
		}

		jobNames += await getJobLabel(societyName) + " (" + percentage + "%)";
	}

	$("#dealership-societies-to-send-money-to").val(jobNames);
}

$("#dealership-loan-is-active").change(function() {
	const enabled = $(this).prop("checked");

	$("#dealership-loan-percentage").prop("disabled", !enabled).prop("required", enabled);
	$("#dealership-loan-interval").prop("disabled", !enabled).prop("required", enabled);
});

$("#dealership-is-resell-active").change(function() {
	const enabled = $(this).prop("checked");

	$("#dealership-resell-percentage").prop("disabled", !enabled).prop("required", enabled);
	$("#dealership-resell-point-customize-marker-btn").prop("disabled", !enabled);
	$("#dealership-resell-div").toggle(enabled);
});

$("#dealership-resell-point-customize-marker-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");
	
	let oldMarkerData = dealershipModal.data("resellPointMarkerData");
	let markerData = await markerDialog(oldMarkerData)

	dealershipModal.data("resellPointMarkerData", markerData);
});

$("#dealership-is-test-drive-active").change(function() {
	const enabled = $(this).prop("checked");

	$("#dealership-test-drive-duration").prop("disabled", !enabled).prop("required", enabled)
	$("#dealership-test-drive-change-routing-bucket").prop("disabled", !enabled)
	$("#dealership-test-drive-coords-x").prop("disabled", !enabled).prop("required", enabled)
	$("#dealership-test-drive-coords-y").prop("disabled", !enabled).prop("required", enabled)
	$("#dealership-test-drive-coords-z").prop("disabled", !enabled).prop("required", enabled)
	$("#dealership-test-drive-heading").prop("disabled", !enabled).prop("required", enabled)
	$("#dealership-test-drive-current-coords-btn").prop("disabled", !enabled)
})

$("#dealership-test-drive-current-coords-btn").click(async function() {
	let data = await chooseCoords();
	if(!data) return;

	$("#dealership-test-drive-coords-x").val(data.coords.x);
	$("#dealership-test-drive-coords-y").val(data.coords.y);
	$("#dealership-test-drive-coords-z").val(data.coords.z);
	$("#dealership-test-drive-heading").val(data.heading);
});

function addPointToPointsList(listDiv, wantsHeading, wantsRadius, pointData) {
	let div = $(`
		<div class="d-flex gap-1 align-items-center justify-content-center my-2 coords-div">
			<button type="button" class="btn-close delete-coords-btn me-2"></button>

			<div class="form-floating text-body col">
				<input type="number" step="0.01" class="form-control form-control-sm coords-x" placeholder="X" required>
				<label>${getLocalizedText("menu:x")}</label>
			</div>

			<div class="form-floating text-body col">
				<input type="number" step="0.01" class="form-control form-control-sm coords-y" placeholder="Y" required>
				<label>${getLocalizedText("menu:y")}</label>
			</div>

			<div class="form-floating text-body col">
				<input type="number" step="0.01" class="form-control form-control-sm coords-z" placeholder="Z" required>
				<label>${getLocalizedText("menu:z")}</label>
			</div>

			<div class="form-floating text-body col heading-div">
				<input type="number" step="0.01" class="form-control form-control-sm heading" placeholder="Heading" required>
				<label>${getLocalizedText("menu:heading")}</label>
			</div>

			<div class="form-floating text-body col radius-div">
				<input type="number" class="form-control form-control-sm radius" value="5" placeholder="Radius" required>
				<label>${getLocalizedText("menu:radius")}</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto current-coords-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:choose_coords")}"><i class="bi bi-arrow-down-square"></i></button>	
		</div>
	`)

	if(!wantsHeading) {
		div.find(".heading-div").remove();
	}

	if(!wantsRadius) {
		div.find(".radius-div").remove();
	}

	div.find(".current-coords-btn").click(async function() {
		let data = await chooseCoords();
		if(!data) return;

		div.find(".coords-x").val(data.coords.x);
		div.find(".coords-y").val(data.coords.y);
		div.find(".coords-z").val(data.coords.z);
		div.find(".heading").val(data.heading);
	}).tooltip();

	div.find(".delete-coords-btn").click(function() {
		div.remove();
	});

	if(pointData) {
		let coords = null;
		
		if(wantsHeading || wantsRadius) {
			coords = pointData.coords;
			div.find(".heading").val(pointData.heading);
			div.find(".radius").val(pointData.radius);
		} else {
			coords = pointData;
		}

		div.find(".coords-x").val(coords.x);
		div.find(".coords-y").val(coords.y);
		div.find(".coords-z").val(coords.z);
	}

	listDiv.append(div);
}

function setPointToPointsList(listDiv, wantsHeading, wantsRadius, pointsList) {
	listDiv.empty();

	if(!pointsList) return;
	
	for(const pointData of pointsList) {
		addPointToPointsList(listDiv, wantsHeading, wantsRadius, pointData);
	}
}

function getPointFromPointsList(listDiv) {
	let pointsList = [];

	listDiv.find(".coords-div").each(function() {
		const coords = {
			x: parseFloat( $(this).find(".coords-x").val() ),
			y: parseFloat( $(this).find(".coords-y").val() ),
			z: parseFloat( $(this).find(".coords-z").val() ),
		}

		const headingInput = $(this).find(".heading");
		const radiusInput = $(this).find(".radius");

		if(headingInput.prop("required")) {
			const heading = parseFloat( headingInput.val() );
			const radius = parseFloat( radiusInput.val() );

			pointsList.push({
				coords,
				heading,
				radius
			});
		} else {
			pointsList.push(coords);
		}
		
	});

	return pointsList;
}

$("#dealership-add-coordinates-btn").click(function() {
	const div = $("#auto-dealership-coords-list");
	addPointToPointsList(div);
});

$("#player-dealership-current-coords-btn").click(async function() {
	let data = await chooseCoords();
	if(!data) return;

	$("#player-dealership-coords-x").val(data.coords.x);
	$("#player-dealership-coords-y").val(data.coords.y);
	$("#player-dealership-coords-z").val(data.coords.z);
});

$("#dealership-add-spawnpoint-btn").click(async function() {
	const div = $("#dealership-spawn-points-list");
	addPointToPointsList(div, true, true);
});

$("#dealership-add-resell-point-btn").click(async function() {
	const div = $("#dealership-resell-points-list");
	addPointToPointsList(div, false, false);
});

$("#dealership-add-display-point-btn").click(async function() {
	const div = $("#player-dealership-display-points-list");
	addPointToPointsList(div, true, true);
});

$("#dealership-enter-showroom-current-coords-btn").click(async function() {
	let data = await chooseCoords();
	if(!data) return;

	$("#dealership-enter-showroom-coords-x").val(data.coords.x);
	$("#dealership-enter-showroom-coords-y").val(data.coords.y);
	$("#dealership-enter-showroom-coords-z").val(data.coords.z);
});

$("#dealership-showroom-current-coords-btn").click(async function() {
	let data = await chooseCoords();
	if(!data) return;

	$("#dealership-showroom-coords-x").val(data.coords.x);
	$("#dealership-showroom-coords-y").val(data.coords.y);
	$("#dealership-showroom-coords-z").val(data.coords.z);
	$("#dealership-showroom-heading").val(data.heading);
});

function toggleAutoDealershipFields(hasToShow) {
	$("#dealership-account-name-div").toggle(hasToShow);
	$("#dealership-account-name").prop("required", hasToShow);

	$("#auto-dealership-coords-div").toggle(hasToShow);
	$("#auto-dealership-coords-list").find("input").prop("required", hasToShow);

	$("#dealership-restrictions-div").toggle(hasToShow);
	$("#dealership-paying-society-div").toggle(hasToShow);

	$("#dealership-resell-points-div").toggle(hasToShow);
	$("#dealership-is-resell-active").prop("checked");

	// options to disable to avoid issues when switching to player dealership
	if(!hasToShow) {
		$("#dealership-pay-with-society-money").prop("checked", false).change();
		$("#dealership-is-resell-active").prop("checked", false).change();
		$("#dealership-resell-points-list").empty();
	}
}

function togglePlayerOwnedDealershipField(hasToShow) {
	$("#player-dealership-coords-div").toggle(hasToShow);
	$("#player-dealership-coords-div").find("input").prop("required", hasToShow);

	$("#player-dealership-purchase-div").toggle(hasToShow);
	$("#player-dealership-purchase-div").find("input").prop("required", hasToShow);

	$("#player-dealership-display-div").toggle(hasToShow);
	$("#player-dealership-display-div").find("input").prop("required", hasToShow);

	$("#player-dealership-enter-showroom-div").toggle(hasToShow);
	$("#player-dealership-enter-showroom-div").find("input").prop("required", hasToShow);
}

$("input[name=dealership-type]").change(function() {
	const type = $(this).val();

	toggleAutoDealershipFields(type == "auto");
	togglePlayerOwnedDealershipField(type == "player");
});

function setSharedDealershipData(data) {
	const dealershipModal = $("#dealership-modal");

	// Generic
	dealershipModal.data("blipData", data.blipData);
	dealershipModal.data("markerData", data.markerData);
	dealershipModal.data("vehiclesData", data.vehiclesData);
	$("#dealership-account-name").val(data.accountName);

	// Spawn points
	setPointToPointsList($("#dealership-spawn-points-list"), true, true, data.spawnPointsList);

	// Showroom
	$("#dealership-showroom-coords-x").val(data.showroomPoint.coords.x);
	$("#dealership-showroom-coords-y").val(data.showroomPoint.coords.y);
	$("#dealership-showroom-coords-z").val(data.showroomPoint.coords.z);
	$("#dealership-showroom-heading").val(data.showroomPoint.heading);

	// Options
	dealershipModal.data("societiesData", data.societiesToSendMoneyTo);
	$("#dealership-pay-with-society-money").prop("checked", data.payWithSocietyMoney).change();

	// Loan data
	$("#dealership-loan-is-active").prop("checked", data.loanData.isActive).change();
	$("#dealership-loan-percentage").val(data.loanData.percentage).change();
	$("#dealership-loan-interval").val(data.loanData.intervalDays);

	// Test drive data
	$("#dealership-is-test-drive-active").prop("checked", data.testDriveData.isActive).change();
	$("#dealership-test-drive-duration").val(data.testDriveData.duration);
	$("#dealership-test-drive-change-routing-bucket").prop("checked", data.testDriveData.changeRoutingBucket);
	$("#dealership-test-drive-coords-x").val(data.testDriveData.pointData.coords.x);
	$("#dealership-test-drive-coords-y").val(data.testDriveData.pointData.coords.y);
	$("#dealership-test-drive-coords-z").val(data.testDriveData.pointData.coords.z);
	$("#dealership-test-drive-heading").val(data.testDriveData.pointData.heading);
}

function setAutoDealershipData(data) {
	const dealershipModal = $("#dealership-modal");

	// Coordinates
	setPointToPointsList($("#auto-dealership-coords-list"), false, false, data.coordinatesList);

	// Restrictions
	dealershipModal.data("jobsData", data.jobsData);
	setRequiredLicenseForDealership(data.requiredLicense)

	// Options
	dealershipModal.data("payingSociety", data.payingSociety);

	// Resell data
	$("#dealership-is-resell-active").prop("checked", data.resellData.isActive).change();
	$("#dealership-resell-percentage").val(data.resellData.percentage);
	setPointToPointsList($("#dealership-resell-points-list"), false, false, data.resellData.points);
	dealershipModal.data("resellPointMarkerData", data.resellData.markerData);
}

function setPlayerDealershipData(data) {
	// Generic
	$("#player-dealership-price").val(data.price);
	$("#player-dealership-resell-percentage").val(data.resellPercentage);

	// Coordinates
	$("#player-dealership-coords-x").val(data.coordinates.x);
	$("#player-dealership-coords-y").val(data.coordinates.y);
	$("#player-dealership-coords-z").val(data.coordinates.z);

	// Display points
	setPointToPointsList($("#player-dealership-display-points-list"), true, true, data.displayPointsList);

	// Enter showroom coords
	$("#dealership-enter-showroom-coords-x").val(data.enterShowroomCoords.x);
	$("#dealership-enter-showroom-coords-y").val(data.enterShowroomCoords.y);
	$("#dealership-enter-showroom-coords-z").val(data.enterShowroomCoords.z);
}

function editDealership(id) {
	const dealershipModal = $("#dealership-modal");
	const dealershipInfo = dealerships[id];

	dealershipModal.data("dealershipId", id);
	dealershipModal.data("action", "edit");

	$("#delete-dealership-btn").show();
	$("#save-dealership-btn").text(getLocalizedText("menu:confirm"));

	const data = dealershipInfo.data;

	// Generic
	$("#dealership-label").val(dealershipInfo.label);
	
	setSharedDealershipData(data);

	if(dealershipInfo.type == "auto") {
		setAutoDealershipData(data);
	} else {
		setPlayerDealershipData(data);
	}
		
	// As last input, so all elements are already added to the DOM
	$(`input[name=dealership-type][value=${dealershipInfo.type}]`).prop("checked", true).change();

	dealershipModal.modal("show");
}

function getSharedDealershipData() {
	const dealershipModal = $("#dealership-modal");

	return {
		// Generic
		blipData: dealershipModal.data("blipData"),
		markerData: dealershipModal.data("markerData"),
		vehiclesData: dealershipModal.data("vehiclesData"),
		accountName: $("#dealership-account-name").val(),

		// Spawn points
		spawnPointsList: getPointFromPointsList( $("#dealership-spawn-points-list") ),

		// Showroom
		showroomPoint: {
			coords: {
				x: parseFloat( $("#dealership-showroom-coords-x").val() ),
				y: parseFloat( $("#dealership-showroom-coords-y").val() ),
				z: parseFloat( $("#dealership-showroom-coords-z").val() ),
			},
			heading: parseFloat( $("#dealership-showroom-heading").val() ),
		},

		// Options
		societiesToSendMoneyTo: dealershipModal.data("societiesData"),
		payWithSocietyMoney: $("#dealership-pay-with-society-money").prop("checked"),

		loanData: {
			isActive: $("#dealership-loan-is-active").prop("checked"),
			percentage: parseInt( $("#dealership-loan-percentage").val() ),
			intervalDays: parseInt( $("#dealership-loan-interval").val() )
		},

		testDriveData: {
			isActive: $("#dealership-is-test-drive-active").prop("checked"),
			duration: parseInt( $("#dealership-test-drive-duration").val() ),
			changeRoutingBucket: $("#dealership-test-drive-change-routing-bucket").prop("checked"),
			pointData: {
				coords: {
					x: parseFloat( $("#dealership-test-drive-coords-x").val() ),
					y: parseFloat( $("#dealership-test-drive-coords-y").val() ),
					z: parseFloat( $("#dealership-test-drive-coords-z").val() ),
				},
				heading: parseFloat( $("#dealership-test-drive-heading").val() ),
			}
		}
	}
}

function getAutoDealershipData() {
	const dealershipModal = $("#dealership-modal");

	const sharedData = getSharedDealershipData();
	const data = {
		// Coordinates
		coordinatesList: getPointFromPointsList( $("#auto-dealership-coords-list") ),

		// Restrictions
		jobsData: dealershipModal.data("jobsData"),
		requiredLicense: $("#dealership-choose-required-license-btn").data("licenseType"),

		// Options
		payingSociety: dealershipModal.data("payingSociety"),
		resellData: {
			isActive: $("#dealership-is-resell-active").prop("checked"),
			percentage: parseInt( $("#dealership-resell-percentage").val() ),
			points: getPointFromPointsList( $("#dealership-resell-points-list") ),
			markerData: dealershipModal.data("resellPointMarkerData")
		},
	}

	return {...sharedData, ...data}
}

function getPlayerDealershipData() {
	const sharedData = getSharedDealershipData();
	const data = {
		// Generic
		price: parseInt( $("#player-dealership-price").val() ),
		resellPercentage: parseInt( $("#player-dealership-resell-percentage").val() ),

		// Coordinates
		coordinates: {
			x: parseFloat( $("#player-dealership-coords-x").val() ),
			y: parseFloat( $("#player-dealership-coords-y").val() ),
			z: parseFloat( $("#player-dealership-coords-z").val() ),
		},

		// Display points
		displayPointsList: getPointFromPointsList( $("#player-dealership-display-points-list") ),

		// Enter showroom coords
		enterShowroomCoords: {
			x: parseFloat( $("#dealership-enter-showroom-coords-x").val() ),
			y: parseFloat( $("#dealership-enter-showroom-coords-y").val() ),
			z: parseFloat( $("#dealership-enter-showroom-coords-z").val() ),
		}
	}

	return {...sharedData, ...data}
}

$("#dealership-form").submit(async function(event) {
	if(isThereAnyErrorInForm(event)) return;

	let dealershipModal = $("#dealership-modal");
	let action = dealershipModal.data("action");

	const dealershipType = $("input[name=dealership-type]:checked").val();

	let dealershipInfo = {
		label: $("#dealership-label").val(),
		type: dealershipType,

		data: dealershipType == "auto" ? getAutoDealershipData() : getPlayerDealershipData()
	}
	
	let success = null;

	switch(action) {
		case "create": {
			success = await $.post(`https://${resName}/createDealership`, JSON.stringify(dealershipInfo));
			break;
		}

		case "edit": {
			success = await $.post(`https://${resName}/updateDealership`, JSON.stringify({dealershipId: dealershipModal.data("dealershipId"), dealershipInfo: dealershipInfo}));
			break;
		}
	}

	if(!success) return;

	dealershipModal.modal("hide");
	loadDealerships();
})

$("#delete-dealership-btn").click(async function() {
	let dealershipModal = $("#dealership-modal");
	let dealershipId = dealershipModal.data("dealershipId");

	const success = await $.post(`https://${resName}/deleteDealership`, JSON.stringify({dealershipId: dealershipId}));
	if(!success) return;

	dealershipModal.modal("hide");
	loadDealerships();
});

$("#import-dealership-btn").click(async function() {
	const dealershipModal = $("#dealership-modal");
	const dealershipId = dealershipModal.data("dealershipId");
	
	const importedData = await dealershipsDialog();

	const oldAction = dealershipModal.data("action"); // To remember if it's an edit or create

	dealerships[dealershipId] = importedData;
	editDealership(dealershipId);
	dealershipModal.data("action", oldAction);
})

$(document).keyup(function(e) {
	if (e.key === "Escape") {
		exitShowroom();
        closeMenu();
	}
});