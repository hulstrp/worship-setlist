fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

client_scripts {
    'client/main.lua'
}

ui_page 'ui/build/index.html'

files({
    'ui/build/index.html',
    'ui/build/**/*',
})

escrow_ignore {
    'client/main.lua'
}

dependency '/assetpacks'