async function objectsMapperDialog(objects = []) {
    if(objects.length == 0) return {};
    
    let div = $(`
    <div class="modal fade" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" role="dialog" style="z-index: 1070;">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">${getLocalizedText("menu:items_dialog:title")}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <p class="text-warning">${getLocalizedText("menu:required_items_info")}</p>
    
                    <ul class="list-group mt-2 objects-list scrollbar" style="overflow: auto; max-height: 70vh">
    
                    </ul>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary use-placeholders-btn">${getLocalizedText("menu:use_placeholders")}</button>
                    <button type="button" class="btn btn-success keep-objects-names-btn" data-bs-dismiss="modal">${getLocalizedText("menu:keep_items_names")}</button>
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
    
    let objectsListDiv = div.find(".objects-list");

    const objectsExistance = await $.post(`https://${GetParentResourceName()}/getObjectsExistance`, JSON.stringify(objects));

    let nameMap = {
        item: {},
        account: {},
        weapon: {},
    };

    objects.forEach(objectData => {
        const elementToAdd = $(`
        <li class="list-group-item list-group-item-action d-flex align-content-center justify-content-between">
            <span class="object-names-wrap my-auto">
                <span class="original-name" data-object-name="${objectData.name}" data-object-type="${objectData.type}">${objectData.name}</span>
                <span class="new-name text-success ms-2" style="display:none;" data-new-object-name=""></span>
            </span>
            <button type="button" class="btn btn-secondary col-auto choose-object-btn"><i class="bi bi-list-ul"></i></button>	
        </li>
        `);
    
        nameMap[objectData.type][objectData.name] = "CHANGE_ITEM_NAME";
    
        elementToAdd.find(".choose-object-btn").click(async() => {
            const newName = await objectDialog(objectData.type);
            if (!newName) return;
    
            elementToAdd.find(".original-name").css("text-decoration", "line-through");    
            elementToAdd.find(".new-name").data("newItemName", newName).text(newName).show();

            nameMap[objectData.type][objectData.name] = newName;
        });
    
        objectsExistance[objectData.type][objectData.name] ? elementToAdd.addClass("text-success") : elementToAdd.addClass("text-danger");
    
        objectsListDiv.append(elementToAdd);
    });
    
    return new Promise((resolve) => {
        div.find(".use-placeholders-btn").click(() => {
            resolve(nameMap);
            div.modal("hide");
        });
    
        div.find(".keep-objects-names-btn").click(() => {

            for(const [objectType, mappedNames] of Object.entries(nameMap)) {
                for(const [objectName, newName] of Object.entries(mappedNames)) {
                    if(newName === "CHANGE_ITEM_NAME") { // keep the original name
                        nameMap[objectType][objectName] = objectName;
                    }
                }
            }

            resolve(nameMap);
            div.modal("hide");
        });
    });    
}