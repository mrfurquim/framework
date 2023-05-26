local Translations = {
    error = {
        no_arrows_your_inventory_load = 'Sem flechas..',
        max_mmo_capacity = 'Arma com capacidade Máxima',
        wrong_ammo_for_weapon = 'Munição para arma errada',
        you_are_not_holding_weapon = 'Você não está segurando uma Arma',
    },
    success = {
        weapon_reloaded = 'Arma Recarregada',
    },
    primary = {
        var = 'text goes here',
    },
    menu = {
        var = 'text goes here',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
