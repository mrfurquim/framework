local Translations = {
    error = {
        nokey = "Você não tem a Chave!",
    },
    success = { 
        
    },
    info = {
        unlocked = "Destrancada",
        unlocking = "Destrancando",
        locking = "Trancada",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
