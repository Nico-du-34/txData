Date.prototype.addHours = function(h) {
  this.setTime(this.getTime() + (h*60*60*1000));
  return this;
}

function impoundRetrievableChange(e) {
  const display = e.target.checked ? "block" : "none";
  document.querySelector("#impound-form-cost").style.display = display;
}

async function impoundTakeOut(plate, impoundId) {
  await fetch(`https://jg-advancedgarages/impoundTakeOutVehicle`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({ plate, impoundId }),
  });

  impoundModal.hide();
}

async function impoundReturn(plate) {
  await fetch(`https://jg-advancedgarages/impoundReturnVehicle`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({ plate }),
  });

  impoundModal.hide();
}

async function onImpoundSubmit(e) {
  e.preventDefault();

  const reason = e.target[2].value;
  const retrievable = e.target[3].checked;
  const retrievalHours = parseInt(e.target[4].value || "0");
  const retrievalCost = parseInt(e.target[5].value || "0");

  await fetch(`https://jg-advancedgarages/impoundVehicle`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({
      plate: currentVehiclePlate,
      reason,
      retrievable,
      retrievalCost,
      retrievalDate: new Date().addHours(retrievalHours).toString(),
    }),
  });

  impoundFormModal.hide();
}

function showImpoundForm(data) {
  const { plate, currencySymbol } = data;
  currentVehiclePlate = plate;

  document.querySelector("#vehiclePlate").value = plate;
  document.querySelector("#currencySymbol").innerHTML = currencySymbol;

  impoundFormModal.show();
}

function showImpound(data) {
  const { vehicles = [], impoundId, isWhitelist, currencySymbol } = data;
  let accordionContent = "";

  if (!vehicles.length)
    accordionContent = "There are no vehicles in the impound.";

  for (let [i, veh] of vehicles.entries()) {
    const { plate, impound_retrievable, impound_data, vehicleLabel } = veh;
    const metadata = JSON.parse(impound_data || "{}");
    const isAvailable = new Date() > new Date(metadata.retrieval_date);
    const availableDate = new Date(metadata.retrieval_date).toLocaleDateString("en-GB", {day: 'numeric', month: 'long', hour: 'numeric', minute: 'numeric', timeZoneName: 'short'});

    accordionContent += `
      <div class="accordion-item">
        <h2 class="accordion-header" id="heading-${i}">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#impound-collapse-${i}" aria-expanded="true" aria-controls="impound-collapse-${i}">
            <div class="d-flex flex-fill justify-content-between">  
              <div>
                ${vehicleLabel}
                <div class="badge bg-dark text-warning ms-2" style="font-family:monospace">${plate}</div>
              </div>
              <div class="me-3">
                ${!isWhitelist ? (isAvailable ? `<div class="badge bg-success">Disponible</div>` : `<div class="badge bg-warning">Disponible ${availableDate}</div>`) : ""}
              </div>
            </div>
          </button>
        </h2>
        <div id="impound-collapse-${i}" class="accordion-collapse collapse" aria-labelledby="heading-${i}" data-bs-parent="#impounded-vehicles-list">
          <div class="accordion-body">
            <p><span class="text-muted">Mis en Fourriére par:</span> ${metadata.charname}</p>
            <p><span class="text-muted">Raison:</span> ${metadata.reason || "Aucune raison fournie"}</p>
            ${isWhitelist ? `<p><span class="text-muted">Récupable par le propriétaire:</span> ${impound_retrievable ? `Oui <span class="badge bg-warning ms-1">Disponible ${availableDate}</span>` : "Non"}</p>` : ""}

            <div class="d-flex justify-content-between">
              ${(isWhitelist || isAvailable) ? `<button class="btn btn-success" onclick="impoundTakeOut('${plate}', '${impoundId}')">Sortir${!isWhitelist ? `<span class="badge bg-white text-success ms-1">${currencySymbol}${metadata.retrieval_cost}</span>` : ""}</button>` : ""}
              ${isWhitelist ? `<button class="btn btn-secondary" onclick="impoundReturn('${plate}')">Retour au garage du propriétaire</button>` : ""}
            </div>
          </div>
        </div>
      </div>
    `;
  }

  document.querySelector("#impounded-vehicles-list").innerHTML =
    accordionContent;

  impoundModal.show();
}
