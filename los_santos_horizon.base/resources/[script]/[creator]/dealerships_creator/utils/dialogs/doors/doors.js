async function doorsDialog(alreadySelectedDoors = {}) { return new Promise(async (resolve, reject) => {
    let div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070; background: rgba(25, 25, 25, 0.7);">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:doors_dialog:title")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" style="max-height: 60vh; overflow-y: auto">
                    <div class="input-group">
                        <span class="input-group-text">${getLocalizedText("menu:doors_dialog:search_door")}</span>
                        <input type="text" class="form-control input-door-search">
                    </div>

                    <div class="mt-2 doors-list">

                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
                    <button type="button" class="btn btn-success input-doors-confirm-btn">${getLocalizedText("menu:confirm")}</button>
                </div>    
            </div>
        </div>
    </div>
    `)
    div.modal("show");

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });

    div.find(".input-door-search").val("");
    
    const doors = await $.post(`https://${resName}/getAllDoors`);

    let inputDoorsList = div.find(".doors-list");
    inputDoorsList.empty();

    for(const[buildingId, data] of Object.entries(doors)) {	
        let buildingDiv = $(`
            <div class="form-check fs-3 mb-2">
                <hr>
                <p class="fw-bold mb-0">${data.label}</p>
                
                <div class="doors-list">

                </div>
            </div>
        `);

        for(let [doorsId, doorsData] of Object.entries(data.doors)) {
            let doorDiv = $(`
                <div class="door-div mx-auto">
                    <input class="form-check-input" type="checkbox" data-doors-id=${doorsData.id}>
                    <label class="form-check-label">
                        ${doorsData.id} - ${doorsData.label}
                    </label>
                </div>
            `);

            buildingDiv.find(".doors-list").append(doorDiv);
        }
        
        inputDoorsList.append(buildingDiv);
    }

    for(let [doorsId, _] of Object.entries(alreadySelectedDoors) ) {
        $(`input[data-doors-id=${doorsId}]`).prop("checked", true);
    }

    // Unbinds the button and rebinds it to callback the selected doors
    div.find(".input-doors-confirm-btn").unbind().click(function() {
        let selectedDoors = {};

        inputDoorsList.find("input:checked").each(function() {	
            let doorsId = parseInt( $(this).data("doorsId") )
                
            selectedDoors[doorsId] = true;
        });

        div.modal("hide");

        resolve(selectedDoors);
    });

    div.find(".input-door-search").on("keyup", function() {
        let text = $(this).val().toLowerCase();
    
        div.find(".doors-list .form-check").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
        });
    });
})}