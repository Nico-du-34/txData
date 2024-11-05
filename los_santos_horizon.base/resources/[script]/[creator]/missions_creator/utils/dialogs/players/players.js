async function playersDialog() {
    let resolve = null;
    const promise = new Promise((res, rej) => { resolve = res; });

    let div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070; background: rgba(25, 25, 25, 0.7);">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:players_dialog:title")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="input-group">
                        <span class="input-group-text">${getLocalizedText("menu:players_dialog:search_player")}</span>
                        <input type="text" class="form-control player-search">
                    </div>
    
                    <ul class="list-group mt-2 players-list" style="overflow: auto; max-height: 70vh">
    
                    </ul>
                </div>
            </div>
        </div>
    </div>
    `)

    // delete the div when the modal is closed
    div.on("hidden.bs.modal", function() {
        div.remove();
    });

    div.modal("show");

    div.find(".player-search").val("").on("keyup", function() {
        let text = $(this).val().toLowerCase();
    
        div.find(".players-list li").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(text) > -1)
        });
    })
    
    const allPlayers = await $.post(`https://${resName}/getAllPlayersArray`);

    let playersListDiv = div.find(".players-list");
    playersListDiv.empty();

    for(const playerData of allPlayers) {
        let playerDiv = $(`
            <li class="list-group-item list-group-item-action clickable">${playerData.name}</li>
        `);

        playerDiv.click(function() {
            div.modal("hide");
            resolve(playerData.id);
        });

        playersListDiv.append(playerDiv);
    }

    return promise;
}