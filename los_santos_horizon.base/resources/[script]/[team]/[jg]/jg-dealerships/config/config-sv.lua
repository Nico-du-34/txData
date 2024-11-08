RegisterNetEvent("jg-dealerships:server:purchase-vehicle:config", function(vehNetId, plate, purchaseType, amount, paymentMethod, financed)
  local src = source
  local vehicle = NetworkGetEntityFromNetworkId(vehNetId)

end)

lib.callback.register("jg-dealerships:server:showroom-pre-check", function(src, dealershipId)
  local allowed = true

  -- Write some server-sided code here. Again, update the "allowed" variable

  if not allowed then
    Framework.Server.Notify(src, "Vous n'êtes pas autorisé à accéder à la salle d'exposition (server-side)", "error")
    return false
  end

  return true
end)
