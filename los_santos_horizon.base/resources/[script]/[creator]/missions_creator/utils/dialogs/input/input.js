async function input(title, message, infoText) {
    let div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <form class="modal-content needs-validation" novalidate>
                <div class="modal-header">
                    <h5 class="modal-title">${title}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <p class="text-center text-warning">${infoText}</p>

                    <div class="form-floating">
                        <input type="text" class="form-control" placeholder="..." required>
                        <label>${message}</label>
                    </div>
                </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">${getLocalizedText("menu:close")}</button>
                    <button type="submit" class="btn btn-success">${getLocalizedText("menu:save")}</button>
                </div>
            </form>
        </div>
    </div>
    `)

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });
    div.modal("show");

    return new Promise((resolve) => {
        div.on("submit", function(event) {
            if(isThereAnyErrorInForm(event)) return;

            let input = div.find("input").val();
            div.modal("hide");
            resolve(input);
        });
    });
}