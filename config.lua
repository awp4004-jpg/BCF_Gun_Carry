Config = {}

-- You can add or remove weapons that should spawn as a prop on the player body in the list below
Config.Weapons = {
    -- ==================== PISTOLS (hip) ====================
    { 
        PropHash = `w_pi_pistol`,          
        WeaponHash = `weapon_pistol`,          
        Item = 'weapon_pistol',          
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_pistol_mk2`,      
        WeaponHash = `weapon_pistol_mk2`,      
        Item = 'weapon_pistol_mk2',      
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_combatpistol`,    
        WeaponHash = `weapon_combatpistol`,    
        Item = 'weapon_combatpistol',    
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_appistol`,        
        WeaponHash = `weapon_appistol`,        
        Item = 'weapon_appistol',        
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_stungun`,         
        WeaponHash = `weapon_stungun`,         
        Item = 'weapon_stungun',         
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_pistol50`,        
        WeaponHash = `weapon_pistol50`,        
        Item = 'weapon_pistol50',        
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_snspistol`,       
        WeaponHash = `weapon_snspistol`,       
        Item = 'weapon_snspistol',       
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_snspistol_mk2`,   
        WeaponHash = `weapon_snspistol_mk2`,   
        Item = 'weapon_snspistol_mk2',   
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_heavypistol`,     
        WeaponHash = `weapon_heavypistol`,     
        Item = 'weapon_heavypistol',     
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_vintagepistol`,   
        WeaponHash = `weapon_vintagepistol`,   
        Item = 'weapon_vintagepistol',   
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_ceramicpistol`,   
        WeaponHash = `weapon_ceramicpistol`,   
        Item = 'weapon_ceramicpistol',   
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },
    { 
        PropHash = `w_pi_navyrevolver`,    
        WeaponHash = `weapon_navyrevolver`,    
        Item = 'weapon_navyrevolver',    
        Bone = 11816, 
        Position = { 
            male = { default = { 0.00, -0.01, -0.22, -90.00, 2.00, 3.50 } }, 
            female = { default = { -0.08, -0.14, 0.01, -5.00, 20.00, -2.50 } } 
        } 
    },

    -- ==================== SMGs / MACHINE PISTOLS (back) ====================
    { 
        PropHash = `w_sb_microsmg`,        
        WeaponHash = `weapon_microsmg`,        
        Item = 'weapon_microsmg',        
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sb_smg`,              
        WeaponHash = `weapon_smg`,              
        Item = 'weapon_smg',              
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sb_smg_mk2`,          
        WeaponHash = `weapon_smg_mk2`,          
        Item = 'weapon_smg_mk2',          
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sb_assaultsmg`,       
        WeaponHash = `weapon_assaultsmg`,       
        Item = 'weapon_assaultsmg',       
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sb_combatpdw`,        
        WeaponHash = `weapon_combatpdw`,        
        Item = 'weapon_combatpdw',        
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sb_machinepistol`,    
        WeaponHash = `weapon_machinepistol`,    
        Item = 'weapon_machinepistol',    
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sb_minismg`,          
        WeaponHash = `weapon_minismg`,          
        Item = 'weapon_minismg',          
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },

    -- ==================== RIFLES / CARBINES (back) ====================
    { 
        PropHash = `w_ar_carbinerifle`,     
        WeaponHash = `weapon_carbinerifle`,     
        Item = 'weapon_carbinerifle',     
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_carbinerifle_mk2`, 
        WeaponHash = `weapon_carbinerifle_mk2`, 
        Item = 'weapon_carbinerifle_mk2', 
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_assaultrifle`,     
        WeaponHash = `weapon_assaultrifle`,     
        Item = 'weapon_assaultrifle',     
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_assaultrifle_mk2`, 
        WeaponHash = `weapon_assaultrifle_mk2`, 
        Item = 'weapon_assaultrifle_mk2', 
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_specialcarbine`,   
        WeaponHash = `weapon_specialcarbine`,   
        Item = 'weapon_specialcarbine',   
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_specialcarbine_mk2`, 
        WeaponHash = `weapon_specialcarbine_mk2`, 
        Item = 'weapon_specialcarbine_mk2', 
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_bullpuprifle`,     
        WeaponHash = `weapon_bullpuprifle`,     
        Item = 'weapon_bullpuprifle',     
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_bullpuprifle_mk2`, 
        WeaponHash = `weapon_bullpuprifle_mk2`, 
        Item = 'weapon_bullpuprifle_mk2', 
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_compactrifle`,     
        WeaponHash = `weapon_compactrifle`,     
        Item = 'weapon_compactrifle',     
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_tacticalrifle`,    
        WeaponHash = `weapon_tacticalrifle`,    
        Item = 'weapon_tacticalrifle',    
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_ar_militaryrifle`,    
        WeaponHash = `weapon_militaryrifle`,    
        Item = 'weapon_militaryrifle',    
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },

    -- ==================== SHOTGUNS (back) ====================
    { 
        PropHash = `w_sg_pumpshotgun`,      
        WeaponHash = `weapon_pumpshotgun`,      
        Item = 'weapon_pumpshotgun',      
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sg_pumpshotgun_mk2`,  
        WeaponHash = `weapon_pumpshotgun_mk2`,  
        Item = 'weapon_pumpshotgun_mk2',  
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sg_sawnoff`,          
        WeaponHash = `weapon_sawnoffshotgun`,   
        Item = 'weapon_sawnoffshotgun',   
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sg_assaultshotgun`,   
        WeaponHash = `weapon_assaultshotgun`,   
        Item = 'weapon_assaultshotgun',   
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sg_bullpupshotgun`,   
        WeaponHash = `weapon_bullpupshotgun`,   
        Item = 'weapon_bullpupshotgun',   
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sg_heavyshotgun`,     
        WeaponHash = `weapon_heavyshotgun`,     
        Item = 'weapon_heavyshotgun',     
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },

    -- ==================== SNIPERS / MARKSMAN (back) ====================
    { 
        PropHash = `w_sr_sniperrifle`,      
        WeaponHash = `weapon_sniperrifle`,      
        Item = 'weapon_sniperrifle',      
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sr_heavysniper`,      
        WeaponHash = `weapon_heavysniper`,      
        Item = 'weapon_heavysniper',      
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sr_heavysniper_mk2`,  
        WeaponHash = `weapon_heavysniper_mk2`,  
        Item = 'weapon_heavysniper_mk2',  
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sr_marksmanrifle`,    
        WeaponHash = `weapon_marksmanrifle`,    
        Item = 'weapon_marksmanrifle',    
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_sr_marksmanrifle_mk2`,
        WeaponHash = `weapon_marksmanrifle_mk2`,
        Item = 'weapon_marksmanrifle_mk2',
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },

    -- ==================== LMGs / HEAVY (back) ====================
    { 
        PropHash = `w_mg_mg`,               
        WeaponHash = `weapon_mg`,               
        Item = 'weapon_mg',               
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_mg_combatmg`,         
        WeaponHash = `weapon_combatmg`,         
        Item = 'weapon_combatmg',         
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_mg_combatmg_mk2`,     
        WeaponHash = `weapon_combatmg_mk2`,     
        Item = 'weapon_combatmg_mk2',     
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
    { 
        PropHash = `w_mg_gusenberg`,        
        WeaponHash = `weapon_gusenberg`,        
        Item = 'weapon_gusenberg',        
        Bone = 24818, 
        Position = { 
            male = { default = { -0.02, -0.14, 0.13, 0.00, 2.50, 5.00 } }, 
            female = { default = { 0.08, -0.14, 0.12, 0.0, 0.0, 0.0 } } 
        } 
    },
}

-- If you set Config.Debug to true, the code in client/cl_debug.lua will be run. This enables the use of the command "/weaponprop_spawn [propName] [boneIndex = 24818 by default]" for all players. So this should only be true for development purposes.
Config.Debug = false

-- Player custom weapon positions (presets)
Config.MaxPresets = 3  -- Number of presets per weapon (1-3 supported)
Config.RequireWeaponInHandToEdit = true  -- Must be holding the weapon to edit its position
-- If you set Config.Debug to true, the code in client/cl_debug.lua will be run. This enables the use of the command "/weaponprop_spawn [propName] [boneIndex = 24818 by default]" for all players. So this should only be true for development purposes.
-- After using the command (for example: "/weaponprop_spawn w_ar_carbinerifle"), the weaponProp will spawn and attach to the player. This weapon can be moved around to the desired position, which allows you to easily configure weapon positions, the weapon position is copied to your clipboard.
-- You can move around the weaponProp via the following buttons:
-- NUMPAD-RIGHT (6)                 = Positive translation of prop over X-axis
-- NUMPAD-RIGHT (6) + L-SHIFT       = Positive Rotation of prop over X-axis
-- NUMPAD-LEFT (4)                  = Negative translation of prop over X-axis
-- NUMPAD-LEFT (4) + L-SHIFT        = Negative Rotation of prop over X-axis
-- NUMPAD-UP (8)                    = Positive translation of prop over Y-axis
-- NUMPAD-UP (8) + L-SHIFT          = Positive Rotation of prop over Y-axis
-- NUMPAD-CENTER (5)                = Negative translation of prop over Y-axis
-- NUMPAD-CENTER (5) + L-SHIFT      = Negative Rotation of prop over Y-axis
-- NUMPAD-TOP-LEFT (7)              = Positive translation of prop over Z-axis
-- NUMPAD-TOP-LEFT (7) + L-SHIFT    = Positive Rotation of prop over Z-axis
-- NUMPAD-TOP-RIGHT (9)             = Negative translation of prop over Z-axis
-- NUMPAD-TOP-RIGHT (9) + L-SHIFT   = Negative Rotation of prop over Z-axis
-- BACKSPACE or X                   = Despawn the prop