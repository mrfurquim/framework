# RexshackGaming
- discord : https://discord.gg/s5uSk56B65
- github : https://github.com/Rexshack-RedM
- original legends-hud : https://github.com/Rexshack-RedM/legends-hud

# Hud moved by Unknown Ghostz#9131

# Instructions
If you want to change between F and C right now you can go into Client/Main.lua and go to line 106
Just comment the one you don't want out, and uncomment the other. (F by default)

Insert code snippet thats below into legends-core/shared/items.lua then you need to add the item into your shops so players can use the drinks to replenish energy after that drop the energydrink picture into legends-inventory/html/images ```['energydrink']        = {['name'] = 'energydrink',        ['label'] = 'Energy Drink',    ['weight'] = 200, ['type'] = 'item', ['image'] = 'energydrink.png',        ['unique'] = false, ['useable'] = true,  ['shouldClose'] = true, ['combinable'] = nil, ['level'] = 0, ['description'] = 'drink to get energy back'},```

# Example
![pic1](https://cdn.discordapp.com/attachments/1097996761894748311/1099945260194467890/newesthudupdate.png)

# Dependancies
- legends-core
- legends-telegram

# Installation
- ensure that the dependancies are added and started
- add legends-hud to your resources folder

# Starting the resource
- add the following to your server.cfg file : ensure legends-hud

# Added features
- food and drink icon changes colour to red when low
- telegram visual notification when telegram is received

# Credits
- Sisyphus#6666 for adding temperature
- https://github.com/qbcore-redm-framework/qbr-hud
- https://github.com/QRCore-RedM-Re/qr-hud
- https://github.com/Rexshack-RedM/legends-hud