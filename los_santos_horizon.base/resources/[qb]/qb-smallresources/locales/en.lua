local Translations = {
    afk = {
        will_kick = 'Vous êtes AFK et serez expulsé dans ',
        time_seconds = ' secondes!',
        time_minutes = ' minute(s)!',
        kick_message = 'Vous avez été expulsé pour être AFK'
    },
    wash = {
        in_progress = "Le véhicule est en cours de lavage...",
        wash_vehicle = "[E] Laver le véhicule",
        wash_vehicle_target = "Laver le véhicule",
        dirty = "Le véhicule n'est pas sale",
        cancel = "Lavage annulé..."
    },
    consumables = {
        eat_progress = "En train de manger...",
        drink_progress = "En train de boire...",
        liqour_progress = "En train de boire de l'alcool...",
        coke_progress = "Un petit sniff rapide...",
        crack_progress = "En train de fumer du crack...",
        ecstasy_progress = "Prend des pilules",
        healing_progress = "En train de se soigner",
        meth_progress = "En train de fumer de la méthamphétamine",
        joint_progress = "Allume un joint...",
        use_parachute_progress = "En train de mettre un parachute...",
        pack_parachute_progress = "En train de plier le parachute...",
        no_parachute = "Vous n'avez pas de parachute!",
        armor_full = "Vous avez déjà suffisamment d'armure!",
        armor_empty = "Vous ne portez pas de gilet...",
        armor_progress = "En train de mettre l'armure...",
        heavy_armor_progress = "En train de mettre une armure lourde...",
        remove_armor_progress = "En train de retirer l'armure...",
        canceled = "Annulé..."
    },
    cruise = {
        unavailable = "Régulateur de vitesse indisponible",
        activated = "Régulateur de vitesse activé",
        deactivated = "Régulateur de vitesse désactivé"
    },
    editor = {
        started = "Enregistrement démarré!",
        save = "Enregistrement sauvegardé!",
        delete = "Enregistrement supprimé!",
        editor = "À plus tard, alligator!"
    },
    firework = {
        place_progress = "Placement du feu d'artifice...",
        canceled = "Annulé...",
        time_left = "Lancement du feu d'artifice dans ~r~"
    },
    seatbelt = {
        use_harness_progress = "Attache du harnais de course",
        remove_harness_progress = "Retrait du harnais de course",
        no_car = "Vous n'êtes pas dans une voiture."
    },
    teleport = {
        teleport_default = 'Utiliser l\'ascenseur'
    },
    pushcar = {
        stop_push = "[E] Arrêter de pousser"
    }
}


Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})