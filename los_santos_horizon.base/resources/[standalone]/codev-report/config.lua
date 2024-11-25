Config = {
    Framework = "qb", -- Framework name (esx or qb)

    BotName = "LSH Report", -- Name of the bot that will send the reports to the discord channel
    Webhook = "https://discord.com/api/webhooks/1304924379376779315/FAUprltoU6bJjbzFS0UDK4-FRIFU6JwKDN4mjixitE3y-ztuJMVsRoXCjQl32dXvZQ-v", -- Discord webhook link

    Admins = { -- Discord IDs of the admins
        "discord:1069568643496681562", -- Nico
    },

    Translations = {
        ["report"] = "Signaler",
        ["report_alert"] = "Il y a un nouveau rapport !",
        ["sent"] = "Envoyé",
        ["report_sent"] = "Rapport envoyé avec succès.",
        ["deleted"] = "Supprimé",
        ["report_deleted"] = "Rapport supprimé avec succès.",
        ["bring"] = "Admin",
        ["admin_bringed"] = "Un admin vous a téléporté.",
        ["goto"] = "Admin",
        ["admin_came"] = "Un admin s'est téléporté pour vous aider.",
        ["concluded"] = "Conclu",
    },

    Notification = function(title, message, msgType, length)
        QBCore.Functions.Notify(message, msgType)
    end
}