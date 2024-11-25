function handleInitialState()
	local voiceModeData = Cfg.voiceModes[mode]
	MumbleSetTalkerProximity(voiceModeData[1] + 0.0)
	MumbleClearVoiceTarget(voiceTarget)
	MumbleSetVoiceTarget(voiceTarget)
	MumbleSetVoiceChannel(LocalPlayer.state.assignedChannel)

	while MumbleGetVoiceChannelFromServerId(playerServerId) ~= LocalPlayer.state.assignedChannel do
		Wait(250)
		MumbleSetVoiceChannel(LocalPlayer.state.assignedChannel)
	end

	MumbleAddVoiceTargetChannel(voiceTarget, LocalPlayer.state.assignedChannel)

	addNearbyPlayers()
end

AddEventHandler('mumbleConnected', function(address, isReconnecting)
	logger.info('Connected to mumble server with address of %s, is this a reconnect %s',
		GetConvarInt('voice_hideEndpoints', 1) == 1 and 'HIDDEN' or address, isReconnecting)

	logger.log('Connecting to mumble, setting targets.')
	-- don't try to set channel instantly, we're still getting data.
	local voiceModeData = Cfg.voiceModes[mode]
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance = voiceModeData[1],
		mode = voiceModeData[2],
	}, true)

	handleInitialState()

	logger.log('Finished connection logic')
end)

AddEventHandler('mumbleDisconnected', function(address)
	logger.info('Disconnected from mumble server with address of %s',
		GetConvarInt('voice_hideEndpoints', 1) == 1 and 'HIDDEN' or address)
end)

-- TODO: Convert the last Cfg to a Convar, while still keeping it simple.
AddEventHandler('pma-voice:settingsCallback', function(cb)
	cb(Cfg)
end)


-- Addon
local dist = 0

AddEventHandler('pma-voice:setTalkingMode', function(data)
    local ped = PlayerPedId()
    local plyState = Player(LocalPlayer).state
    local proximity = plyState.proximity
    local StartMarker = 0 
     
    dist = proximity.distance
    StartMarker = 0
    while StartMarker < 200 do
        if dist ~= proximity.distance then
            break
        else
        StartMarker = StartMarker + 1
        DrawMarker(1, GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z - 1, 0, 0, 0, 0, 0, 0, proximity.distance, proximity.distance, 0.2, 0, 155, 255, 255, 0, 0, 0, 0)
        Wait(1)
        end
    end
end)