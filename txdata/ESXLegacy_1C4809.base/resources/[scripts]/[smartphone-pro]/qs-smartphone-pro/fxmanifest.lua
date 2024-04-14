fx_version 'cerulean'

game 'gta5'

ui_page 'html/index.html'

lua54 'yes'

version '1.2.1'

shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua',
    'locales/*.lua'
}

client_scripts {
    'client/custom/**/*.lua',
    'client/main.lua',
    'client/modules/*.lua',
    'client/apps/*.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/custom/**/*.lua',
    'server/main.lua',
    'server/modules/*.lua',
    'server/apps/*.lua'
}

files {
    'html/index.html',
    'config/*.js',
    'html/**/**'
}

escrow_ignore {
    'config/config.lua',
    'locales/*.lua',
    'client/custom/**/*.lua',
    'server/custom/**/*.lua'
}

dependencies {
    '/gameBuild:2545',
    'ox_lib',
    'xsound',
    'mhacking',
    'progressbar',
    'phone-render'
}

dependency '/assetpacks'