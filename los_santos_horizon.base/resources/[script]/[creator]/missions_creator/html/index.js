const resName = GetParentResourceName();

function reloadAllData() {
	loadMissions();
	resetNexus();
}

// Open/Close menu
function openMenu(version, fullConfig) {
	$("#missions-creator-version").text(version);

	reloadAllData();
	loadSettings(fullConfig);

    $("#missions-creator").show()
}

function closeMenu() {
	// Resets current active tab
	$("#missions-creator").find(".nav-link, .tab-pane").each(function() {
		if($(this).data("isDefault") == "1") {
			$(this).addClass(["active", "show"])
		} else {
			$(this).removeClass(["active", "show"])
		}
	})
	
    $("#missions-creator").hide();

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
	}
})

function generateStaticId() {
	return "10000000-1000-4000-8000-100000000000".replace(/[018]/g, c =>
		(c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
	);
}

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

$("#settings-reset-player-missions-progression-btn").click(async function() {
	const playerServerId = await playersDialog();
	if(!playerServerId) return;

	if(!await confirmDeletion()) return;
	
	const response = await $.post(`https://${resName}/resetPlayerMissionsProgression`, JSON.stringify({playerServerId}));
	showServerResponse(response);
});

function loadSettings(fullConfig) {
	// Generic
	setTomSelectValue("#settings-locale", fullConfig.locale);
	$("#settings-ace-permission").val(fullConfig.acePermission);
	$("#settings-can-always-carry").prop("checked", fullConfig.canAlwaysCarryItem);
	$("#settings-debug-enabled").prop("checked", fullConfig.debug);
	$("#settings-can-receive-multiple-same-item").prop("checked", fullConfig.canReceiveMultipleTimesTheSameItem);
	$("#settings-show-panels-on-mission-completion").prop("checked", fullConfig.showPanelsOnMissionCompletion);
	
	// Keys
	$("#settings-key-to-interact").val(fullConfig.keys.interact);
	$("#settings-key-to-exit").val(fullConfig.keys.exit);
	$("#settings-key-to-confirm").val(fullConfig.keys.confirm);

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

	// Player mission
	$("#settings-minutes-to-receive-vehicle-after-order").val(fullConfig.minutesToReceiveVehicleAfterOrder);
}

$("#settings").submit(async function(event) {
	if(isThereAnyErrorInForm(event)) return;

	let clientSettings = {
		helpNotification: $("#settings-help-notification-script").val(),
		showPanelsOnMissionCompletion: $("#settings-show-panels-on-mission-completion").prop("checked"),

		keys: {
            interact: parseInt( $("#settings-key-to-interact").val() ) ,
            exit: parseInt( $("#settings-key-to-exit").val() ) ,
            confirm: parseInt( $("#settings-key-to-confirm").val() ) ,
        }
	}

	let sharedSettings = {
		locale: $("#settings-locale").val(),
		debug: $("#settings-debug-enabled").prop("checked"),
	}

	let serverSettings = {
		// Generic
		acePermission: $("#settings-ace-permission").val(),
		canAlwaysCarryItem: $("#settings-can-always-carry").prop("checked"),
		canReceiveMultipleTimesTheSameItem: $("#settings-can-receive-multiple-same-item").prop("checked"),

		// Discord logs
		areDiscordLogsActive: $("#settings-areDiscordLogsActive").prop("checked"),
		mainDiscordWebhook: $("#settings-mainDiscordWebhook").val(),
		specificWebhooks: getSeparatedDiscordWebhooks(),
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
███    ███ ██ ███████ ███████ ██  ██████  ███    ██ ███████ 
████  ████ ██ ██      ██      ██ ██    ██ ████   ██ ██      
██ ████ ██ ██ ███████ ███████ ██ ██    ██ ██ ██  ██ ███████ 
██  ██  ██ ██      ██      ██ ██ ██    ██ ██  ██ ██      ██ 
██      ██ ██ ███████ ███████ ██  ██████  ██   ████ ███████ 
*/
let selectedStage = null;
let selectedWorkflowType = null;
let selectedWorkflowItemIndex = null;

let missionsDatatable = $("#missions-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );
			editMission(id);
		})
	},
});

let missions = {};

async function loadMissions() {
	const rawMissions = await $.post(`https://${resName}/getAllMissions`);

	// Manually create the table to avoid incompatibilities due table indexing
	missions = {};

	for(const[k, missionData] of Object.entries(rawMissions)) {
		missions[missionData.id] = missionData;
	}

	missionsDatatable.clear();

	for(const[id, missionData] of Object.entries(missions)) {
		missionsDatatable.row.add([
			id,
			missionData.label
		]);
	}

	missionsDatatable.draw();
}

$("#stage-workflow-items-selection-list").click(function(event) {
	const target = $(event.target);
	if(!target.hasClass("list-group-item") && !target.parent().hasClass("list-group-item")) return; // Allows both the list container and the text span to be clicked

	const workflowItemIndex = target.data("workflowItemIndex") || target.parent().data("workflowItemIndex");
	toggleWorkflowItem(workflowItemIndex)
});

function toggleWorkflowItem(workflowItemIndex) {
	selectedWorkflowItemIndex = workflowItemIndex;

	// Reset
	$("#stage-workflow-items-selection-list").find(".active").removeClass("active");

	$("#stage-elements-container").find(`.workflow-item`).hide();

	if(selectedWorkflowItemIndex == null) return;
	
	$("#stage-elements-container").find(`.workflow-item[data-stage-unique-id='${selectedStage}'][data-workflow-item-index='${workflowItemIndex}'][data-workflow-type='${selectedWorkflowType}']`).show();

	// Color button in list
	$("#stage-workflow-items-selection-list").find(`[data-workflow-item-index='${workflowItemIndex}']`).addClass("active");
}

function resetWorkflowItems() {
	$("#stage-elements-container").find(`.workflow-item`).hide();
	$("#stage-workflow-items-selection-list").html(`<a href="#" class="list-group-item list-group-item-action p-2 disabled">${getLocalizedText("menu:select_something")}</a>`);
}

function getWorkflowItemIndexForThisStage() {
	return $("#stage-elements-container").find(`.workflow-item[data-stage-unique-id='${selectedStage}'][data-workflow-type='${selectedWorkflowType}']`).length + 1;
}

async function fillWorkflowItemsInList() {
	const stageWorkflowItemsSelectionList = $("#stage-workflow-items-selection-list");
	stageWorkflowItemsSelectionList.empty();

	// Load workflow items
	const allWorkflowItemsOfType = $(`#stage-elements-container .workflow-item[data-stage-unique-id='${selectedStage}'][data-workflow-type='${selectedWorkflowType}']`)
	allWorkflowItemsOfType.each(function(index, element) {
		const workflowItemIndex = $(element).data("workflowItemIndex");
		const workflowItemId = $(element).data("workflowItemId");
		const label = $(element).find(".label").val() || getLocalizedText(workflowItemId);

		const div = $(`
		<li href="#" class="list-group-item list-group-item-action p-2 clickable" data-stage-unique-id="${selectedStage}" data-workflow-item-index="${workflowItemIndex}" data-workflow-item-id="${workflowItemId}">
			<span class="entity-label">${label}</span>
			<span class="d-inline-flex position-absolute" style="right: 0; top: 0; height: 100%;">
				<button type="button" class="btn py-0 btn-close my-auto me-2"></button>
			</span>
		</li>
		`);

		div.find(".btn-close").click(function() {
			$(element).remove(); // This is the workflow item setup
			div.remove(); // This is the list item
		});

		$(stageWorkflowItemsSelectionList).append(div);
	});

	const createNewDiv = $(`<a href="#" class="list-group-item list-group-item-action p-2">${getLocalizedText("menu:create_new")}</a>`);

	const ALL_WORKFLOW_ITEMS = await $.post(`https://${resName}/getAllWorkflowItems`);

	const elements = ALL_WORKFLOW_ITEMS[selectedWorkflowType].map(function(workflowItemId) {
		return {label: getLocalizedText(workflowItemId), value: workflowItemId}
	});

	createNewDiv.click(async function() {
		const workflowItemId = await listDialog(getLocalizedText("menu:choose"), getLocalizedText("menu:search"), elements);
		if(!workflowItemId) return;

		await createWorkflowItem(selectedStage, {type: workflowItemId}, selectedWorkflowType);
		fillWorkflowItemsInList();
	});

	$(stageWorkflowItemsSelectionList).append(createNewDiv);
}

function toggleWorkflowType(workflowType) {
	// Reset
	resetWorkflowItems();
	$("#stage-workflow-types-selection-list").find(".active").removeClass("active");
	toggleWorkflowItem(null);

	selectedWorkflowType = workflowType;
	if(workflowType == null) return;

	// Color button in list
	$("#stage-workflow-types-selection-list").find(`.stage-workflow-type[data-workflow-type="${workflowType}"]`).addClass("active");
	fillWorkflowItemsInList();
}

$("#stage-workflow-types-selection-list").click(function(event) {
	const target = $(event.target);
	if(!target.hasClass("stage-workflow-type")) return;

	const workflowType = target.data("workflowType");
	
	toggleWorkflowType(workflowType);
})

function resetWorkflowTypesSelection() {
	$("#stage-workflow-types-selection-list").html(`<a href="#" class="list-group-item list-group-item-action p-2 disabled">${getLocalizedText("menu:select_a_stage_first")}</a>`);
}

function toggleStage(stageUniqueId) {
	// Reset
	$("#stages-list").find(`.stage-list-item`).removeClass("active");
	$("#mission-header-div").find(".stage-options").hide();

	// Reset elements types
	toggleWorkflowType(null);
	resetWorkflowTypesSelection();

	selectedStage = stageUniqueId;
	if(stageUniqueId == null) return;;
	
	$("#stage-workflow-types-selection-list").html(`
	<a href="#" class="list-group-item list-group-item-action p-2 stage-workflow-type" data-workflow-type="startingActions">${getLocalizedText("menu:on_stage_start")}</a>
	<a href="#" class="list-group-item list-group-item-action p-2 stage-workflow-type" data-workflow-type="endingActions">${getLocalizedText("menu:on_stage_end")}</a>
	<a href="#" class="list-group-item list-group-item-action p-2 stage-workflow-type" data-workflow-type="tasks">${getLocalizedText("menu:tasks")}</a>
	`);

	// Add active class
	$("#stages-list").find(`.stage-list-item[data-stage-unique-id="${stageUniqueId}"]`).addClass("active");

	// Show only this stage options
	$(`#mission-header-div .stage-options[data-stage-unique-id='${stageUniqueId}']`).show();
}

function setupSpawnEntityInCoordsDiv(workflowItem) {
	const data = workflowItem.data || {};

	const RADIO_NAME = generateStaticId(); // So radio name will be random and won't bother
	const STATIC_ID = data.staticId || generateStaticId();
	const ENTITY_LABEL = workflowItem.data?.label ? workflowItem.data.label : `Entity ${shortenStaticId(STATIC_ID)}`;
	
	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex gap-3 justify-content-center align-items-center">
			<div class="form-floating">
				<input type="text" class="form-control entity-label" placeholder="..." data-static-id="${STATIC_ID}" value="${ENTITY_LABEL}" required disabled>
				<label>${getLocalizedText("menu:label")}</label>
			</div>

			<div class="btn-group" role="group">
				<input type="radio" class="btn-check" name="${RADIO_NAME}" id="spawn-ped-${RADIO_NAME}" value="ped" disabled checked>
				<label class="btn btn-outline-primary" for="spawn-ped-${RADIO_NAME}">${getLocalizedText("menu:ped")}</label>
			
				<input type="radio" class="btn-check" name="${RADIO_NAME}" id="spawn-vehicle-${RADIO_NAME}" value="vehicle" disabled>
				<label class="btn btn-outline-primary" for="spawn-vehicle-${RADIO_NAME}">${getLocalizedText("menu:vehicle")}</label>
			
				<input type="radio" class="btn-check" name="${RADIO_NAME}" id="spawn-object-${RADIO_NAME}" value="object" disabled>
				<label class="btn btn-outline-primary" for="spawn-object-${RADIO_NAME}">${getLocalizedText("menu:object")}</label>
			</div>

			<div class="form-floating">
				<input type="text" class="form-control entity-model" placeholder="..." value="${data.model || ""}" required>
				<label>${getLocalizedText("menu:model")}</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-model" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:models_list")}"><i class="bi bi-list-ul"></i></button>
		
			<div class="form-check my-auto">
				<input class="form-check-input freeze-in-position" type="checkbox" value="">
				<label class="form-check-label">${getLocalizedText("menu:freeze_in_position")}</label>
			</div>
		</div>

		<div class="ped-options-container">
			<div class="d-flex gap-3 justify-content-center align-items-center mt-3">
				<div class="form-floating">
					<input type="text" class="form-control ped-armor" min="0" max="100" placeholder="..." value="${data.armor || ""}">
					<label>${getLocalizedText("menu:armor")}</label>
				</div>
				
				<div class="form-floating">
					<input type="text" class="form-control ped-weapon" placeholder="..." value="${data.weapon || ""}">
					<label>${getLocalizedText("menu:weapon")}</label>
				</div>

				<div class="form-check my-auto">
					<input class="form-check-input ped-is-invincible" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_invincible")}</label>
				</div>

				<div class="form-check my-auto">
					<input class="form-check-input ped-does-headshot-one-shot" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:does_headshot_one_shot")}</label>
				</div>
			</div>
		</div>

		<h3 class="text-center mt-4">${getLocalizedText("menu:coordinates")}</h3>

		<div class="d-flex gap-3 justify-content-center align-items-center">
			<div class="form-floating">
				<input type="text" class="form-control coords-x" placeholder="..." value="${data.coordinates?.x || ""}" required>
				<label>${getLocalizedText("menu:x")}</label>
			</div>

			<div class="form-floating">
				<input type="text" class="form-control coords-y" placeholder="..." value="${data.coordinates?.y || ""}" required>
				<label>${getLocalizedText("menu:y")}</label>
			</div>

			<div class="form-floating">
				<input type="text" class="form-control coords-z" placeholder="..." value="${data.coordinates?.z || ""}" required>
				<label>${getLocalizedText("menu:z")}</label>
			</div>

			<div class="form-floating">
				<input type="text" class="form-control heading" placeholder="..." value="${data.heading || ""}" required>
				<label>${getLocalizedText("menu:heading")}</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-coords" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:choose_coords")}"><i class="bi bi-arrow-down-square"></i></button>							
		</div>
	</div>
	`)

	div.find(".choose-model").click(function() {
		const type = div.find("input[type=radio]:checked").val();

		switch(type) {
			case "ped": window.invokeNative("openUrl", "https://docs.fivem.net/docs/game-references/ped-models/"); break;
			case "vehicle": window.invokeNative("openUrl", "https://docs.fivem.net/docs/game-references/vehicle-models/"); break;
			case "object": window.invokeNative("openUrl", "https://forge.plebmasters.de/objects/"); break;
		}
	}).tooltip();

	div.find(".choose-coords").click(async function() {
		const placedEntities = getAvailableEntitiesForStage(selectedStage, selectedWorkflowType);
		
		const model = div.find(".entity-model").val();
		const type = div.find("input[type=radio]:checked").val();

		const data = await placeEntity(model, type, placedEntities)
		if(!data) return;

		div.find(".coords-x").val(data.coords.x);
		div.find(".coords-y").val(data.coords.y);
		div.find(".coords-z").val(data.coords.z);
		div.find(".heading").val(data.heading);
	}).tooltip();

	div.find(`input[type=radio][name=${RADIO_NAME}]`).change(function() {
		const val = $(this).val();
		const isPed = val == "ped";

		const pedOptionsContainer = div.find(".ped-options-container")

		pedOptionsContainer.toggle(isPed);
	});

	div.find(".freeze-in-position").prop("checked", data.freezeInPosition);

	// Ped options
	div.find(`input[type=radio][name=${RADIO_NAME}][value=${data.type}]`).prop("checked", true).change();
	div.find(".ped-is-invincible").prop("checked", data.isInvincible);
	div.find(".ped-does-headshot-one-shot").prop("checked", data.doesHeadshotOneShot);

	// Add a tooltip with the staticId
	div.find(".entity-label").parent()
		.attr("data-bs-toggle", "tooltip")
		.attr("data-bs-placement", "top")
		.attr("title", "ID: " + shortenStaticId(STATIC_ID))
		.tooltip();

	return div;
}

function getStageIndexFromUniqueId(stageUniqueId) {
	return $("#stages-list").find(`.stage-list-item[data-stage-unique-id='${stageUniqueId}']`).index() + 1;
}

function getAvailableEntitiesForStage(stageUniqueId, workflowType, entityType) {
	const stageIndex = getStageIndexFromUniqueId(stageUniqueId);

	const spawnedEntitiesDivs = $("#stage-elements-container").find("[data-workflow-item-id='spawn_entity_in_coords']").filter(function(index, element) {
		const thisElementWorkflowType = $(element).data("workflowType");
		const thisElementStageUniqueId = $(element).data("stageUniqueId");
		const thisElementStageIndex = getStageIndexFromUniqueId(thisElementStageUniqueId);

		if(thisElementStageIndex == stageIndex && workflowType != "endingActions" && thisElementWorkflowType == "endingActions") return false;

		return thisElementStageIndex <= stageIndex;
	});

	const allDeletedEntitiesDivs = $("#stage-elements-container").find("[data-workflow-item-id='delete_entities']").filter(function(index, element) {
		const thsiElementStageUniqueId = $(element).data("stageUniqueId");
		const thisElementStageIndex = getStageIndexFromUniqueId(thsiElementStageUniqueId);
		return workflowType == "endingActions" ? thisElementStageIndex <= stageIndex : thisElementStageIndex < stageIndex;
	});

	const availableEntities = spawnedEntitiesDivs.filter(function(index, element) {
		const staticId = $(element).find(".entity-label").data("staticId");
		return !allDeletedEntitiesDivs.find(`.static-id[data-static-id='${staticId}']`).length; // If it's 0, it means it's not been deleted
	});

	const elements = availableEntities.map(function(index, element) {
		const elementLabelDiv = $(element).find(".entity-label");
		const THIS_ENTITY_TYPE = $(element).find("input[type=radio]:checked").val();
		if(entityType && entityType != THIS_ENTITY_TYPE) return; // If it's not the same type, return (if entityType is defined)

		const label = elementLabelDiv.val();
		const staticId = elementLabelDiv.data("staticId");

		return {
			label,
			value: staticId,
			model: $(element).find(".entity-model").val(),
			type: THIS_ENTITY_TYPE,
			coords: {
				x: parseFloat($(element).find(".coords-x").val()),
				y: parseFloat($(element).find(".coords-y").val()),
				z: parseFloat($(element).find(".coords-z").val()),
			},
			heading: parseFloat($(element).find(".heading").val()),
		};
	}).get(); // .get is used to convert jQuery object to array

	return elements;
}

function getEntityLabelFromStaticId(staticId) {
	const div = $("#stage-elements-container").find(`.entity-label[data-static-id='${staticId}']`);
	return div.val()
}

// Create a function that returns the last digits of a staticId
function shortenStaticId(staticId) {
	return staticId.split("-").pop();
}	

function addEntityInStaticIdsListDiv(listDiv, staticId) {
	const label = getEntityLabelFromStaticId(staticId);

	const div = $(`
		<li href="#" class="list-group-item p-2 static-id" data-static-id="${staticId}">
			<span class="entity-label" data-bs-toggle="tooltip" data-bs-placement="top" title="ID: ${shortenStaticId(staticId)}">${label}</span>
			<span class="d-inline-flex position-absolute" style="right: 0; top: 0; height: 100%;">
				<button type="button" class="btn py-0 btn-close my-auto me-2"></button>
			</span>
		</li>
	`);

	div.find(".btn-close").click(function() {
		div.remove();
	});

	div.find(".entity-label").tooltip();

	div.insertBefore( listDiv.find(".add-entity-btn") );
}

function createDivForStaticIdsList(entityType, staticIds) {
	const div = $(`
	<ul class="list-group entities-list col-3 mx-auto text-center">
		<button type="button" class="list-group-item list-group-item-action add-entity-btn p-2">${getLocalizedText("menu:add_entity")}</button>
	</ul>
	`);

	div.find(".add-entity-btn").click(async function() {
		const values = await listArrayDialog(
			getLocalizedText("menu:choose"),
			getLocalizedText("menu:search"),
			getAvailableEntitiesForStage(selectedStage, selectedWorkflowType, entityType),
			[],
			getLocalizedText("menu:all_spawned_entities_have_already_been_deleted")
			);
		if(!values) return;

		values.forEach(function(value) {
			addEntityInStaticIdsListDiv(div, value);
		});
	});

	if(staticIds) {
		staticIds.forEach(function(staticId) {
			addEntityInStaticIdsListDiv(div, staticId);
		});
	}

	return div;
}

function getStaticIdsFromListDiv(div) {
	return div.find(".static-id").map(function(index, element) {
		return $(element).data("staticId");
	}).get();
}

function createDivForCoordinates(data, hasRadius = true, hasCustomizeBlipBtn = true, hasCustomizeMarkerBtn = true) {
	const div = $(`
	<div class="d-flex gap-3 justify-content-center align-items-center">
		<div class="form-floating">
			<input type="text" class="form-control coords-x" placeholder="..." value="${data.coordinates?.x || ""}" required>
			<label>${getLocalizedText("menu:x")}</label>
		</div>

		<div class="form-floating">
			<input type="text" class="form-control coords-y" placeholder="..." value="${data.coordinates?.y || ""}" required>
			<label>${getLocalizedText("menu:y")}</label>
		</div>

		<div class="form-floating">
			<input type="text" class="form-control coords-z" placeholder="..." value="${data.coordinates?.z || ""}" required>
			<label>${getLocalizedText("menu:z")}</label>
		</div>

		<div class="form-floating">
			<input type="text" class="form-control radius" placeholder="..." min="2" value="${data.radius || ""}" required>
			<label>${getLocalizedText("menu:radius")}</label>
		</div>

		<button type="button" class="btn btn-secondary col-auto choose-coords" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:choose_coords")}"><i class="bi bi-arrow-down-square"></i></button>
	
		<button type="button" class="btn btn-secondary customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>
		<button type="button" class="btn btn-secondary customize-marker-btn">${getLocalizedText("menu:customize_marker")}</button>
	</div>
	`);

	if(!hasRadius) {
		div.find(".radius").prop("required", false).parent().hide();
	}

	if(!hasCustomizeBlipBtn) {
		div.find(".customize-blip-btn").hide();
	}

	if(!hasCustomizeMarkerBtn) {
		div.find(".customize-marker-btn").hide();
	}

	div.find(".choose-coords").click(async function() {
		const data = await chooseCoords();
		if(!data) return;

		div.find(".coords-x").val(data.coords.x);
		div.find(".coords-y").val(data.coords.y);
		div.find(".coords-z").val(data.coords.z);
	});

	div.find(".customize-blip-btn").click(async function() {
		const oldBlipData = div.find(".customize-blip-btn").data("blipData");

		const blipData = await blipDialog(oldBlipData);
		if(!blipData) return;

		div.find(".customize-blip-btn").data("blipData", blipData);
	}).data("blipData", data.blipData || getDefaultBlipCustomization());

	div.find(".customize-marker-btn").click(async function() {
		const oldMarkerData = div.find(".customize-marker-btn").data("markerData");

		const markerData = await markerDialog(oldMarkerData);
		if(!markerData) return;

		div.find(".customize-marker-btn").data("markerData", markerData);
	}).data("markerData", data.markerData || getDefaultMarkerCustomization());

	return div;
}

function setupDeleteEntitiesDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>
	</div>
	`);

	div.append( createDivForStaticIdsList(null, data.staticIds) );

	return div;
}

function addParameterInParametersListDiv(listDiv, parameter = {}) {
	const div = $(`
	<div class="d-flex gap-3 align-items-center mb-6 parameter">
		<button type="button" class="btn btn-close mt-auto mb-3"></button>
		
		<div class="col-3">
			<label class="form-label">Parameter Type</label>
			<select class="form-select parameter-type">
				<option value="static" selected>Static</option>
				<option value="dynamic">Dynamic</option>
			</select>
		</div>

		<div class="static-parameter-div" style="display:none">
			<div class="d-flex gap-3 align-items-center">
				<div class="col-auto">
					<label class="form-label">Data type</label>
					<select class="form-select parameter-data-type" >
						<option value="string" selected>String</option>
						<option value="number">Number</option>
						<option value="bool">Bool</option>
					</select>
				</div>

				<div class="col-auto static-param-value-div" data-param-type="string" style="display:none">
					<label class="form-label">Parameter value</label>
					<input type="text" class="form-control static-parameter-value" placeholder="pizza">
				</div>

				<div class="col-auto static-param-value-div" data-param-type="number" style="display:none">
					<label class="form-label">Parameter value</label>
					<input type="number" class="form-control static-parameter-value" placeholder="1074">
				</div>

				<div class="col-auto static-param-value-div" data-param-type="bool" style="display:none">
					<label class="form-label">Parameter value</label>
					<select class="form-select static-parameter-value">
						<option value="true" selected>True</option>
						<option value="false">False</option>
					</select>
				</div>
			</div>
		</div>

		<div class="dynamic-parameter-div" style="display:none">
			<div class="d-flex gap-3 align-items-center">
				<div class="col-auto dynamic-param-value-div">
					<label class="form-label">Parameter value</label>
					<select class="form-select dynamic-parameter-value" >
						<option value="mission_id" selected>Mission ID</option>
						<option value="instance_id">Instance ID</option>
						<option value="stage_index">Stage Index</option>
						<option value="entity_net_id">Entity Net ID</option>
						<option value="players_arr">Players server IDs array</option>
					</select>
				</div>

				<div class="col-auto dynamic-param-entity-div">
					<label class="form-label">${getLocalizedText("menu:entity_dynamic_param")}</label>
					
					<div class="input-group">
						<input type="text" class="form-control entity-label" placeholder="N/A" required disabled>
						<button type="button" class="btn btn-secondary choose-entity" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:choose_entity")}"><i class="bi bi-list-ul"></i></button>
					</div>
				</div>
			</div>
		</div>
	</div>
	`);

	div.find(".btn-close").click(function() { div.remove(); });

	div.find(".parameter-type").change(function() {
		const isStatic = $(this).val() == "static";

		div.find(".static-parameter-div").toggle(isStatic);
		div.find(".dynamic-parameter-div").toggle(!isStatic);
	});

	div.find(".parameter-data-type").change(function() {
		const dataType = $(this).val();

		div.find(".static-param-value-div").hide();
		div.find(`.static-param-value-div[data-param-type='${dataType}']`).show();
	});

	div.find(".dynamic-parameter-value").change(function() {
		const isEntity = $(this).val() == "entity_net_id";
		div.find(".dynamic-param-entity-div").toggle(isEntity);
	});

	// Set old values
	div.find(".parameter-type").val(parameter.type || "static").change();
	div.find(".parameter-data-type").val(parameter.dataType || "string").change();
	div.find(".static-parameter-value").val(parameter.value);
	div.find(".dynamic-parameter-value").val(parameter.value || "mission_id").change();
	div.find(".entity-label").val( getEntityLabelFromStaticId(parameter.entityStaticId) ).data("staticId", parameter.entityStaticId);

	// Otherwise the old value of bool is not selected
	if(parameter.type == "static" && parameter.dataType == "bool") {
		div.find(".static-parameter-value").val(parameter.value == true ? "true" : "false");
	}

	// Other
	div.find(".choose-entity").click(async function() {
		const elements = getAvailableEntitiesForStage(selectedStage, selectedWorkflowType); // An issue is that you'll be able to choose entities which are not spawned yet
		const staticId = await listDialog(
			getLocalizedText("menu:choose"),
			getLocalizedText("menu:search"),
			elements,
			getLocalizedText("menu:all_spawned_entities_have_already_been_deleted")
			);
		if(!staticId) return;

		div.find(".entity-label").val( getEntityLabelFromStaticId(staticId) ).data("staticId", staticId);
	}).tooltip();

	div.insertBefore( listDiv.find(".add-parameter-btn") );
}

function getParametersFromDiv(div) {
	return div.find(".parameter").map(function(index, element) {
		const parameterType = $(element).find(".parameter-type").val();

		switch(parameterType) {
			case "static": {
				const dataType = $(element).find(".parameter-data-type").val();
				let value = $(element).find(".static-param-value-div[data-param-type='" + dataType + "'] .static-parameter-value").val();

				if(dataType == "number") value = parseFloat(value);
				if(dataType == "bool") value = value == "true";

				return {
					type: "static",
					dataType,
					value
				}
			}

			case "dynamic": {
				return {
					type: "dynamic",
					value: $(element).find(".dynamic-parameter-value").val(),
					entityStaticId: $(element).find(".entity-label").data("staticId"),
				}
			}
		}
	}).get();
}

function createDivForEventParameters(parameters = []) {
	const div = $(`
		<div class="mt-3 parameters-setup col-6 mx-auto">
			<h3 class="text-center">Parameters</h3>

			<div class="d-flex gap-3 justify-content-center align-items-center parameters-list">

			</div>

			<button type="button" class="btn btn-secondary col-auto add-parameter-btn">${getLocalizedText("menu:add_parameter")}</button>
		</div>
	`);

	div.find(".add-parameter-btn").click(function() {
		addParameterInParametersListDiv(div);
	});

	parameters.forEach(function(parameter) {
		addParameterInParametersListDiv(div, parameter);
	});

	return div;
}

function setupTriggerClientEventDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>	
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex gap-3 justify-content-center align-items-center event-setup">
			<div class="col-3">
				<label class="form-label">Event Name</label>
				<input type="text" class="form-control event-name" placeholder="any_event:you_want">
			</div>

			<div class="col-3">
				<label class="form-label">Target players</label>
				<select class="form-select target-players">
					<option value="-1" selected>All players (-1)</option>
					<option value="1">Players in mission</option>
				</select>
			</div>
		</div>
	</div>
	`);

	const parametersSetupDiv = createDivForEventParameters(data.parameters);
	div.append(parametersSetupDiv);

	div.find(".event-name").val(data.eventName);
	div.find(".target-players").val(data.targetPlayers);

	return div;
}

function setupTriggerEventDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex gap-3 justify-content-center align-items-center">
			<div class="col-3">
				<label class="form-label">Event Name</label>
				<input type="text" class="form-control event-name" placeholder="any_event:you_want">
			</div>
		</div>
	</div>
	`);

	const parametersSetupDiv = createDivForEventParameters(data.parameters);
	div.append(parametersSetupDiv);

	div.find(".event-name").val(data.eventName);

	return div;
}

function setupGiveItemsDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		
	</div>
	`);

	const rewardItemsListDiv = createDivForRewardItemsList(data.rewardItems, data.rewardMinAmount, data.rewardMaxAmount);
	div.append(rewardItemsListDiv);

	return div;
}

function setupAlertPoliceDiv(workflowItem) {
	const data = workflowItem.data || {};

	const radioId = generateStaticId(); // So radio name will be random and won't bother

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="col-8 mb-3 mx-auto d-flex gap-3">
			<div class="form-floating col">
				<input type="text" class="form-control message" placeholder="..." value="${data.message || ""}" required>
				<label>${getLocalizedText("menu:message")}</label>
			</div>

			<div class="form-floating col">
				<input type="number" class="form-control probability" min="0" max="100" placeholder="..." value="${data.probability || ""}" required>
				<label>${getLocalizedText("menu:probability")}</label>
			</div>
		</div>

		<div class="text-center">
			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="${radioId}" id="${radioId}-coordinates" value="coordinates">
				<label class="form-check-label" for="${radioId}">${getLocalizedText("menu:coordinates")}</label>
			</div>

			<div class="form-check form-check-inline">
				<input class="form-check-input" type="radio" name="${radioId}" id="${radioId}-entity" value="entity">
				<label class="form-check-label" for="${radioId}">${getLocalizedText("menu:entity")}</label>
			</div>
		</div>

		<div class="coordinates-div"></div>
		<div class="entity-div"></div>
	</div>
	`);

	const divForCoordinates = createDivForCoordinates(data, false, false, false);
	div.find(".coordinates-div").append(divForCoordinates);

	const divForStaticIdInput = createDivForStaticIdInput(null, data.staticId);
	div.find(".entity-div").append(divForStaticIdInput);

	div.find(`input[type=radio][name=${radioId}]`).change(function() {
		const val = $(this).val();
		const isCoordinates = val == "coordinates";
		const isEntity = val == "entity";
		
		div.find(".coordinates-div").toggle(isCoordinates);
		div.find(".coordinates-div").find(".coords-x").prop("required", isCoordinates)
		div.find(".coordinates-div").find(".coords-y").prop("required", isCoordinates)
		div.find(".coordinates-div").find(".coords-z").prop("required", isCoordinates);
		

		div.find(".entity-div").toggle(isEntity);
	});

	div.find(`input[type=radio][name=${radioId}][value=${data.type || "coordinates"}]`).prop("checked", true).change();

	return div;
}

function setupMessageDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div"></div>
	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("ped", data.staticId);
	div.find(".setup-div").append(divForStaticIdInput);

	const dialogueDiv = createDivForDialogueList(data.dialogue);
	div.append(dialogueDiv);

	return div;
}

function setupWalkPedToCoordsDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex gap-3 justify-content-center align-items-center setup-div">
			<input type="radio" class="btn-check" name="ped-walk-to-coords-speed" id="ped-walk-to-coords-speed-walk" autocomplete="off" value="1" checked>
			<label class="btn btn-secondary" for="ped-walk-to-coords-speed-walk">${getLocalizedText("menu:walk")}</label>
			
			<input type="radio" class="btn-check" name="ped-walk-to-coords-speed" id="ped-walk-to-coords-speed-run" autocomplete="off" value="2">
			<label class="btn btn-secondary" for="ped-walk-to-coords-speed-run">${getLocalizedText("menu:run")}</label>
		</div>
	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("ped", data.staticId);
	div.find(".setup-div").prepend(divForStaticIdInput);

	const divForCoordinates = createDivForCoordinates(data, true, false, false);
	div.find(".setup-div").prepend(divForCoordinates);

	div.find(`input[type=radio][name=ped-walk-to-coords-speed][value=${data.speed || "1"}]`).prop("checked", true);

	return div;
}

function setupWanderPedDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex gap-3 justify-content-center align-items-center setup-div">
			<div class="form-check my-auto">
				<input class="form-check-input remain-in-area" type="checkbox" value="">
				<label class="form-check-label">${getLocalizedText("menu:remain_in_area")}</label>
			</div>

			<div class="form-floating radius-div" style="display: none">
				<input type="number" class="form-control radius" placeholder="..." value="${data.radius || ""}" required>
				<label>${getLocalizedText("menu:radius")}</label>
			</div>
		</div>
	</div>
	`);

	div.find(".remain-in-area").change(function() {
		const isChecked = $(this).prop("checked");
		div.find(".radius-div").toggle(isChecked);
		div.find(".radius").prop("required", isChecked);
	});

	const divForStaticIdInput = createDivForStaticIdInput("ped", data.staticId);
	div.find(".setup-div").prepend(divForStaticIdInput);

	div.find(".remain-in-area").prop("checked", data.remainInArea).change();

	return div;
}

function setupSetDoorlockDiv(workflowItem) {
	const data = workflowItem.data || {};

	const RADIO_NAME = generateStaticId();

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>
		
		<div class="d-flex gap-3 justify-content-center align-items-center">
			<button type="button" class="btn btn-secondary col-auto choose-doors">${getLocalizedText("menu:choose_doors")}</button>

			<div class="btn-group" role="group">
				<input type="radio" class="btn-check new-door-state" name="${RADIO_NAME}" id="${RADIO_NAME + "-lock"}" value="1" autocomplete="off">
				<label class="btn btn-outline-primary" for="${RADIO_NAME + "-lock"}">${getLocalizedText("menu:lock")}</label>

				<input type="radio" class="btn-check new-door-state" name="${RADIO_NAME}" id="${RADIO_NAME + "-unlock"}" value="0" autocomplete="off" checked>
				<label class="btn btn-outline-primary" for="${RADIO_NAME + "-unlock"}">${getLocalizedText("menu:unlock")}</label>
			</div>
		</div>
	</div>
	`);

	div.find(".choose-doors").click(async function() {
		const selectedDoors = $(this).data("selectedDoors");
		const doorsId = await doorsDialog(selectedDoors);
		if(!doorsId) return;

		$(this).data("selectedDoors", doorsId);
	}).data("selectedDoors", data.selectedDoors);

	div.find(`.new-door-state[value="${data.newState}"]`).prop("checked", true);

	return div;
}

function setupTeleportPlayersDiv(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>
	</div>
	`);

	const divForCoordinates = createDivForCoordinates(data, false, false, false);
	div.append(divForCoordinates);

	return div;
}

function setupGoToCoordinates(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center setup-title">${getLocalizedText("menu:setup")}</h3>
	</div>
	`);

	const divForCoordinatesWithRadius = createDivForCoordinates(data);

	div.find('.setup-title').after(divForCoordinatesWithRadius);

	return div;
}

function getWorkflowItemDataFromDiv(div) {
	const workflowItemId = div.data("workflowItemId");

	switch(workflowItemId) {
		case "spawn_entity_in_coords": {
			return {
				staticId: div.find(".entity-label").data("staticId"),
				label: div.find(".entity-label").val(),	
				type: div.find("input[type=radio]:checked").val(),
				model: div.find(".entity-model").val(),
				freezeInPosition: div.find(".freeze-in-position").prop("checked"),
				armor: parseInt( div.find(".ped-armor").val() ),
				weapon: div.find(".ped-weapon").val(),
				isInvincible: div.find(".ped-is-invincible").prop("checked"),
				doesHeadshotOneShot: div.find(".ped-does-headshot-one-shot").prop("checked"),
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				heading: parseFloat( div.find(".heading").val() ),
			}
		}

		case "delete_entities": {
			const staticIds = getStaticIdsFromListDiv(div);

			return {staticIds}
		}

		case "trigger_client_event": {
			return {
				eventName: div.find(".event-name").val(),
				targetPlayers: parseInt( div.find(".target-players").val() ),
				parameters: getParametersFromDiv(div.find(".parameters-setup")),
			}
		}

		case "trigger_event": {
			return {
				eventName: div.find(".event-name").val(),
				parameters: getParametersFromDiv(div.find(".parameters-setup")),
			}
		}

		case "give_items": {
			return {
				rewardMinAmount: parseInt( div.find(".reward-min-amount").val() ),
				rewardMaxAmount: parseInt( div.find(".reward-max-amount").val() ),
				rewardItems: getRewardItemsFromDiv(div.find(".reward-items-list")),
			}
		}

		case "alert_police": {
			return {
				message: div.find(".message").val(),
				probability: parseInt( div.find(".probability").val() ),
				type: div.find("input[type=radio]:checked").val(),
				staticId: div.find(".entity-input").data("staticId"),
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
			}
		}

		case "message": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
				dialogue: getDialogueFromDiv(div.find(".dialogue-setup-list")),
			}
		}

		case "walk_ped_to_coords": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
				speed: parseFloat( div.find("input[type=radio]:checked").val() ),
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
			}
		}

		case "wander_ped": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
				remainInArea: div.find(".remain-in-area").prop("checked"),
				radius: parseFloat( div.find(".radius").val() ),
			}
		}
		
		case "set_doorlock": {
			return {
				selectedDoors: div.find(".choose-doors").data("selectedDoors"),
				newState: parseInt( div.find(".new-door-state:checked").val() ),
			}
		}

		case "teleport_players": {
			return {
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
			}
		}

		case "goto_coordinates": {
			return {
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
				blipData: div.find(".customize-blip-btn").data("blipData"),
				markerData: div.find(".customize-marker-btn").data("markerData"),
			}
		}

		case "enter_vehicle": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
			}
		}

		case "deliver_vehicle": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
			
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),

				blipData: div.find(".customize-blip-btn").data("blipData"),
				markerData: div.find(".customize-marker-btn").data("markerData"),
			}
		}

		case "pickup_object": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
				requiredItems: getRequiredItemsFromDiv(div.find(".required-items-list")),
				rewardMinAmount: parseInt( div.find(".reward-min-amount").val() ),
				rewardMaxAmount: parseInt( div.find(".reward-max-amount").val() ),
				rewardItems: getRewardItemsFromDiv(div.find(".reward-items-list")),
				animationsData: div.find(".animations-btn").data("animationsData"),
				blipData: div.find(".customize-blip-btn").data("blipData"),
				markerData: div.find(".customize-marker-btn").data("markerData"),
				maxProgress: parseInt( div.find(".max-progress").val() ),
				highlightWhenNear: div.find(".highlight-when-near").prop("checked"),
			}
		}

		case "blowup_entity": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
			}
		}

		case "kill_ped": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
			}
		}

		case "protect_ped": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
				toughness: getDifficultyFromDiv(div),
				attackersStaticIds: getStaticIdsFromListDiv(div)
			}
		}

		case "play_minigame": {
			return {
				minigameName: div.find(".minigame-name").val(),
				difficulty: parseInt( div.find(".difficulty").val() ),
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
				blipData: div.find(".customize-blip-btn").data("blipData"),
				markerData: div.find(".customize-marker-btn").data("markerData"),

				requiredItems: getRequiredItemsFromDiv(div.find(".required-items-list")),
				rewardMinAmount: parseInt( div.find(".reward-min-amount").val() ),
				rewardMaxAmount: parseInt( div.find(".reward-max-amount").val() ),
				rewardItems: getRewardItemsFromDiv(div.find(".reward-items-list")),
			}
		}

		case "leave_area": {
			return {
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
				blipData: div.find(".customize-blip-btn").data("blipData"),
			}
		}

		case "talk_to_ped": {
			return {
				staticId: div.find(".entity-input").data("staticId"),
				dialogue: getDialogueFromDiv(div.find(".dialogue-setup-list")),
				requiredItems: getRequiredItemsFromDiv(div.find(".required-items-list")),
				rewardMinAmount: parseInt( div.find(".reward-min-amount").val() ),
				rewardMaxAmount: parseInt( div.find(".reward-max-amount").val() ),
				rewardItems: getRewardItemsFromDiv(div.find(".reward-items-list")),
			}
		}

		case "play_animation": {
			return {
				animationsData: div.find(".animations-btn").data("animationsData"),
				
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
				blipData: div.find(".customize-blip-btn").data("blipData"),
				markerData: div.find(".customize-marker-btn").data("markerData"),
				requiredItems: getRequiredItemsFromDiv(div.find(".required-items-list")),
				rewardMinAmount: parseInt( div.find(".reward-min-amount").val() ),
				rewardMaxAmount: parseInt( div.find(".reward-max-amount").val() ),
				rewardItems: getRewardItemsFromDiv(div.find(".reward-items-list")),
			}
		}

		case "survive": {
			return {
				minutesToSurvive: parseInt( div.find(".minutes-to-survive").val() ),
				maxEnemies: parseInt( div.find(".max-enemies").val() ),
				toughness: getDifficultyFromDiv(div),
				possibleWeapons: getListedElementsFromDiv(div.find(".elements-list.weapons")),
				possiblePedsModels: getListedElementsFromDiv(div.find(".elements-list.ped-models")),
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
				blipData: div.find(".customize-blip-btn").data("blipData"),
			}
		}

		case "vehicle_attack": {
			return {
				minutesToSurvive: parseInt( div.find(".minutes-to-survive").val() ),
				maxEnemiesVehicles: parseInt( div.find(".max-enemies-vehicles").val() ),
				toughness: getDifficultyFromDiv(div),
				possibleWeapons: getListedElementsFromDiv(div.find(".elements-list.weapons")),
				possiblePedsModels: getListedElementsFromDiv(div.find(".elements-list.ped-models")),
				possibleVehiclesModels: getListedElementsFromDiv(div.find(".elements-list.vehicles-models")),
			}
		}

		case "wait_in_coordinates": {
			return {
				secondsToWait: parseInt( div.find(".seconds-to-wait").val() ),
				coordinates: {
					x: parseFloat( div.find(".coords-x").val() ),
					y: parseFloat( div.find(".coords-y").val() ),
					z: parseFloat( div.find(".coords-z").val() ),
				},
				radius: parseFloat( div.find(".radius").val() ),
				blipData: div.find(".customize-blip-btn").data("blipData"),
				markerData: div.find(".customize-marker-btn").data("markerData"),
			}
		}
	}
}

function getWorkflowItemsDataForStage(stageUniqueId, workflowType) {
	const workflowItems = $("#stage-elements-container").find(`.workflow-item[data-stage-unique-id='${stageUniqueId}'][data-workflow-type='${workflowType}']`);

	const isTask = workflowType == "tasks";

	const workflowItemsData = workflowItems.map(function(index, element) {
		return {
			label: isTask ? $(element).find(".label").val() : undefined,
			description: isTask ? $(element).find(".description").val() : undefined,
			isOptional: isTask ? $(element).find(".is-optional").prop("checked") : undefined,
			requiresAllPlayers: isTask ? $(element).find(".requires-all-players").prop("checked") : undefined,
			type: $(element).data("workflowItemId"),
			data: getWorkflowItemDataFromDiv( $(element) )
		}
	}).get();

	return workflowItemsData;
}

function setStaticIdForInput(div, staticId) {
	div.find(".entity-input").data("staticId", staticId);
	div.find(".entity-input").val( getEntityLabelFromStaticId(staticId) );

	// Add the tooltip
	div.find(".entity-input")
		.tooltip("dispose")
		.attr("data-bs-toggle", "tooltip")
		.attr("data-bs-placement", "top")
		.attr("title", "ID: " + shortenStaticId(staticId))
		.tooltip();
}

function createDivForStaticIdInput(entityType, staticId) {
	let placeholder = getLocalizedText("menu:entity");

	if(entityType) placeholder = getLocalizedText(`menu:${entityType}`);

	const div = $(`
	<div class="d-flex justify-content-center">
		<div class="input-group" style="width:auto">
			<input type="text" class="form-control entity-input" disabled placeholder="${placeholder}" required>
			<button class="btn btn-outline-secondary choose-entity-btn" type="button">${getLocalizedText("menu:choose")}</button>
		</div>
	</div>
	`);

	if(staticId) setStaticIdForInput(div, staticId);

	div.find(".choose-entity-btn").click(async function() {
		const availableEntities = getAvailableEntitiesForStage(selectedStage, selectedWorkflowType, entityType);

		const staticId = await listDialog(
			getLocalizedText("menu:choose"),
			getLocalizedText("menu:search"),
			availableEntities,
			getLocalizedText("menu:all_spawned_entities_have_already_been_deleted")
			);
		if(!staticId) return;

		setStaticIdForInput(div, staticId);
	});

	return div;
}

function setupEnterVehicle(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("vehicle", data.staticId);

	div.append(divForStaticIdInput);

	return div;
}

function setupDeliverVehicle(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center setup-title">${getLocalizedText("menu:setup")}</h3>

		<h3 class="text-center mt-4">${getLocalizedText("menu:coordinates")}</h3>
	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("vehicle", data.staticId);

	// Add the div after .setup-title
	div.find('.setup-title').after(divForStaticIdInput);

	const divForCoordinatesWithRadius = createDivForCoordinates(data);
	
	div.append(divForCoordinatesWithRadius);

	return div;
}

function addRequiredItemInList(listDiv, requiredItem) {
	const div = $(`
	<div class="row g-2 row-cols-auto align-items-center my-2 justify-content-center required-item">
		<button type="button" class="btn-close col-auto me-3"></button>

		<select class="form-select item-type" style="width: auto;">
			<option selected value="item">${getLocalizedText("menu:item")}</option>
			<option value="account">${getLocalizedText("menu:account")}</option>
			${getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
		</select>
		
		<div class="form-floating">
			<input type="text" class="form-control item-name" placeholder="Name" required>
			<label>${ getLocalizedText("menu:object_name") }</label>
		</div>

		<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

		<div class="form-floating">
			<input type="number" min="1" class="form-control item-quantity" placeholder="..." required>
			<label>${getLocalizedText("menu:quantity")}</label>
		</div>

		<div class="form-check my-auto">
			<input class="form-check-input has-to-remove-checkbox" type="checkbox" value="">
			<label class="form-check-label">${getLocalizedText("menu:has_to_remove")}</label>
		</div>
	</div>
	`);

	div.find(".btn-close").click(function() {
		div.remove();
	});

	div.find(".choose-item-btn").click(async function() {
		let objectType = div.find(".item-type").val();
		let objectName = await objectDialog(objectType);

		div.find(".item-name").val(objectName);
	});

	if(requiredItem) {
		div.find(".item-type").val(requiredItem.type);
		div.find(".item-name").val(requiredItem.name);
		div.find(".item-quantity").val(requiredItem.minQuantity);
		div.find(".has-to-remove-checkbox").prop("checked", requiredItem.hasToRemove);
	}

	listDiv.append(div);
}

function createDivForRequiredItemsList(requiredItems=[]) {
	const div = $(`
		<div>
			<h3 class="text-center mt-4 mb-2">${getLocalizedText("menu:required_items")}</h3>

			<div class="required-items-list elements-list"></div>
			<div class="no-elements-message text-center text-warning p-5 fw-bold">${getLocalizedText("menu:no_elements_added")}</div>

			<div class="d-inline-block col-12">
				<button type="button" class="btn btn-outline-secondary float-end add-required-item-btn">${getLocalizedText("menu:add_object")}</button>
			</div
			
		</div>
	`);

	div.find(".add-required-item-btn").click(function() {
		addRequiredItemInList(div.find(".required-items-list"));
	});

	requiredItems.forEach(function(requiredItem) {
		addRequiredItemInList(div.find(".required-items-list"), requiredItem);
	});

	return div;
}

function addRewardItemInList(listDiv, rewardItem) {
	const div = $(`
	<div class="row g-2 row-cols-auto align-items-center my-2 justify-content-center reward-item">
		<button type="button" class="btn-close col-auto me-3"></button>

		<select class="form-select item-type" style="width: auto;">
			<option selected value="item">${getLocalizedText("menu:item")}</option>
			<option value="account">${getLocalizedText("menu:account")}</option>
			${getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
		</select>

		<div class="form-floating">
			<input type="text" class="form-control item-name" placeholder="Name" required>
			<label>${ getLocalizedText("menu:object_name") }</label>
		</div>

		<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>

		<div class="form-floating">
			<input type="number" min="1" class="form-control item-min-quantity" placeholder="..." required>
			<label>${getLocalizedText("menu:min_quantity")}</label>
		</div>

		<div class="form-floating">
			<input type="number" min="1" class="form-control item-max-quantity" placeholder="..." required>
			<label>${getLocalizedText("menu:max_quantity")}</label>
		</div>

		<div class="form-floating">
			<input type="number" min="1" class="form-control item-chances" placeholder="..." required>
			<label>${getLocalizedText("menu:probability")}</label>
		</div>
	`);

	div.find(".btn-close").click(function() {
		div.remove();
	});

	div.find(".choose-item-btn").click(async function() {
		let objectType = div.find(".item-type").val();
		let objectName = await objectDialog(objectType);

		div.find(".item-name").val(objectName);
	});

	if(rewardItem) {
		div.find(".item-type").val(rewardItem.type);
		div.find(".item-name").val(rewardItem.name);
		div.find(".item-min-quantity").val(rewardItem.minQuantity);
		div.find(".item-max-quantity").val(rewardItem.maxQuantity);
		div.find(".item-chances").val(rewardItem.chances);
	}

	listDiv.append(div);
}

function createDivForRewardItemsList(rewardItems=[], rewardMinAmount, rewardMaxAmount) {
	const div = $(`
		<div>
			<h3 class="text-center mt-4 mb-2">${getLocalizedText("menu:reward_items")}</h3>

			<div class="d-flex justify-content-center gap-3">
				<div class="form-floating" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:min_drop_amount:description")}">
					<input type="number" min="1" class="form-control reward-min-amount" placeholder="..." value="${rewardMinAmount || 1}" required>
					<label>${getLocalizedText("menu:min_amount")}</label>
				</div>

				<div class="form-floating" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:max_drop_amount:description")}">
					<input type="number" min="1" class="form-control reward-max-amount" placeholder="..." value="${rewardMaxAmount || 1}" required>
					<label>${getLocalizedText("menu:max_amount")}</label>
				</div>
			</div>

			<div class="reward-items-list elements-list"></div>
			<div class="no-elements-message text-center text-warning p-5 fw-bold">${getLocalizedText("menu:no_elements_added")}</div>

			<div class="d-inline-block col-12">
				<button type="button" class="btn btn-outline-secondary float-end add-reward-item-btn">${getLocalizedText("menu:add_object")}</button>
			</div
		</div>
	`);

	// Activate tooltips
	div.find("[data-bs-toggle=tooltip]").tooltip();

	div.find(".add-reward-item-btn").click(function() {
		addRewardItemInList(div.find(".reward-items-list"));
	});

	rewardItems.forEach(function(rewardItem) {
		addRewardItemInList(div.find(".reward-items-list"), rewardItem);
	});

	return div;
}

function getRewardItemsFromDiv(div) {
	let rewardItems = [];

	div.find(".reward-item").each(function() {
		let rewardItem = {
			type: $(this).find(".item-type").val(),
			name: $(this).find(".item-name").val(),
			minQuantity: parseInt( $(this).find(".item-min-quantity").val() ),
			maxQuantity: parseInt( $(this).find(".item-max-quantity").val() ),
			chances: parseInt( $(this).find(".item-chances").val() )
		}

		rewardItems.push(rewardItem);
	});

	return rewardItems;
}

function getRequiredItemsFromDiv(div) {
	let requiredItems = [];

	div.find(".required-item").each(function() {
		let requiredItem = {
			type: $(this).find(".item-type").val(),
			name: $(this).find(".item-name").val(),
			minQuantity: parseInt( $(this).find(".item-quantity").val() ),
			hasToRemove: $(this).find(".has-to-remove-checkbox").prop("checked")
		}

		requiredItems.push(requiredItem);
	});

	return requiredItems;
}

function setupPickupObject(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
			<div class="form-check my-auto">
				<input class="form-check-input highlight-when-near" type="checkbox" value="">
				<label class="form-check-label">${getLocalizedText("menu:highlight_when_near")}</label>
			</div>

			<button type="button" class="btn btn-secondary mx-1 animations-btn">${getLocalizedText("menu:choose_animations")}</button>

			<div class="form-floating">
				<input type="number" min="1" class="form-control max-progress" placeholder="..." value="${data.maxProgress || 1}" required>
				<label>${getLocalizedText("menu:times_to_repeat")}</label>
			</div>

			<button type="button" class="btn btn-secondary customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>
			<button type="button" class="btn btn-secondary customize-marker-btn">${getLocalizedText("menu:customize_marker")}</button>	
		</div>
	</div>
	`);

	div.find(".highlight-when-near").prop("checked", data.highlightWhenNear);

	const divForStaticIdInput = createDivForStaticIdInput("object", data.staticId);

	// Add the div as first element of .setup-div
	div.find(".setup-div").prepend(divForStaticIdInput);

	const requiredItemsDiv = createDivForRequiredItemsList(data.requiredItems);
	div.append(requiredItemsDiv);

	const rewardItemsDiv = createDivForRewardItemsList(data.rewardItems, data.rewardMinAmount, data.rewardMaxAmount);
	div.append(rewardItemsDiv);

	const animationsBtn = div.find(".animations-btn");
	animationsBtn.click(async function() {
		const oldAnimations = animationsBtn.data("animationsData");
	
		const animations = await animationsDialog(oldAnimations);
		if (!animations) return;
	
		animationsBtn.data("animationsData", animations);
	}).data("animationsData", data.animationsData || getDefaultAnimationsData());

	const customizeBlipBtn = div.find(".customize-blip-btn");
	customizeBlipBtn.click(async function() {
		const oldBlipData = customizeBlipBtn.data("blipData");

		const blipData = await blipDialog(oldBlipData);
		if (!blipData) return;

		customizeBlipBtn.data("blipData", blipData);
	}).data("blipData", data.blipData || getDefaultBlipCustomization());

	const customizeMarkerBtn = div.find(".customize-marker-btn");
	customizeMarkerBtn.click(async function() {
		const oldMarkerData = customizeMarkerBtn.data("markerData");

		const markerData = await markerDialog(oldMarkerData);
		if (!markerData) return;

		customizeMarkerBtn.data("markerData", markerData);
	}).data("markerData", data.markerData || getDefaultMarkerCustomization());
	
	return div;
}

function setupBlowupEntity(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		
		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
		
		</div>
	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("object", data.staticId);

	// Add the div as first element of .setup-div
	div.find(".setup-div").prepend(divForStaticIdInput);

	return div;
}

function setupKillPed(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		
		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
		
		</div>
	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("ped", data.staticId);

	// Add the div as first element of .setup-div
	div.find(".setup-div").prepend(divForStaticIdInput);

	return div;
}

function setupProtectPed(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">

		</div>

		<h3 class="text-center mt-4">${getLocalizedText("menu:attackers")}</h3>
	</div>
	`);

	const difficultyDiv = createDivForDifficulty(true, data.toughness);
	div.find(".setup-div").append(difficultyDiv);

	const divForStaticIdInput = createDivForStaticIdInput("ped", data.staticId);

	// Add the div as first element of .setup-div
	div.find(".setup-div").prepend(divForStaticIdInput);

	const divForAttackersList = createDivForStaticIdsList("ped", data.attackersStaticIds);
	div.append(divForAttackersList);

	return div;
}

function setupPlayMinigame(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
			<div class="form-floating">
				<input type="text" class="form-control minigame-name" placeholder="..." value="${data.minigameName || ""}" required readonly>
				<label>${getLocalizedText("menu:name")}</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-minigame-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:choose")}"><i class="bi bi-list-ul"></i></button>
			
			<div class="form-floating col-1">
				<input type="number" class="form-control difficulty" min="1" max="3" placeholder="..." value="${data.difficulty || "1"}" required>
				<label>${getLocalizedText("menu:difficulty")}</label>
			</div>
		</div>

		<h3 class="text-center mt-4">${getLocalizedText("menu:coordinates")}</h3>

	</div>
	`);

	const divForCoordinatesWithRadius = createDivForCoordinates(data);
	div.append(divForCoordinatesWithRadius);

	div.find(".choose-minigame-btn").click(async function() {
		const ALL_MINIGAMES_NAMES = await $.post(`https://${resName}/getAllMinigames`);
		
		const elements = ALL_MINIGAMES_NAMES.map(function(minigame) {
			return {label: firstCharToUpperCase(minigame), value: minigame};
		});

		const minigameName = await listDialog(getLocalizedText("menu:choose"), getLocalizedText("menu:search"), elements);
		if(!minigameName) return;

		div.find(".minigame-name").val(minigameName);
	}).tooltip();

	const requiredItemsDiv = createDivForRequiredItemsList(data.requiredItems);
	div.append(requiredItemsDiv);

	const rewardItemsDiv = createDivForRewardItemsList(data.rewardItems, data.rewardMinAmount, data.rewardMaxAmount);
	div.append(rewardItemsDiv);

	return div;
}

function setupLeaveArea(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center setup-title">${getLocalizedText("menu:setup")}</h3>
	</div>
	`);

	const divForCoordinatesWithRadius = createDivForCoordinates(data);
	div.find('.setup-title').after(divForCoordinatesWithRadius);

	return div;
}

function setDialoguePieceAudioFile(div, audioFile) {
	if(audioFile) {
		div.find(".choose-audio-btn").data("audioFile", audioFile);
		div.find(".choose-audio-btn").text(audioFile);
	} else {
		div.find(".choose-audio-btn").data("audioFile", undefined);
		div.find(".choose-audio-btn").text(getLocalizedText("menu:choose_audio"));
	}
}

function addDialoguePieceInList(listDiv, dialoguePiece={}) {
	const div = $(`
	<div class="row g-2 row-cols-auto align-items-center my-2 justify-content-center dialogue-piece">
		<button type="button" class="btn-close col-auto me-3"></button>

		<div class="form-floating">
			<input type="text" class="form-control dialogue-piece-title" placeholder="..." value="${dialoguePiece.title || ""}" required>
			<label>${getLocalizedText("menu:title")}</label>
		</div>

		<div class="form-floating">
			<input type="text" class="form-control dialogue-piece-message" placeholder="..." value="${dialoguePiece.message || ""}" required>
			<label>${getLocalizedText("menu:message")}</label>
		</div>

		<div class="form-floating">
			<input type="number" min="1" class="form-control seconds-duration" placeholder="..." value="${dialoguePiece.secondsDuration || 3}" required>
			<label>${getLocalizedText("menu:seconds_duration")}</label>
		</div>

		<button type="button" class="btn btn-secondary col-auto choose-audio-btn"></button>
	</div>
	`);

	div.find(".choose-audio-btn").click(async function() {
		const ALL_AUDIO_FILES = await $.post(`https://${resName}/getAllAudioFiles`);
		const elements = ALL_AUDIO_FILES.map(audioFile => { return {label: audioFile, value: audioFile} });

		const audioFile = await listDialog(getLocalizedText("menu:choose"), getLocalizedText("menu:search"), elements, getLocalizedText("menu:no_audio_files_found"));
		setDialoguePieceAudioFile(div, audioFile);
	});

	setDialoguePieceAudioFile(div, dialoguePiece.audioFile);		

	div.find(".btn-close").click(function() {
		div.remove();
	});

	listDiv.append(div);
}

function createDivForDialogueList(dialogue=[]) {
	const div = $(`
		<div>
			<h3 class="text-center mt-4 mb-2">Dialogue</h3>

			<div class="dialogue-setup-list elements-list"></div>
			<div class="no-elements-message text-center text-warning p-5 fw-bold">${getLocalizedText("menu:no_elements_added")}</div>

			<div class="d-inline-block col-12">
				<button type="button" class="btn btn-outline-secondary float-end add-dialogue-piece-btn">${getLocalizedText("menu:add_message")}</button>
			</div
		</div>
	`);

	div.find(".add-dialogue-piece-btn").click(function() {
		addDialoguePieceInList(div.find(".dialogue-setup-list"));
	});

	dialogue.forEach(function(dialoguePiece) {
		addDialoguePieceInList(div.find(".dialogue-setup-list"), dialoguePiece);
	});

	if(dialogue.length == 0) {
		addDialoguePieceInList(div.find(".dialogue-setup-list"));
	}

	return div;
}

function getDialogueFromDiv(div) {
	let dialogue = [];

	div.find(".dialogue-piece").each(function() {
		let dialoguePiece = {
			title: $(this).find(".dialogue-piece-title").val(),
			message: $(this).find(".dialogue-piece-message").val(),
			secondsDuration: parseInt( $(this).find(".seconds-duration").val() ),
			audioFile: $(this).find(".choose-audio-btn").data("audioFile")
		}

		dialogue.push(dialoguePiece);
	});

	return dialogue;
}

function setupTalkToPed(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">

		</div>
	</div>
	`);

	const divForStaticIdInput = createDivForStaticIdInput("ped", data.staticId);

	// Add the div as first element of .setup-div
	div.find(".setup-div").prepend(divForStaticIdInput);

	const dialogueDiv = createDivForDialogueList(data.dialogue);
	div.append(dialogueDiv);
	
	const requiredItemsDiv = createDivForRequiredItemsList(data.requiredItems);
	div.append(requiredItemsDiv);

	const rewardItemsDiv = createDivForRewardItemsList(data.rewardItems, data.rewardMinAmount, data.rewardMaxAmount);
	div.append(rewardItemsDiv);

	return div;
}

function setupPlayAnimation(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
			<button type="button" class="btn btn-secondary mx-1 animations-btn">${getLocalizedText("menu:choose_animations")}</button>
		</div>

		<h3 class="text-center mt-4">${getLocalizedText("menu:coordinates")}</h3>
	</div>
	`);

	const animationsBtn = div.find(".animations-btn");

	animationsBtn.click(async function() {
		const oldAnimations = animationsBtn.data("animationsData");

		const animations = await animationsDialog(oldAnimations);
		if (!animations) return;

		animationsBtn.data("animationsData", animations);
	}).data("animationsData", data.animationsData || getDefaultAnimationsData());

	const divForCoordinatesWithRadius = createDivForCoordinates(data);
	div.append(divForCoordinatesWithRadius);

	const requiredItemsDiv = createDivForRequiredItemsList(data.requiredItems);
	div.append(requiredItemsDiv);

	const rewardItemsDiv = createDivForRewardItemsList(data.rewardItems, data.rewardMinAmount, data.rewardMaxAmount);
	div.append(rewardItemsDiv);

	return div;
}

function addElementInListedElements(listDiv, element) {
	const div = $(`
	<li class="list-group-item p-2 text-center">
		<span class="element">${element}</span>
		<span class="d-inline-flex position-absolute" style="right: 0; top: 0; height: 100%;">
			<button type="button" class="btn py-0 btn-close my-auto me-2"></button>
		</span>
	</li>
	`);

	div.find(".btn-close").click(function() {
		div.remove();
	});

	listDiv.append(div);
}

function createDivForListedElements(id, title, placeholder, buttonText, elements=[]) {
	const div = $(`
	<div>
		<h3 class="text-center mt-4">${title}</h3>

		<ul class="list-group elements-list ${id}"></ul>
		<div class="no-elements-message text-center text-warning p-5 fw-bold">${getLocalizedText("menu:no_elements_added")}</div>

		<div class="input-group mt-3">
			<input type="text" class="form-control element-id" placeholder="${placeholder}">
			<button class="btn btn-outline-secondary add-element-btn" type="button">${buttonText}</button>
		</div>
	</div>
	`);

	div.find(".add-element-btn").click(function() {
		const elementInputDiv = div.find(".element-id");
		const elementId = elementInputDiv.val();
		if(!elementId || elementId == "") return;

		elementInputDiv.val("");

		addElementInListedElements(div.find(`.${id}`), elementId);
	});

	elements.forEach(function(elementId) {
		addElementInListedElements(div.find(`.${id}`), elementId);
	});

	return div;
}

function getListedElementsFromDiv(div) {
	let elements = [];

	div.find(".element").each(function() {
		elements.push($(this).text());
	});

	return elements;
}

function createDivForDifficulty(isReverse = false, difficulty = 2) {
	const RADIO_NAME = generateStaticId(); // So radio name will be random and won't bother

	const div = $(`
	<div class="btn-group" role="group">
		<input type="radio" class="btn-check difficulty" name="${RADIO_NAME}" id="${RADIO_NAME + "-easy"}" autocomplete="off">
		<label class="btn btn-outline-primary" for="${RADIO_NAME + "-easy"}">${getLocalizedText("menu:easy")}</label>

		<input type="radio" class="btn-check difficulty" name="${RADIO_NAME}" id="${RADIO_NAME + "-normal"}" autocomplete="off">
		<label class="btn btn-outline-primary" for="${RADIO_NAME + "-normal"}">${getLocalizedText("menu:normal")}</label>

		<input type="radio" class="btn-check difficulty" name="${RADIO_NAME}" id="${RADIO_NAME + "-hard"}" autocomplete="off">
		<label class="btn btn-outline-primary" for="${RADIO_NAME + "-hard"}">${getLocalizedText("menu:hard")}</label>
	</div>
	`);

	// Add values to inputs
	div.find("input").each(function(index, element) {
		const totalElements = div.find("input").length;
		const value = isReverse ? totalElements - index : index + 1;

		$(element).val(value);
	});

	// Set the default value
	div.find(`input[value="${difficulty}"]`).prop("checked", true);

	return div;
}

function getDifficultyFromDiv(div) {
	return parseInt( div.find(".difficulty:checked").val() );
}

function setupSurvive(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
			<div class="form-floating col-2">
				<input type="number" min="1" class="form-control minutes-to-survive" placeholder="..." value="${data.minutesToSurvive || 2}" required>
				<label>${getLocalizedText("menu:minutes_to_survive")}</label>
			</div>

			<div class="form-floating col-3">
				<input type="number" min="1" class="form-control max-enemies" placeholder="..." value="${data.maxEnemies || 5}" required>
				<label>${getLocalizedText("menu:max_enemies")}</label>
			</div>
		</div>

		<div class="d-flex gap-3 justify-content-center lists">

		</div>

		<h3 class="text-center mt-4">${getLocalizedText("menu:coordinates")}</h3>
	</div>
	`);

	const difficultyDiv = createDivForDifficulty(false, data.toughness);
	div.find(".setup-div").append(difficultyDiv);

	const divForCoordinatesWithRadius = createDivForCoordinates(data, true, true, false);
	div.append(divForCoordinatesWithRadius);

	const divForPossibleModels = createDivForListedElements("ped-models", getLocalizedText("menu:possible_models"), getLocalizedText("menu:model"), getLocalizedText("menu:add_model"), data.possiblePedsModels);
	div.find(".lists").append(divForPossibleModels);
	
	const divForPossibleWeapons = createDivForListedElements("weapons", getLocalizedText("menu:possible_weapons"), getLocalizedText("menu:weapon"), getLocalizedText("menu:add_weapon"), data.possibleWeapons);
	div.find(".lists").append(divForPossibleWeapons);

	// Set old data
	div.find(".minutes-to-survive").val(data.minutesToSurvive);
	div.find(".max-enemies").val(data.maxEnemies);
	div.find(".customize-blip-btn").data("blipData", data.blipData);

	return div;
}

function setupVehicleAttack(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
			<div class="form-floating col-3">
				<input type="number" min="1" max="15" class="form-control max-enemies-vehicles" placeholder="..." value="${data.maxEnemiesVehicles || 5}" required>
				<label>${getLocalizedText("menu:max_enemies")}</label>
			</div>
			
			<div class="form-floating col-2">
				<input type="number" min="1" class="form-control minutes-to-survive" placeholder="..." value="${data.minutesToSurvive || 3}" required>
				<label>${getLocalizedText("menu:minutes_to_survive")}</label>
			</div>
		</div>

		<div class="d-flex gap-3 justify-content-center lists">

		</div>
	</div>
	`);

	const difficultyDiv = createDivForDifficulty(false, data.toughness);
	div.find(".setup-div").append(difficultyDiv);
	
	const divForPossibleModels = createDivForListedElements("ped-models", getLocalizedText("menu:possible_models"), getLocalizedText("menu:model"), getLocalizedText("menu:add_model"), data.possiblePedsModels);
	div.find(".lists").append(divForPossibleModels);
	
	const divForPossibleWeapons = createDivForListedElements("weapons", getLocalizedText("menu:possible_weapons"), getLocalizedText("menu:weapon"), getLocalizedText("menu:add_weapon"), data.possibleWeapons);
	div.find(".lists").append(divForPossibleWeapons
	);
	const divForPossibleVehicles = createDivForListedElements("vehicles-models", getLocalizedText("menu:possible_vehicles_models"), getLocalizedText("menu:vehicle"), getLocalizedText("menu:add_vehicle"), data.possibleVehiclesModels);
	div.find(".lists").append(divForPossibleVehicles);

	return div;
}

function setupWaitInCoordinates(workflowItem) {
	const data = workflowItem.data || {};

	const div = $(`
	<div>
		<h3 class="text-center setup-title">${getLocalizedText("menu:setup")}</h3>

		<div class="d-flex justify-content-center align-items-center gap-3 mb-2 setup-div">
			<div class="form-floating">
				<input type="number" min="1" class="form-control seconds-to-wait" placeholder="..." value="${data.secondsToWait || 5}" required>
				<label>${getLocalizedText("menu:seconds_to_wait")}</label>
			</div>

		</div>
	</div>
	`);

	const divForCoordinatesWithRadius = createDivForCoordinates(data);
	div.find(".setup-div").append(divForCoordinatesWithRadius);

	return div;
}

async function createWorkflowItem(stageUniqueId, workflowItem, workflowType) {
	const workflowItemIndex = workflowItem.index || getWorkflowItemIndexForThisStage();
	const label = workflowItem.label || getLocalizedText(workflowItem.type);

	let parent = $(`
	<div class="workflow-item" 
		data-workflow-type="${workflowType}" 
		data-workflow-item-id="${workflowItem.type}" 
		data-stage-unique-id="${stageUniqueId}" 
		data-workflow-item-index="${workflowItemIndex}" 
		style="display:none">
		
		<div class="generic-div">
			<h3 class="text-center">${getLocalizedText("menu:generic")}</h3>

			<div class="d-flex gap-3 justify-content-center align-items-center task-options mb-3">
				<div class="form-floating">
					<input type="text" class="form-control label" placeholder="..." value="${label}" required>
					<label>${getLocalizedText("menu:label")}</label>
				</div>

				<div class="form-floating">
					<input type="text" class="form-control description" placeholder="..." value="${workflowItem.description || ""}">
					<label>${getLocalizedText("menu:description")}</label>
				</div>

				<div class="form-check my-auto" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:is_optional:description")}">
					<input class="form-check-input is-optional" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>

				<div class="form-check my-auto" data-bs-toggle="tooltip" data-bs-placement="top" title="${getLocalizedText("menu:requires_all_players:description")}">
					<input class="form-check-input requires-all-players" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:requires_all_players")}</label>
				</div>
			</div>
		</div>
	</div>
	`);
	let child = null;

	if(workflowType != "tasks") {
		parent.find(".generic-div").remove();
	}

	parent.find(".is-optional").prop("checked", workflowItem.isOptional);
	parent.find(".requires-all-players").prop("checked", workflowItem.requiresAllPlayers);

	parent.find("[data-bs-toggle=tooltip]").tooltip();

	switch(workflowItem.type) {
		case "spawn_entity_in_coords": {
			if(!workflowItem.data?.label) { // If the user is creating it right now
				const label = await input(getLocalizedText("menu:label"), getLocalizedText("menu:entity_label"), getLocalizedText("menu:it_cannot_be_changed_after_creating_it"));
				if(!label) return;

				workflowItem.label = label;

				const type = await listDialog(getLocalizedText("menu:choose"), getLocalizedText("menu:search"), [
					{label: getLocalizedText("menu:ped"), value: "ped"},
					{label: getLocalizedText("menu:vehicle"), value: "vehicle"},
					{label: getLocalizedText("menu:object"), value: "object"},
				]);
				if(!type) return;

				workflowItem.data = {label, type};
			}
			
			child = setupSpawnEntityInCoordsDiv(workflowItem);

			break;
		}

		case "delete_entities": {
			child = setupDeleteEntitiesDiv(workflowItem);
			break;
		}

		case "trigger_client_event": {
			child = setupTriggerClientEventDiv(workflowItem);
			break;
		}

		case "trigger_event": {
			child = setupTriggerEventDiv(workflowItem);
			break;
		}

		case "give_items": {
			child = setupGiveItemsDiv(workflowItem);
			break;
		}

		case "alert_police": {
			child = setupAlertPoliceDiv(workflowItem);
			break;
		}

		case "message": {
			child = setupMessageDiv(workflowItem);
			break;
		}

		case "walk_ped_to_coords": {
			child = setupWalkPedToCoordsDiv(workflowItem);
			break;
		}

		case "wander_ped": {
			child = setupWanderPedDiv(workflowItem);
			break;
		}

		case "set_doorlock": {
			child = setupSetDoorlockDiv(workflowItem);
			break;
		}

		case "teleport_players": {
			child = setupTeleportPlayersDiv(workflowItem);
			break;
		}

		case "goto_coordinates": {
			child = setupGoToCoordinates(workflowItem);
			break;
		}

		case "enter_vehicle": {
			child = setupEnterVehicle(workflowItem);
			break;
		}

		case "deliver_vehicle": {
			child = setupDeliverVehicle(workflowItem);
			break;
		}

		case "pickup_object": {
			child = setupPickupObject(workflowItem);
			break;
		}

		case "blowup_entity": {
			child = setupBlowupEntity(workflowItem);
			break;
		}

		case "kill_ped": {
			child = setupKillPed(workflowItem);
			break;
		}

		case "protect_ped": {
			child = setupProtectPed(workflowItem);
			break;
		}

		case "play_minigame": {
			child = setupPlayMinigame(workflowItem);
			break;
		}

		case "leave_area": {
			child = setupLeaveArea(workflowItem);
			break;
		}

		case "talk_to_ped": {
			child = setupTalkToPed(workflowItem);
			break;
		}

		case "play_animation": {
			child = setupPlayAnimation(workflowItem);
			break;
		}

		case "survive": {
			child = setupSurvive(workflowItem);
			break;
		}

		case "vehicle_attack": {
			child = setupVehicleAttack(workflowItem);
			break;
		}

		case "wait_in_coordinates": {
			child = setupWaitInCoordinates(workflowItem);
			break;
		}
	}

	parent.append(child);
	$("#stage-elements-container").append(parent);
}

function loadWorkflowItems(stageData) {
	if(stageData.startingActions) {
		stageData.startingActions.forEach(async function(workflowItem) {
			await createWorkflowItem(stageData.uniqueId, workflowItem, "startingActions");
		});
	}

	if(stageData.endingActions) {
		stageData.endingActions.forEach(async function(workflowItem) {
			await createWorkflowItem(stageData.uniqueId, workflowItem, "endingActions");
		});
	}

	if(stageData.tasks) {
		stageData.tasks.forEach(async function(workflowItem) {
			await createWorkflowItem(stageData.uniqueId, workflowItem, "tasks");
		});
	}
}

function deleteStageUniqueId(stageUniqueId) {
	$(`.stage-options[data-stage-unique-id=${stageUniqueId}]`).remove();
	$(`.workflow-item[data-stage-unique-id=${stageUniqueId}]`).remove();
	$("#stages-list").find(`.list-group-item[data-stage-unique-id=${stageUniqueId}]`).remove();
}

function createStage(stageData={}) {
	const stageUniqueId = stageData.uniqueId || generateStaticId();
	
	const stageLabel = stageData.label || getLocalizedText("menu:new_stage");

	const stageListElementDiv = $(`		
	<li href="#" class="list-group-item list-group-item-action p-2 clickable stage-list-item" data-stage-unique-id="${stageUniqueId}">
		<span class="stage-label-in-list">${stageLabel}</span>
		<span class="d-inline-flex position-absolute" style="right: 0; top: 0; height: 100%;">
			<button type="button" class="btn py-0 btn-close my-auto me-2"></button>
		</span>
	</li>
	`);

	stageListElementDiv.find(".btn-close").click(async function() {
		const wantsToDelete = await confirmDeletion(getLocalizedText("menu:delete_stage:warning"));
		if(!wantsToDelete) return;

		deleteStageUniqueId(stageUniqueId);
	});

	stageListElementDiv.insertBefore(".create-new-stage");

	const stageOptionsDiv = $(`
	<div class="stage-options col" style="display:none" data-stage-unique-id="${stageUniqueId}">
	<div class="d-flex flex-column gap-3 justify-content-center">
		<div class="form-floating">
			<input type="text" class="form-control stage-label" placeholder="..." value="${stageLabel}" required>
			<label>${getLocalizedText("menu:stage_label")}</label>
		</div>

		<div class="form-floating">
			<input type="number" class="form-control stage-max-minutes-duration" placeholder="..." min="1" value="${stageData.maxMinutesDuration || 30}" required>
			<label>${getLocalizedText("menu:maximum_duration")}</label>
		</div>

		<div class="form-floating">
			<textarea class="form-control stage-description" placeholder="..." style="max-height: 10vh;">${stageData.description || ""}</textarea>
			<label for="mission-description">${getLocalizedText("menu:stage_description")}</label>
		</div>
	</div>
	</div>
	`);

	stageOptionsDiv.find(".stage-label").keyup(function() {
		const label = $(this).val() || "!!!!!!!!!";
		stageListElementDiv.find(".stage-label-in-list").text(label);
	});

	loadWorkflowItems(stageData);

	$("#mission-header-div").append(stageOptionsDiv);
}

$("#stages-list").click(function(event) {
	const target = $(event.target).closest(".list-group-item-action"); // So it works also if the click is on the span inside the li
	if(target.hasClass("create-new-stage")) { createStage(); return; }

	// If it's not the button, it's an existing stage
	const stageUniqueId = target.data("stageUniqueId");
	toggleStage(stageUniqueId);	
})

function changeStageUniqueId(oldIndex, newIndex) {
	let elementsWithOldIndex = {}; 
	const elements = $(`.[data-stage-unique-id]`);
	
	elements.forEach(function(element) {
		const stageUniqueId = $(element).data("stageUniqueId");
		
		if(!elementsWithOldIndex[stageUniqueId]) {
			elementsWithOldIndex[stageUniqueId] = [];
		}

		elementsWithOldIndex[stageUniqueId].push(element);
	});

	const elementsToChange = elementsWithOldIndex[oldIndex];

}

function loadStages(stages) {
	const stagesListDiv = $("#stages-list");

	// Reset
	stagesListDiv.html(`<a href="#" class="list-group-item list-group-item-action p-2 fw-bold create-new-stage">${getLocalizedText("menu:create_new_stage")}</a>`);
	resetWorkflowTypesSelection();
	$("#stage-workflow-items-selection-list").html(`<a href="#" class="list-group-item list-group-item-action p-2 disabled">${getLocalizedText("menu:select_something")}</a>`);
	$("#stage-elements-container").html("");

	$("#stages-list").sortable({
		cancel: ".create-new-stage",
		beforeStop: function( event, ui ) {
			if (!ui.item.prev().hasClass("create-new-stage")) return;

			$("#stages-list").sortable("cancel");
		},
		update: async function(event, ui) {
			const wantsToMove= await confirmDeletion(getLocalizedText("menu:move_stage:warning"));
			if(!wantsToMove) {
				$("#stages-list").sortable("cancel");
				return;
			}
		}
	});

	// Cleanup stage options (label, time, description)
	$("#mission-header-div .stage-options").remove();
	for(let stageIndex=0; stageIndex < stages.length; stageIndex++) {
		let stageData = stages[stageIndex];
		stageData.uniqueId = generateStaticId();

		createStage(stageData);
	}
}

$("#mission-can-be-repeated").change(function() {
	const isChecked = $(this).prop("checked");
	$("#mission-cooldown-hours-div").toggle(isChecked).prop("required", isChecked);
});

function editMission(id) {
	const missionInfo = missions[id];
	const missionOptions = missionInfo.options;

	let missionModal = $("#mission-modal");

	// Converts from create modal to edit modal
	missionModal.data("action", "edit");
	missionModal.data("missionId", id);

	$("#delete-mission-btn").show();
	$("#save-mission-btn").text( getLocalizedText("menu:save") );
	
	// Options
	$("#mission-label").val(missionInfo.label);
	$("#mission-description").val(missionInfo.description);
	$("#mission-minimum-players").val(missionOptions.minPlayers);
	$("#mission-maximum-players").val(missionOptions.maxPlayers);
	$("#mission-can-be-repeated").prop("checked", missionOptions.canBeRepeated).change();
	$("#mission-cooldown-hours").val(missionOptions.cooldownHours);
	$("#mission-minutes-before-cleanup").val(missionOptions.minutesBeforeCleanup);
	$("#mission-allow-multiple-sessions").prop("checked", missionOptions.allowMultipleSessions);

	// Requirements
	setRequiredMissions(missionOptions.requiredMissions);
	setAllowedJobs(missionOptions.allowedJobs);
	$("#mission-minimum-police").val(missionOptions.minimumPolice || 0);

	// Mission start
	$("#mission-start-coordinates-x").val(missionOptions.startCoordinates?.x);
	$("#mission-start-coordinates-y").val(missionOptions.startCoordinates?.y);
	$("#mission-start-coordinates-z").val(missionOptions.startCoordinates?.z);
	$("#mission-start-customize-blip-btn").data("blipData", missionOptions.blipData);
	$("#mission-start-customize-marker-btn").data("markerData", missionOptions.markerData);
	$("#mission-start-customize-ped-btn").data("pedData", missionOptions.pedData);

	// Stages
	loadStages(missionInfo.stages);

	missionModal.modal("show");
}

function setDefaultDataOfMission() {
	// Options
	$("#mission-label").val("");
	$("#mission-description").val("");
	$("#mission-minimum-players").val(1);
	$("#mission-maximum-players").val(4);
	$("#mission-can-be-repeated").prop("checked", true).change();
	$("#mission-cooldown-hours").val(0);
	$("#mission-minutes-before-cleanup").val(5);
	$("#mission-allow-multiple-sessions").prop("checked", true);
	
	// Requirements
	setRequiredMissions([]);
	setAllowedJobs(false);
	$("#mission-minimum-police").val(0);

	// Mission start
	$("#mission-start-coordinates-x").val("");
	$("#mission-start-coordinates-y").val("");
	$("#mission-start-coordinates-z").val("");
	$("#mission-start-customize-blip-btn").data("blipData", getDefaultBlipCustomization() );
	$("#mission-start-customize-marker-btn").data("markerData", getDefaultMarkerCustomization() );
	$("#mission-start-customize-ped-btn").data("pedData", getDefaultPedCustomization() );

	loadStages([]);
	toggleStage(null);
}

$("#new-mission-btn").click(function() {
	let missionModal = $("#mission-modal");

	// Converts from edit modal to create modal
	missionModal.data("action", "create");
	
	$("#delete-mission-btn").hide();
	$("#save-mission-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfMission();

	missionModal.modal("show");
})

function getStages() {
	let stages = [];

	$(".stage-list-item").each(function(index, element) {
		const stageUniqueId = $(element).data("stageUniqueId");
		const stageOptionsDiv = $(`#mission-header-div [data-stage-unique-id='${stageUniqueId}']`);

		const stageData = {
			label: $(stageOptionsDiv).find(".stage-label").val(),
			maxMinutesDuration: parseInt( $(stageOptionsDiv).find(".stage-max-minutes-duration").val() ),
			description: $(stageOptionsDiv).find(".stage-description").val(),

			startingActions: getWorkflowItemsDataForStage(stageUniqueId, "startingActions"),
			endingActions: getWorkflowItemsDataForStage(stageUniqueId, "endingActions"),
			tasks: getWorkflowItemsDataForStage(stageUniqueId, "tasks"),
		}

		stages.push(stageData);
	});

	return stages;
}

function clearHelperErrorsInForm(form) {
	form.find(".legend-circle").remove();
}

function showErrorsInForm(form) {
	clearHelperErrorsInForm(form);

	form.find(":invalid").each(function(index, element) {
		// Verify if the issue is on stage options (label, description, max duration)
		const stageUniqueId = $(element).closest(".stage-options").data("stageUniqueId") || $(element).closest(".workflow-item").data("stageUniqueId");
		if(!stageUniqueId) return;
		
		const stageElement = $(`#stages-list [data-stage-unique-id='${stageUniqueId}']`);

		// Check if the stage has a legend-circle
		if(stageElement.find(".legend-circle").length == 0) {
			stageElement.prepend(`<span class="legend-circle bg-danger"></span>`);
		}

		const workflowType = $(element).closest(".workflow-item").data("workflowType");

		// Check if the workflow type has a legend-circle
		if(!workflowType) return;
		const workflowTypeElement = $(`#stage-workflow-types-selection-list [data-workflow-type='${workflowType}']`);

		if(workflowTypeElement.find(".legend-circle").length == 0) {
			workflowTypeElement.prepend(`<span class="legend-circle bg-danger"></span>`);
		}

		// Check if the workflow item has a legend-circle
		const workflowItemIndex = $(element).closest(".workflow-item").data("workflowItemIndex");
		const workflowItemElement = $(`#stage-workflow-items-selection-list [data-workflow-item-index='${workflowItemIndex}']`);

		if(workflowItemElement.find(".legend-circle").length > 0) return;

		workflowItemElement.prepend(`<span class="legend-circle bg-danger"></span>`);
	})
}

$("#mission-form").submit(async function(event) {
	if(isThereAnyErrorInForm(event)) {
		showErrorsInForm($(this));
		return;
	};

	let missionModal = $("#mission-modal");
	let action = missionModal.data("action");

	let missionInfo = {
		label: $("#mission-label").val(),
		description: $("#mission-description").val(),
		
		options: {
			minPlayers: parseInt( $("#mission-minimum-players").val() ),
			maxPlayers: parseInt( $("#mission-maximum-players").val() ),
			canBeRepeated: $("#mission-can-be-repeated").prop("checked"),
			cooldownHours: parseInt( $("#mission-cooldown-hours").val() ),
			minutesBeforeCleanup: $("#mission-minutes-before-cleanup").val(),
			allowMultipleSessions: $("#mission-allow-multiple-sessions").prop("checked"),
			startCoordinates: {
				x: parseFloat( $("#mission-start-coordinates-x").val() ),
				y: parseFloat( $("#mission-start-coordinates-y").val() ),
				z: parseFloat( $("#mission-start-coordinates-z").val() ),
			},
			blipData: $("#mission-start-customize-blip-btn").data("blipData"),
			markerData: $("#mission-start-customize-marker-btn").data("markerData"),
			pedData: $("#mission-start-customize-ped-btn").data("pedData"),

			// Requirements
			requiredMissions: $("#mission-required-missions").data("requiredMissions"),
			allowedJobs: $("#mission-allowed-jobs").data("allowedJobs"),
			minimumPolice: parseInt( $("#mission-minimum-police").val() )
		},

		stages: getStages()
	}
	
	let success = null;

	switch(action) {
		case "create": {
			success = await $.post(`https://${resName}/createMission`, JSON.stringify(missionInfo));
			break;
		}

		case "edit": {
			success = await $.post(`https://${resName}/updateMission`, JSON.stringify({missionId: missionModal.data("missionId"), missionInfo: missionInfo}));
			break;
		}
	}

	if(!success) return;

	missionModal.modal("hide");
	loadMissions();
})

$("#delete-mission-btn").click(async function() {
	if(!await confirmDeletion()) return;
	let missionModal = $("#mission-modal");
	let missionId = missionModal.data("missionId");

	const success = await $.post(`https://${resName}/deleteMission`, JSON.stringify({missionId: missionId}));
	if(!success) return;

	missionModal.modal("hide");
	loadMissions();
});

$("#mission-start-choose-coords-btn").click(async function() {
	const data = await chooseCoords();
	if(!data) return;

	$("#mission-start-coordinates-x").val(data.coords.x);
	$("#mission-start-coordinates-y").val(data.coords.y);
	$("#mission-start-coordinates-z").val(data.coords.z);
});

$("#mission-start-customize-blip-btn").click(async function() {
	const oldBlipData = $(this).data("blipData");

	const blipData = await blipDialog(oldBlipData);
	if(!blipData) return;

	$(this).data("blipData", blipData);
});

$("#mission-start-customize-marker-btn").click(async function() {
	const oldMarkerData = $(this).data("markerData");

	const markerData = await markerDialog(oldMarkerData);
	if(!markerData) return;

	$(this).data("markerData", markerData);
});

$("#mission-start-customize-ped-btn").click(async function() {
	const oldPedData = $(this).data("pedData");

	const pedData = await pedDialog(oldPedData);
	if(!pedData) return;

	$(this).data("pedData", pedData);
});

function setRequiredMissions(requiredMissions=[]) {
	$("#mission-required-missions").val(requiredMissions.join(", ")).data("requiredMissions", requiredMissions);

	if(requiredMissions.length == 0) {
		$("#mission-required-missions").val(getLocalizedText("menu:none"));
	}
}

$("#mission-required-missions-choose-btn").click(async function() {
	const oldRequiredMissions = $("#mission-required-missions").data("requiredMissions") || [];

	const elements = Object.values(missions).map(function(mission) {
		return {label: mission.label, value: mission.id};
	});

	const requiredMissionsIds = await listArrayDialog(
		getLocalizedText("menu:choose"),
		getLocalizedText("menu:search"),
		elements,
		oldRequiredMissions,
		"N\\A"
		);
	if(!requiredMissionsIds) return;

	setRequiredMissions(requiredMissionsIds);
});

function setAllowedJobs(allowedJobs = false) {
	$("#mission-allowed-jobs").data("allowedJobs", allowedJobs);

	$("#mission-allowed-jobs").tooltip("dispose");

	if(allowedJobs === false) {
		$("#mission-allowed-jobs").val(getLocalizedText("menu:all_jobs_allowed"));
		return;
	}

	const jobsLabel = Object.keys(allowedJobs).join(", ");
	
	$("#mission-allowed-jobs").val(jobsLabel);

	// Add tooltip 
	$("#mission-allowed-jobs").attr("title", jobsLabel);
	$("#mission-allowed-jobs").tooltip();
}

$("#mission-allowed-jobs-choose-btn").click(async function() {
	const oldAllowedJobs = $("#mission-allowed-jobs").data("allowedJobs");
	const newAllowedJobs = await jobsDialog(oldAllowedJobs);
	setAllowedJobs(newAllowedJobs);
});

// [[ NEXUS ]]
const voteInstanceRater = raterJs({
	starSize: 35,
	element: document.querySelector("#vote-instance-rater"),
	rateCallback: async function rateCallback(rating, done) {
		const instanceId = $("#nexus-modal").data("instance").id;
		const success = await $.post(`https://${resName}/nexus/rateInstance`, JSON.stringify({rating, instanceId}));
		if(success) voteInstanceRater.setRating(rating);

		done();
	}
});

const averageInstanceVotes = raterJs({
	starSize: 20,
	readOnly: true,
	element: document.querySelector("#nexus-modal-instance-average-rating"),
});

$("#nexus-import-instance-btn").click(async function() {
	const instance = $("#nexus-modal").data("instance");
	const id = instance.id;

	const mappedObjectsNames = await objectsMapperDialog(instance.requiredItemsNames);
	if(!mappedObjectsNames) return;

	const response = await $.post(`https://${resName}/nexus/importInstance`, JSON.stringify({id, mappedObjectsNames}));
	$("#nexus-modal").modal("hide");

	if(response === true) reloadAllData();

	showServerResponse(response);
});

let nexusDataTable = $("#nexus-table").DataTable({
	"lengthMenu": [5, 10, 15],
	"pageLength": 15,
	"order": [[7, 'desc'], [4, 'desc'], [5, 'desc']], 
	"createdRow": function (row, data, index) {
		$('td', row).css('white-space', 'nowrap').addClass("py-3");
		$(row).addClass("clickable");
		$(row).click(function () {
			const instance = $(this).data("instance");
			showInstance(instance);
			$("#nexus-modal").modal("show");
		});
	},
	"columnDefs": [{ "defaultContent": "???", "targets": "_all" }]
});
  
function showInstance(instance) {
	$("#nexus-modal").data("instance", instance);

	$("#nexus-modal-instance-listing-label").text(instance.label);
	$("#nexus-instance-content-type").text(instance.type);
	$("#nexus-modal-instance-description").text(instance.description || getLocalizedText("menu:nexus:no_description"));
	$("#nexus-modal-instance-author").text(instance.rawAuthor);
	$("#nexus-instance-stages-amount").text(instance.minifiedContent.stages.length);

	// Votes
	if(instance?.votes?.total > 0) {
		averageInstanceVotes.setRating(instance?.votes.averageRating);
	} else {
		averageInstanceVotes.setRating(0);
	}

	$("#nexus-modal-instance-total-votes").text(instance.votes?.total || 0);

	$("#nexus-modal-instance-content").html(""); // Clear content
	for(let i=0; i<instance.minifiedContent.stages.length; i++) {
		const stageData = instance.minifiedContent.stages[i];
		const stageDescription = stageData.description ? ` - ${stageData.description}` : "";
		const stageDiv = $(`
		<div class="stage-div mb-5">
			<h3 class="mb-0">${stageData.label.toUpperCase()}${stageDescription}</h3>

			<div class="nexus-tasks-list"></div>
		</div>
		`);

		// Tasks
		stageData.tasks.forEach(task => {
			const taskDescription = task.description ? ` - ${task.description}` : "";
			const taskDiv = $(`<p class="mb-0">${task.label}${taskDescription}</p>`);

			stageDiv.find(".nexus-tasks-list").append(taskDiv);
		});

		$("#nexus-modal-instance-content").append(stageDiv);
	}

	// This server vote
	voteInstanceRater.setRating(0);
}

$("#upload-to-nexus-btn").click(async function() {
	let dataToChooseFrom = await $.post(`https://${resName}/getAllMissions`);
	const type = "mission";

	let elements = [];

	Object.values(dataToChooseFrom).forEach(data => {
		elements.push({
			value: data.id,
			label: data.id + " - " + (data.label || data.name)
		});
	})
	
	const selectedData = await listDialog(getLocalizedText("menu:nexus:data_to_share"), getLocalizedText("menu:search"), elements, getLocalizedText("menu:no_missions_created"))
	if(!selectedData) return;

	$("#nexus-modal-upload").data("selectedData", selectedData);
	$("#nexus-modal-upload").data("dataType", type);

	$("#nexus-upload-label").val("");
	$("#nexus-upload-description").val("");

	$("#nexus-upload-accept-tos").prop("checked", false);
	
	$("#nexus-modal-upload").modal("show");
});

$("#nexus-upload-form").submit(async function(event) {
	if(isThereAnyErrorInForm(event)) return;

	const dataToUpload = {
		type: $("#nexus-modal-upload").data("dataType"),
		id: $("#nexus-modal-upload").data("selectedData"),
		label: $("#nexus-upload-label").val(),
		description: $("#nexus-upload-description").val(),
	}

	const result = await $.post(`https://${resName}/nexus/uploadData`, JSON.stringify(dataToUpload));

	if(result == true) {
		swal("Success", getLocalizedText("menu:nexus:upload_success"), "success");
		resetNexus();
	} else {
		swal("Error", result, "error");
	}

	$("#nexus-modal-upload").modal("hide");
});

$("#enter-in-nexus-btn").click(async function() {
	$("#nexus-login").find(".spinner-border").show();
	$("#enter-in-nexus-label").text("...");

	const sharedData = await $.get(`https://${resName}/nexus/getSharedData`);
	if(!sharedData) {
		swal("Error", getLocalizedText("menu:nexus:not_available"), "error");
		resetNexus();
		return;
	} 
	
	nexusDataTable.clear()

	Object.values(sharedData).forEach(instance => {
		const roundedAverageRating = instance?.votes?.averageRating ? Math.round(instance.votes.averageRating) : 0;
		const ratingStars = instance?.votes?.total ? "⭐".repeat(roundedAverageRating) : getLocalizedText("menu:nexus:not_rated");
		const limitedDescription = instance.description?.length > 50 ? instance.description.substring(0, 50) + "..." : instance.description;
		const stagesCount = instance.minifiedContent.stages.length;

		const rawRow = nexusDataTable.row.add( [instance.label, limitedDescription, stagesCount, ratingStars, instance.votes?.total || 0, instance.downloadCount, instance.author, (instance.featured ? "💡" : "⚪")] );

		const rowDiv = $(rawRow.node());
		$(rowDiv).data("instance", instance);
	})

	nexusDataTable.draw();

	$("#nexus-login").hide();
	$("#nexus-container").show();
})

function resetNexus() {
	$("#nexus-login").show();
	$("#nexus-login").find(".spinner-border").hide();
	$("#enter-in-nexus-label").text("Enter in Nexus");

	$("#nexus-container").hide();
}

/*
███████ ████████  █████  ████████ ███████ 
██         ██    ██   ██    ██    ██      
███████    ██    ███████    ██    ███████ 
     ██    ██    ██   ██    ██         ██ 
███████    ██    ██   ██    ██    ███████ 
*/

let currentPage = 0;
const itemsPerPage = 10;

const MissionsStatisticsChart = new Chart(document.getElementById('missions-statistics-canvas').getContext('2d'), {
	type: 'bar',

	data: {
		labels: "Missions",
		datasets: []
	},

	options: {
		scales: {
			y: {
				beginAtZero: true
			}
		},

		devicePixelRatio: 2,
	}
});

function loadAllMissionsLikesDislikes(statistics) {
    const labels = statistics.map(stat => `${missions[stat.template_id].label}`);
    const likesData = statistics.map(stat => stat.likes);
    const dislikesData = statistics.map(stat => stat.dislikes);

    MissionsStatisticsChart.data = {
        labels: labels,
        datasets: [{
            label: 'Likes',
            data: likesData,
            backgroundColor: 'rgba(46, 204, 113,0.5)',
            borderColor: 'rgba(46, 204, 113,1.0)',
            borderWidth: 1
        }, {
            label: 'Dislikes',
            data: dislikesData,
            backgroundColor: 'rgba(192, 57, 43,0.5)',
            borderColor: 'rgba(192, 57, 43,1.0)',
            borderWidth: 1
        }]
    };

    MissionsStatisticsChart.update();
}

function loadAllMissionsSuccessFailure(statistics) {
    const labels = statistics.map(stat => `${missions[stat.template_id].label}`);
    const successData = statistics.map(stat => stat.success_count);
    const failureData = statistics.map(stat => stat.fail_count);

    MissionsStatisticsChart.data = {
        labels: labels,
        datasets: [{
            label: 'Success',
            data: successData,
            backgroundColor: 'rgba(46, 204, 113,0.5)',
            borderColor: 'rgba(46, 204, 113,1.0)',
            borderWidth: 1
        }, {
            label: 'Failure',
            data: failureData,
            backgroundColor: 'rgba(192, 57, 43,0.5)',
            borderColor: 'rgba(192, 57, 43,1.0)',
            borderWidth: 1
        }]
    };

    MissionsStatisticsChart.update();
}

function getPaginatedData(statistics, page) {
    const start = page * itemsPerPage;
    const end = start + itemsPerPage;
    return statistics.slice(start, end);
}

function loadPaginatedData(statistics, action) {
    const paginatedStatistics = getPaginatedData(statistics, currentPage);

    if (action === "likes-dislikes") {
        loadAllMissionsLikesDislikes(paginatedStatistics);
    } else if (action === "success-failure") {
        loadAllMissionsSuccessFailure(paginatedStatistics);
    }
}

function nextPage(statistics, action) {
    const totalPages = Math.ceil(statistics.length / itemsPerPage);
    if (currentPage >= totalPages - 1) return;
	
	currentPage++;
	loadPaginatedData(statistics, action);
}

function prevPage(statistics, action) {
    if (currentPage <= 0) return;

	currentPage--;
	loadPaginatedData(statistics, action);
}

$("#statistics-prev-page-btn").click(async function() {
	const statistics = await $.post(`https://${resName}/getAllMissionsStatistics`);
	let action = $('input[type=radio][name=missions-statistics-type]:checked').val();

	prevPage(statistics, action);
});

$("#statistics-next-page-btn").click(async function() {
	const statistics = await $.post(`https://${resName}/getAllMissionsStatistics`);
	let action = $('input[type=radio][name=missions-statistics-type]:checked').val();
	
	nextPage(statistics, action);
});

$('input[type=radio][name=missions-statistics-type]').change(async function() {
	const statistics = await $.post(`https://${resName}/getAllMissionsStatistics`);
    let action = $(this).val();
	currentPage = 0;

	loadPaginatedData(statistics, action);
});

/*
████████ ██████   █████   ██████ ██   ██ ███████ ██████  
   ██    ██   ██ ██   ██ ██      ██  ██  ██      ██   ██ 
   ██    ██████  ███████ ██      █████   █████   ██████  
   ██    ██   ██ ██   ██ ██      ██  ██  ██      ██   ██ 
   ██    ██   ██ ██   ██  ██████ ██   ██ ███████ ██   ██ 
*/
function getTrackerDivSteps(instanceData) {
	const MAX_STAGES = instanceData.stages.length;
	const currentStageUniqueId = instanceData.currentStageUniqueId;

	const div = $(`
	<ul class="nav nav-pills steps col" role="tablist"></ul>
	`);

	const baseStep = $(`
	<li class="nav-item" role="presentation">
		<button class="nav-link" type="button" role="tab"></button>
	</li>
	`)

	for(let i=1; i <= MAX_STAGES; i++) {
		let currentDiv = baseStep.clone();
		currentDiv.find("button").text(i);	

		if(i < currentStageUniqueId) {
			currentDiv.addClass("visited");
		}

		if(i == currentStageUniqueId) {
			currentDiv.find(".nav-link").addClass("active");
		}

		div.append(currentDiv);
	}

	return div;
}
async function refreshMissionTracker() {
	const activeInstances = await $.post(`https://${resName}/getActiveInstances`);

	$("#missions-tracker-instances-div").empty();

	for(const instanceData of Object.values(activeInstances)) {
		const missionId = instanceData.missionId;
		const missionLabel = missions[missionId].label;

		const div = $(`
		<div>
			<h3 class="text-center">${missionLabel} - ${getLocalizedText("menu:instance")} ${instanceData.instanceId}</h3>

			<div class="secondary-div d-flex">
				<button class="btn btn-danger px-4 ms-4 abort-mission-btn" title="${getLocalizedText("menu:abort_mission")}" data-bs-toggle="tooltip" data-bs-placement="top""><i class="bi bi-trash-fill"></i></button>
			</div>
		</div>
		`);

		const stepsDiv = getTrackerDivSteps(instanceData);
		div.find(".secondary-div").prepend(stepsDiv);

		div.append("<hr>");

		div.find("[data-bs-toggle=tooltip]").tooltip();
		
		div.find(".abort-mission-btn").click(async function() {
			const wantsToAbort = await confirmDeletion();
			if(!wantsToAbort) return;

			const success = await $.post(`https://${resName}/abortMission`, JSON.stringify({instanceId: instanceData.instanceId}));
			if(!success) return;

			refreshMissionTracker();
		})

		$("#missions-tracker-instances-div").append(div);
	}
}
$("#refresh-missions-tracker-btn").click(refreshMissionTracker);


/*
 █████  ██    ██ ██████  ██  ██████  
██   ██ ██    ██ ██   ██ ██ ██    ██ 
███████ ██    ██ ██   ██ ██ ██    ██ 
██   ██ ██    ██ ██   ██ ██ ██    ██ 
██   ██  ██████  ██████  ██  ██████  
*/

const soundQueue = [];
let currentSound = null;

window.addEventListener("message", function(event) {
	const data = event.data;
	
	if(data.action !== "playPedAudio") return;

	const sound = document.createElement("audio");
	sound.src = `../audio/${data.audioFile}`;
	sound.volume = 0.2;

	const playNextSound = () => {
		if (soundQueue.length > 0) {
			currentSound = soundQueue.shift();
			currentSound.play();
			currentSound.onended = playNextSound;
		} else {
			currentSound = null;
		}
	};

	if (currentSound && !currentSound.ended) {
		soundQueue.push(sound);
	} else {
		currentSound = sound;
		sound.play();
		sound.onended = playNextSound;
	}
});