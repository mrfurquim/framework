fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
lua54 "yes"

escrow_ignore {
	'*.lua'
}

client_scripts {
	'@dataview_lua/client.lua',
	'config.lua',
	'client.lua',
	'not.js'
}

files { 'not.js'}

server_scripts {
	'config.lua',
	'server.lua',
}

dependency '/assetpacks'