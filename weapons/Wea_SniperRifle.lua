local afterShootTimes = 0
local isPerfectChargedTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_SniperRifle')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'SemiAutomaticGun'
    data.rightForceTrigger = '(2)(5)(8)'

    local freq = 0

    if (not isPerfectCharged) then
        isPerfectChargedTimes = 0
    end

    if (name == 'w_rifle_sniper_tsunami_ashura') then
        -- * Modded Weapon: Game.AddToInventory("Items.Preset_Antitank_Default", 1)	https://www.nexusmods.com/cyberpunk2077/mods/11675?tab=description
        local isAntitank = FindInString(itemName, 'Antitank')

        if (isAntitank) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(6)(7)'

            if (isAiming) then
                data.leftTriggerType = 'Normal'
            end

            if (state ~= 'Shoot' and state ~= 'NoAmmo') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(0)(5)'

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(4)(3)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        else
            -- Original

            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(4)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(6)(7)'

            if (isAiming) then
                data.leftTriggerType = 'Normal'
            end

            if (state ~= 'Shoot' and state ~= 'NoAmmo') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(0)(3)'

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(0)(7)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    elseif (name == 'w_rifle_sniper_tsunami_nekomata') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(8)'

        if (state ~= 'Shoot' and state ~= 'NoAmmo' and not isPerfectCharged) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Charging') then
            freq = GetChargeTrigger(name, dilated, false, 0.37, 2, 35)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'

            if (isPerfectCharged) then
                local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(), dilated, false)

                if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(3)(9)(4)(4)('.. freq * 2 ..')(0)'

                    isPerfectChargedTimes = isPerfectChargedTimes + 1
                end
            end
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 30, false, false)

            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(6)'

            data.rightTriggerType = 'Normal'

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(4)(8)'
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_rifle_sniper_techtronika_grad') then
        data.skipDefaultState = false

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        local isOFive = FindInString(itemName, 'Buck')

        if (isOFive) then
            data.leftForceTrigger = '(1)(6)'

            if (isAiming) then data.leftForceTrigger = '(1)(4)' end
        end

        if (triggerType == 'SemiAuto') then
            if (state ~= 'Shoot' and state ~= 'NoAmmo') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 15, dilated, false)

                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(6)'

                if (isOFive) then data.leftForceTrigger = '(1)(7)' end

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(attackSpeed * 1.6, dilated, name)

                    data.leftTriggerType = 'Normal'

                    data.rightTriggerType = 'Bow'
                    data.rightForceTrigger = '(0)(8)(8)(8)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        else
            if (state == 'Charging') then
                freq = GetChargeTrigger(name, dilated, false, 0.3, 1, 35)

                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(8)'

                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(8)(8)(8)'
            end
        end
    elseif (name == 'w_rifle_sniper_nokota_osprey') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(4)(5)'

        if (triggerType == 'FullAuto') then
            if (state == 'Shoot' or state == 'NoAmmo') then
                freq = GetFrequency(attackSpeed, dilated, name)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(1)'
            end
        elseif (triggerType == 'Burst') then
            if (state ~= 'Shoot' and state ~= 'NoAmmo') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 30, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    if (dilated) then
                        freq = GetFrequency(11, dilated, name, false, 'Burst')
                    else
                        freq = GetFrequency(10, dilated, name, false, 'Burst')
                    end

                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(1)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    elseif (name == 'w_rifle_sniper_tsunami_rasetsu') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(7)'

        if (state ~= 'Charging') then GetChargeTrigger(name, dilated, true) end

        if (triggerType == 'SemiAuto') then
            if (state ~= 'Shoot' and state ~= 'NoAmmo') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 25, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(0)(8)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        elseif (triggerType == 'Charge') then
            if (state ~= 'Shoot' and state ~= 'NoAmmo' and not isPerfectCharged) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Charging') then
                freq = GetChargeTrigger(name, dilated, false, 0.3, 0, 50)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'

                if (isPerfectCharged) then
                    local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(), dilated, false)
    
                    if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(3)(9)(4)(4)('.. freq * 2 ..')(0)'
    
                        isPerfectChargedTimes = isPerfectChargedTimes + 1
                    end
                end
            end

            if (state == 'Shoot' or state == 'NoAmmo') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 30, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Normal'

                    data.rightTriggerType = 'Rigid'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    end

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    return data
end

return Weapon
