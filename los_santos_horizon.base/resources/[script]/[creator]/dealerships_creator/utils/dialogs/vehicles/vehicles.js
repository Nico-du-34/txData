function createVehicleCard(vehicle, askForPrices, categoryId) {
    let card = $(`
        <div class="col">
            <label class="card h-100 d-flex align-items-center px-2 vehicle-card" data-vehicle-id="${vehicle.spawnName}">
                <input type="checkbox" class="form-check-input d-none vehicle-selected-checkbox">
                <img data-src="../_vehicles_images/${vehicle.spawnName}.webp" class="card-img-top mx-auto mt-3 p-2" alt="${vehicle.label}">
                <div class="card-body d-flex flex-column justify-content-end">
                    <h5 class="card-title text-center">${vehicle.label}</h5>
                    <p class="card-title text-center fst-italic">${vehicle.spawnName}</p>
                </div>
                
                <div class="input-group input-group-sm my-2 price-div">
                    <span class="input-group-text">${getLocalizedText("menu:price")}</span>
                    <input type="number" min="0" class="form-control vehicle-price" placeholder="$$$">
                </div>
            </label>
        </div>
    `);

    card.find('.vehicle-selected-checkbox').change(function () {
        const active = $(this).is(':checked');

        card.find(".vehicle-card").toggleClass("selected", active);
        card.find(".vehicle-price").prop("required", active).prop("disabled", !active);
        card.find('.vehicle-price').val("");

        // Updates the count of selected vehicles in the category header
        const navLink = $(`#nav-link-${categoryId}`)
        const categoryVehiclesList = $(`#vehicles-list-${categoryId}`)
        const selectedCount = categoryVehiclesList.find(".vehicle-card.selected").length;
        let finalLabel = navLink.data("category-label")
        
        if(selectedCount > 0) {
            finalLabel += " - " + selectedCount;
        }

        navLink.text(finalLabel);
    }).change(); // Trigger the change event to set the initial state

    card.find(".price-div").toggle(askForPrices);
    card.find(".vehicle-price").click(function (e) {
        e.stopPropagation(); // Prevent the event from bubbling up to the category header
    });

    return card;
}

function createVehicleGroup(fullVehiclesContainer, categoryId, categoryLabel, categoryVehicles, askForPrices) {
    const navItem = $(`
        <button id="nav-link-${categoryId}" class="nav-link" data-bs-toggle="pill" data-bs-target="#vehicles-list-${categoryId}" type="button" role="tab" data-category-label="${categoryLabel}">${categoryLabel}</button>
    `);

    fullVehiclesContainer.find(".categories-container").append(navItem);

    let group = $(`
        <div id="vehicles-list-${categoryId}" class="container tab-pane">
            <div class="d-inline-block col-12 my-2 fs-3">
                <div class="input-group input-group-sm w-25 float-start">
                    <span class="input-group-text">${getLocalizedText("menu:search")}</span>
                    <input type="text" class="form-control input-vehicles-search" placeholder="${getLocalizedText("menu:search")}">
                </div>

                <div class="btn-group float-end">
                    <button type="button" class="btn btn-sm btn-primary mx-1 select-all-btn">${getLocalizedText("menu:select_all")}</button>
                    <button type="button" class="btn btn-sm btn-secondary mx-1 deselect-all-btn">${getLocalizedText("menu:select_none")}</button>
                </div>

                <div class="form-check float-start all-vehicles-in-category-allowed-div">
                    <input class="form-check-input all-vehicles-in-category-allowed-checkbox" type="checkbox" value="">
                    <label class="form-check-label">${getLocalizedText("menu:all_vehicles_of_category_allowed")}</label>
                </div>
            </div>

            <div class="row row-cols-6 g-2 mb-4 vehicles-list" data-category-id="${categoryId}">

            </div>
        </div>
    `);

    navItem.on('show.bs.tab', function (e) {
        let targetPane = $(e.target.getAttribute('data-bs-target'));
        targetPane.find(".vehicle-card img").each(function () {
            $(this).attr("src", $(this).attr("data-src"));
        });
    });

    navItem.on('hidden.bs.tab', function (e) {
        let targetPane = $(e.target.getAttribute('data-bs-target'));
        targetPane.find(".vehicle-card img").each(function () {
            $(this).attr("src", "");
        });
    });

    group.find(".all-vehicles-in-category-allowed-div").toggle(!askForPrices);

    group.find(".all-vehicles-in-category-allowed-checkbox").change(function () {
        group.find(".vehicle-selected-checkbox").prop("checked", this.checked).change();

        group.find(".select-all-btn").prop("disabled", this.checked);
        group.find(".deselect-all-btn").prop("disabled", this.checked);
        group.find(".vehicle-card").prop("disabled", this.checked);
    });

    group.find('.select-all-btn').click(function (e) {
        e.stopPropagation();
        group.find(".vehicle-selected-checkbox:not(:checked)").prop("checked", true).change();
    });
    
    group.find('.deselect-all-btn').click(function (e) {
        e.stopPropagation();
        group.find(".vehicle-selected-checkbox").prop("checked", false).change();
    });    

    group.find(".input-vehicles-search").on("input", function () {
        const search = $(this).val().toLowerCase();
        group.find(".vehicle-card").each(function () {
            const vehicleLabel = $(this).find(".card-body").text().toLowerCase();
            $(this).parent().toggle(vehicleLabel.includes(search));
        });
    });

    categoryVehicles.forEach(vehicle => {
        let vehicleCard = createVehicleCard(vehicle, askForPrices, categoryId);
        group.find(".vehicles-list").append(vehicleCard);
    });

    fullVehiclesContainer.find(".vehicles-container").append(group);
}

function vehiclesDialog(oldVehicles, askForPrices) {
    return new Promise(async (resolve, reject) => {
        let div = $(`
        <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
            <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                <form class="modal-content needs-validation" novalidate>
                    <div class="modal-header">
                        <h5 class="modal-title">${getLocalizedText("menu:vehicles_dialog:title")}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body scrollbar full-vehicles-container" style="max-height: 60vh; overflow-y:auto">

                        <div class="nav nav-pills categories-container justify-content-center">

                        </div>

                        <div class="tab-content vehicles-container">

                        </div>

                    </div>
    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
                        <button type="submit" class="btn btn-success">${getLocalizedText("menu:confirm")}</button>
                    </div>    
                </form>
            </div>
        </div>
        `);

        // delete the div when the modal is closed
        div.on("hidden.bs.modal", function () {
            div.remove();
        });

        div.modal("show");

        div.find(".input-vehicles-search").val("");

        const vehiclesData = await $.post(`https://${resName}/getAllVehicles`, JSON.stringify({}));

        let vehiclesByCategory = {};

        for (vehicle of Object.values(vehiclesData.vehicles)) {
            if (!vehiclesByCategory[vehicle.class]) {
                vehiclesByCategory[vehicle.class] = [];
            }
            vehiclesByCategory[vehicle.class].push(vehicle);
        }
        
        const fullVehiclesContainer = div.find(".full-vehicles-container");

        for (vehicleClass of Object.values(vehiclesData.classes)) {
            if (vehiclesByCategory[vehicleClass.id]) {
                createVehicleGroup(fullVehiclesContainer, vehicleClass.id, vehicleClass.label, vehiclesByCategory[vehicleClass.id], askForPrices);
            }
        }

        $('head').append(`
        <style>
            .vehicle-card {
                cursor: pointer;
            }

            .vehicle-card.selected {
                border: 3px solid #4CAF50;
            }
            
            .category-header {
                cursor: pointer;
            }
        </style>
        `);

        // Submit
        div.find(".modal-content").submit(function (event) {
            if(isThereAnyErrorInForm(event)) return;

            if(askForPrices) {
                resolve(getSelectedVehiclesWithPrices(div));
            } else {
                resolve(getSelectedVehiclesWithoutPrices(div));
            }

            div.modal("hide");
        });

        if(oldVehicles) {
            if(askForPrices) {
                for(let i=0; i<oldVehicles.length; i++) {
                    const categoryData = oldVehicles[i];
                    const vehicles = categoryData.vehicles;

                    for(let j=0; j<vehicles.length; j++) {
                        const vehicleData = vehicles[j];
                        const vehicleSpawnName = vehicleData.id;
                        const price = vehicleData.price;

                        // Temporary "patch" otherwise it doesn't update the category label with the number of selected vehicles
                        setTimeout(() => {
                            const vehicleCard = div.find(`.vehicle-card[data-vehicle-id="${vehicleSpawnName}"]`);
                            vehicleCard.find(".vehicle-selected-checkbox").prop("checked", true).change();
                            vehicleCard.find(".vehicle-price").val(price);
                        }, 0);
                    }
                }
            } else {
                console.log("NOT HANDLED YET")
            }
        }
    });
}

function getSelectedVehiclesWithPrices(div) {
    let data = [];

    div.find(".vehicles-list").each(function () {
        const categoryId = $(this).attr("data-category-id");
        let vehiclesInCategoryArr = [];

        // register each vehicle with its price
        $(this).find(".vehicle-card.selected").each(function () {
            const vehicleId = $(this).attr("data-vehicle-id");
            const vehiclePrice = parseInt( $(this).find(".vehicle-price").val() );

            vehiclesInCategoryArr.push({id: vehicleId, price: vehiclePrice});
        });
        
        if(vehiclesInCategoryArr.length > 0) {
            data.push({categoryId: categoryId, vehicles: vehiclesInCategoryArr});
        }
    });

    return data;
}