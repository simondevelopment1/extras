fx_version 'adamant'

game 'gta5'

author 'Simon'
version '1.0'
description 'Some basic extra resources'
discord 'https://discord.gg/gcFm6Z8ns9'

lua54 'yes'

server_scripts {
	'@es_extended/imports.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

client_scripts {
    'client/*.lua'
}

dependency 'simon_core'