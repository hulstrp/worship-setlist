fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

version '1.0.6'

ui_page 'html/index.html'

shared_scripts {
	'config.lua',
	'utils/*.lua',
	'locales/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/custom/**/**.lua',
	'server/modules/*.lua',
	'server/*.lua'
}

client_scripts {
	'client/custom/**/**.lua',
	'client/*.lua'
}

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/img/*.*'
}

escrow_ignore {
	'config.lua',
	'locales/*.lua',
	'client/custom/**/**.lua',
	'server/custom/**/**.lua',
}

dependency '/assetpacks'

dependency '/assetpacks'