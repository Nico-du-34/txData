let selectedCategory;
let color;

$(".dealership-notification").hide();

window.addEventListener("message", async function(event){
    let data = event.data;

    switch(data.action) {
        case "showBuyPage":
            showBuyPage(data.dealershipInfo);
            display(true);
            break;

        case "toggleDisplay": {
            display(data.display);
            break;
        }

        case "openManagementOptions": {
            CURRENT_DEALERSHIP_ID = data.dealershipId;
            openManagementOptions();
            break;
        }

        case "showManagementPage": {
            CURRENT_DEALERSHIP_ID = data.dealershipId;
            showManagementPage(data.employeesData);
            break;
        }

        case "openHireEmployee": {
            CURRENT_DEALERSHIP_ID = data.dealershipId;
            openHireEmployee(data.closePlayers);
            break;
        }

        case "openEmployeeMenu": {
            CURRENT_DEALERSHIP_ID = data.dealershipId;
            openEmployeeMenu();
            break;
        }

        case "askInput": {
            const value = await askInput(data.label, data.description, data.type, data.placeholder);
            $.post(`https://${resName}/askInputCallback`, JSON.stringify({value}));

            break;
        }

        case "listDialog": {
            const value = await dealershipListDialog(data.elements);
            $.post(`https://${resName}/listDialogCallback`, JSON.stringify({value}));
        }
    }
})