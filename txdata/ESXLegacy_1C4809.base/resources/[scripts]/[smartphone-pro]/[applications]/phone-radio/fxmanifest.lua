fx_version 'cerulean'

games { 'gta5' }

lua54 'yes'

ui_page 'html/index.html'

shared_script 'config.lua'

client_script {
    'client.lua',
    'voice.lua'
}

files({
    'html/*'
})

escrow_ignore {
    'client.lua',
    'config.lua',
    'voice.lua'
}

dependency '/assetpacks'