local Translations = {
    error = {
        not_online = 'Jogador não está online!',
        wrong_format = 'Formato inválido',
        missing_args = 'Não foram inseridos todos os argumentos (x, y, z)',
        missing_args2 = 'Todos os argumentos devem ser preenchidos!',
        no_access = 'Sem acesso a este comando',
        company_too_poor = 'Seu empregador está quebrado',
        item_not_exist = 'Item não existe',
        too_heavy = 'Inventário Cheio',
        location_not_exist = 'Localização não existe',
        duplicate_license = 'Licença duplicada da Rockstar encontrada',
        no_valid_license = 'Nenhuma licença válida da Rockstar encontrada',
        not_whitelisted = 'Você não tem permissão para entrar neste servidor',
        server_already_open = 'O servidor já está aberto',
        server_already_closed = 'O servidor já está fechado',
        no_permission = 'Você não tem permissões para isto..',
        no_waypoint = 'Nenhum waypoint definido.',
        tp_error = 'Erro ao teletransportar.'
    },
    success = {
        server_opened = 'O servidor foi aberto',
        server_closed = 'O servidor foi fechado',
        teleported_waypoint = 'Teleportado para o Waypoint.'
    },
    info = {
        received_paycheck = 'Você recebeu seu salário de $%{value}',
        job_info = 'Trabalho: %{value} | Grau: %{value2} | Dever: %{value3}',
        gang_info = 'Gangue: %{value} | Grau: %{value2}',
        on_duty = 'Você agora está em serviço!',
        off_duty = 'Você agora está fora de serviço!',
        checking_ban = 'Olá %s. Estamos verificando se você está banido.',
        join_server = 'Bem-vindo %s ao {Nome do Servidor}.',
        checking_whitelisted = 'Olá %s. Estamos verificando se você está autorizado.',
        exploit_banned = 'Você foi banido por trapaça. Verifique o nosso Discord para mais informações: %{discord}',
        exploit_dropped = 'Você foi expulso por exploração'
    },
    command = {
        tp = {
            help = 'Teleportar para um Jogador ou Coordenadas (Somente Admin)',
            params = {
                x = {
                    name = 'id/x',
                    help = 'ID do jogador ou posição X'
                },
                y = {
                    name = 'y',
                    help = 'Posição Y'
                },
                z = {
                    name = 'z',
                    help = 'Posição Z'
                }
            }
        },
        tpm = {
            help = 'Teleportar para um Marcador (Somente Admin)'
        },
        noclip = {
            help = 'Modo fantasma (Somente Admin)'
        },
        addpermission = {
            help = 'Dar Permissões a um Jogador (Somente Deus)',
            params = {
                id = {
                    name = 'id',
                    help = 'ID do jogador'
                },
                permission = {
                    name = 'permission',
                    help = 'Nível de permissão'
                }
            }
        },
        removepermission = {
            help = 'Remover Permissões de um Jogador (Somente Deus)',
            params = {
                id = {
                    name = 'id',
                    help = 'ID do jogador'
                },
                permission = {
                    name = 'permission',
                    help = 'Nível de permissão'
                }
            }
        },
        openserver = {
            help = 'Abrir o servidor para todos (Somente Admin)'
        },
        closeserver = {
            help = 'Fechar o servidor para pessoas sem permissão (Somente Admin)',
            params = {
                reason = {
                    name = 'reason',
                    help = 'Motivo do fechamento (opcional)'
                }
            }
        },
        car = {
            help = 'Spawnar veículo (Somente Admin)',
            params = {
                model = {
                    name = 'model',
                    help = 'Nome do modelo do veículo'
                }
            }
        },
        dv = {
            help = 'Deletar veículo (Somente Admin)'
        },
        spawnwagon = {
            help = 'Spawnar uma carroça (Somente Admin)'
        },
        spawnhorse = {
            help = 'Spawnar um cavalo (Somente Admin)'
        },
        givemoney = {
            help = 'Dar dinheiro a um jogador (Somente Admin)',
            params = {
                id = {
                    name = 'id',
                    help = 'ID do jogador'
                },
                moneytype = {
                    name = 'moneytype',
                    help = 'Tipo de dinheiro (dinheiro em espécie, banco, dinheiro sujo)'
                },
                amount = {
                    name = 'amount',
                    help = 'Quantidade de dinheiro'
                }
            }
        },
        setmoney = {
            help = 'Definir a quantidade de dinheiro do jogador (Somente Admin)',
            params = {
                id = {
                    name = 'id',
                    help = 'ID do jogador'
                },
                moneytype = {
                    name = 'moneytype',
                    help = 'Tipo de dinheiro (dinheiro em espécie, banco, dinheiro sujo)'
                },
                amount = {
                    name = 'amount',
                    help = 'Quantidade de dinheiro'
                }
            }
        },
        job = {
            help = 'Verificar seu emprego'
        },
        setjob = {
            help = 'Definir o emprego de um jogador (Somente Admin)',
            params = {
                id = {
                    name = 'id',
                    help = 'ID do jogador'
                },
                job = {
                    name = 'job',
                    help = 'Nome do emprego'
                },
                grade = {
                    name = 'grade',
                    help = 'Grau do emprego'
                }
            }
        },
        gang = {
            help = 'Verificar sua gangue'
        },
        setgang = {
            help = 'Definir a gangue de um jogador (Somente Admin)',
            params = {
                id = {
                    name = 'id',
                    help = 'ID do jogador'
                },
                gang = {
                    name = 'gang',
                    help = 'Nome da gangue'
                },
                grade = {
                    name = 'grade',
                    help = 'Grau da gangue'
                }
            }
        },
        ooc = {
            help = 'OOC Chat Message'
        },
        me = {
            help = 'Mostra mensagem local',
            params = {
                message = {
                    name = 'message',
                    help = 'Message a enviar'
                }
            }
        }
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
