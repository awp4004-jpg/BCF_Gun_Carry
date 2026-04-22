---@diagnostic disable: undefined-field

-- =====================================================
-- ORIGINAL + PLAYER PRESETS INTEGRATION (EDITED VERSION)
-- =====================================================

PlayerCustoms = {}          -- Make this global so cl_player_presets.lua can access it easily
local PresetsLoaded = false

-- If the resource is stopped, ensure all props on the player are despawned as well
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    DeleteAllWeaponProps()
end)

-- We have to wait for the player to load in, before attaching any props to the player
function onPlayerLoaded(cb)
    local playerPed = PlayerPedId()

    while not DoesEntityExist(playerPed) do
        Wait(100)
        playerPed = PlayerPedId()
    end

    -- Wait until ox_inventory is ready
    while not exports.ox_inventory do
        Wait(100)
    end

    Wait(500) -- give it time to populate items

    cb()
end

onPlayerLoaded(function()
    -- Request player's custom presets from server
    TriggerServerEvent('gs_weaponcarry:requestPlayerPresets')

    -- Save the current ped model
    local previousPedModel = GetEntityModel(PlayerPedId())

    CreateThread(function()
        -- Wait until presets are loaded from database (max 5 seconds)
        local timeout = 0
        while not PresetsLoaded and timeout < 50 do
            Wait(100)
            timeout = timeout + 1
        end

        if not PresetsLoaded then
            print('[WeaponCarry] Warning: Presets not loaded in time, using defaults.')
        end

        while true do
            local ped = PlayerPedId()

            -- Reset equipped weapon
            for _, weapon in ipairs(Config.Weapons) do
                weapon.Equiped = false
            end

            local _, weaponHash = GetCurrentPedWeapon(ped, true)
            local iWeapon = nil
            for i, weapon in ipairs(Config.Weapons) do
                if weapon.WeaponHash == weaponHash then
                    iWeapon = i
                    break
                end
            end

            if iWeapon then
                Config.Weapons[iWeapon].Equiped = true
            end

            local enableWeapons = DoesPlayerRequireWeapons()
            if not enableWeapons then
                DeleteAllWeaponProps()
            end

            local currentPedModel = GetEntityModel(ped)
            if (currentPedModel ~= previousPedModel) then
                DeleteAllWeaponProps()
                previousPedModel = currentPedModel
            end

            if enableWeapons then
                for _, weaponData in ipairs(Config.Weapons) do
                    local playerHasWeapon = DoesPlayerHaveWeapon(weaponData.Item)
                    if playerHasWeapon then
                        if weaponData.Equiped and DoesEntityExist(weaponData.Entity) then
                            DeleteEntity(weaponData.Entity)
                            weaponData.Entity = -1
                            goto continue
                        end

                        if weaponData.Equiped then
                            goto continue
                        end

                        if DoesEntityExist(weaponData.Entity) then
                            goto continue
                        end

                        weaponData.Entity = SpawnWeaponProp(weaponData)
                    elseif DoesEntityExist(weaponData.Entity) then
                        DeleteEntity(weaponData.Entity)
                        weaponData.Entity = -1
                    end
                    ::continue::
                end
            end

            Wait(250)
        end
    end)
end)

-- Load presets event (moved here for reliability)
RegisterNetEvent('gs_weaponcarry:loadPlayerPresets', function(presets)
    PlayerCustoms = presets or {}
    PresetsLoaded = true
    print('[WeaponCarry] Loaded ' .. (#PlayerCustoms or 0) .. ' custom weapon presets')
end)

function DoesPlayerHaveWeapon(itemName)
    if (GetResourceState('ox_inventory') == 'started') then
        return exports.ox_inventory:GetItemCount(itemName) > 0
    end
    if (GetResourceState('es_extended') == 'started' or GetResourceState('qb-core') == 'started') then
        return HasPedGotWeapon(PlayerPedId(), GetHashKey(itemName), false)
    end
    return false
end

function GetWeaponComponents(weaponItem)
    local components = {}

    if GetResourceState('ox_inventory') == 'started' then
        local cleanName = weaponItem:lower():gsub("^weapon_", ""):gsub("^WEAPON_", "")
        local searchName = "WEAPON_" .. string.upper(cleanName)

        local items = exports.ox_inventory:Search('slots', searchName)
        if items and #items > 0 then
            local item = items[1]
            if item.metadata and item.metadata.components then
                components = item.metadata.components
            end
        end
    end

    return components
end

function DoesPlayerRequireWeapons()
    local isDead = IsPedDeadOrDying(PlayerPedId(), true)
    return not (isDead)
end

function SpawnWeaponProp(weaponData)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))

    local weaponHash = GetHashKey(weaponData.Item)

    local weaponEntity = CreateWeaponObject(weaponHash, 1, x, y, z + 0.2, true, 1.0, 0)
    while not DoesEntityExist(weaponEntity) do
        Wait(50)
    end

    SetEntityCollision(weaponEntity, false, false)

    -- Apply attachments
    local components = GetWeaponComponents(weaponData.Item)
    for _, comp in ipairs(components) do
        local fullCompName = "COMPONENT_" .. string.upper(comp)
        local compHash = GetHashKey(fullCompName)
        GiveWeaponComponentToWeaponObject(weaponEntity, compHash)
    end

    local bone = GetPedBoneIndex(ped, weaponData.Bone)
    local weaponPosition = GetPlayerWeaponPosition(weaponData)
    local xpos, ypos, zpos, xrot, yrot, zrot = table.unpack(weaponPosition)
    
    AttachEntityToEntity(weaponEntity, ped, bone, xpos, ypos, zpos, xrot, yrot, zrot, true, true, false, true, 1, true)

    -- === FIXED NETWORKING (removes the warning) ===
    local netId = ObjToNet(weaponEntity)
    NetworkSetNetworkIdDynamic(netId, false)
    SetNetworkIdExistsOnAllMachines(netId, true)

    TriggerServerEvent('gs_weaponcarry:weaponPropSpawned', netId)
    SetModelAsNoLongerNeeded(weaponHash)

    return weaponEntity
end

function LoadPropDict(modelHash)
    while not HasModelLoaded(modelHash) do
        RequestModel(modelHash)
        Wait(50)
    end
end

function DeleteAllWeaponProps()
    for _, weaponData in ipairs(Config.Weapons) do
        if DoesEntityExist(weaponData.Entity) then
            DeleteEntity(weaponData.Entity)
        end
    end
end

-- NEW: Get player custom position (preset 1) or fallback to config
function GetPlayerWeaponPosition(weaponData)
    -- Use the player's chosen ACTIVE preset (instead of always 1)
    local activePreset = ActivePresets[weaponData.Item] or 1
    if PlayerCustoms[weaponData.Item] and PlayerCustoms[weaponData.Item][activePreset] then
        return PlayerCustoms[weaponData.Item][activePreset]
    end
    -- fallback to original config
    return GetWeaponPositionInfo(weaponData.Position)
end

function GetWeaponPositionInfo(clothingPositions)
    local ped = PlayerPedId()
    local pedModel = GetEntityModel(ped)
    local gender = 'male'
    if (not IsPedMale(ped) or pedModel == `mp_f_freemode_01`) then
        gender = 'female'
    end
    local weaponPosition = clothingPositions[gender].default

    if (GetResourceState('skinchanger') == 'started') then
        local skinReceived = false
        while (not skinReceived) do
            Wait(0)
            TriggerEvent("skinchanger:getSkin", function(skin)
                local gender = 'male'
                if (skin.sex == 1) then gender = 'female' end
                weaponPosition = clothingPositions[gender].default

                for clothingType, clothingData in pairs(clothingPositions[gender]) do
                    if (clothingType ~= 'default') then
                        for clothingIndex, position in pairs(clothingData) do
                            if (skin[clothingType] == clothingIndex) then
                                weaponPosition = position
                                break
                            end
                        end
                    end
                end
                skinReceived = true
            end)
        end
    end

    return weaponPosition
end