local savedWeaponName = ''
local resistanceEnabled = true
local resistanceTimes = 0
local maxResistanceTimes = 10

local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Shotgun')

    if (state == 'Safe') then return data end

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(8)(4)'

    local freq = 0

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    if (savedWeaponName ~= name or state ~= 'Shoot') then
        resistanceEnabled = true
        resistanceTimes = 0
    end

    savedWeaponName = name

    if (name == 'w_shotgun_budget_carnage') then
        -- * Modded Weapon: Game.AddToInventory("Items.SJ_PlasmaShotgun")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isPlasmaShotgun = FindInString(itemName, 'PlasmaShotgun')

        -- * Modded Weapon: Game.AddToInventory("Items.ZMod_Carnage", 1)   https://www.nexusmods.com/cyberpunk2077/mods/15281
        local isZMod = FindInString(itemName, 'ZMod_Carnage')

        data.skipDefaultState = false

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        local isMox = FindInString(itemName, 'Mox')
        local isGuts = FindInString(itemName, 'Edgerunners')

        if (state ~= 'Shoot' and state ~= 'NoAmmo' and state ~= 'Default') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (isMox) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(2)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(6)(6)'
        end

        if (isGuts or isZMod) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(2)'
        end

        if (state == 'Shoot' or state == 'NoAmmo' or state == 'Default') then
            if (isPlasmaShotgun) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'840', 10, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(30, dilated, name, true)

                    if (isAiming) then
                        data.leftTriggerType = 'Machine'
                        data.leftForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'

                        data.rightTriggerType = 'Bow'
                        data.rightForceTrigger = '(0)(7)(8)(8)'
                    else
                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
                    end
                end
            else
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 35, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(6)'

                    data.rightTriggerType = 'Bow'
                    data.rightForceTrigger = '(0)(7)(8)(8)'

                    if (isMox) then
                        data.leftTriggerType = 'Resistance'
                        data.leftForceTrigger = '(1)(4)'

                        data.rightTriggerType = 'Bow'
                        data.rightForceTrigger = '(0)(7)(6)(6)'
                    end

                    if (isGuts or isZMod) then
                        data.leftTriggerType = 'Resistance'
                        data.leftForceTrigger = '(1)(8)'
                    end
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_revolver_militech_crusher') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(5)'

        if (state == 'Shoot') then
            freq = GetFrequency(attackSpeed, dilated, name)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(2)(9)(2)(2)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(2)(9)(7)(7)('.. freq ..')(0)'
        end
    elseif (name == 'w_shotgun_zhuo') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(6)(8)'

        local isBaXingChong = FindInString(itemName, 'Eight_Star')

        if (state ~= 'Shoot' and state ~= 'NoAmmo') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(1)(6)(8)(8)'

            if (isBaXingChong) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 27, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    if (dilated) then
                        freq = GetFrequency(7, dilated, name)
                    else
                        freq = GetFrequency(6, dilated, name)
                    end

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end

        -- data.canUseWeaponReloadEffect = true
        -- data.canUseNoAmmoWeaponEffect = false
    elseif (name == 'w_rifle_precision__techtronika_pozhar') then
        -- * Modded Weapon: Game.AddToInventory("Items.Items.ZMod_Grenade_Launcher", 1)   https://www.nexusmods.com/cyberpunk2077/mods/15281
        local isZModGrenadeLauncher = FindInString(itemName, 'ZMod_Grenade_Launcher')

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(2)(6)(6)'

        if (state ~= 'Shoot') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot') then
            if (triggerType == 'SemiAuto' and isZModGrenadeLauncher) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(4)(1)'

                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'shoot', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(1)(5)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                if (dilated) then
                    freq = GetFrequency(attackSpeed + 1, dilated, name, true)
                else
                    freq = GetFrequency(attackSpeed, dilated, name, true)
                end
    
                if (resistanceEnabled) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(4)(1)'
                else
                    data.leftTriggerType = 'Normal'
                end
    
                resistanceTimes = resistanceTimes + 1
    
                if (dilated and resistanceTimes > maxResistanceTimes * 10 * TimeDilation or not dilated and resistanceTimes > maxResistanceTimes) then
                    resistanceEnabled = not resistanceEnabled
                    resistanceTimes = 0
                end
    
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
            end
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_shotgun_constitutional_tactician') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(5)(4)'

        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(3)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(7)(4)'
        end

        if (state ~= 'Shoot' and state ~= 'NoAmmo') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 20, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                if (isAiming) then
                    data.leftTriggerType = 'Normal'
                else
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(1)(4)'
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    end

    return data
end

return Weapon
