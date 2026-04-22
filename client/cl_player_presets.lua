-- =====================================================
-- FINAL VERSION - FULLY AUTOMATIC RELOG LOADING
-- =====================================================

local QBCore = exports['qb-core']:GetCoreObject()

PlayerCustoms = {}      -- saved positions
ActivePresets = {}      -- which preset is the main one

local PresetsLoaded = false

-- =====================================================
-- SUPER RELIABLE AUTO LOADING (no more refresh needed)
-- =====================================================
local function RequestPresets()
    TriggerServerEvent('gs_weaponcarry:requestPlayerPresets')
    print('[WeaponCarry] 🔄 Auto-requesting presets from database...')
end

-- Best QBCore moment
RegisterNetEvent('QBCore:PlayerLoaded', function()
    Wait(3000)           -- longer delay for safety
    RequestPresets()
end)

-- Backup retry system (tries every 2 seconds until success)
CreateThread(function()
    Wait(5000)
    while not PresetsLoaded do
        RequestPresets()
        Wait(2000)
    end
    print('[WeaponCarry] ✅ Presets loaded successfully!')
end)

-- Receive data
RegisterNetEvent('gs_weaponcarry:loadPlayerPresets', function(presets, active)
    PlayerCustoms = presets or {}
    ActivePresets = active or {}
    PresetsLoaded = true

    local count = 0
    for _ in pairs(PlayerCustoms) do count = count + 1 end
    print(('[WeaponCarry] ✅ FULLY LOADED %d weapons with presets!'):format(count))
end)

-- =====================================================
-- HELPERS
-- =====================================================
local function GetHeldWeaponData()
    local ped = PlayerPedId()
    local _, hash = GetCurrentPedWeapon(ped, true)
    for _, w in ipairs(Config.Weapons) do
        if w.WeaponHash == hash then return w end
    end
    return nil
end

local function Notify(msg, type)
    QBCore.Functions.Notify(msg, type or 'primary')
end

-- =====================================================
-- EDIT MODE
-- =====================================================
local CurrentEditingWeapon = nil
local EditingProp = nil
local EditingMoving = false
local edit_xp, edit_yp, edit_zp, edit_xrp, edit_yrp, edit_zrp = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

local function StartEditMode(weaponData, preset)
    if EditingMoving then Notify('Already editing!', 'error') return end
    CurrentEditingWeapon = weaponData.Item

    local startPos = PlayerCustoms[weaponData.Item] and PlayerCustoms[weaponData.Item][preset] or {0.0,0.0,0.0,0.0,0.0,0.0}
    edit_xp, edit_yp, edit_zp = startPos[1], startPos[2], startPos[3]
    edit_xrp, edit_yrp, edit_zrp = startPos[4], startPos[5], startPos[6]

    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    if not HasModelLoaded(weaponData.PropHash) then LoadPropDict(weaponData.PropHash) end

    EditingProp = CreateObject(weaponData.PropHash, x, y, z + 0.2, true, true, true)
    while not DoesEntityExist(EditingProp) do Wait(50) end
    SetEntityCollision(EditingProp, false, false)
    local bone = GetPedBoneIndex(ped, weaponData.Bone)
    AttachEntityToEntity(EditingProp, ped, bone, edit_xp, edit_yp, edit_zp, edit_xrp, edit_yrp, edit_zrp, true, true, false, true, 1, true)

    EditingMoving = true
    Notify('Editing preset ' .. preset, 'success')

    CreateThread(function()
        while EditingMoving do
            Wait(0)
            if IsControlPressed(0, 21) and IsControlPressed(0, 111) then edit_yrp = edit_yrp + 0.5; RespawnEditProp(weaponData)
            elseif IsControlPressed(0, 111) then edit_yp = edit_yp + 0.005; RespawnEditProp(weaponData) end
            if IsControlPressed(0, 21) and IsControlPressed(0, 110) then edit_yrp = edit_yrp - 0.5; RespawnEditProp(weaponData)
            elseif IsControlPressed(0, 110) then edit_yp = edit_yp - 0.005; RespawnEditProp(weaponData) end
            if IsControlPressed(0, 21) and IsControlPressed(0, 117) then edit_xrp = edit_xrp - 0.5; RespawnEditProp(weaponData)
            elseif IsControlPressed(0, 117) then edit_xp = edit_xp - 0.005; RespawnEditProp(weaponData) end
            if IsControlPressed(0, 21) and IsControlPressed(0, 118) then edit_xrp = edit_xrp + 0.5; RespawnEditProp(weaponData)
            elseif IsControlPressed(0, 118) then edit_xp = edit_xp + 0.005; RespawnEditProp(weaponData) end
            if IsControlPressed(0, 21) and IsControlPressed(0, 108) then edit_zrp = edit_zrp + 0.5; RespawnEditProp(weaponData)
            elseif IsControlPressed(0, 108) then edit_zp = edit_zp + 0.005; RespawnEditProp(weaponData) end
            if IsControlPressed(0, 21) and IsControlPressed(0, 109) then edit_zrp = edit_zrp - 0.5; RespawnEditProp(weaponData)
            elseif IsControlPressed(0, 109) then edit_zp = edit_zp - 0.005; RespawnEditProp(weaponData) end

            if IsControlPressed(0, 177) or IsControlPressed(0, 73) then
                if DoesEntityExist(EditingProp) then DeleteEntity(EditingProp) end
                EditingMoving = false
                Notify('Edit cancelled', 'error')
            end
        end
    end)
end

function RespawnEditProp(weaponData)
    if not DoesEntityExist(EditingProp) then return end
    DeleteEntity(EditingProp)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    EditingProp = CreateObject(weaponData.PropHash, x, y, z + 0.2, true, true, true)
    while not DoesEntityExist(EditingProp) do Wait(50) end
    SetEntityCollision(EditingProp, false, false)
    local bone = GetPedBoneIndex(ped, weaponData.Bone)
    AttachEntityToEntity(EditingProp, ped, bone, edit_xp, edit_yp, edit_zp, edit_xrp, edit_yrp, edit_zrp, true, true, false, true, 1, true)
    SendNUIMessage({type = 'copy', data = string.format("{ %.2f, %.2f, %.2f, %.2f, %.2f, %.2f }", edit_xp, edit_yp, edit_zp, edit_xrp, edit_yrp, edit_zrp)})
end

function LoadPropDict(modelHash)
    while not HasModelLoaded(modelHash) do RequestModel(modelHash) Wait(50) end
end

function SpawnWeaponPropWithPosition(weaponData, position)
    local ped = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(ped))
    if not HasModelLoaded(weaponData.PropHash) then LoadPropDict(weaponData.PropHash) end
    local ent = CreateObject(weaponData.PropHash, x, y, z + 0.2, true, true, true)
    while not DoesEntityExist(ent) do Wait(50) end
    SetEntityCollision(ent, false, false)
    local bone = GetPedBoneIndex(ped, weaponData.Bone)
    AttachEntityToEntity(ent, ped, bone, position[1], position[2], position[3], position[4], position[5], position[6], true, true, false, true, 1, true)
    TriggerServerEvent('gs_weaponcarry:weaponPropSpawned', NetworkGetNetworkIdFromEntity(ent))
    return ent
end

-- =====================================================
-- COMMANDS
-- =====================================================
RegisterCommand('weaponpos_edit', function(source, args)
    local preset = tonumber(args[1]) or 1
    local weaponData = GetHeldWeaponData()
    if not weaponData then Notify('Hold a weapon first!', 'error') return end
    StartEditMode(weaponData, preset)
end, false)

RegisterCommand('weaponpos_save', function(source, args)
    local preset = tonumber(args[1]) or 1
    if not EditingMoving or not CurrentEditingWeapon then Notify('Not editing anything', 'error') return end
    TriggerServerEvent('gs_weaponcarry:savePlayerPreset', CurrentEditingWeapon, preset, {edit_xp, edit_yp, edit_zp, edit_xrp, edit_yrp, edit_zrp})
    if DoesEntityExist(EditingProp) then DeleteEntity(EditingProp) end
    EditingMoving = false
    Notify('Saved preset ' .. preset, 'success')
end, false)

RegisterCommand('weaponpos_load', function(source, args)
    local preset = tonumber(args[1]) or 1
    local weaponData = GetHeldWeaponData()
    if not weaponData then Notify('Hold the weapon first', 'error') return end

    local item = weaponData.Item
    if not PlayerCustoms[item] or not PlayerCustoms[item][preset] then
        Notify('No saved position for preset ' .. preset, 'error')
        return
    end

    if DoesEntityExist(weaponData.Entity) then DeleteEntity(weaponData.Entity) weaponData.Entity = -1 end
    weaponData.Entity = SpawnWeaponPropWithPosition(weaponData, PlayerCustoms[item][preset])

    ActivePresets[item] = preset
    TriggerServerEvent('gs_weaponcarry:setActivePreset', item, preset)

    Notify('✅ Preset ' .. preset .. ' is now your MAIN carry style', 'success')
end, false)

print('[WeaponCarry] ✅ Fully automatic preset system loaded - no refresh needed!')