fx_version 'adamant'
game 'gta5'
lua54 'yes'

files {
	'handling.meta',
	'vehicles.meta',
	'carvariations.meta',
	'carcols.meta',
}
client_scripts {
	'configs/*.config.lua'
	}
escrow_ignore {
'configs/*.config.lua'
}
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

dependency '/assetpacks'
dependency '/assetpacks'