fx_version 'cerulean'
games { 'gta5' }

author 'Original Eviate, Butcher reworked'
description 'Fuck me daddy'
version '1.0.47'

lua54 'yes'

ui_page 'clipboard/index.html'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/cl_*.lua',
    'client/cl_player_presets.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua'
}

files {
    'clipboard/index.html',
    'clipboard/copy.js'
}

dependencies {
    'oxmysql',
    'qb-core'
}