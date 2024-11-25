function getDefaultPedCustomization() {
	return {
		isEnabled: false,
		model: "",
		heading: 0.0,
	}
}

async function pedDialog(currentPedData) {
    let resolve = null;
    const promise = new Promise((res, rej) => { resolve = res; });

    const div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070; background: rgba(25, 25, 25, 0.7);">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <form class="modal-content needs-validation" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:ped_customization")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                
                <div class="modal-body text-center">
                    <div class="form-check form-check-inline fs-4 mb-5">
                        <input class="form-check-input ped-enabled" type="checkbox" value="">
                        <label class="form-check-label">${getLocalizedText("menu:ped_enabled")}</label>
                    </div>

                    <br>

                    <a class="fst-italic" href="https://docs.fivem.net/docs/game-references/ped-models/" target="_blank" onclick='window.invokeNative("openUrl", "https://docs.fivem.net/docs/game-references/ped-models/")'>https://docs.fivem.net/docs/game-references/ped-models/</a>
                    
                    <div class="d-flex gap-3 mt-3 align-items-center justify-content-center">
                        <div class="form-floating">
                            <input type="text" class="form-control ped-model" placeholder="..." required>
                            <label>${getLocalizedText("menu:ped_model")}</label>
                        </div>
                        <div class="form-floating">
                            <input type="number" class="form-control ped-heading" placeholder="..." step="0.01" required>
                            <label>${getLocalizedText("menu:ped_heading")}</label>
                        </div>

                        <button type="button" class="btn btn-secondary col-auto px-4 choose-heading"><i class="bi bi-arrow-down-square"></i></button>							
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
    div.on("hidden.bs.modal", function() {
        div.remove();
    });

    if(!currentPedData) {
        currentPedData = getDefaultPedCustomization()
    }

    div.find(".choose-heading").click(async function() {
        const data = await chooseCoords();
		if(!data) return;

        div.find(".ped-heading").val(data.heading);
    });

    div.find(".ped-enabled").change(function() {
        let isEnabled = $(this).prop("checked");
    
        div.find("input").not( $(this) )
            .prop("disabled", !isEnabled)
            .prop("required", isEnabled);
    })

    div.find("form").submit(function(event) {
        if(isThereAnyErrorInForm(event)) return;

        let pedData = {
            isEnabled: div.find(".ped-enabled").prop("checked"),
            model: div.find(".ped-model").val(),
            heading: parseFloat(div.find(".ped-heading").val()),
        }

        div.modal("hide");

        resolve(pedData);
    })

    div.find(".ped-enabled").prop("checked", currentPedData.isEnabled).change();
    div.find(".ped-model").val(currentPedData.model);
    div.find(".ped-heading").val(currentPedData.heading);

    div.modal("show");

    return promise;
}