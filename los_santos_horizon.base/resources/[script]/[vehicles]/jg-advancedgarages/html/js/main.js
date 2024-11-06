let impoundModal = false,
  impoundFormModal = false,
  garageModal = false,
  privGarageCreatorModal = false,
  changeVehiclePlateModal = false,
  currentVehiclePlate = false;

async function closeNUI() {
  await fetch(`https://jg-advancedgarages/close`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
  });
}

function main() {
  window.addEventListener("message", ({ data }) => {
    switch (data.type) {
      case "showGarage":
        showGarage(data);
        break;
      case "showImpound":
        showImpound(data);
        break;
      case "showImpoundForm":
        showImpoundForm(data);
        break;
      case "showPrivGarageCreator":
        showPrivateGarageCreator(data);
        break;
      case "showChangeVehiclePlate":
        showChangeVehiclePlate(data.plate);
        break;
      default:
        console.log("No action received.");
        break;
    }
  });

  impoundModal = new bootstrap.Modal(
    document.getElementById("show-impounded-vehicles")
  );
  impoundFormModal = new bootstrap.Modal(
    document.getElementById("impound-form")
  );
  garageModal = new bootstrap.Modal(
    document.getElementById("show-garage-vehicles")
  );
  privGarageCreatorModal = new bootstrap.Modal(
    document.getElementById("priv-garage-creator")
  );
  changeVehiclePlateModal = new bootstrap.Modal(
    document.getElementById("change-vehicle-plate-form")
  );

  document.querySelectorAll(".modal").forEach((modal) => {
    modal.addEventListener("hidden.bs.modal", () => {
      closeNUI();
    });
  });
}

main();
