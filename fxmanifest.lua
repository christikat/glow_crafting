fx_version 'cerulean'
game 'gta5'

author 'Glowie'
description 'Crafting Benches'
version '1.0'

client_script 'client.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

shared_scripts {
    '@qb-core/shared/locale.lua',
	'config.lua',
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css',
	'html/images/*',
}

lua54 'yes'