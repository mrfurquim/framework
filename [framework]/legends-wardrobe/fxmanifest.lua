fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'RexShack#3041'
description 'legends-example'

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

shared_scripts {
    '@legends-core/shared/locale.lua',
    'locales/en.lua', -- Change this to your preferred language
    'config.lua',
}

dependencies {
    'legends-core',
    'legends-appearance',
    'legends-clothes'
}

lua54 'yes'
