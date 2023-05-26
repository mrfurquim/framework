local Translations = {
    error = {
        error_var = 'Example Text',
    },
    success = {
        success_var = 'Example Text',
    },
    primary = {
        primary_var = 'Example Text',
    },
    menu = {
        make_a_note  = 'Escrever Nota',
        message      = 'Mensagem:',
        written_by   = 'Escrito por: ',
        tear_up_note = 'Pegar Nota',
    },
    text = {
        enter_message = 'Escreva sua mensagem'
    },
    targetinfo = {
        read_note = 'Ler Nota',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
