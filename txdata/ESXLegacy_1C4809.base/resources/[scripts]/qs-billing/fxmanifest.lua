fx_version "bodacious"

game "gta5"

author "quasar-store.com"

version "1.0.3"

lua54 "yes"

shared_scripts {
    "@ox_lib/init.lua",
    "config/*.lua",
    "shared/*.lua",
    "locales/*.lua"
}

ui_page "web/build/index.html"

files {
    "web/build/index.html",
    "web/build/**/*"
}



client_scripts {
    "client/utils/*.lua",
    "client/lib/*.lua",
    "client/custom/**/*.lua",
    "client/modules/*.lua",
    "client/*.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server/utils/*.lua",
    "server/lib/*.lua",
    "server/data/*.lua",
    "server/custom/**/*.lua",
    "server/*.lua"
}

escrow_ignore {
    "config/*.lua",
    "locales/*.lua",
    "client/custom/**/*.lua",
    "server/custom/**/*.lua"
}

dependencies {
    "ox_lib"
}
dependency '/assetpacks'