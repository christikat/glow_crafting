# Crafting Script For QbCore

![Crafting UI](https://i.imgur.com/sLJrGWY.png)

This script creates crafting benches and allows players to use blueprints to unlock new crafts. Each bench can hold up to 5 blueprints. Players are able to remove blueprints by using qb-target to interact with the crafting bench. This opens up the crafting UI where they can right click on the blueprint they wish to remove. Here players will also be able to right click on crafting recipes to make those items.

# Installation
- Drag and drop into your resouces file and ensure glow_crafting in your server.cfg

## Adding Blueprint Items
- Add blueprint items into qb-core's items.lua, setting ['useable] = true
- In order to add functionality to blueprints use the CreateUseableItem function in server.lua

Example with blueprint_advancedlockpick used to craft the advancedlockpick item
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
- Edit Config.craftingBenches in Config.lua,  ensuring that each id is unique. Follow the format below, to add coords and a heading for each crafting bench

```lua
Config.craftingBenches = {
    {id = "exampleId", coords = vector3(1950.95, 3768.83, 32.21), heading = 48.92},
    {id = "exampleId1", coords = vector3(1948.14, 3765.95, 32.21), heading = 25.53},
}
```

## Adding Recipes
- Items in Config.defaultRecipes do not require blueprints to craft and will automatically appear in the crafting UI
- Items in Config.blueprintRecipes are unlocked by using blueprint. This table requires and additional value for storing the blueprint image

Example of an entry for Config.defaultRecipes
```lua
drill = {
    item = "drill",
    label = "Drill",
    image = "drill.png",
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
    components = {
        {item = "aluminum", label = "Aluminum", amount = 10, image = "aluminum.png"},
        {item = "rubber", label = "Rubber", amount = 10, image = "rubber.png"},
        {item = "plastic", label = "Plastic", amount = 10, image = "plastic.png"},
    },
    blueprintImage = "blueprint.png" --Additional Value Required
},
```

## Adding Images
- Add images in html/images folder
- Ensure the name of the image file matches with the image values in Config.defaultRecipes and Config.blueprintRecipes
