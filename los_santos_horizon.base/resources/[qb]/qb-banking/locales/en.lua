local Translations = {
    success = {
        withdraw = 'Retrait effectué avec succès',
        deposit = 'Dépôt effectué avec succès',
        transfer = 'Transfert réussi',
        account = 'Compte créé',
        rename = 'Compte renommé',
        delete = 'Compte supprimé',
        userAdd = 'Utilisateur ajouté',
        userRemove = 'Utilisateur retiré',
        card = 'Carte créée',
        give = '%s$ en espèces donné',
        receive = '%s$ en espèces reçu',
    },
    error = {
        error = 'Une erreur est survenue',
        access = 'Non autorisé',
        account = 'Compte introuvable',
        accounts = 'Nombre maximum de comptes créés',
        user = 'Utilisateur déjà ajouté',
        noUser = 'Utilisateur introuvable',
        money = 'Fonds insuffisants',
        pin = 'PIN invalide',
        card = 'Aucune carte bancaire trouvée',
        amount = 'Montant invalide',
        toofar = 'Vous êtes trop loin',
    },
    progress = {
        atm = 'Accès au distributeur automatique',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
