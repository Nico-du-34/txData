async function itemsDialog() {
	return new Promise((resolve, reject) => {
		let inputItemsModal = $("#input-items-dialog-modal")
		inputItemsModal.modal("show");
	
		$("#input-item-search").val("");
		
		$.post(`https://${resName}/getAllItems`, JSON.stringify({}), function (items) {
			let itemListDiv = $("#items-list");
	
			itemListDiv.empty();
	
			for(const[itemName, itemData] of Object.entries(items)) {
				let itemDiv = $(`
					<li class="list-group-item list-group-item-action" value=${itemName}>${itemData.label}</li>
				`);
	
				itemDiv.click(function() {
					inputItemsModal.modal("hide");
					resolve(itemName);
				});
	
				itemListDiv.append(itemDiv);
			}
		});
	})
}

$("#input-item-search").on("keyup", function() {
	let text = $(this).val().toLowerCase();

	$("#items-list li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
    });
})

async function weaponsDialog() {
	return new Promise((resolve, reject) => {
		let inputWeaponsModal = $("#input-weapons-dialog-modal")
		inputWeaponsModal.modal("show");

		$("#input-weapon-search").val();

		$.post(`https://${resName}/getAllWeapons`, JSON.stringify({}), function (weapons) {
			let weaponListDiv = $("#weapons-list");

			weaponListDiv.empty();

			weapons.forEach(weaponData => {
				let weaponDiv = $(`
					<li class="list-group-item list-group-item-action" value=${weaponData.name}>${weaponData.label}</li>
				`);

				weaponDiv.click(function() {
					inputWeaponsModal.modal("hide");
					resolve(weaponData.name);
				});

				weaponListDiv.append(weaponDiv);
			})
		});
	})
}

$("#input-weapon-search").on("keyup", function() {
	let text = $(this).val().toLowerCase();

	$("#weapons-list li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
    });
})

async function accountsDialog() {
	return new Promise((resolve, reject) => {
		let accountsModal = $("#input-accounts-dialog-modal");
		let accountsList = $("#accounts-list");

		$.post(`https://${resName}/getAllAccounts`, {}, function (accounts) {
			accountsList.empty();

			for(const[accountName, accountLabel] of Object.entries(accounts)) {
				let accountDiv = $(`
					<li class="list-group-item list-group-item-action" value=${accountName}>${accountLabel}</li>
				`);

				accountDiv.click(function() {
					accountsModal.modal("hide");
					resolve(accountName);
				});

				accountsList.append(accountDiv);
			}

			accountsModal.modal("show");
		})
	});
}

async function objectDialog(type) {
	return new Promise(async function(resolve, reject) {
		switch(type) {
			case "item": {
				resolve( await itemsDialog() );
	
				break;
			}
	
			case "account": {
				resolve( await accountsDialog() );

				break;
			}
	
			case "weapon": {
				resolve( await weaponsDialog() );

				break;
			}
		}
	});
}

function getDefaultMarkerCustomization() {
	return {
		type: 1,
		scale: {
			x: 0.7,
			y: 0.7,
			z: 0.7
		},
		color: {
			red: 230,
			green: 126,
			blue: 34,
			opacity: 200
		},
		rotation: {
			x: 0.0,
			y: 0.0,
			z: 0.0
		},
		followCamera: false,
		bounce: false,
		rotate: false
	}
}

async function markerDialog(currentMarkerData) {
	return new Promise((resolve, reject) => {
		let markerModal = $("#marker-customization-dialog-modal");

		if(!currentMarkerData) {
			currentMarkerData = getDefaultMarkerCustomization()
		}

		$("#marker-type").val(currentMarkerData.type);
		$("#marker-size-x").val(currentMarkerData.scale.x);
		$("#marker-size-y").val(currentMarkerData.scale.y);
		$("#marker-size-z").val(currentMarkerData.scale.z);
		$("#marker-color-red").val(currentMarkerData.color.red);
		$("#marker-color-green").val(currentMarkerData.color.green);
		$("#marker-color-blue").val(currentMarkerData.color.blue);
		$("#marker-color-opacity").val(currentMarkerData.color.opacity);
		$("#marker-rotation-x").val(currentMarkerData.rotation.x);
		$("#marker-rotation-y").val(currentMarkerData.rotation.y);
		$("#marker-rotation-z").val(currentMarkerData.rotation.z);
		$("#marker-follow-camera").prop("checked", currentMarkerData.followCamera);
		$("#marker-bounce").prop("checked", currentMarkerData.bounce);
		$("#marker-rotate").prop("checked", currentMarkerData.rotate);

		$("#marker-customization-form").unbind().submit(function(event) {
			if (!this.checkValidity()) {
				event.preventDefault();
				event.stopPropagation();
		
				return;
			} else {
				$(this).removeClass("was-validated");
			}

			let markerData = {
				type: parseInt( $("#marker-type").val() ),
				scale: {
					x: parseFloat( $("#marker-size-x").val() ),
					y: parseFloat( $("#marker-size-y").val() ),
					z: parseFloat( $("#marker-size-z").val() )
				},
				color: {
					red: parseInt( $("#marker-color-red").val() ),
					green: parseInt( $("#marker-color-green").val() ),
					blue: parseInt( $("#marker-color-blue").val() ),
					opacity: parseInt( $("#marker-color-opacity").val() )
				},
				rotation: {
					x: parseFloat( $("#marker-rotation-x").val() ),
					y: parseFloat( $("#marker-rotation-y").val() ),
					z: parseFloat( $("#marker-rotation-z").val() )
				},
				followCamera: $("#marker-follow-camera").prop("checked"),
				bounce: $("#marker-bounce").prop("checked"),
				rotate: $("#marker-rotate").prop("checked")
			}

			markerModal.modal("hide");

			resolve(markerData);
		})

		markerModal.modal("show");
	});
}

function getDefaultBlipCustomization() {
	return {
		isEnabled: true,
		sprite: 38,
		label: "Race",
		scale: 0.8,
		color: 2,
		display: 2,
	}
}

async function blipDialog(currentBlipData) {
	return new Promise((resolve, reject) => {
		let blipModal = $("#blip-customization-dialog-modal");

		if(!currentBlipData) {
			currentBlipData = getDefaultBlipCustomization()
		}

		$("#blip-enabled").prop("checked", currentBlipData.isEnabled).change();
		$("#blip-sprite").val(currentBlipData.sprite);
		$("#blip-name").val(currentBlipData.label);
		$("#blip-color").val(currentBlipData.color);
		$("#blip-display").val(currentBlipData.display);
		$("#blip-scale").val(currentBlipData.scale);

		$("#blip-customization-form").unbind().submit(function(event) {
			if (!this.checkValidity()) {
				event.preventDefault();
				event.stopPropagation();
		
				return;
			} else {
				$(this).removeClass("was-validated");
			}

			let blipData = {
				isEnabled: $("#blip-enabled").prop("checked"),
				sprite: parseInt( $("#blip-sprite").val() ),
				label: $("#blip-name").val(),
				scale: parseFloat( $("#blip-scale").val() ),
				color: parseInt( $("#blip-color").val() ),
				display: parseInt( $("#blip-display").val() ),
			}

			blipModal.modal("hide");

			resolve(blipData);
		})

		blipModal.modal("show");
	});
}

$("#blip-enabled").change(function() {
	let isEnabled = $(this).prop("checked");

	$("#blip-customization-form").find("input, select").not( $(this) )
		.prop("disabled", !isEnabled)
		.prop("required", isEnabled);
})

function jobsDialog(oldJobs) {
	return new Promise((resolve, reject) => {
		let inputJobsModal = $("#input-jobs-dialog-modal")
		inputJobsModal.modal("show");
	
		$("#input-job-search").val("");
		
		$.post(`https://${resName}/getAllJobs`, JSON.stringify({}), function (jobs) {
			let jobListDiv = $("#jobs-list");
	
			jobListDiv.empty();
	
			for(const[jobName, jobData] of Object.entries(jobs)) {
				let jobDiv = $(`
					<div class="form-check fs-3 mb-2">
						<input class="form-check-input" data-type="job" type="checkbox" data-job-name="${jobName}">

						<p class="fw-bold mb-0">${jobData.label}</p>
						
						<div class="job-grades ms-3">
	
						</div>
					</div>
				`);
	
				for(let [grade, gradeData] of Object.entries(jobData.grades)) {
					// QB-Core
					if(gradeData.grade == undefined) {
						gradeData.grade = grade;
						gradeData.label = gradeData.name;
					}

					let rankDiv = $(`
						<div class="rank-div">
							<input class="form-check-input" data-type="job-grade" type="checkbox" data-job-name="${jobName}" data-grade=${gradeData.grade}>
							<label class="form-check-label">
								${gradeData.grade} - ${gradeData.label}
							</label>
						</div>
					`);
	
					jobDiv.find(".job-grades").append(rankDiv);
				}
	
				jobListDiv.append(jobDiv);
			}

			// Disables and uncheck grades checkbox if the entire job is selected
			$("#jobs-list").find(`[data-type="job"]`).change(function() {
				let isChecked = $(this).prop("checked");

				if(isChecked) {
					$(this).parent().find(".job-grades").find("input").prop("checked", false).prop("disabled", true);
				} else {
					$(this).parent().find(".job-grades").find("input").prop("disabled", false);
				}
			})
	
			if(oldJobs) {
				for(let [jobName, allowedGrades] of Object.entries(oldJobs)) {
					if(allowedGrades === true) {
						$("#jobs-list").find(`[data-type="job"][data-job-name="${jobName}"]`).prop("checked", true).change();
					} else {
						for(let [grade, _] of Object.entries(allowedGrades)) {
							$("#jobs-list").find(`[data-type="job-grade"][data-job-name="${jobName}"][data-grade="${grade}"]`).prop("checked", true);
						}
					}
				}
			}

			// Unbinds the button and rebinds it to callback the selected jobs
			$("#input-jobs-confirm-btn").unbind().click(function() {
				let selectedJobs = {};
	
				let isThereAnyJob = false;
	
				jobListDiv.find("input:checked").each(function() {
					let checkBoxType = $(this).data("type");
					isThereAnyJob = true;
	
					let jobName = $(this).data("jobName");

					switch(checkBoxType) {
						case "job":
							selectedJobs[jobName] = true;
							break;
						case "job-grade":
							let grade = $(this).data("grade");
	
							if(!selectedJobs[jobName]) {
								selectedJobs[jobName] = {};
							}
							
							selectedJobs[jobName][grade] = true;
							break;
						default:
							console.log("Unknown checkbox type: " + checkBoxType + " in jobs dialog");
							break;
					}
				});
	
				inputJobsModal.modal("hide");
	
				resolve(isThereAnyJob ? selectedJobs : false);
			})
		});
	})
}
$("#input-job-search").on("keyup", function() {
	let text = $(this).val().toLowerCase();

	$("#jobs-list .form-check").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
    });
})

async function getCustomVehiclesClasses() {
	return new Promise((resolve, reject) => {
		$.post(`https://${GetParentResourceName()}/getCustomVehiclesClasses`, JSON.stringify({}), function(customVehiclesClasses) {
			resolve(customVehiclesClasses);
		});
	})
}

async function vehicleClassesDialog(oldVehicleClasses) {
	const customVehiclesClasses = await getCustomVehiclesClasses();

	$("#custom-vehicle-classes-list").find(".custom-class").remove();
	for(const [classId, classData] of Object.entries(customVehiclesClasses)) {
		let vehicleClassDiv = $(`
			<div class="form-check fs-5 custom-class">
				<input class="form-check-input" type="checkbox" value="${classId}">
				<label class="form-check-label">${classData.label}</label>
			</div>
		`);

		if( $("#custom-vehicle-classes-col-1").children().length <= $("#custom-vehicle-classes-col-2").children().length ) {
			$("#custom-vehicle-classes-col-1").append(vehicleClassDiv);
		} else {
			$("#custom-vehicle-classes-col-2").append(vehicleClassDiv);
		}
	}

	return new Promise((resolve, reject) => {
		let vehicleClassesModal = $("#vehicle-classes-dialog-modal");

		if(!oldVehicleClasses) {
			$("#vehicle-classes-list").find("input").prop("checked", true);
			$("#custom-vehicle-classes-list").find("input").prop("checked", false);
		} else {
			$("#vehicle-classes-list").find("input").prop("checked", false);
			$("#custom-vehicle-classes-list").find("input").prop("checked", false);
			
			for(let [vehicleClass, _] of Object.entries(oldVehicleClasses.standard)) {
				$("#vehicle-classes-list").find(`input[value="${vehicleClass}"]`).prop("checked", true);
			}

			for(let [vehicleClass, _] of Object.entries(oldVehicleClasses.custom)) {
				$("#custom-vehicle-classes-list").find(`input[value="${vehicleClass}"]`).prop("checked", true);
			}
		}

		$("#vehicle-classes-form").unbind().submit(function(event) {
			if (!this.checkValidity()) {
				event.preventDefault();
				event.stopPropagation();
		
				return;
			} else {
				$(this).removeClass("was-validated");
			}

			let selectedStandardVehicleClasses = {}

			$("#vehicle-classes-list").find("input:checked").each(function() {
				let vehicleClass = $(this).val();

				selectedStandardVehicleClasses[vehicleClass] = true;
			});

			let selectedCustomVehicleClasses = {}

			$("#custom-vehicle-classes-list").find("input:checked").each(function() {
				let vehicleClass = $(this).val();

				selectedCustomVehicleClasses[vehicleClass] = true;
			});

			vehicleClassesModal.modal("hide");

			resolve({
				standard: selectedStandardVehicleClasses,
				custom: selectedCustomVehicleClasses
			});
		})

		vehicleClassesModal.modal("show");
	});
}

async function racesDialog() {
	return new Promise((resolve, reject) => {
		let raceDialogModal = $("#races-dialog-modal")
		raceDialogModal.modal("show");
	
		$("#input-race-search").val("");
		
		$.post(`https://${resName}/getAllRaces`, JSON.stringify({}), function (races) {
			let racesListDiv = $("#races-list");
	
			racesListDiv.empty();
	
			for(const[_, raceInfo] of Object.entries(races)) {
				if(raceInfo.identifier != "admin") continue;

				let raceDiv = $(`
					<li class="list-group-item list-group-item-action" value=${raceInfo.id}>${raceInfo.label}</li>
				`);
	
				raceDiv.click(function() {
					raceDialogModal.modal("hide");
					resolve(raceInfo.id);
				});
	
				racesListDiv.append(raceDiv);
			}
		});
	})
}

$("#input-race-search").on("keyup", function() {
	let text = $(this).val().toLowerCase();

	$("#races-list li").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
    });
});

function toggleCursor(enabled) {
	if (enabled) {
		$.post(`https://${resName}/enableCursor`, JSON.stringify({}));
	} else {
		$.post(`https://${resName}/disableCursor`, JSON.stringify({}));
	}
}

function loadDialog(dialogName) {
	var script = document.createElement('script');

	console.log(`../utils/dialogs/${dialogName}/${dialogName}.js`)
	script.setAttribute('src',`../utils/dialogs/${dialogName}/${dialogName}.js`);

	document.head.appendChild(script);
}

// Messages received by client
window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {
		case "loadDialog": {
			var script = document.createElement('script');
			script.setAttribute('src',`../utils/dialogs/${data.dialogName}/${data.dialogName}.js`);
			document.head.appendChild(script);
			break;
		}
	}
})

$.post(`https://${resName}/nuiReady`, JSON.stringify({}));