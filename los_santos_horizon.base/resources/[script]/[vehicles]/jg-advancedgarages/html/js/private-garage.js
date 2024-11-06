async function onPrivateGarageCreate(e) {
  e.preventDefault();

  const garageName = e.target[1].value;
  const playerId = parseInt(e.target[2].value);

  await fetch(`https://jg-advancedgarages/createPrivGarage`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({
      garageName,
      playerId
    }),
  }).then(r => r.json()).then((r) => {
    if(!r.error) privGarageCreatorModal.hide();
  });
}

function showPrivateGarageCreator(data) {
  const {allPlayers = []} = data;

  document.querySelector("#priv-garage-players-list").innerHTML = !allPlayers.length ? 
    '<option disabled>Pas de joueurs en ligne</option>' : 
    `${allPlayers.map(({id, name}) => `<option value="${id}">${name} (#${id})</option>`)}`;

  privGarageCreatorModal.show();
}