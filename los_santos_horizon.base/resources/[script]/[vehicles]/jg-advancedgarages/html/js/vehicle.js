async function onChangeVehiclePlate(e) {
  e.preventDefault();

  const curPlate = e.target[1].value;
  const newPlate = e.target[2].value.toUpperCase();

  await fetch(`https://jg-advancedgarages/changeVehiclePlate`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({
      curPlate,
      newPlate
    }),
  });

  changeVehiclePlateModal.hide();
}

function showChangeVehiclePlate(plate) {
  document.querySelector("#cur-plate").value = plate;

  changeVehiclePlateModal.show();
}