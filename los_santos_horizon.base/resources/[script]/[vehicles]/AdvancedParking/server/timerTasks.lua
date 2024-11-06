--[[
	Custom license

	Copyright (c) 2021-2023 Philipp Decker

	timerTasks.lua by Discord user Kiminaze#9097

	You are free to use this file for any of your projects. This whole comment needs to be included 
	when doing so.

	The AddTask[...] functions can be used to add a timed task on server side.

	AddTask(task, hours, minutes)
		Takes a time of day and a function that should be run at that time of day.

	AddTaskForEveryHour(task)
		Takes a function that should be run once every single hour.

	AddTaskForEveryMinute(task)
		Takes a function that should be run once every single minute.
--]]

local os_time = os.time
local os_date = os.date
local math_floor = math.floor

local function GetTimeFormatted()
	local dateTime = os_time()

	return {
		hours	= tonumber(os_date("%H", dateTime)),
		minutes	= tonumber(os_date("%M", dateTime))
	}
end

local lastTime = GetTimeFormatted()

local dayTasks		= {}
local hourTasks		= {}
local minuteTasks	= {}

local function OnTimeChanged(time)
	for i = 1, #dayTasks do
		if (dayTasks[i].hours == time.hours and dayTasks[i].minutes == time.minutes) then
			dayTasks[i].Run()
		end
	end
end

local function OnHourChanged()
	for i = 1, #hourTasks do
		hourTasks[i]()
	end
end

local function OnMinuteChanged()
	for i = 1, #minuteTasks do
		minuteTasks[i]()
	end
end

CreateThread(function()
	local currentTime = nil

	while (true) do
		Wait(5000)

		currentTime = GetTimeFormatted()

		if (currentTime.minutes ~= lastTime.minutes) then
			OnTimeChanged(currentTime)

			if (currentTime.hours ~= lastTime.hours) then
				OnHourChanged()
			end

			if (currentTime.minutes ~= lastTime.minutes) then
				OnMinuteChanged()
			end

			lastTime = currentTime
		end
	end
end)



function AddTask(task, h, m, s)
	assert(task ~= nil and type(task) == "function", "Parameter \"task\" must be a function!")

	dayTasks[#dayTasks + 1] = {
		hours	= math_floor(h and h or 0),
		minutes	= math_floor(m and m or 0),
		Run		= task
	}
end

function AddTaskForEveryHour(task)
	assert(task ~= nil and type(task) == "function", "Parameter \"task\" must be a function!")

	hourTasks[#hourTasks + 1] = task
end

function AddTaskForEveryMinute(task)
	assert(task ~= nil and type(task) == "function", "Parameter \"task\" must be a function!")

	minuteTasks[#minuteTasks + 1] = task
end



exports("AddTask", AddTask)
exports("AddTaskForEveryHour", AddTaskForEveryHour)
exports("AddTaskForEveryMinute", AddTaskForEveryMinute)
