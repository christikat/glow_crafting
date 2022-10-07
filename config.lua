Config = {}

Config.prop = 'gr_prop_gr_bench_04b'

Config.craftingBenches = {
    {id = "testId", coords = vector3(429.16, 6478.77, 28.79), heading = 140.76},
}

-- Recipes that come with every workbench
Config.defaultRecipes = {
    radio = {
        item = "radio",
        label = "Radio",
        image = "radio.png",
        components = {
            {item = "aluminum", label = "Aluminum", amount = 10, image = "aluminum.png"},
            {item = "rubber", label = "Rubber", amount = 10, image = "rubber.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "plastic.png"},
        }
    },
}

--Recipes that are unlocke with blueprints
Config.blueprintRecipes = {
    advancedlockpick = {
        item = "advancedlockpick",
        label = "Advanced Lockpick",
        image = "advancedlockpick.png",
        components = {
            {item = "aluminum", label = "Aluminum", amount = 10, image = "aluminum.png"},
            {item = "rubber", label = "Rubber", amount = 10, image = "rubber.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "plastic.png"},
        },
        blueprintImage = "blueprint.png"
    },
}