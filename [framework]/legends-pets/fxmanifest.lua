fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'RexShack#3041'
description 'legends-pets'

client_scripts {
    'client/client.lua',
    'client/dog.lua',
    'client/func.lua'
}

server_scripts {
    'server/server.lua',
}

shared_scripts {
    'config.lua'
}

lua54 'yes'