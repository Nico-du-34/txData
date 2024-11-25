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

function getDefaultBlipCustomization() {
	return {
		isEnabled: true,
		sprite: 1,
		label: getLocalizedText("menu:colleague"),
		scale: 0.8,
		color: 3,
		display: 2,
	}
}

function getDefaultBlipCustomizationForSignalLost() {
	return {
		isEnabled: true,
		sprite: 66,
		label: getLocalizedText("menu:signal_lost"),
		scale: 0.8,
		color: 39,
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