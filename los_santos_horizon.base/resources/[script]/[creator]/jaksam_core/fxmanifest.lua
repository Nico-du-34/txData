version '1.0.2' -- Core version

ui_page "html/index.html"

files {
    "html/index.html",
    "html/index.css",
    "src/localize/localize.js",

    "config/*.lua",
    "src/**/*.*"
}

data_file 'DLC_ITYP_REQUEST' 'stream/L1_1.ytyp' 

files {
    'stream/L1_1.ytyp',
    'stream/L1_1.ydr',
}

lua54 'yes'
fx_version 'cerulean'
game 'gta5'

escrow_ignore {
    -- Locales
    "config/*.lua",
}
dependency '/assetpacks'