// const resName = GetParentResourceName();

const CURRENCY_SYMBOL = "$";

let CATEGORIES_DATA = null;
let CURRENT_DEALERSHIP_ID = null;
let CURRENT_DEALERSHIP_DATA = null;
let CURRENT_UI_TYPE = null; // Used to know what buttons to show (for example difference between auto dealership and order vehicles in player dealership)
let MODELS_PRICES = {}; // Used when a player checks the showroom of a player owned dealership, for custom prices set by employees

SELECTED_VEHICLE = {}
let SELECTED_COLOR = 111; // GTA Color

let currentActiveCategory = null;

function display(bool) {
	if (bool) {
		$(".main-container").show();
	} else {
		$(".main-container").hide();

		$.post(`https://${resName}/exitDealership`);
	}
}

async function showSelectionPage(categoryToShow) {
	const div = $(`
		<div class="header">
			<div class="hrec hrec-s"></div>
			<div class="selected-vehicle" id="header-title"><p>${getLocalizedText("menu:dealership")}</p></div>
			<div class="hrec vehicle-preview"></div>
			<ul class="categories vehicle-preview"></ul>
			<div class="hrec"></div>
			<div class="exit-btn" id="exit"><p>${getLocalizedText("menu:exit_dealership")}</p></div>
			<div class="hrec hrec-s"></div>
		</div>

		<div class="selection-page">
			<ul class="vehicle-list"></ul>
		</div>

	`)

	$(div).find(".exit-btn").click(function() {
		$(".selection-page").empty();
		$(".categories").remove();

		exitShowroom();
	});

	$(".main-container").html(div);

	// Load Categories
	await loadCategories();
	$(`#all`).addClass('active');

	// Category selection
	$('.main-container .category').click(async function() {
		const categoryId = $(this).attr('id');
		setActiveCategory(categoryId);
	});

	setActiveCategory(categoryToShow || "all");

	display(true);
}

async function setActiveCategory(categoryId) {
	$(".main-container .header ul.categories li.category").removeClass('active');
	$(`#${categoryId}`).addClass('active');

	let filteredList = await getCategoryVehicles(categoryId);
	$(".vehicle-list").empty();

	loadVehicleList(filteredList);

	currentActiveCategory = categoryId;
}

async function getCategoryVehicles(categoryId) {
    let vehicles = [];

    if (categoryId === "all") {
        for (const category of CATEGORIES_DATA) {
            const categoryLabel = await getClassLabelFromId(category.categoryId);
            const vehiclesWithLabel = category.vehicles.map(vehicle => ({
                ...vehicle,
                categoryLabel
            }));
			
            vehicles.push(...vehiclesWithLabel);
        }
    } else {
        const category = CATEGORIES_DATA.find(cat => cat.categoryId === categoryId);
        if (!category) return vehicles;

		const categoryLabel = await getClassLabelFromId(categoryId);
		vehicles = category.vehicles.map(vehicle => ({
			...vehicle,
			categoryLabel
		}));
	}

    return vehicles;
}


function loadVehicleList(vehiclesList) {
	vehiclesList.forEach(async vehicleData => {
		const vehicleLabel = await $.post(`https://${resName}/getVehicleLabelFromModel`, JSON.stringify({model: vehicleData.id}));

		let modelPrice = vehicleData.price;

		if(CURRENT_UI_TYPE == "player") {
			modelPrice = MODELS_PRICES[vehicleData.id] ? MODELS_PRICES[vehicleData.id] : vehicleData.price;
		}

		const div = $(`
			<li class="vehicle-element" id="${vehicleData.id}">
				<div class="vehicle-head">
					<div class="vehicle-category"><p>${upCase(vehicleData.categoryLabel)}</p></div>
					<div class="hrec"></div>
					<div class="vehicle-preview-btn"><img src="./assets/svg/preview.svg"></div>
				</div>
				<img src="../_vehicles_images/${vehicleData.id}.webp" class="vehicle-img">
				<div class="vehicle-bottom">
					<div class="vehicle-info">
						<p class="vehicle-name">${upCase(vehicleLabel)}</p>
						<p class="vehicle-price">${formatNumber(modelPrice)}</p>
					</div>
					<div class="hrec"></div>
					</div>
			</li>
		`);

		const clickableElement = div.find(".vehicle-preview-btn, .vehicle-img");

		if(CURRENT_UI_TYPE == "editModelsPrices") {
			clickableElement.click(async function () {
				const newPrice = await askInput(getLocalizedText("menu:price"), getLocalizedText("menu:choose_the_new_price"), "number", "5000");

				$.post(`https://${resName}/updatePriceForModelInStock`, JSON.stringify({model: vehicleData.id, dealershipId: CURRENT_DEALERSHIP_ID, newPrice}));
			});
		} else {
			clickableElement.click(function () {
				vehicleData.label = vehicleLabel;
				SELECTED_VEHICLE = vehicleData;
				showPreviewPage(vehicleData)
			})
		}

		$(".selection-page .vehicle-list").append(div);

		// removed info button 
		// <div class="vehicle-info-btn"><img src="./assets/svg/info.svg"></div>
	});
}

function refreshButtonsForType(div) {
	const CAN_DO_TEST_DRIVE = (CURRENT_UI_TYPE == "auto" || CURRENT_UI_TYPE == "player") && CURRENT_DEALERSHIP_DATA.testDriveData.isActive;

	div.find(".test-drive-btn").toggle(CAN_DO_TEST_DRIVE);
	div.find(".loan-btn").toggle(CURRENT_UI_TYPE == "auto" && CURRENT_DEALERSHIP_DATA.loanData.isActive);

	div.find(".price-btn").toggle(CURRENT_UI_TYPE != "player")

	div.find(".sell-to-player-btn").toggle(CURRENT_UI_TYPE == "stock");
	div.find(".loan-to-player-btn").toggle(CURRENT_UI_TYPE == "stock");
	div.find(".display-vehicle-btn").toggle(CURRENT_UI_TYPE == "stock");
}

function changeSelectedColor(color) {
	SELECTED_COLOR = color;

	$.post(`https://${resName}/changeVehicleColor`, JSON.stringify({color: SELECTED_COLOR}));
}

async function showPreviewPage(vehicleData) {
	const oldBackground = $(".main-container").css("background");
	$(".main-container").css("background", "");

	$.post(`https://${resName}/showCarInShowroom`, JSON.stringify({model: vehicleData.id}));

	const div = $(`
		<div class="header">
			<div class="hrec hrec-s"></div>
			<div class="selected-vehicle" id="header-title"><p>${vehicleData.label}</p></div>
			<div class="hrec vehicle-preview"></div>
			<div class="hrec"></div>
			<div class="exit-btn" id="back"><p>${getLocalizedText("menu:go_back")}</p></div>
			<div class="hrec hrec-s"></div>
		</div>

		<ul class="left-side-wrap vehicle-preview">
			<div class="left-side-element-header">
				<img src="./assets/svg/stats_icon.svg">
				<p>${getLocalizedText("menu:vehicle_stats")}</p>
				<div class="clickable class-statistic-button" data-bs-toggle="tooltip" data-bs-title="${getLocalizedText("menu:vehicle_statistic_compared_with_same_class")}"><i class="bi bi-arrow-repeat"></i></div>
				<div class="clickable global-statistic-button" data-bs-toggle="tooltip" data-bs-title="${getLocalizedText("menu:vehicle_statistic_compared_globally")}"><i class="bi bi-globe2"></i></div>
			</div>
			<ul class="vehicle-stats left-side-element"></ul>
			<ul class="color-palette left-side-element">
				<div class="left-side-element-header"><img src="./assets/svg/colors_icon.svg"><p>${getLocalizedText("menu:color_palette")}</p></div>

				<ul class="vehicle-color-list">
					<li class="vehicle-color" data-color="#000000" data-gta-color="0"></li>
					<li class="vehicle-color" data-color="#FFFFFF" data-gta-color="111"></li>
					<li class="vehicle-color" data-color="#808080" data-gta-color="13"></li>
					<li class="vehicle-color" data-color="#0000FF" data-gta-color="83"></li>
					<li class="vehicle-color" data-color="#FFFF00" data-gta-color="42"></li>
					<li class="vehicle-color" data-color="#A020F0" data-gta-color="148"></li>				
				</ul>
			</ul>

		<ul class="total-price left-side-element">
				<div class="left-side-element-header"><img src="./assets/svg/price_icon.svg"><p>${getLocalizedText("menu:total_price")}</p></div>
				<li class="price-btn" id="buy"><p>${formatNumber(vehicleData.price)}</p></li>
				<li class="test-drive-btn centralized-flex-element" id="test"><p>Test Drive</p><span class="test">${getLocalizedText("menu:try_now")}</span></li>
				<li class="loan-btn centralized-flex-element" id="rent"><p>${getLocalizedText("menu:loan")}</p><span class="loan-price"></span></li>

				<li class="sell-to-player-btn centralized-flex-element"><p>${getLocalizedText("menu:sell_to_player")}</p></li>
				<li class="loan-to-player-btn centralized-flex-element"><p>${getLocalizedText("menu:loan_to_player")}</p></li>
				<li class="display-vehicle-btn centralized-flex-element"><p>${getLocalizedText("menu:display_vehicle")}</p></li>
			</ul>
		</ul>

		<div class="rotate-vehicle vehicle-preview p-5">
			<img src="./assets/svg/rotate_icon.svg" class="rotate-img">
			<p class="fs-1">${getLocalizedText("menu:free_visual")}</p>
		</div>
	`)

	let lastVehicleColorLi = div.find("li.vehicle-color:last-child");
	
	lastVehicleColorLi.click(function() {
		var hiddenColorPicker = div.find(".color-picker");
		hiddenColorPicker.click();
	})

	div.find(".vehicle-color").each(function () {
		const color = $(this).data('color');
		$(this).css('background-color', color);
	});

	refreshButtonsForType(div);

	// Vehicle Name
	$(".main-container").html(div);

	div.find(".class-statistic-button").click(function () {
		loadVehicleStats(vehicleData.id, "class");
	}).tooltip();

	div.find(".global-statistic-button").click(function () {
		loadVehicleStats(vehicleData.id, "category");
	}).tooltip();

	$(".main-container .header .exit-btn#back").click(function () {
		$(".main-container").css("background", oldBackground);
		showSelectionPage(currentActiveCategory);
	});
	
	// Color Selection
	$(".main-container .left-side-wrap ul.vehicle-color-list li.vehicle-color").click((function () {
		color = $(this).data('gtaColor');
		changeSelectedColor(color);
	}));

	$(".rotate-vehicle").click(async function () {
		const oldBackground = $(".main-container").css("background");
		$(".main-container").css("background", "transparent");
		await $.post(`https://${resName}/freeVisual`); // when await finishes, the player ended watching it
		$(".main-container").css("background", oldBackground);
	});

	// Load Stats
	loadVehicleStats(vehicleData.id);

	div.find(".test-drive-btn").click(function () {
		$.post(`https://${resName}/dealerships-testDrive`, JSON.stringify({vehicleName: vehicleData.id, dealershipId: CURRENT_DEALERSHIP_ID}));
	});

	if(CURRENT_UI_TYPE == "auto" || CURRENT_UI_TYPE == "order") {
		div.find(".price-btn").click(function () {
			displayNotification(CURRENT_UI_TYPE == "auto" ? "buy" : "order", vehicleData.label, vehicleData.price);
		});
	}

	// Get loan price from the vehicle price and the loanData percentage
	const loanPrice = vehicleData.price/100 * CURRENT_DEALERSHIP_DATA.loanData.percentage;
	div.find(".loan-price").text(`${formatNumber(loanPrice)}`);

	div.find(".loan-btn").click(function () {
		displayNotification("loan", vehicleData.label, loanPrice);
	});

	div.find(".sell-to-player-btn").click(async function () {
		exitShowroom();
		$.post(`https://${resName}/sellToPlayerFromStock`, JSON.stringify({plate: vehicleData.plate, dealershipId: CURRENT_DEALERSHIP_ID}));
	});

	div.find(".loan-to-player-btn").click(function () {
		exitShowroom();
		$.post(`https://${resName}/loanToPlayerFromStock`, JSON.stringify({plate: vehicleData.plate, dealershipId: CURRENT_DEALERSHIP_ID}));
	});

	div.find(".display-vehicle-btn").click(function () {
		exitShowroom();
		$.post(`https://${resName}/displayVehicleFromStock`, JSON.stringify({plate: vehicleData.plate, dealershipId: CURRENT_DEALERSHIP_ID}));
	});
}

function showBuyPage(dealershipInfo) {
	CURRENT_DEALERSHIP_ID = dealershipInfo.id;

	const buyPage = $(`
	<div class="buy-container">
		<div class="buy-preview">
			<img src="assets/img/dealership.png" class="buy-preview-img">
			<div class="img-overlay"></div>
			<div class="information">
				<p class="dealership-label">${dealershipInfo.label} no. ${dealershipInfo.id}</p>
				<p class="dealership-street">${dealershipInfo.street}</p>
			</div>
			<!-- <div class="preview-btn"><p>Preview</p></div> -->
		</div>
		<div class="buy-information-container">
			<div class="buy-description buy-info-element">
				<div class="information-header"><img src="./assets/svg/price_icon.svg"><p>${getLocalizedText("menu:description")}</p></div>
				<p class="description-text">${getLocalizedText("menu:buy_dealership_description")}</p>
			</div>
			<div class="buy-owner buy-info-element">
				<div class="information-header"><img src="./assets/svg/price_icon.svg"><p>${getLocalizedText("menu:owner")}</p></div>
				<p class="description-text">${getLocalizedText("menu:no_owner_yet")}</p>
			</div>
			<div class="buy-purchase buy-info-element">
				<div class="information-header"><img src="./assets/svg/price_icon.svg"><p>${getLocalizedText("menu:total_price")}</p></div>
				<div class="purchase-btn"><p>${formatNumber(dealershipInfo.data.price)}</p></div>
				<div class="resell-element"><p>Resell (${dealershipInfo.data.resellPercentage}%)</p><span>${formatNumber(dealershipInfo.data.price * (dealershipInfo.data.resellPercentage / 100))}</span></div>
				<!-- <div class="salary-element"><p>Average Salary</p><span>${formatNumber(0)}</span></div> -->
			</div>
		</div>
	</div>
	`);
	$(".main-container .buy-container").remove();
	$(".main-container").append(buyPage);

	$(".buy-container .buy-preview .preview-btn").click(function () {
		// $.post(`https://${resName}/previewDealership`, JSON.stringify({dealershipInfo}));
	});

	$(".buy-container .purchase-btn").click(function () {
		$(".preview-btn").hide();
		$(".buy-container").css("opacity", ".2");
		displayNotification("purchase-dealership", dealershipInfo.label, dealershipInfo.data.price);
	});
}

$(".main-container .header .exit-btn#exit").click(function () {
	display(false);
});

async function loadCategories() {
    $(".categories").append(`
        <li class="category" id="all">${upCase(getLocalizedText("menu:all"))}</li>      
    `);

    for (const categoryData of CATEGORIES_DATA) {
        const categoryId = categoryData.categoryId;
        const categoryLabel = await getClassLabelFromId(categoryId);

        $(".categories").append(`
            <li class="category" id="${categoryId}">${upCase(categoryLabel)}</li>      
        `);
    }
}

async function loadVehicleStats(vehicleModel, compareWith = "global") {
	const STATS = await $.post(`https://${resName}/getVehicleModelStats`, JSON.stringify({model: vehicleModel, compareWith}));
	$(".main-container .vehicle-stats").html(``);
	
	// Load Vehicle Stats
	Object.entries(STATS).forEach(([statistic, rating]) => {
		const ratingPoints = '<li class="rating-point"></li>'.repeat(7);

		$(".main-container .vehicle-stats").append(`
			<li class="vehicle-stat-element centralized-flex-element" id="${statistic}">
				<p>${getLocalizedText("menu:statistic:" + statistic)}</p>
				<ul class="rating">${ratingPoints}</ul>
			</li>
		`);

		$(`#${statistic} .rating li:lt(${rating})`).addClass('active');
	});
}

function formatNumber(num) {
	if (isNaN(num)) return getLocalizedText("menu:price_not_set");

	return CURRENCY_SYMBOL + num.toLocaleString('en-US');
}

function upCase(str) {
	return str.charAt(0).toUpperCase() + str.slice(1);
}

function rotateVehicle(direction) {
	console.log(`Rotating vehicle to the ${direction}`);
	// $.post(`https://${resName}/rotateVehicle`, JSON.stringify({ direction }));
}

function displayNotification(type, label, price) {
	$(".main-container .dealership-notification").remove();
	$(".main-container").append(`
		<div class="dealership-notification">
			<div class="notification-bg"></div>
			<h2 class="dollar-sign">$</h2>
			<p class="notify-text">Are you sure you want to buy ${label} for $${price}?</p>
			<div class="notify-confirm-btn"><p>Confirm</p></div>
			<p class="close-notification">Close</p>
		</div>
	`);
	notifyActive = true;
	$(".dealership-notification").show();
	let msg;
	switch (type) {
		case 'purchase-dealership': {
			msg = `Are you sure you want to buy ${label} for ${formatNumber(price)}?`;
			break;
		}
		case 'buy': {
			msg = `Are you sure you want to buy ${label} for ${formatNumber(price)}?`;
			break;
		}
		case 'order': {
			msg = `Are you sure you want to order ${label} for ${formatNumber(price)}?`;
			break;
		}
		case 'loan': {
			msg = `Are you sure you want to get a loan for ${label} for ${formatNumber(price)} each ${CURRENT_DEALERSHIP_DATA.loanData.intervalDays} days?`;
			break;
		}
	}
	$(".main-container .dealership-notification .notify-text").html(msg);
	$(".main-container .dealership-notification .close-notification").click(function () {
		$(".dealership-notification").hide();
		$(".preview-btn").show();
		$(".buy-container").css("opacity", "");
	});

	$(".main-container .notify-confirm-btn").click(function () {
		switch (type) {
			case 'purchase-dealership': {
				// BUY DEALERSHIP
				$.post(`https://${resName}/buyDealership`, JSON.stringify({dealershipId: CURRENT_DEALERSHIP_ID}));
				display(false);
				break;
			}
			case 'buy': {
				// BUY VEHICLE
				$.post(`https://${resName}/dealerships-buyVehicle`, JSON.stringify({vehicleName: SELECTED_VEHICLE.id, dealershipId: CURRENT_DEALERSHIP_ID, spawnNow: true, color: SELECTED_COLOR}));
				exitShowroom();
				break;
			}
			case 'order': {
				// ORDER VEHICLE
				$.post(`https://${resName}/purchaseVehicleForStock`, JSON.stringify({vehicleName: SELECTED_VEHICLE.id, dealershipId: CURRENT_DEALERSHIP_ID, color: SELECTED_COLOR }));
				exitShowroom();

				break;
			}
			case 'loan': {
				// LOAN VEHICLE
				$.post(`https://${resName}/dealerships-loanVehicle`, JSON.stringify({vehicleName: SELECTED_VEHICLE.id, dealershipId: CURRENT_DEALERSHIP_ID, spawnNow: true, color: SELECTED_COLOR }));
				exitShowroom();

				break;
			}
			case 'test': {
				// TEST VEHICLE
				console.log(`Testing ${SELECTED_VEHICLE.name} for ${formatNumber(SELECTED_VEHICLE.PRICING.test)} / 15 Minutes`)
				display(false);
				break;
			}
		}
		$(".buy-container").css("opacity", "");
		$(".preview-btn").show();
		$(".dealership-notification").hide();
	});
}

// type: number or text
async function askInput(title, description="", type, placeholder) {
	let resolve = null;
	const promise = new Promise(res => resolve = res);

	const wasMainContainerShowed = $(".main-container").is(":visible");
	$(".main-container .input-overlay").remove();
	  
	const inputOverlay = $(`
	  <div class="input-overlay">
		<div class="input-box">
		<p class="input-box-title">${title}</p>
		<p class="input-box-description">${description}</p>
		<input id="input" autocomplete="off" type="${type}" class="input-field" placeholder="${placeholder}">
		<div class="input-btn" id="cancel"><p>${getLocalizedText("menu:cancel")}</p></div>
		<div class="input-btn" id="submit"><p>${getLocalizedText("menu:submit")}</p></div>
		</div>
	  </div>
	`);
  
	$(".main-container").append(inputOverlay);
  
	// Buttons
	$(".input-overlay #cancel").click(function () {
		$(".main-container .input-overlay").remove();

		resolve(false)

		display(wasMainContainerShowed);
	});
	
	$(".input-overlay #submit").click(function () {
		const inputValue = $("#input").val();

		if (type === "number" && !isNaN(inputValue) && inputValue >= 0) {
			resolve(parseInt(inputValue))
			$(".main-container .input-overlay").remove();

			display(wasMainContainerShowed);

		} else if (type === "text" && inputValue.trim() !== "") {
			resolve(inputValue)
			$(".main-container .input-overlay").remove();

			display(wasMainContainerShowed);
		}
	});	

	display(true);

	return promise;
}

async function dealershipListDialog(elements) {
	let resolve = null;
	const promise = new Promise(res => resolve = res);

	$(".main-container").empty();

	const listDialog = $(`
	  <div class="management-page" style="width: 35vh;height: unset;">
	  	<button type="button" class="btn btn-close position-absolute top-0 end-0 mt-4 me-4"></button>
		<div class="management-title" style="top:0; margin-top: 4.5vh">
		  <div class="hrec hrec"></div>
			<p>${getLocalizedText("menu:choose_from_list")}</p>
		  <div class="hrec hrec"></div>
		</div>
		<div class="inner-container mt-4 mb-6">
		  <ul class="employee-management-list" style="overflow-y: unset; max-height: unset;">
		  </ul>
		</div>
	  </div>
	`);

	listDialog.find(".btn-close").click(function () {
		display(false);
		resolve(false);
	});

	$(".main-container").append(listDialog)

	elements.forEach(elementData => {		
		const div = $(`
			<li id="${elementData.value}" class="employee-element clickable">
				<p id="employee-name">${elementData.label}</p>
			</li>
		`);

		div.click(function () {
			$(".main-container .management-page").remove();
			resolve(elementData.value);
			display(false);
		});

		$(".employee-management-list").append(div);
	});

	display(true);

	return promise;
}