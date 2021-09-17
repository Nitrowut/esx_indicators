fx_version 'adamant'

game 'gta5'

version '1.4.0'

client_scripts {
	'@es_extended/locale.lua',
	'client/main.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'@es_extended/locale.lua',
	'server/main.lua'
}