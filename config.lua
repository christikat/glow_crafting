Config = {}

Config.useTargetModels = true -- If true, all prop models below can be targeted to access the crafting menu and negates making box zones for them // Currently only setup for base crafting
Config.Models = {
    base = {`prop_toolchest_05`, `prop_tool_bench02_ld`, `prop_tool_bench02`, `prop_toolchest_02`, `prop_toolchest_03`, `prop_toolchest_03_l2`, `prop_toolchest_05`, `prop_toolchest_04`},
}

Config.benchReps = {
    rep = {"base", "electronic"},
    attachmentRep = {"ammo", "attachment", "weapon"},
}

Config.craftingBenches = {
    {id = "pbbase", coords = vector3(97.51, 6618.9, 31.43), heading = 134.43, objExists = true, prop = 'prop_toolchest_05', benchType = 'base'},
    {id = "pbbase2", coords = vector3(429.16, 6478.77, 28.79), heading = 140.76, objExists = false, prop = 'gr_prop_gr_bench_04b', benchType = 'base'},
    {id = "gsbase", coords = vector3(2135.7, 4771.66, 39.98), heading = 5.35, objExists = true, prop = 'prop_toolchest_05', benchType = 'base'},
    {id = "lmelec", coords = vector3(1272.18, -1710.86, 54.77), heading = 26, objExists = true, prop = 'electronicbench', benchType = 'electronic'},
    {id = "ssattach", coords = vector3(1539.41, 1699.72, 109.74), heading = 79.24, objExists = false, prop = 'gr_prop_gr_bench_02a', benchType = 'attachment'},
    {id = "gsammo", coords = vector3(2130.79, 4765.54, 41.12), heading = 26.21, objExists = false, prop = 'gr_prop_gr_speeddrill_01b', benchType = 'ammo'},
}

--[[
Make sure to change the image path to your inventory image file. Default is qb-inventory, you can change it to lj-inventory by doing this example below:
    https://cfx-nui-lj-inventory/html/images/radio.png
]]

-- Recipes that come with every workbench
Config.defaultRecipes = {
    -- Base Items -- 
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
    screwdriverset = {
        item = "screwdriverset",
        label = "Screwdriver Set",
        image = "https://cfx-nui-qb-inventory/html/images/screwdriverset.png",
        benchType = "base",
        threshold = 0,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 42, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    repairkit = {
        item = "repairkit",
        label = "Repair Kit",
        image = "https://cfx-nui-qb-inventory/html/images/repairkit.png",
        benchType = "base",
        threshold = 200,
        points = 7,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 32, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 43, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 61, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    ironoxide = {
        item = "ironoxide",
        label = "Iron Oxide",
        image = "https://cfx-nui-qb-inventory/html/images/repairkit.png",
        benchType = "base",
        threshold = 300,
        points = 9,
        components = {
            {item = "iron", label = "Iron", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "glass", label = "Glass", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/glass.png"},
        }
    },
    aluminumoxide = {
        item = "aluminumoxide",
        label = "Aluminum Oxide",
        image = "https://cfx-nui-qb-inventory/html/images/aluminumoxide.png",
        benchType = "base",
        threshold = 300,
        points = 9,
        components = {
            {item = "aluminum", label = "Aluminum", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "glass", label = "Glass", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/glass.png"},
        }
    },
    -- Electronic Items -- 
    electronickit = {
        item = "electronickit",
        label = "Electronic Kit",
        image = "https://cfx-nui-qb-inventory/html/images/electronickit.png",
        benchType = "electronic",
        threshold = 0,
        points = 3,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 45, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 28, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
        }
    },
    radio = {
        item = "radio",
        label = "Radio",
        image = "https://cfx-nui-qb-inventory/html/images/radio.png",
        benchType = "electronic",
        threshold = 0,
        points = 4,
        components = {
            {item = "electronickit", label = "Electronic Kit", amount = 1, image = "https://cfx-nui-qb-inventory/html/images/electronickit.png"},
            {item = "plastic", label = "Plastic", amount = 26, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "steel", label = "Steel", amount = 20, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
        }
    },
    radioscanner = {
        item = "radioscanner",
        label = "Radio Scanner",
        image = "https://cfx-nui-qb-inventory/html/images/radioscanner.png",
        benchType = "electronic",
        threshold = 0,
        points = 5,
        components = {
            {item = "electronickit", label = "Electronic Kit", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/electronickit.png"},
            {item = "plastic", label = "Plastic", amount = 52, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "steel", label = "Steel", amount = 40, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
        }
    },
    -- Ammo Items -- 
    pistolammo = {
        item = "pistol_ammo",
        label = "Pistol Ammo",
        image = "https://cfx-nui-qb-inventory/html/images/pistol_ammo.png",
        benchType = "ammo",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 37, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "copper", label = "Copper", amount = 26, image = "https://cfx-nui-qb-inventory/html/images/copper.png"},
        }
    },
    -- Weapon Items -- 
    pistol = {
        item = "weapon_pistol",
        label = "Pistol Ammo",
        image = "https://cfx-nui-qb-inventory/html/images/weapon_pistol.png",
        benchType = "weapon",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 280, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 500, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 180, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
        }
    },
    -- Attachment Items --
    pistolextendclip = {
        item = "pistol_extendedclip",
        label = "Pistol Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/pistol_extendedclip.png",
        benchType = "attachment",
        threshold = 0,
        points = 1,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 140, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 250, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 60, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    pistolsuppressor = {
        item = "pistol_suppressor",
        label = "Pistol Suppressor",
        image = "https://cfx-nui-qb-inventory/html/images/pistol_suppressor.png",
        benchType = "attachment",
        threshold = 10,
        points = 2,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 165, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 285, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 75, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    smgextendedclip = {
        item = "smg_extendedclip",
        label = "SMG Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/smg_extendedclip.png",
        benchType = "attachment",
        threshold = 25,
        points = 3,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 190, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 305, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 85, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    microsmgextendedclip = {
        item = "microsmg_extendedclip",
        label = "Micro Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/microsmg_extendedclip.png",
        benchType = "attachment",
        threshold = 50,
        points = 4,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 205, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 340, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 110, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    smgdrum = {
        item = "smg_drum",
        label = "SMG Drum Mag",
        image = "https://cfx-nui-qb-inventory/html/images/smg_drum.png",
        benchType = "attachment",
        threshold = 75,
        points = 5,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 230, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 365, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 130, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    smgscope = {
        item = "smg_scope",
        label = "SMG Scope",
        image = "https://cfx-nui-qb-inventory/html/images/smg_scope.png",
        benchType = "attachment",
        threshold = 100,
        points = 6,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 255, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 390, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 145, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        }
    },
    assaultrifleextendedclip = {
        item = "assaultrifle_extendedclip",
        label = "AR Extended Mag",
        image = "https://cfx-nui-qb-inventory/html/images/assaultrifle_extendedclip.png",
        benchType = "attachment",
        threshold = 150,
        points = 7,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 270, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 435, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 155, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "smg_extendedclip", label = "SMG Extended Mag", amount = 1, image = "https://cfx-nui-qb-inventory/html/images/smg_extendedclip.png"},
        }
    },
    assaultrifledrum = {
        item = "assaultrifle_drum",
        label = "AR Drum Mag",
        image = "https://cfx-nui-qb-inventory/html/images/assaultrifle_extendedclip.png",
        benchType = "attachment",
        threshold = 200,
        points = 8,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 300, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 469, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "rubber", label = "Rubber", amount = 170, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "smg_extendedclip", label = "SMG Extended Mag", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/smg_extendedclip.png"},
        }
    },
}

--Recipes that are unlocked with blueprints
Config.blueprintRecipes = {
    -- Base Items --
    advancedlockpick = {
        item = "advancedlockpick",
        label = "Advanced Lockpick",
        image = "https://cfx-nui-qb-inventory/html/images/advancedlockpick.png",
        benchType = "base",
        points = 10,
        components = {
            {item = "aluminum", label = "Aluminum", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "rubber", label = "Rubber", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/rubber.png"},
            {item = "plastic", label = "Plastic", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
    handcuffs = {
        item = "handcuffs",
        label = "Handcuffs",
        image = "https://cfx-nui-qb-inventory/html/images/handcuffs.png",
        benchType = "base",
        points = 6,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 36, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "steel", label = "Steel", amount = 24, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "aluminum", label = "Aluminum", amount = 28, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
    armor = {
        item = "armor",
        label = "Armor",
        image = "https://cfx-nui-qb-inventory/html/images/armor.png",
        benchType = "base",
        points = 11,
        components = {
            {item = "iron", label = "Iron", amount = 33, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "steel", label = "Steel", amount = 44, image = "https://cfx-nui-qb-inventory/html/images/steel.png"},
            {item = "plastic", label = "Plastic", amount = 55, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 22, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
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
    -- Electronic Items --
    gatecrack = {
        item = "gatecrack",
        label = "Gatecrack",
        image = "https://cfx-nui-qb-inventory/html/images/gatecrack.png",
        benchType = "electronic",
        points = 5,
        components = {
            {item = "metalscrap", label = "Metal Scrap", amount = 10, image = "https://cfx-nui-qb-inventory/html/images/metalscrap.png"},
            {item = "plastic", label = "Plastic", amount = 50, image = "https://cfx-nui-qb-inventory/html/images/plastic.png"},
            {item = "aluminum", label = "Aluminum", amount = 30, image = "https://cfx-nui-qb-inventory/html/images/aluminum.png"},
            {item = "iron", label = "Iron", amount = 17, image = "https://cfx-nui-qb-inventory/html/images/iron.png"},
            {item = "electronickit", label = "Electronic Kit", amount = 2, image = "https://cfx-nui-qb-inventory/html/images/electronickit.png"},
        },
        blueprintImage = "https://cfx-nui-qb-inventory/html/images/blueprint.png"
    },
}