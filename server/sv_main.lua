---@diagnostic disable: undefined-field
local QBCore = exports['qb-core']:GetCoreObject()

local propList = {}
local PlayerPresets = {}

-- Original prop cleanup code
AddEventHandler('entityRemoved', function(entity)
    if GetEntityType(entity) ~= 3 then return end
    local entityModel = GetEntityModel(entity)
    local isWeapon = false
    for _, weapon in ipairs(Config.Weapons) do
        if entityModel == weapon.PropHash then isWeapon = true break end
    end
    if not isWeapon then return end
    local entityNetId = NetworkGetNetworkIdFromEntity(entity)
    for _, weapons in pairs(propList) do
        for i = #weapons, 1, -1 do
            if weapons[i] == entityNetId then table.remove(weapons, i) end
        end
    end
end)

RegisterNetEvent('gs_weaponcarry:weaponPropSpawned')
AddEventHandler('gs_weaponcarry:weaponPropSpawned', function(netId)
    local src = source
    if propList[src] == nil then propList[src] = {} end
    table.insert(propList[src], netId)
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if propList[src] then
        for _, netId in ipairs(propList[src]) do
            local entity = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(entity) and GetEntityType(entity) == 3 then
                DeleteEntity(entity)
            end
        end
    end
    PlayerPresets[src] = nil
end)

-- =====================================================
-- PLAYER PRESETS SYSTEM WITH DEBUG LOGS
-- =====================================================

RegisterNetEvent('gs_weaponcarry:requestPlayerPresets')
AddEventHandler('gs_weaponcarry:requestPlayerPresets', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then 
        print('[WeaponCarry] ERROR: Could not get player for source ' .. src)
        return 
    end

    local citizenid = Player.PlayerData.citizenid
    print('[WeaponCarry] Player ' .. src .. ' requested presets. CitizenID: ' .. citizenid)

    exports.oxmysql:query('SELECT weapon, preset, pos_x, pos_y, pos_z, rot_x, rot_y, rot_z FROM player_weapon_positions WHERE citizenid = ?', { citizenid }, function(result)
        if not result then result = {} end

        print('[WeaponCarry] Found ' .. #result .. ' saved presets for ' .. citizenid)

        PlayerPresets[src] = {}

        for _, row in ipairs(result) do
            if not PlayerPresets[src][row.weapon] then
                PlayerPresets[src][row.weapon] = {}
            end
            PlayerPresets[src][row.weapon][row.preset] = {
                row.pos_x, row.pos_y, row.pos_z,
                row.rot_x, row.rot_y, row.rot_z
            }
        end

        TriggerClientEvent('gs_weaponcarry:loadPlayerPresets', src, PlayerPresets[src])
        print('[WeaponCarry] Sent presets to player ' .. src)
    end)
end)

RegisterNetEvent('gs_weaponcarry:savePlayerPreset')
AddEventHandler('gs_weaponcarry:savePlayerPreset', function(weaponItem, preset, position)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid
    local x, y, z, rx, ry, rz = table.unpack(position)

    exports.oxmysql:query([[
        INSERT INTO player_weapon_positions (citizenid, weapon, preset, pos_x, pos_y, pos_z, rot_x, rot_y, rot_z)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE 
            pos_x = VALUES(pos_x), pos_y = VALUES(pos_y), pos_z = VALUES(pos_z),
            rot_x = VALUES(rot_x), rot_y = VALUES(rot_y), rot_z = VALUES(rot_z)
    ]], { citizenid, weaponItem, preset, x, y, z, rx, ry, rz }, function()
        if not PlayerPresets[src] then PlayerPresets[src] = {} end
        if not PlayerPresets[src][weaponItem] then PlayerPresets[src][weaponItem] = {} end
        PlayerPresets[src][weaponItem][preset] = { x, y, z, rx, ry, rz }

        TriggerClientEvent('gs_weaponcarry:loadPlayerPresets', src, PlayerPresets[src])
        TriggerClientEvent('QBCore:Notify', src, 'Position saved for preset ' .. preset, 'success')
        print('[WeaponCarry] Saved preset ' .. preset .. ' for ' .. weaponItem .. ' (CitizenID: ' .. citizenid .. ')')
    end)
end)

RegisterNetEvent('gs_weaponcarry:resetPlayerPreset')
AddEventHandler('gs_weaponcarry:resetPlayerPreset', function(weaponItem, preset)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:query('DELETE FROM player_weapon_positions WHERE citizenid = ? AND weapon = ? AND preset = ?', { citizenid, weaponItem, preset }, function()
        if PlayerPresets[src] and PlayerPresets[src][weaponItem] then
            PlayerPresets[src][weaponItem][preset] = nil
        end
        TriggerClientEvent('gs_weaponcarry:loadPlayerPresets', src, PlayerPresets[src] or {})
        TriggerClientEvent('QBCore:Notify', src, 'Preset ' .. preset .. ' reset', 'primary')
    end)
end)

-- =====================================================
-- ACTIVE PRESET SYSTEM (new)
-- =====================================================

RegisterNetEvent('gs_weaponcarry:setActivePreset')
AddEventHandler('gs_weaponcarry:setActivePreset', function(weaponItem, preset)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:query('INSERT INTO player_weapon_active_preset (citizenid, weapon, active_preset) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE active_preset = ?', 
    { citizenid, weaponItem, preset, preset })
end)

-- Modify the request event to also send active presets
RegisterNetEvent('gs_weaponcarry:requestPlayerPresets')
AddEventHandler('gs_weaponcarry:requestPlayerPresets', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:query('SELECT weapon, preset, pos_x, pos_y, pos_z, rot_x, rot_y, rot_z FROM player_weapon_positions WHERE citizenid = ?', { citizenid }, function(presetsResult)
        local presets = {}
        for _, row in ipairs(presetsResult or {}) do
            if not presets[row.weapon] then presets[row.weapon] = {} end
            presets[row.weapon][row.preset] = {row.pos_x, row.pos_y, row.pos_z, row.rot_x, row.rot_y, row.rot_z}
        end

        exports.oxmysql:query('SELECT weapon, active_preset FROM player_weapon_active_preset WHERE citizenid = ?', { citizenid }, function(activeResult)
            local active = {}
            for _, row in ipairs(activeResult or {}) do
                active[row.weapon] = row.active_preset
            end

            TriggerClientEvent('gs_weaponcarry:loadPlayerPresets', src, presets, active)
        end)
    end)
end)