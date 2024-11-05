async function dealershipsDialog() { return new Promise(async (resolve, reject) => {
    const allDealerships = await $.post(`https://${resName}/getAllDealerships`);

    const div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070; background: rgba(25, 25, 25, 0.7);">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:dealerships_list")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="input-group">
                        <span class="input-group-text">${getLocalizedText("menu:search_dealership")}</span>
                        <input type="text" class="form-control input-search">
                    </div>
    
                    <ul class="list-group mt-2 elements-list" style="overflow: auto; max-height: 70vh">
    
                    </ul>
                </div>
            </div>
        </div>
    </div>
    `)

    div.find(".input-search").val("").on("keyup", function() {
        let text = $(this).val().toLowerCase();
    
        div.find(".elements-list li").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
        });
    });

    let listDiv = div.find(".elements-list");
    listDiv.empty();

    for(const dealershipData of Object.values(allDealerships)) {
        let dealershipDiv = $(`
            <li class="list-group-item list-group-item-action clickable" data-dealershipdata=${dealershipData} value=${dealershipData.id}>${dealershipData.label}</li>
        `);

        dealershipDiv.click(function() {
            div.modal("hide");
            resolve(dealershipData);
        });

        listDiv.append(dealershipDiv);
    }
        

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });

    div.modal("show");
}); }