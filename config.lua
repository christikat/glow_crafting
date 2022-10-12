Config = {}

Config.prop = 'gr_prop_gr_bench_04b'

Config.craftingBenches = {
    {id = "testId", coords = vector3(429.16, 6478.77, 28.79), heading = 140.76},
}

--[[
Make sure to change the image path to your inventory image file. Default is lj-inventory, you can change it to qb-inventory by doing this example below:
    https://cfx-nui-qb-inventory/html/images/radio.png
]]


-- Recipes that come with every workbench
Config.defaultRecipes = {
    radio = {
        item = "radio",
        label = "Radio",
        image = "https://cfx-nui-lj-inventory/html/images/radio.png", 
        isAttachment = false,
        threshold = 0,
        points = 1,
        components = {
            {item = "aluminum", label = "Aluminum", amount = 10, image = "https://cfx-nui-lj-inventory/html/images/aluminum.png"},
            {item = "rubber", label = "Rubber", amount = 10, image = "https://cfx-nui-lj-inventory/html/images/rubber.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "https://cfx-nui-lj-inventory/html/images/plastic.png"},
        }
    },
}

--Recipes that are unlocked with blueprints
Config.blueprintRecipes = {
    advancedlockpick = {
        item = "advancedlockpick",
        label = "Advanced Lockpick",
        image = "https://cfx-nui-lj-inventory/html/images/advancedlockpick.png",
        isAttachment = false,
        points = 1,
        components = {
            {item = "aluminum", label = "Aluminum", amount = 10, image = "https://cfx-nui-lj-inventory/html/images/aluminum.png"},
            {item = "rubber", label = "Rubber", amount = 10, image = "https://cfx-nui-lj-inventory/html/images/rubber.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "https://cfx-nui-lj-inventory/html/images/plastic.png"},
        },
        blueprintImage = "https://cfx-nui-lj-inventory/html/images/blueprint.png"
    },
}
