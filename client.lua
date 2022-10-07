local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()

local loadedBenches = false
local craftingBenches = {}
local uiSetup = false
local currentBenchId = nil
local currentDefaultRecipes = {}

local function getThresholdRecipes()
    local playerDefaultRecipes = {}
    local craftingRep = PlayerData.metadata.craftingrep
    local attachmentRep = PlayerData.metadata.attachmentcraftingrep
    for k, v in pairs(Config.defaultRecipes) do
        if v.isAttachment then
            if attachmentRep >= v.threshold then
                playerDefaultRecipes[#playerDefaultRecipes + 1] = v
            end
        else
            if craftingRep >= v.threshold then
                playerDefaultRecipes[#playerDefaultRecipes + 1] = v
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

local function spawnObj(model, coords, heading)
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

   return object
end

local function loadBenches()
    if not loadedBenches then
        for k, v in pairs(Config.craftingBenches) do
            craftingBenches[#craftingBenches + 1] = spawnObj(Config.prop, v.coords, v.heading)
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

        local defaultRecipes = getThresholdRecipes()
        currentDefaultRecipes = defaultRecipes

        SendNUIMessage({
            action = "displayBlueprints",
            blueprint = blueprintRecipes,
            default = defaultRecipes
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
    local recipes = getThresholdRecipes()
    if #recipes > #currentDefaultRecipes then
        local newUnlocks = getNewUnlocks(recipes, currentDefaultRecipes)
        SendNUIMessage({
            action = "displayNewRecipes",
            recipes = newUnlocks
        })
        
        for k, v in pairs(newUnlocks) do
            print(v.item)
        end
        currentDefaultRecipes = recipes
        QBCore.Functions.Notify('New recipe unlocked', 'success')
    
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
         for _, prop in pairs(craftingBenches) do
              DeleteObject(prop)
         end
    end
end)