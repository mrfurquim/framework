fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'RexShack#3041'
description 'legends-outlawpost'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/client.lua',
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua',
}

dependencies {
    'legends-core',
    'legends-menu',
    'legends-input',
    'PolyZone',
}

lua54 'yes'