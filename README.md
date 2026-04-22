# gs_weaponcarry - Player Presets Update (Modified by Grok)

## What's New
- **Per-player custom weapon carry positions** saved in database (`player_weapon_positions` table).
- **3 presets per weapon** (preset 1 is used for normal carry).
- **Strict requirements to edit**:
  1. Must have the weapon **item in inventory**.
  2. Must be **holding the weapon in hand** (`Config.RequireWeaponInHandToEdit = true`).
- Reuses the excellent debug movement system (numpad controls).
- Fully compatible with original global config + clothes system.

## New Commands (Players)
- `/weaponpos_edit <preset>`  
  Example: `/weaponpos_edit weapon_pistol 1`  
  → Must be **holding the pistol** and have it in inventory.

- `/weaponpos_save <preset>`  
  While editing, saves the current position to that preset slot.

- `/weaponpos_load <preset>`  
  Choose between the saved presets.

- `/weaponpos_reset <preset>`  
  Deletes that preset (reverts to global default).

**Preset 1** is the default used when the weapon is on your back/holster.

## How It Works
- Global positions in `config.lua` = default for everyone.
- When you save a preset, it overrides only for **you**.
- Normal carry always uses **Preset 1** (or falls back to config + clothes logic).

## Config Options (new)
```lua
Config.MaxPresets = 3
Config.RequireWeaponInHandToEdit = true

# Weapon Carry Script Original

#### ⭐ Check out our other resources on [gamzkystore.com](https://gamzkystore.com/) or in our [Discord](https://discord.com/invite/sjFP3HrWc3).
#### 📼 Preview video: [Youtube](https://www.youtube.com/watch?v=guhRcpf_r-Q)

There are already quite some 'weapon-carry' scripts available, but I often found them to be either, buggy, lacking in features or badly optimized. So I decided to create a version of my own.

## Features
-   Tested on the esx-framework, but should also work on qb-core and with ox-inventory.
-   Configure the weapons that should be displayed on a players body, if the player has the weapon in his loadout/inventory.
-   The weapons are attached to a configured position and ped-bone.
-   A debug-mode enables a command which can be used to easily determine the right weapon positions (see the end of the preview video).
-   It is also possible to add clothes-dependend positions, as of now this only works with [skinchanger](https://github.com/mitlight/skinchanger).
-   The spawned weapon props are tracked on the server, which handles the attached props on a player disconnect.
