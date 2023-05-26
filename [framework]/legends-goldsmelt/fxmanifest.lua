fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'RexShack#3041'
description 'legends-goldsmelt'

shared_scripts {
    '@legends-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

client_script {
	'client/client.lua'
}

server_script {
	'server/server.lua'
}

dependency 'legends-core'
dependency 'legends-menu'

lua54 'yes'