game 'rdr3'
fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 "yes"

escrow_ignore {
	'*.lua', 
}

client_scripts {
    'not.js',
    'client.lua',
}

files {'not.js'}
server_scripts {
    'server.lua',

}
dependency '/assetpacks'