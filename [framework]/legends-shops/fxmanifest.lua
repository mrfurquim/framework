fx_version 'cerulean'
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

author 'rexshack and qbcore'
description 'legends-shops'

shared_scripts {
    '@legends-core/shared/locale.lua',
    'config.lua',
    'locales/en.lua',
    'locales/*.lua',

}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

dependencies {
    'legends-core',
    'legends-inventory',
    'legends-target'
}
