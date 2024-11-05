// Messages received by client
window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {
		case "openShowroom": {
			openShowroom(data.vehiclesData, data.dealershipId, data.dealershipData, data.modelsPrices, data.type);

			break;
		}
	}
})

async function getClassLabelFromId(categoryId) {
    return await $.post(`https://${resName}/getClassLabelFromId`, JSON.stringify({categoryId}));
}

async function getVehicleLabelFromModel(model) {
    return await $.post(`https://${resName}/getVehicleLabelFromModel`, JSON.stringify({model}));
}

async function openShowroom(vehiclesData, dealershipId, dealershipData, modelsPrices, type) {
	CATEGORIES_DATA = vehiclesData || CATEGORIES_DATA;
	CURRENT_DEALERSHIP_ID = dealershipId || CURRENT_DEALERSHIP_ID;
	CURRENT_DEALERSHIP_DATA = dealershipData || CURRENT_DEALERSHIP_DATA;
	CURRENT_UI_TYPE = type || CURRENT_UI_TYPE;
	MODELS_PRICES = modelsPrices || MODELS_PRICES;
	
    showSelectionPage();
}

function exitShowroom() {
	$(".main-container").html("").css("background-color", "rgba(11,11,11,0.9)");//.css("background", "url(../assets/img/BackgroundOverlay.png);");
	$.post(`https://${resName}/exitShowroom`, JSON.stringify({}));
	display(false);
}