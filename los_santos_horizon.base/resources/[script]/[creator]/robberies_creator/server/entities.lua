RobberiesCreator = RobberiesCreator or {}

-- staticId = heistId-stageId-stepId
local entitiesStaticIdsData = {} -- { [staticId] = { heistId, stageId, stepId, netId=nil, entityData } }
local waitedEntitiesTokens = {} -- { [token] = stepStaticId when waiting}

function RobberiesCreator.areThereObjectsForHeist(heistId)
    for _, entityData in pairs(entitiesStaticIdsData) do
        if(entityData.heistId == heistId) then
            return true
        end
    end

    return false
end

function RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    local entityRuntimeData = entitiesStaticIdsData[stepStaticId]
    return entityRuntimeData
end

function RobberiesCreator.getEntityDataFromEntity(entity)
    if(not DoesEntityExist(entity)) then return end
    
    local stepStaticId = Entity(entity).state.stepStaticId
    if(not stepStaticId) then return end

    return RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
end

function RobberiesCreator.getDataFromObjectNetId(objectNetId)
    local object = NetworkGetEntityFromNetworkId(objectNetId)

    local data = RobberiesCreator.getEntityDataFromEntity(object)
    if(not data) then
        print("^1Data not found for object net id: " .. objectNetId .. "^7")
        return nil
    end

    return data.heistId, data.stageId, data.stepId, data.stepData
end

function RobberiesCreator.spawnEntityInCoords(heistId, stageId, stepId, entityData, index)
    local stepStaticId = RobberiesCreator.getStaticId(heistId, stageId, stepId, index)

    if(entitiesStaticIdsData[stepStaticId]) then
        RobberiesCreator.deleteEntityWithStaticId(stepStaticId)
        Citizen.Wait(1000) -- Wait a bit to avoid issues with the entity deletion
    end

    if(not RobberiesCreator.Heists[heistId]) then return end -- Heist doesn't exist anymore

    local token = Utils.generateToken()

    waitedEntitiesTokens[token] = stepStaticId

    entitiesStaticIdsData[stepStaticId] = {
        heistId = heistId,
        stageId = stageId,
        stepId = stepId,
        netId = nil,
        entityData = entityData,
        stepData = RobberiesCreator.Heists[heistId].stages[stageId].steps[stepId],
        token = token
    }

    debugPrint("Spawning entity", stepStaticId, "in coords: " .. entityData.coordinates.x .. " , " .. entityData.coordinates.y .. " , " .. entityData.coordinates.z)

    TriggerClientEvent(Utils.eventsPrefix .. ":spawnEntityInCoords", -1, heistId, stageId, stepId, stepStaticId, entityData, token)
end

-- Used to avoid spawning the entity 2 times in case when a player enters (AGAIN) the interaction point
local function tellPlayersThatEntityHasAlreadySpawned(stepStaticId, entityNetId, token)
    TriggerClientEvent(Utils.eventsPrefix .. ":runtimeEntitySpawned", -1, stepStaticId, entityNetId, token)
end

-- Used to inform clients that the token is not to be spawned anymore
local function invalidateTokenCompletely(token)
    waitedEntitiesTokens[token] = nil
    TriggerClientEvent(Utils.eventsPrefix .. ":invalidateToken", -1, token)
end

local function DEBUGOUTPUT(msg, entity, stepStaticId)
    local staticIdData = RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    if(not staticIdData) then print("^1DEBUGOUTPUT Couldn't find staticIdData for " .. stepStaticId .. "^7") return end

    local entCoords = GetEntityCoords(entity)
    local stepCoords = vecFromTable(staticIdData.entityData.coordinates)
    local dist = math.floor(#(entCoords - stepCoords))

    if(dist > 20.0) then
        local serverTime = os.date("%H:%M:%S", os.time())
        print("^1DEBUGOUTPUT " .. msg .. " | Distance: " .. dist .. "m | coords " .. tostring(entCoords) .. " | staticId " .. stepStaticId .. " | stepType " .. staticIdData.stepData.method .. " | " .. serverTime, "^7")
    end
end

RegisterNetEvent(Utils.eventsPrefix .. ":entityCreated", function(stepStaticId, entityNetId, token)
    local entityData = RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    if(not waitedEntitiesTokens[token] or not entityData or entityData.token ~= token) then -- Can happen when entityCreated server side is called right after spawnEntityInCoords server side was called another time, deleting entity data
        local success, entity = Utils.waitServerNetId(entityNetId)
        if(not success) then return end

        DeleteEntity(entity)
        return
    end

    waitedEntitiesTokens[token] = nil

    entityData.netId = entityNetId
    tellPlayersThatEntityHasAlreadySpawned(stepStaticId, entityNetId, token)
    
    -- Also handles the issue caused by an entity created correctly, but for any reason disappears and its net ID is replaced before being able to proceed
    -- Can be improved somehow, only checking model is not perfect
    local success, entity = Utils.waitServerNetId(entityNetId)
    if(not success or GetEntityModel(entity) ~= GetHashKey(entityData.entityData.model) or entity == entityNetId) then  -- This can happen if the entity was deleted before Utils.waitServerNetId
        DEBUGOUTPUT("A NET ID " .. tostring(entityNetId), entity, stepStaticId)
        RobberiesCreator.spawnEntityInCoords(entityData.heistId, entityData.stageId, entityData.stepId, entityData.entityData)
        return
    end

    DEBUGOUTPUT("B", entity, stepStaticId)
    Entity(entity).state.stepStaticId = stepStaticId
    SetEntityRoutingBucket(entity, 0)

    DEBUGOUTPUT("C", entity, stepStaticId)

    local heistId, stageId, stepId = entityData.heistId, entityData.stageId, entityData.stepId
    DEBUGOUTPUT("D", entity, stepStaticId)
    local stageData = RobberiesCreator.Heists[heistId].stages[stageId]
    DEBUGOUTPUT("E", entity, stepStaticId)
    local stepData = stageData.steps[stepId]
    DEBUGOUTPUT("F", entity, stepStaticId)

    local stepRuntimeData = RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    DEBUGOUTPUT("H", entity, stepStaticId)

    if(stepRuntimeData.entityData.type == "object") then
        TriggerClientEvent(Utils.eventsPrefix .. ":heist:objectSpawned", -1, entityNetId, GetEntityModel(entity), heistId, stageId, stepData)
    elseif(stepRuntimeData.entityData.type == "ped") then
        Entity(entity).state.isGuard = true
        Entity(entity).state.stepData = stepRuntimeData.entityData
        TriggerClientEvent(Utils.eventsPrefix .. ":heist:activateGuard", -1, entityNetId, GetEntityModel(entity))
    end

    DEBUGOUTPUT("G", entity, stepStaticId)

    if(stepRuntimeData.stepData.method == "SEARCH_POINTS") then
        RobberiesCreator.addAvailableSearchPoint(heistId, stageId, stepId, entityNetId)
    end
end)

RegisterNetEvent(Utils.eventsPrefix .. ":entityCreationFailed", function(stepStaticId)
    local entityData = RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    if(not entityData) then return end

    -- Token is already removed in deleteEntityWithStaticId
    RobberiesCreator.spawnEntityInCoords(entityData.heistId, entityData.stageId, entityData.stepId, entityData.entityData)
end)

function RobberiesCreator.deleteEntityWithStaticId(stepStaticId)    
    local entityData = RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    if(not entityData) then print("^1Entity data not found in deleteEntityWithStaticId^7") return end

    local token = entityData.token
    invalidateTokenCompletely(token)

    entitiesStaticIdsData[stepStaticId] = nil

    Citizen.CreateThread(function()
        local success, entity = Utils.waitServerNetId(entityData.netId)
        if(not success or not DoesEntityExist(entity)) then return end

        DeleteEntity(entity)
    end)
end

function RobberiesCreator.deleteEntitiesForHeistId(heistId)
    for stepStaticId, entityData in pairs(entitiesStaticIdsData) do
        if(entityData.heistId == heistId) then
            local object = NetworkGetEntityFromNetworkId(entityData.netId)
            RobberiesCreator.disableObject(object)

            if(DoesEntityExist(object) and Entity(object).state.isBeingUsed and not Entity(object).state.isUseFinished) then
                RobberiesCreator.addObjectToPendingDeletion(object)
            else
                RobberiesCreator.deleteEntityWithStaticId(stepStaticId)
            end
        end
    end
end

function RobberiesCreator.deleteAllHeistsEntities()
    for stepStaticId, entityData in pairs(entitiesStaticIdsData) do
        RobberiesCreator.deleteEntityWithStaticId(stepStaticId)
    end
end

function RobberiesCreator.deleteAllHeistsEntitiesImmediately(cb)
    local count = 0

    for stepStaticId, entityData in pairs(entitiesStaticIdsData) do
        local object = NetworkGetEntityFromNetworkId(entityData.netId)
        if(DoesEntityExist(object)) then
            DeleteEntity(object)
        end
    end

    if(cb) then cb(count) end
end

function RobberiesCreator.disableObjectsOfHeist(heistId)
    for entity, entityData in pairs(entitiesStaticIdsData) do
        if(entityData.heistId == heistId) then
            RobberiesCreator.disableObject(entity)
        end
    end
end

local searchPointsBeingRestored = {}
local function restoreSearchPoints(heistId, stageId, stepId)
    if(searchPointsBeingRestored[heistId] and searchPointsBeingRestored[heistId][stageId] and searchPointsBeingRestored[heistId][stageId][stepId]) then return end
    searchPointsBeingRestored[heistId] = searchPointsBeingRestored[heistId] or {}
    searchPointsBeingRestored[heistId][stageId] = searchPointsBeingRestored[heistId][stageId] or {}
    searchPointsBeingRestored[heistId][stageId][stepId] = true

    Citizen.Wait(2000)

    -- Delete all search points
    for stepStaticId, entityData in pairs(entitiesStaticIdsData) do
        if(entityData.heistId == heistId and entityData.stageId == stageId and entityData.stepId == stepId) then
            RobberiesCreator.deleteEntityWithStaticId(stepStaticId)
        end
    end

    RobberiesCreator.setupSearchPointsForHeist(heistId, stageId, stepId)
end

-- Respawn in case they get deleted for any reason (outside the indicated functions)
RegisterNetEvent("entityRemoved", function(entity)
    local stepStaticId = Entity(entity).state.stepStaticId
    if(not stepStaticId) then return end

    debugPrint("Heist entity has been deleted", stepStaticId)

    local entityRuntimeData = RobberiesCreator.getEntityDataFromStaticId(stepStaticId)
    if(not entityRuntimeData) then return end

    -- Even if it was deleted, it wasn't needed anymore
    if(Entity(entity).state.isUseFinished) then return end

    local heistId, stageId, stepId, index = RobberiesCreator.extractDataFromStaticId(stepStaticId)
    local entityData = entityRuntimeData.entityData

    entityData.coordinates = GetEntityCoords(entity)
    entityData.rotation = GetEntityRotation(entity, 2)

    if(GetEntityType(entity) == 1) then -- ped
        if(GetEntityHealth(entity) <= 0) then return end -- If the entity is dead, don't respawn it

        entityData.coordinates = entityData.coordinates - vector3(0, 0, 1.0) -- So it spawns properly (peds spawn 1.0 above the ground)
    end
    
    RobberiesCreator.spawnEntityInCoords(heistId, stageId, stepId, entityData, index)
end)

RegisterNetEvent("onResourceStop", function(resource)
    if(resource ~= GetCurrentResourceName()) then return end

    local promise = promise.new()

    RobberiesCreator.deleteAllHeistsEntitiesImmediately(function(deletedObjects)
        print("^3Deleted " .. deletedObjects .. " heists objects^7")
        promise:resolve()
    end)

    Citizen.Await(promise)
end)


--[[
███████ ███    ██ ████████ ██ ████████ ██ ███████ ███████     ██   ██  █████  ███    ██ ██████  ██      ███████ ██████  
██      ████   ██    ██    ██    ██    ██ ██      ██          ██   ██ ██   ██ ████   ██ ██   ██ ██      ██      ██   ██ 
█████   ██ ██  ██    ██    ██    ██    ██ █████   ███████     ███████ ███████ ██ ██  ██ ██   ██ ██      █████   ██████  
██      ██  ██ ██    ██    ██    ██    ██ ██           ██     ██   ██ ██   ██ ██  ██ ██ ██   ██ ██      ██      ██   ██ 
███████ ██   ████    ██    ██    ██    ██ ███████ ███████     ██   ██ ██   ██ ██   ████ ██████  ███████ ███████ ██   ██ 
]]

--[[ Key = Player ID, value = Object handle (Not network id) This will be used to not send twice the same object to the client ]]
local playersAlreadyLoadedObjects = {}

local function addPlayerLoadedObject(playerId, object)
    playersAlreadyLoadedObjects[playerId] = playersAlreadyLoadedObjects[playerId] or {}
    playersAlreadyLoadedObjects[playerId][object] = true
end

local function hasPlayerAlreadyLoadedObject(playerId, object)
    return playersAlreadyLoadedObjects[playerId] and playersAlreadyLoadedObjects[playerId][object]
end

local function forceLoadHeistsStagesObjects(playerId)
    while not RobberiesCreator.haveHeistsBeenSetToFirstStage do Citizen.Wait(2000) end

    local copy = Utils.deepCopy(entitiesStaticIdsData)

    for stepStaticId, runtimeData in pairs(copy) do
        local heistId = runtimeData.heistId
        local currentStageId = RobberiesCreator.getCurrentHeistStage(heistId)

        if(runtimeData.entityData.type == "object" and currentStageId == runtimeData.stageId) then
            if(runtimeData.netId) then -- If it's already spawned, only add the missing interactions points
                local entity = NetworkGetEntityFromNetworkId(runtimeData.netId)
                if(DoesEntityExist(entity) and not hasPlayerAlreadyLoadedObject(playerId, entity)) then
                    TriggerClientEvent(Utils.eventsPrefix .. ":heist:objectSpawned", playerId, runtimeData.netId, GetEntityModel(entity), runtimeData.heistId, runtimeData.stageId, runtimeData.stepData)
                    addPlayerLoadedObject(playerId, entity)

                    debugPrint("Informing about spawn of ", stepStaticId)
                    Citizen.Wait(500) -- Avoids network overflow
                end
            else
                RobberiesCreator.spawnEntityInCoords(heistId, runtimeData.stageId, runtimeData.stepId, runtimeData.entityData)
                Citizen.Wait(500) -- Avoids network overflow
            end
        end

        Citizen.Wait(0)
    end
end

RegisterNetEvent(Utils.eventsPrefix .. ":heist:forceLoadHeistsStagesObjects", function() 
    local playerId = source
    forceLoadHeistsStagesObjects(playerId)
end)

RegisterNetEvent(Utils.eventsPrefix .. ":heist:objectLoaded", function(objectNetId) 
    local playerId = source
    local object = NetworkGetEntityFromNetworkId(objectNetId)

    if(not DoesEntityExist(object)) then return end

    addPlayerLoadedObject(playerId, object)
end)