Translations = Translations or {
    notifications = {
        ["char_deleted"] = "Personagem deletado!",
        ["deleted_other_char"] = "Você deletou com sucesso o personagem com o ID do cidadão %{citizenid}.",
        ["forgot_citizenid"] = "Você esqueceu de inserir o ID do cidadão!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "Deleta o personagem de outro jogador",
        ["citizenid"] = "ID do cidadão",
        ["citizenid_help"] = "O ID do cidadão do personagem que você deseja deletar",
    
        -- /logout
        ["logout_description"] = "Desconectar do Personagem (Somente Admin)",
    
        -- /closeNUI
        ["closeNUI_description"] = "Fechar Multi NUI"
    },
    
    misc = {
        ["droppedplayer"] = "Você se desconectou do QRCore"
    },
    
    ui = {
        -- Main
        characters_header = "Meus Personagens",
        emptyslot = "Espaço Vazio",
        play_button = "Jogar",
        create_button = "Criar Personagem",
        delete_button = "Deletar Personagem",
    
        -- Informações do Personagem
        charinfo_header = "Informações do Personagem",
        charinfo_description = "Selecione um espaço de personagem para ver todas as informações sobre o seu personagem.",
        name = "Nome",
        male = "Masculino",
        female = "Feminino",
        firstname = "Nome",
        lastname = "Sobrenome",
        nationality = "Nacionalidade",
        gender = "Gênero",
        birthdate = "Data de Nascimento",
        job = "Emprego",
        jobgrade = "Grau de Emprego",
        cash = "Dinheiro",
        bank = "Banco",
        phonenumber = "Número de Telefone",
        accountnumber = "Número de Conta",
    
        chardel_header = "Registro de Personagem",
    
        -- Deletar Personagem
        deletechar_header = "Deletar Personagem",
        deletechar_description = "Você tem certeza que deseja deletar seu personagem?",
    
        -- Botões
        cancel = "Cancelar",
        confirm = "Confirmar",
    
        -- Texto de Carregamento
        retrieving_playerdata = "Recuperando dados do jogador",
        validating_playerdata = "Validando dados do jogador",
        retrieving_characters = "Recuperando personagens",
        validating_characters = "Validando personagens",
    
        -- Notificações
        ran_into_issue = "Encontramos um problema",
        profanity = "Parece que você está tentando usar algum tipo de palavrão / palavras ruins em seu nome ou nacionalidade!",
        forgotten_field = "Parece que você esqueceu de inserir um ou vários campos!"    
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
