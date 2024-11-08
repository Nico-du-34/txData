GenScripts = {}

GenScripts.Framework = "qb" -- es_extended = "esx" - qb-core = "qb"

GenScripts.Language = "en" -- English = "en" - Turkish = "tr" - Deutschland = "de"
-- you can add another language on locales folder

GenScripts.Image = "discord" 
-- Steam = "steam" : you need enter SteamApiKey in server_config.lua
-- Discord = "discord" : you need enter Token in server_config.lua

GenScripts.CoreExport = function()
    if GenScripts.Framework == "esx" then
        return exports['es_extended']:getSharedObject() -- for ESX
    elseif GenScripts.Framework == "qb" then
        return exports['qb-core']:GetCoreObject() -- for QB Core
    end
end

GenScripts.ServerName = "LSH" -- for ui Server Name side
 
------------------------
------ General Configs
------------------------

GenScripts.ServerWait = 1 * 60000 -- 5 min 
GenScripts.ClientWait = 5 * 60000 -- 5 min 

GenScripts.Announce = {
    table = {
        {title = 'Announce Detail', date = '11.05.2024', text = 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc.'},
        {title = 'Announce Detail', date = '11.05.2024', text = 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc.'},
        {title = 'Announce Detail', date = '11.05.2024', text = 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc.'},
        {title = 'Announce Detail', date = '11.05.2024', text = 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc.'},
        {title = 'Announce Detail', date = '11.05.2024', text = 'Lorem ipsum dolor sit amet consectetur. Urna a lobortis vel non purus mi aliquet. Turpis mi quam posuere auctor mi a at nunc.'}
    }
}