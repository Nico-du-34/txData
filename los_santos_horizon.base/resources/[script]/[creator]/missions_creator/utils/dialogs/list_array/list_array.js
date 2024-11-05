async function listArrayDialog(title, searchBarText, elements, alreadySelectedElements, messageWhenEmpty) {
    let div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${title}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="input-group search-bar-div">
                        <span class="input-group-text">${searchBarText}</span>
                        <input type="text" class="form-control element-search">
                    </div>
    
                    <ul class="list-group mt-2 elements-list scrollbar" style="overflow: auto; max-height: 70vh">
    
                    </ul>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
                    <button type="button" class="btn btn-success confirm-btn" data-bs-dismiss="modal">${getLocalizedText("menu:confirm")}</button>
                </div>
            </div>
        </div>
    </div>
    `)

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });

    if(elements.length == 0) div.find(".elements-list").append(`<p class="text-center">${messageWhenEmpty}</p>`);
    if(elements.length < 6) div.find(".search-bar-div").hide();

    div.modal("show");

    div.find(".element-search").val("").on("keyup", function() {
        let text = $(this).val().toLowerCase();
    
        div.find(".elements-list li").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
        });
    })
    
    let itemsListDiv = div.find(".elements-list");
    
    elements.forEach(element => {
        const elementDiv = $(`
            <li class="list-group-item list-group-item-action clickable" data-element-value=${element.value}>
                <div class="form-check my-auto">
                    <input class="form-check-input" type="checkbox" value="">
                    <label class="form-check-label">${element.label}</label>
                </div>
            </li>
        `);

        itemsListDiv.append(elementDiv);
    });

    itemsListDiv.on("click", ".list-group-item", function(e) {
        const checkbox = $(this).find(".form-check-input")[0];
        if (e.target === checkbox) return;

        checkbox.checked = !checkbox.checked;
    });

    alreadySelectedElements.forEach(element => {
        itemsListDiv.find(`[data-element-value="${element}"]`).find("input").prop("checked", true);
    });

    return new Promise((resolve) => {
        div.find(".confirm-btn").click(function() {
            let values = [];
            
            div.find(".list-group-item").each(function() {
                if ($(this).find("input").is(":checked")) {
                    values.push($(this).data("element-value"));
                }
            });

            div.modal("hide");
            resolve(values);
        });

        div.find(".element-search").keydown(function(e) {
            if (e.keyCode != 13) return;
            
            let searchContent = $(this).val();
            div.modal("hide");
            resolve(searchContent);
        });
    });
}