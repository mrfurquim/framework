game 'rdr3'
fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 "yes"

escrow_ignore {
	'*.lua', 
}

client_scripts {
    'config.lua',
    'client.lua',
    'not.js',
    'dataview.lua',
}
files {'not.js'}

server_scripts {
    'config.lua',
    'server.lua',
    '@mysql-async/lib/MySQL.lua',
}

export 'GetSpawnedHorse'

--[[
    How to use at client side:
    local a = exports.ricx_horses:GetSpawnedHorse()
    print(a)
]]
dependency {'/assetpacks'
}
