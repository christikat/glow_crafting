local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

local loadedBenches = false
local craftingBenches = {}
local uiSetup = false
local currentBenchId = nil
local currentDefaultRecipes = {}


local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function getThresholdRecipes(craftingRep, attachmentRep, benchType)
    local playerDefaultRecipes = {}
    for k, v in pairs(Config.defaultRecipes) do
        if v.benchType == benchType then
            for k, baseRep in pairs(Config.benchReps.rep) do 
                if v.benchType == baseRep then
                    if craftingRep >= v.threshold then
                        playerDefaultRecipes[#playerDefaultRecipes + 1] = v
                    end
                end
            end
            for k, attachRep in pairs(Config.benchReps.attachmentRep) do
                if v.benchType == attachRep then
                    if attachmentRep >= v.threshold then
                        playerDefaultRecipes[#playerDefaultRecipes + 1] = v
                    end
                end
            end
        end
    end
    return playerDefaultRecipes
end

local function getNewUnlocks(newRecipes, oldRecipes)
    local temp = {}
    local unlocks = {}
    for k, v in pairs(newRecipes) do
        temp[v.item] = true
    end

    for k, v in pairs(oldRecipes) do
        temp[v.item] = nil
    end

    for k,v in pairs(newRecipes) do
        if temp[v.item] then
            unlocks[#unlocks + 1] = v
        end
    end

    return unlocks
end

local function setupUI()
    SendNUIMessage({
        action = "setupUI",
    })
end

local function openCraftingMenu()
    TriggerScreenblurFadeIn(500)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "show"
    })
end

local function hideCraftingMenu()
    currentBenchId = nil
    TriggerScreenblurFadeOut(500)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hide"
    })
end

local function spawnObj(model, coords, heading, objExists)
    if not objExists then
        local modelHash = type(model) == 'string' and GetHashKey(model) or model
        if not HasModelLoaded(modelHash) then
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Wait(10)
            end
        end 
       
        local object = CreateObject(modelHash, coords.x, coords.y, coords.z - 1, false, false, false)
        while not DoesEntityExist(object) do
            Wait(10)
        end

        PlaceObjectOnGroundProperly(object)
        SetEntityAsMissionEntity(object, true, true)
        FreezeEntityPosition(object, true)
        SetEntityHeading(object, heading - 180)

        exports['qb-target']:AddTargetEntity(object, {
            options = { {
                icon = "fa-solid fa-hammer",
                label = "Craft",
                action = function()
                    TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
                end
            }
            },
            distance = 1.5
        })
    else
        if model == 'prop_toolchest_05' then
            if Config.useTargetModels then
                for k, v in pairs(Config.Models.base) do 
                    exports['qb-target']:AddTargetModel(v, {
                        options = { 
                            {   icon = "fa-solid fa-hammer",
                                label = "Craft",
                                action = function()
                                    TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
                                end
                            },
                        },
                        distance = 1.5
                    })
                end
            else
                exports['qb-target']:AddBoxZone("BaseCrafting", coords, 0.8, 1.2, {
                    name = "BaseCrafting",
                    heading = heading,
                    debugPoly = false,
                    minZ = coords.z-1,
                    maxZ = coords.z+1,
                }, {
                    options = { {
                        icon = "fa-solid fa-hammer",
                        label = "Craft",
                        action = function()
                            TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
                        end
                    }
                    },
                    distance = 1.5
                })
            end
        elseif model == 'gr_prop_gr_bench_01a' then
            exports['qb-target']:AddBoxZone("WeaponCrafting", coords, 1, 4, {
                name = "WeaponCrafting",
                heading = heading,
                debugPoly = false,
                minZ = coords.z-0.8,
                maxZ = coords.z+1.5,
            }, {
                options = { {
                    icon = "fa-solid fa-gun",
                    label = "Craft",
                    action = function()
                        TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
                    end
                }
                },
                distance = 1.5
            })
        elseif model == 'gr_prop_gr_speeddrill_01b' then
            exports['qb-target']:AddBoxZone("AmmoCrafting", coords, 1, 0.6, {
                name = "AmmoCrafting",
                heading = heading,
                debugPoly = false,
                minZ = coords.z-0.8,
                maxZ = coords.z+1.8,
            }, {
                options = { {
                    icon = "fa-solid fa-gun",
                    label = "Craft",
                    action = function()
                        TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
                    end
                }
                },
                distance = 1.5
            })
        elseif model == 'gr_prop_gr_bench_02a' then
            exports['qb-target']:AddBoxZone("AttachmentCrafting", coords, 1, 2, {
                name = "AttachmentCrafting",
                heading = heading,
                debugPoly = false,
                minZ = coords.z-0.8,
                maxZ = coords.z+1.5,
            }, {
                options = { {
                    icon = "fa-solid fa-gun",
                    label = "Craft",
                    action = function()
                        TriggerServerEvent("glow_crafting_sv:getWorkBenchData")
                    end
                }
                },
                distance = 1.5
            })
        elseif model == 'electronicbench' then
            exports['qb-target']:AddBoxZone("ElectronicCrafting", coords, 0.8, 1.4, {
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
        end
    end

   return object
end

local function loadBenches()
    if not loadedBenches then
        for k, v in pairs(Config.craftingBenches) do
            craftingBenches[#craftingBenches + 1] = spawnObj(v.prop, v.coords, v.heading, v.objExists)
        end
    end
end

RegisterNUICallback("discardBlueprint", function(data, cb)
    if currentBenchId then
        QBCore.Functions.TriggerCallback('glow_crafting_sv:discardBlueprint', function (result)
            cb(result)
        end, currentBenchId, data.currentBlueprint)
    else
        cb(false)
    end
end)

RegisterNUICallback("attemptCraft", function(data, cb)
    if currentBenchId then
        TriggerServerEvent("glow_crafting_sv:attemptCraft", currentBenchId, data.currentRecipe, data.amt, data.isBlueprintRecipe)
    end
end)

RegisterNUICallback("close", function(data, cb)
    local player = PlayerPedId()
    hideCraftingMenu()
    StopAnimTask(player, "mini@repair", "fixing_a_player", 1.0)
end)

RegisterNetEvent("glow_crafting_cl:openCraftingBench", function(craftingBenchData, benchId)
    currentBenchId = benchId[1]
    local player = PlayerPedId()
    local benchType = benchId[2]
    local craftingRep = PlayerData.metadata.craftingrep
    local attachmentRep = PlayerData.metadata.attachmentcraftingrep

    loadAnimDict("mini@repair")
    TaskPlayAnim(player, "mini@repair", "fixing_a_player", 1.0, 1.0, -1, 1, 0, 0, 0, 0)

    if not uiSetup then
        setupUI()
        uiSetup = true
    end

    if craftingBenchData then
        local blueprintRecipes = {}
        for k, v in pairs(craftingBenchData.blueprints) do
            if Config.blueprintRecipes[v] then
                blueprintRecipes[#blueprintRecipes + 1] = Config.blueprintRecipes[v]
            end
        end

        local defaultRecipes = getThresholdRecipes(craftingRep, attachmentRep, benchType)
        currentDefaultRecipes = defaultRecipes

        SendNUIMessage({
            action = "displayBlueprints",
            blueprint = blueprintRecipes,
            default = defaultRecipes
        })
    else
        local defaultRecipes = getThresholdRecipes(craftingRep, attachmentRep, benchType)
        currentDefaultRecipes = defaultRecipes

        SendNUIMessage({
            action = "displayBlueprints",
            blueprint = {},
            default = defaultRecipes
        })
    end
        
    openCraftingMenu()
end)

RegisterNetEvent("glow_crafting_cl:increasedRep", function(craftingRep, attachmentRep, benchType)
    local recipes = getThresholdRecipes(craftingRep, attachmentRep, benchType)
    if #recipes > #currentDefaultRecipes then
        local newUnlocks = getNewUnlocks(recipes, currentDefaultRecipes)
        SendNUIMessage({
            action = "displayNewRecipes",
            recipes = newUnlocks
        })
        
        currentDefaultRecipes = recipes
        QBCore.Functions.Notify('New recipe unlocked', 'success')
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    loadBenches()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    PlayerData = QBCore.Functions.GetPlayerData()
    loadBenches()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    currentDefaultRecipes = {}
    currentBenchId = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
         for _, prop in pairs(craftingBenches) do
              DeleteObject(prop)
         end
    end
end)
