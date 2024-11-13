Config = {}

Config.Framework = 'qbcore' -- esx, qbcore, autodetect

Config.ServerLogo = 'https://cdn.discordapp.com/attachments/944572269202640946/1023536303180107856/tech2.png?ex=65e44bf7&is=65d1d6f7&hm=ced1dbe69cd051c1ae15bed82a641532b19b9941a9403de462224aa0613ae0ce&'

Config.LicenseType  = 'license' -- steam, discord or license

Config.CanUserOpenStaffStats = true

Config.StaffGroups = {
    'admin',
    'god'
}

Config.KeyMapping = {
    sendImage = {
        key = 'E',
        description = "Send Photo"
    },
    sendImage2 = {
        key = 'BACK',
        description = "Return Back"
    },
    openReport = {
        enable = false,
        key = 'F7',
        description = "Open Report Menu"
    },
    openReportStaff = {
        enable = false,
        key = 'H',
        description = "Open Staff Report Menu"
    },
}

Config.Command = {
    openReport = {
        commandName = 'report',
    },
    openReportStaff = {
        commandName = 'reportstaff',
    }
}

Config.Locales = {
    ['create_new_report'] = "Créer un nouveau rapport",
    ['actions'] = "Actions",
    ['close'] = "Fermer",
    ['dashboard'] = "Tableau de bord",
    ['report_list'] = "Liste des rapports",
    ['report_claimed'] = "Rapport pris en charge",
    ['staff_list'] = "Liste du personnel",
    ['welcome_back'] = "Bon retour",
    ['you_are_available'] = "Vous êtes disponible",
    ['you_are_not_available'] = "Vous n'êtes pas disponible",
    ['latest'] = "Derniers",
    ['report'] = "Rapport",
    ['staff'] = "Personnel",
    ['available'] = "Disponible",
    ['your'] = "Votre",
    ['statistics'] = "Statistiques",
    ['open'] = "Ouvrir",
    ['chat'] = "Chat",
    ['report_closed'] = "Rapport fermé",
    ['sent_messages'] = "Messages envoyés",
    ['staff_chat'] = "Chat du personnel",
    ['type_something'] = "Tapez quelque chose",
    ['set_pos'] = "Cliquez pour définir la position",
    ['search_from_title'] = "Recherche par titre",
    ['user_info'] = "Informations sur l'utilisateur",
    ['chat'] = "Chat",
    ['actions'] = "Actions",
    ['license'] = "Licence",
    ['steam'] = "Steam",
    ['discord'] = "Discord",
    ['not_found'] = "Non trouvé",
    ['view'] = "Voir",
    ['all_reports'] = "Tous les rapports",
    ['set'] = "Définir",
    ['annotation'] = "Annotation",
    ['add_note'] = "Ajouter une note",
    ['current'] = "Actuel",
    ['report_actions'] = "Actions sur le rapport",
    ['user_actions'] = "Actions de l'utilisateur",
    ['claim'] = "Prendre en charge",
    ['claimed'] = "Pris en charge",
    ['goto'] = "Aller à",
    ['bring'] = "Apporter",
    ['freeze'] = "Geler",
    ['search_from_name'] = "Recherche par nom",
    ['player'] = "Joueur",
    ['bug'] = "Bug",
    ['question'] = "Question",
    ['title'] = "Titre",
    ['create'] = "Créer",
    ['loading_information'] = "Chargement des informations...",
    ['send_photo'] = "[E] Envoyer la photo",
    ['return_back'] = "[Backspace] Retour",
    ['closed'] = "Fermé",
    ['report_closed2'] = "Rapport fermé",
}


Config.Notification = {
    ['new_report'] = {
        label = "Nouveaux Report!",
        type = "info"
    },
    ['new_message'] = {
        label = "Nouveaux Message!",
        type = "info"
    },
    ['new_waypoint'] = {
        label = "Le waypoint a été défini",
        type = "info"
    },
    ['your_report_claimed'] = {
        label = "Votre rapport a été revendiqué",
        type = "info"
    }
}

Config.NotificationFunction = function(message, type)
    if Framework == 'esx' then 
        ESX.ShowNotification(message, type)
    elseif Framework == 'qbcore' then
        QBCore.Functions.Notify(message, type)
    end
end