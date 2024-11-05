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

/* Limited objects dialog */
async function limitedObjectsDialog(oldLimitedObjects) {
	return new Promise((resolve, reject) => {
		let limitedObjectsModal = $("#limited-objects-dialog-modal")
		limitedObjectsModal.modal("show");
	
		$("#limited-objects-list").empty();

		if(oldLimitedObjects) {
			
			if(oldLimitedObjects.item) {
				for(const objectName of Object.keys(oldLimitedObjects.item)) {
					let objectData = {
						name: objectName,
						type: "item",
					}
	
					addLimitedObjectToList(objectData);
				}
			}
			
			if(oldLimitedObjects.weapon) {
				for(const objectName of Object.keys(oldLimitedObjects.weapon)) {
					let objectData = {
						name: objectName,
						type: "weapon",
					}
	
					addLimitedObjectToList(objectData);
				}
			}
		}
		
		$("#limited-objects-form").unbind().submit(function(event) {
			if (!this.checkValidity()) {
				event.preventDefault();
				event.stopPropagation();
		
				return;
			} else {
				$(this).removeClass("was-validated");
			}

			let limitedObjects = {
				"item": {},
				"weapon": {},
			};

			$("#limited-objects-list .limited-object").each(function() {
				let type = $(this).find(".item-type").val();
				let name = $(this).find(".item-name").val();

				limitedObjects[type][name] = true;
			})
			
			limitedObjectsModal.modal("hide");

			resolve(limitedObjects);
		})
	})
}

async function addLimitedObjectToList(objectData) {
	let objectDiv = $(`
		<div class="row g-2 row-cols-auto align-items-center text-body my-2 limited-object justify-content-center">
			<button type="button" class="btn btn-danger delete-limited-object-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

			<select class="form-select item-type" style="width: auto;">
				<option selected value="item">${getLocalizedText("menu:item")}</option>
				${await getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
			</select>
			
			<div class="form-floating col-6">
				<input type="text" class="form-control item-name" placeholder="Name" required>
				<label>${ getLocalizedText("menu:object_name") }</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	
		</div>
	`);

	objectDiv.find(".delete-limited-object-btn").click(function() {
		objectDiv.remove();
	});

	objectDiv.find(".choose-item-btn").click(async function() {
		let objectType = objectDiv.find(".item-type").val();

		let objectName = await objectDialog(objectType);

		objectDiv.find(".item-name").val(objectName);
	}).tooltip();

	if(objectData) {
		objectDiv.find(".item-type").val(objectData.type);
		objectDiv.find(".item-name").val(objectData.name);
	}

	$("#limited-objects-list").append(objectDiv);
}

$("#limited-objects-list-add-object-btn").click(function() {
	addLimitedObjectToList();
})

async function inputDialog(title, label) {
	return new Promise((resolve, reject) => {
		let inputDialogModal = $("#input-dialog-modal");
		$("#input-dialog-modal-value").val("");
		$("#input-dialog-modal-title").text(title);
		$("#input-dialog-modal-label").text(label);
	
		inputDialogModal.modal("show");

		$("#input-dialog-modal-form").unbind().submit(function(event) {
			if (!this.checkValidity()) {
				event.preventDefault();
				event.stopPropagation();
		
				return;
			} else {
				$(this).removeClass("was-validated");
			}
	
			inputDialogModal.modal("hide");
	
			resolve( $("#input-dialog-modal-value").val() );
		});
	})
}

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