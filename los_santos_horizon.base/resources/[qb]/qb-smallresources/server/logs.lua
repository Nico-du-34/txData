local QBCore = exports['qb-core']:GetCoreObject()
local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/1302373799836258455/v3GsmooJSyG1SCs0DHnlD0dScHRiZ_M0_x0cPnprw7CAYDQm2kJaED6vKuFeaUgK_lU8',
    ['testwebhook'] = 'https://discord.com/api/webhooks/1302373799836258455/v3GsmooJSyG1SCs0DHnlD0dScHRiZ_M0_x0cPnprw7CAYDQm2kJaED6vKuFeaUgK_lU8',
    ['playermoney'] = 'https://discord.com/api/webhooks/1302372143211745413/HnaE7tYZrOUZ8IcpP3jYFDmFC7SFXv5uY2EsziHa3taGbfctgO2N7usceS7c3ZR929ct',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1302372143211745413/HnaE7tYZrOUZ8IcpP3jYFDmFC7SFXv5uY2EsziHa3taGbfctgO2N7usceS7c3ZR929ct',
    ['robbing'] = 'https://discord.com/api/webhooks/1302372420992237739/kNNINoWp4VjKcBOQ8v_m-OIcGn31OGO4AYwOidSfLTMXM6EOq162AIXaF5kuGTJe0Vtv',
    ['cuffing'] = 'https://discord.com/api/webhooks/1302372143211745413/HnaE7tYZrOUZ8IcpP3jYFDmFC7SFXv5uY2EsziHa3taGbfctgO2N7usceS7c3ZR929ct',
    ['drop'] = 'https://discord.com/api/webhooks/1302372633219829830/rNzm85cb6GpUse5mQrnSlmfpL2ov9grKkoxZGMjP-ptC8_R_tAvWHuguWzizdkUVma5c',
    ['trunk'] = 'https://discord.com/api/webhooks/1302372633219829830/rNzm85cb6GpUse5mQrnSlmfpL2ov9grKkoxZGMjP-ptC8_R_tAvWHuguWzizdkUVma5c',
    ['stash'] = 'https://discord.com/api/webhooks/1302372633219829830/rNzm85cb6GpUse5mQrnSlmfpL2ov9grKkoxZGMjP-ptC8_R_tAvWHuguWzizdkUVma5c',
    ['glovebox'] = 'https://discord.com/api/webhooks/1302372633219829830/rNzm85cb6GpUse5mQrnSlmfpL2ov9grKkoxZGMjP-ptC8_R_tAvWHuguWzizdkUVma5c',
    ['banking'] = 'https://discord.com/api/webhooks/1302372143211745413/HnaE7tYZrOUZ8IcpP3jYFDmFC7SFXv5uY2EsziHa3taGbfctgO2N7usceS7c3ZR929ct',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/1302373360059289660/IfenXglaM1WHTJ626gt0hozphsrSILFqzvJam_K8KYCuLVR4v3vUDYgjtEsZIlT7wv14',
    ['shops'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['dealers'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['storerobbery'] = 'https://discord.com/api/webhooks/1302372420992237739/kNNINoWp4VjKcBOQ8v_m-OIcGn31OGO4AYwOidSfLTMXM6EOq162AIXaF5kuGTJe0Vtv',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/1302372420992237739/kNNINoWp4VjKcBOQ8v_m-OIcGn31OGO4AYwOidSfLTMXM6EOq162AIXaF5kuGTJe0Vtv',
    ['powerplants'] = 'https://discord.com/api/webhooks/1302373799836258455/v3GsmooJSyG1SCs0DHnlD0dScHRiZ_M0_x0cPnprw7CAYDQm2kJaED6vKuFeaUgK_lU8',
    ['death'] = 'https://discord.com/api/webhooks/1302372143211745413/HnaE7tYZrOUZ8IcpP3jYFDmFC7SFXv5uY2EsziHa3taGbfctgO2N7usceS7c3ZR929ct',
    ['joinleave'] = 'https://discord.com/api/webhooks/1302372038400544828/8xYeMHd_FhScfnEt_uO4OKa91DeRCvnZhBv7D79VjH0uO-95kuMI-kmA6N6tnJaKXFPn',
    ['ooc'] = 'https://discord.com/api/webhooks/1302373799836258455/v3GsmooJSyG1SCs0DHnlD0dScHRiZ_M0_x0cPnprw7CAYDQm2kJaED6vKuFeaUgK_lU8',
    ['report'] = 'https://discord.com/api/webhooks/1302373689400234044/-KaNC3wyFGZmdmiT3Yp66f17KOlag8jDMVtfqTjvfqNbUCr60Q8rj6xUhxzfnhq0OYgw',
    ['me'] = 'https://discord.com/api/webhooks/1302372143211745413/HnaE7tYZrOUZ8IcpP3jYFDmFC7SFXv5uY2EsziHa3taGbfctgO2N7usceS7c3ZR929ct',
    ['pmelding'] = 'https://discord.com/api/webhooks/1302373799836258455/v3GsmooJSyG1SCs0DHnlD0dScHRiZ_M0_x0cPnprw7CAYDQm2kJaED6vKuFeaUgK_lU8',
    ['112'] = 'https://discord.com/api/webhooks/1302373799836258455/v3GsmooJSyG1SCs0DHnlD0dScHRiZ_M0_x0cPnprw7CAYDQm2kJaED6vKuFeaUgK_lU8',
    ['bans'] = 'https://discord.com/api/webhooks/1302373556985921667/vKpBTjCNb0mJ01U6LpnhLGLkFrHrQ60F2mG_OxbVqslK-FUkk2Ml2fnXssNb4B1sOzwZ',
    ['anticheat'] = 'https://discord.com/api/webhooks/1302373556985921667/vKpBTjCNb0mJ01U6LpnhLGLkFrHrQ60F2mG_OxbVqslK-FUkk2Ml2fnXssNb4B1sOzwZ',
    ['weather'] = 'https://discord.com/api/webhooks/1302373228752404623/hhUNeUjNoj4PqQJoJSbXTbSdYeb1r8qx8lakGx304I4IFvpVYZZUOV3tJjMLteO77ejq',
    ['moneysafes'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['bennys'] = 'https://discord.com/api/webhooks/1302373360059289660/IfenXglaM1WHTJ626gt0hozphsrSILFqzvJam_K8KYCuLVR4v3vUDYgjtEsZIlT7wv14',
    ['bossmenu'] = 'https://discord.com/api/webhooks/1302373360059289660/IfenXglaM1WHTJ626gt0hozphsrSILFqzvJam_K8KYCuLVR4v3vUDYgjtEsZIlT7wv14',
    ['robbery'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['casino'] = 'https://discord.com/api/webhooks/1302373360059289660/IfenXglaM1WHTJ626gt0hozphsrSILFqzvJam_K8KYCuLVR4v3vUDYgjtEsZIlT7wv14',
    ['traphouse'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['911'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['palert'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['house'] = 'https://discord.com/api/webhooks/1302372859511050272/Ihe6p6fHxnYdgAXqe55u0CpN8-y_l-kUCk1kMGNyUE1j8REAPDlXJpzNKDOsSACYCSNV',
    ['qbjobs'] = 'https://discord.com/api/webhooks/1302373360059289660/IfenXglaM1WHTJ626gt0hozphsrSILFqzvJam_K8KYCuLVR4v3vUDYgjtEsZIlT7wv14',
    ['ps-adminmenu'] = 'https://discord.com/api/webhooks/1302373689400234044/-KaNC3wyFGZmdmiT3Yp66f17KOlag8jDMVtfqTjvfqNbUCr60Q8rj6xUhxzfnhq0OYgw',
} 

local colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

local logQueue = {}
--[[local oxmysql = exports['oxmysql']

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local postData = {}
    local tag = tagEveryone or false
    if not Webhooks[name] then print('Tried to call a log that isn\'t configured with the name of ' ..name) return end
    local webHook = Webhooks[name] ~= '' and Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = colors[color] or colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'City RP | Logs',
                ['icon_url'] = 'https://media.discordapp.net/attachments/1084276130804150352/1221105454982369340/city1024tr.png?ex=66115e13&is=65fee913&hm=4818e96b00427a6ad22949f94281c623354edaf4f6f4dc9cc71c474d9c18c82a&=&format=webp&quality=lossless&width=676&height=676',
            },
        }
    }

-- Log to MySQL using oxmysql
    local dataToInsert = {
        title = title,
        color = colors[color] or colors['default'],
        footer = os.date('%c'),
        description = message,
        author = 'City RP | Logs'
    }

-- Asynchronous insertion
    oxmysql:insert('INSERT INTO logs (title, color, footer, description, author) VALUES (?, ?, ?, ?, ?)',
        { 
            dataToInsert.title,
            dataToInsert.color,
            dataToInsert.footer,
            dataToInsert.description,
            dataToInsert.author
        },
        function(rowsAffected, lastInsertedId)
            -- Check if insertion was successful
            if rowsAffected > 0 then
                print('Log successfully saved to MySQL.')
            else
                print('Failed to save log to MySQL.')
            end
        end
    )

    -- Posting to Discord remains the same as before
    if not logQueue[name] then logQueue[name] = {} end
    logQueue[name][#logQueue[name] + 1] = {webhook = webHook, data = embedData}

    if #logQueue[name] >= 10 then
        if tag then
            postData = {username = 'City RP | Logs', content = '@everyone', embeds = {}}
        else
            postData = {username = 'City RP | Logs', embeds = {}}
        end
        for i = 1, #logQueue[name] do postData.embeds[#postData.embeds + 1] = logQueue[name][i].data[1] end
        PerformHttpRequest(logQueue[name][1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })
        logQueue[name] = {}
    end
end)]]


RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local postData = {}
    local tag = tagEveryone or false
    if not Webhooks[name] then print('Tried to call a log that isn\'t configured with the name of ' ..name) return end
    local webHook = Webhooks[name] ~= '' and Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = colors[color] or colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'LSH | Logs',
                ['icon_url'] = '',
            },
        }
    }

    if not logQueue[name] then logQueue[name] = {} end
    logQueue[name][#logQueue[name] + 1] = {webhook = webHook, data = embedData}

    if #logQueue[name] >= 10 then
        if tag then
            postData = {username = 'LSH | Logs', content = '@everyone', embeds = {}}
        else
            postData = {username = 'LSH | Logs', embeds = {}}
        end
        for i = 1, #logQueue[name] do postData.embeds[#postData.embeds + 1] = logQueue[name][i].data[1] end
        PerformHttpRequest(logQueue[name][1].webhook, function() end, 'POST', json.encode(postData), { ['Content-Type'] = 'application/json' })
        logQueue[name] = {}
    end
end)

Citizen.CreateThread(function()
    local timer = 0
    while true do
        Wait(1000)
        timer = timer + 1
        if timer >= 60 then -- If 60 seconds have passed, post the logs
            timer = 0
            for name, queue in pairs(logQueue) do
                if #queue > 0 then
                    local postData = {username = 'LSH | Logs', embeds = {}}
                    for i = 1, #queue do
                        postData.embeds[#postData.embeds + 1] = queue[i].data[1]
                    end
                    PerformHttpRequest(queue[1].webhook, function() end, 'POST', json.encode(postData), {['Content-Type'] = 'application/json'})
                    logQueue[name] = {}
                end
            end
        end
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')