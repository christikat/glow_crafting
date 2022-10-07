local QBCore = exports['qb-core']:GetCoreObject()
local craftingBenches = {}
local uiSetup = false
local currentBenchId = nil

local function setupUI()
    SendNUIMessage({
        action = "setupUI",
        recipes = Config.defaultRecipes
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

local function getClosestCraftingBench()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(Config.craftingBenches) do
        local dist = #(playerCoords - v.coords)
        if dist < 2.5 then
            TriggerServerEvent("glow_crafting_sv:getCraftingBenchBlueprints", v.id)
            break
        end
    end
end

local function spawnObj(model, coords, heading)
    local modelHash = type(model) == 'string' and GetHashKey(model) or model
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(10)
        end
    end

    local object = CreateObject(modelHash, coords, false, false, false)
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

   return object
end

local function loadBenches()
    for k, v in pairs(Config.craftingBenches) do
        craftingBenches[#craftingBenches + 1] = spawnObj(Config.prop, v.coords, v.heading)
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
    hideCraftingMenu()
end)

RegisterNetEvent("glow_crafting_cl:openCraftingBench", function(craftingBenchData, benchId)
    currentBenchId = benchId
    
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
        
        SendNUIMessage({
            action = "displayBlueprints",
            recipes = blueprintRecipes
        })
    end
    
    openCraftingMenu()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    loadBenches()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    loadBenches()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
         for _, prop in pairs(craftingBenches) do
              DeleteObject(prop)
         end
    end
end)