# Crafting Script For QbCore

![Crafting UI](https://i.imgur.com/dUocf9m.png)

This script creates crafting benches and allows players to use blueprints to unlock new crafts. Each bench can hold up to 5 blueprints. Players are able to remove blueprints by using qb-target to interact with the crafting bench. This opens up the crafting UI where they can right click on the blueprint they wish to remove. Here players will also be able to right click on crafting recipes to make those items.

Crafting benches also come with default crafts that do not require blueprints. These crafts can be locked using qb-core's crafting rep system, and will only appear to the player if they meet those rep requirements.

Each bench's blueprints are not unique to the player and are set globally. Meaning that if player A adds a blueprint, player B will also see the blueprint if they access the same crafting bench.

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
    {id = "exampleId", coords = vector3(1950.95, 3768.83, 32.21), heading = 48.92},
    {id = "exampleId1", coords = vector3(1948.14, 3765.95, 32.21), heading = 25.53},
}
```

## Adding Recipes
- Items in Config.defaultRecipes do not require blueprints to craft and will automatically appear in the crafting UI if the player has enough crafting rep above the item's threshold

- Items in Config.blueprintRecipes are unlocked by using blueprint. These recipes do not have any crafting rep requirements, and do not have a threshold value. However, this table requires an additional value for storing the blueprint image

Example of an entry for Config.defaultRecipes
```lua
drill = {
    item = "drill",
    label = "Drill",
    image = "drill.png",
    isAttachment = false,
    threshold = 0,
    points = 1,
    components = {
        {item = "aluminum", label = "Aluminum", amount = 10, image = "aluminum.png"},
        {item = "rubber", label = "Rubber", amount = 10, image = "rubber.png"},
        {item = "plastic", label = "Plastic", amount = 10, image = "plastic.png"},
    }
},
```

Example of an entry for Config.blueprintRecipes
```lua
drill = {
    item = "drill",
    label = "Drill",
    image = "drill.png",
    isAttachment = false,
    points = 1,
    components = {
        {item = "aluminum", label = "Aluminum", amount = 10, image = "aluminum.png"},
        {item = "rubber", label = "Rubber", amount = 10, image = "rubber.png"},
        {item = "plastic", label = "Plastic", amount = 10, image = "plastic.png"},
    },
    blueprintImage = "blueprint.png" --Additional Value Required
},
```

## Adding Images
- Images can be setup to pull from you inventory script. See config.lua on how to do this. Make sure the the name of your inventory resource matches the name used in the config
