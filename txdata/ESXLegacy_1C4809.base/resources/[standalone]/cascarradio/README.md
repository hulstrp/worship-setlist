My Discord: cas.vdv

<p>
    This is a <b>FIVEM</b> STANDALONE (esx /qbcore / qbox supported) vehicle radio script which keeps the original gta 5 radio look with the ability to change stations name, sound (as radios for example) and picture (hud.ytd -> change textures using open iv for example)
    Changing the radios sound and name is easily done through fxmanifest.lua
    Vehicle radios are synced between players and can be heard outside of the vehicles (distance is based on volume)
</p>

# Installation steps

## Dependencies

1. ox_lib - for the options menu (https://github.com/overextended/ox_lib)
2. xsound (https://github.com/Xogy/xsound)

### Optional

1. qb-core/QBox/ESX (https://github.com/search?q=qbcore&type=repositories / https://github.com/Qbox-project/qbx_core / https://github.com/esx-framework/esx_core)

## Installation

1. Download the resource, put it in your resources folder, ensure it and then do the following:
2. Locate config.lua > availableRadios, this list provides a complete list of radios that are available in GTA 5
3. Locate fxmanifest.lua
4. Add / Remove radios like shown in the examples. (Do not remove the radio with url = "options", you will lose the options menu on the radio wheel)
5. NOTE: URLs must be https://...

## Features

1. Fully synced radios between players
2. Radios can be heard outside of the vehicles that have their engines on
3. 0.00 - 0.01 CPU usage
4. Multi-Language Support
5. 24/7 Support on discord

## Bugs

[If you encounter any bug, please feel free to reach out to me on discord (cas.vdv)](https://discord.gg/7HSqr9XmEA)

## TODO

1. UI for ingame config
