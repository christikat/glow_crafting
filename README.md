# Crafting Script For QbCore

![Crafting UI](https://i.imgur.com/dUocf9m.png)

This script creates crafting benches and allows players to use blueprints to unlock new crafts. Each bench can hold up to 5 blueprints. Players are able to remove blueprints by using qb-target to interact with the crafting bench. This opens up the crafting UI where they can right click on the blueprint they wish to remove. Here players will also be able to right click on crafting recipes to make those items.

Crafting benches also come with default crafts that do not require blueprints. These crafts can be locked using qb-core's crafting rep system, and will only appear to the player if they meet those rep requirements.

Each bench's blueprints are not unique to the player and are set globally. Meaning that if player A adds a blueprint, player B will also see the blueprint if they access the same crafting bench.

```
    #Note for DonHulieo's Update
    This is christikat's script through and through, I merely added box zones and configured the items... Hell even the readme is the same as the old and only updated to include my changes. Please if you like this script and want to give it a star, you should give christikat's OP one too :).
```

[christikat](https://github.com/christikat/glow_crafting)

# Installation
- Drag and drop into your resources file and ensure glow_crafting in your server.cfg

## Adding Blueprint Items
- Add blueprint items into qb-core's items.lua, setting ['useable] = true
- In order to add functionality to blueprints use the CreateUseableItem function in server.lua

Example with blueprint_advancedlockpick used to craft the advancedlockpick item. Ensure that craftItem matches the key in your config recipes table.
```lua
QBCore.Functions.CreateUseableItem("blueprint_advancedlockpick", function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("blueprint_advancedlockpick") then
        local craftItem = "advancedlockpick"
        local addedBlueprint = blueprintUsed(source, craftItem)
        if addedBlueprint then
            Player.Functions.RemoveItem("blueprint_advancedlockpick", 1)
        end
    end
end)
```

## Creating Crafting Benches
- Edit Config.craftingBenches in Config.lua, ensuring that each id is unique. Follow the format below, to add coords and a heading for each crafting bench

```lua
Config.craftingBenches = {
    {id = "pbbase", coords = vector3(97.51, 6618.9, 31.43), heading = 134.43, objExists = true, prop = 'prop_toolchest_05', benchType = 'base'},
    {id = "gsammo", coords = vector3(2130.79, 4765.54, 41.12), heading = 26.21, objExists = false, prop = 'gr_prop_gr_speeddrill_01b', benchType = 'ammo'},
    {id = "lmelec", coords = vector3(1272.18, -1710.86, 54.77), heading = 26, objExists = true, prop = 'electronicbench', benchType = 'electronic'},
}
```

- Set objExists to false if you want the script to spawn a crafting bench at the declared coords or true to create a boxzone of an existing model.
- Benches have associated bench types, when adding recipes and benches, make sure they state the same bench type.

## Using Box Zones instead of Props
- If creating a boxzone around an existing prop by using objExists = true, you'll need to configure the boxzone inside the Client.lua after line 221.

```lua
elseif model == 'electronicbench' then -- Model is the prop model decalred in Config.craftingBenches
    exports['qb-target']:AddBoxZone("ElectronicCrafting", coords, 0.8, 1.4, { -- Change the length and width (0.8, 1.4 respectively) to suit the prop the boxzone is for
        name = "ElectronicCrafting",
        heading = heading,
        debugPoly = false,
        minZ = coords.z-0.6,
        maxZ = coords.z+0.8,
    }, {
        options = { {
            icon = "fa-solid fa-bolt",
            label = "Craft",
            action = function()
                TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
            end
        }
        },
        distance = 1.5
    })
```

- As long as model has the same name as the prop declared in Config.craftingBenches, the boxzone doesn't actually need a prop associated like above.

- If you don't want to make individual boxzones for each prop, set Config.useTargetModels = true and add the props to Config.Models.

```lua
Config.Models = {
    base = {`prop_toolchest_05`, `prop_tool_bench02_ld`, `prop_tool_bench02`, `prop_toolchest_02`, `prop_toolchest_03`, `prop_toolchest_03_l2`, `prop_toolchest_05`, `prop_toolchest_04`},
}
```

- Please note this is only configured for base crafting, so no electronics, weapons, attachments or ammo will appear on these tables.

## Adding Bench Types
- When adding your own bench types, make sure to add them to the Config.benchReps table.

```lua
Config.benchReps = {
    rep = {"base", "electronic"},
    attachmentRep = {"ammo", "attachment", "weapon"},
}
```

- If you also want to change what rep is required for each type of crafting you declare it in this table as well;
        where rep is base crafting reputation and attachmentrep is attachment crafting reputation.       

## Adding Recipes
- Items in Config.defaultRecipes do not require blueprints to craft and will automatically appear in the crafting UI if the player has enough crafting rep above the item's threshold

- Items in Config.blueprintRecipes are unlocked by using blueprint. These recipes do not have any crafting rep requirements, and do not have a threshold value. However, this table requires an additional value for storing the blueprint image

Example of an entry for Config.defaultRecipes
```lua
    lockpick = {
        item = "lockpick",
        label = "Lockpick",
        image = "https://cfx-nui-qb-inventory/html/images/lockpick.png",
        benchType = "base",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 22, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 32, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
```

Example of an entry for Config.blueprintRecipes
```lua
    drill = {
        item = "drill",
        label = "Drill",
        image = "https://cfx-nui-qb-inventory/html/images/drill.png",
        benchType = "base",
        points = 12,
        components = {
            {item = "iron", label = "Iron", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "steel", label = "Steel", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "screwdriverset", label = "Screwdriver Set", amount = 3, image = "https://cfx-nui-qb-inventory/html/images/screwdriverset.png"},
            {item = "advancedlockpick", label = "Advanced Lockpick", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/advancedlockpick.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
```
