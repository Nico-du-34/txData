Citizen.CreateThread(function()


RequestIpl("rfc_church_milo_")

    interiorID = GetInteriorAtCoords(-776.75120000, -5.43450000, 47.87502000)
        
    
    if IsValidInterior(interiorID) then      
            DisableInteriorProp(interiorID, "rfc_church_wedding") -- Write "EnableInteriorProp" to Wedding Mode
            DisableInteriorProp(interiorID, "rfc_church_funeral") -- Write "EnableInteriorProp" to Funeral Mode
            
    RefreshInterior(interiorID)

    end

end)