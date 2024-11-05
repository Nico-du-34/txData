Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = PlayerPedId()
        if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
            local chance_result = math.random()
            if chance_result < 0.50 then
                Citizen.Wait(600)     
                SetPedToRagdoll(ped, 5000, 1, 2)
            else
                Citizen.Wait(2000)
            end
        end
    end
end)