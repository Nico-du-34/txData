function openManagementOptions() {
	$(".main-container").empty();

	const actions = [
		{ label: getLocalizedText("hire_new_employee"), id: "hire" },
		{ label: getLocalizedText("manage_employees"), id: "manage_employees" },
	]
	
	const managementPage = $(`
		<div class="management-page">
			<button type="button" class="btn btn-close position-absolute top-0 end-0 mt-4 me-4"></button>

			<div class="management-title">
				<div class="hrec hrec"></div>
				<p>Dealership</p>
				<div class="hrec hrec"></div>
			</div>
			<div class="inner-container">
				<ul class="employee-management-list">
				
				</ul>
			</div>
		</div>
	`);

	managementPage.find(".btn-close").click(function () {
		display(false);
	});

	$(".main-container").append(managementPage)

	actions.forEach(action => {
		const div = $(`
			<li class="employee-element">
				<p id="employee-name">${action.label}</p>
			</li>
		`);

		div.click(function () {
			$.post(`https://${resName}/employeeMenuAction`, JSON.stringify({ id: action.id, dealershipId: CURRENT_DEALERSHIP_ID }));
		});

		$(".employee-management-list").append(div);
	});

	display(true);
}

// MANAGEMENT PAGE
function showManagementPage(employeesData) {
	let selectedEmployee = undefined;

	$(".main-container").empty();

	const managementPage = $(`
	  <div class="management-page">
	  	<button type="button" class="btn btn-close position-absolute top-0 end-0 mt-4 me-4"></button>
		<div class="management-title">
		  <div class="hrec hrec"></div>
			<p>${getLocalizedText("menu:employees_management")}</p>
		  <div class="hrec hrec"></div>
		</div>
		<div class="inner-container">
		  <ul class="employee-management-list">
		  </ul>
		  <div class="employee-management-actions">
			<div class="employee-amount-box">
			  <div class="title-box">
				<p>${getLocalizedText("menu:employees")}</p>
				<div class="hrec"></div>
			  </div>
			  <div class="employee-count-box">
				<p class="employee-count">${employeesData.length} ${getLocalizedText("menu:members")}</p>
				<img src="./assets/svg/employees.svg" class="employee-count-icon">
			  </div>
			</div>
			<div class="employee-action employee-selected" id="employee-selected"><p>N/A</p></div>
			<div class="employee-action manage-permissions-btn" id="employee-manage"><p>${getLocalizedText("menu:manage_permissions")}</p></div>
			<div class="employee-action fire-btn" id="employee-fire"><p>${getLocalizedText("menu:fire")}</p></div>
			<div class="employee-action submit-btn" id="employee-submit"><p>${getLocalizedText("menu:submit")}</p></div>
		  </div>
		</div>
	  </div>
	`);

	managementPage.find(".btn-close").click(function () {
		display(false);
	});

	$(".main-container").append(managementPage)

	employeesData.forEach(employeeData => {
		const { label } = employeeData;
		
		const div = $(`
			<li id="${employeeData.identifier}" class="employee-element">
				<p id="employee-name">${label}</p>
				<p class="employee-details">Details</p>
			</li>
		`);

		div.click(function () {
			selectedEmployee = employeeData;
			$(".employee-element").removeClass("selected");
			$(this).addClass("selected");
			$("#employee-selected p").html(label)
		});

		$(".employee-management-list").append(div);
	});

	$(".employee-element").first().click();

	$(".employee-action").click(async function () {
		const action = $(this).attr("id");
		switch (action) {
			case "employee-manage": {
				showPermissionsPage(selectedEmployee);
				break;
			}
			case "employee-fire": {
				await $.post(`https://${resName}/fireEmployee`, JSON.stringify({ dealershipId: CURRENT_DEALERSHIP_ID, employeeIdentifier: selectedEmployee.identifier }))
				display(false);
				break;
			}
			case "employee-submit": {
				display(false);
				break;
			}
		}
	});

	display(true);

}
function openHireEmployee(closePlayers) {
	let selectedEmployee = undefined;

	$(".main-container").empty();

	const managementPage = $(`
	  <div class="management-page">
	  	<button type="button" class="btn btn-close position-absolute top-0 end-0 mt-4 me-4"></button>
		<div class="management-title">
		  <div class="hrec hrec"></div>
			<p>${getLocalizedText("menu:employees_management")}</p>
		  <div class="hrec hrec"></div>
		</div>
		<div class="inner-container">
		  <ul class="employee-management-list">
		  </ul>
		  <div class="employee-management-actions">
			<div class="employee-amount-box">
			  <div class="title-box">
				<p>${getLocalizedText("menu:employees")}</p>
				<div class="hrec"></div>
			  </div>
			  <div class="employee-count-box">
				<p class="employee-count">${closePlayers.length} ${getLocalizedText("menu:nearby")}</p>
				<img src="./assets/svg/stats_icon.svg" class="employee-count-icon">
			  </div>
			</div>
			<div class="employee-action employee-selected" id="employee-selected"><p>N/A</p></div>
			<div class="employee-action submit-btn" id="hire"><p>${getLocalizedText("menu:hire")}</p></div>
		  </div>
		</div>
	  </div>
	`);

	managementPage.find(".btn-close").click(function () {
		display(false);
	});

	$(".main-container").append(managementPage)

	closePlayers.forEach(employeeData => {
		const { label } = employeeData;
		
		const div = $(`
			<li id="${employeeData.identifier}" class="employee-element">
				<p id="employee-name">${label}</p>
				<p class="employee-details">Details</p>
			</li>
		`);

		div.click(function () {
			selectedEmployee = employeeData;
			$(".employee-element").removeClass("selected");
			$(this).addClass("selected");
			$("#employee-selected p").html(label)
		});

		$(".employee-management-list").append(div);
	});

	$(".employee-element").first().click();

	$(".employee-action").click(async function () {
		const action = $(this).attr("id");
		switch (action) {
			case "hire": {
				await $.post(`https://${resName}/hireEmployee`, JSON.stringify({ dealershipId: CURRENT_DEALERSHIP_ID, identifier: selectedEmployee.identifier }))
				break;
			}
		}
	});

	display(true);
}

// Permissions Page
function showPermissionsPage(employeeData) {
	const { identifier, permissions, label } = employeeData;

	$(".management-page").hide();

	const div = $(`
		<div class="permissions-page">
		<div class="permissions-title">
			<div class="hrec hrec"></div>
			<p>${label}</p>
			<div class="hrec hrec"></div>
		</div>
		<ul class="permissions-list">

		</ul>
		<div class="submit-btn" id="save-permissions"><p>Submit</p></div>
		</div>
	`);
	
	$(".main-container").append(div);

	const ALL_PERMISSIONS = [
		{ permissionId: "purchaseVehicleForStock", label: getLocalizedText("menu:purchaseVehicleForStock") },
		{ permissionId: "displayVehicleFromStock", label: getLocalizedText("menu:displayVehicleFromStock") },
		{ permissionId: "addMoneyToDealership", label: getLocalizedText("menu:addMoneyToDealership") },
		{ permissionId: "removeMoneyFromDealership", label: getLocalizedText("menu:removeMoneyFromDealership") },
		{ permissionId: "sellVehicleFromStock", label: getLocalizedText("menu:sellVehicleFromStock") },
		{ permissionId: "updatePriceForModel", label: getLocalizedText("menu:updatePriceForModel") },
		{ permissionId: "manager", label: getLocalizedText("menu:manager") },
	];

	ALL_PERMISSIONS.forEach(permissionData => {
		// Imposta su false se non definito
		const { permissionId, label } = permissionData;
		permissions[permissionId] = permissions[permissionId] || false;
	
		// Carica e aggiungi l'elemento dell'autorizzazione alla lista
		$(".permissions-list").append(`
			<li class="permissions-element" data-permission="${permissionId}" data-state="${permissions[permissionId]}">
				<p class="permission-desc">${label}</p>
				<div class="permission-switches">
					<div class="permission-switch switch-off" id="off"></div>
					<div class="permission-seperator"></div>
					<div class="permission-switch switch-on" id="on"></div>
				</div>
			</li>
		`);
	});
	
	updateStates();

	$(".permissions-list").on("click", ".permission-switches", function () {
		let state = !$(this).closest("li").data("state");

		$(this).closest("li").data("state", state);

		updateStates();
	});

	div.find("#save-permissions").click(async function () {
		const newPermissions = {};

		$(".permissions-element").each(function () {
			const permissionId = $(this).data("permission");
			const state = $(this).data("state");

			newPermissions[permissionId] = state;
		});

		await $.post(`https://${resName}/updateEmployeePermissions`, JSON.stringify({ employeeIdentifier: identifier, permissions: newPermissions,dealershipId: CURRENT_DEALERSHIP_ID }));
		$(".management-page").show();
		$(".permissions-page").remove();
	});

	function updateStates() {
		$(".permissions-element").each(function () {
			const state = $(this).data("state");
			$(this).find(".permission-switch.switch-on").toggleClass("active", state);
			$(this).find(".permission-switch.switch-off").toggleClass("active", !state);
		});
	}	
}
