local afterShootTimes = 0
local isPerfectChargedTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_PrecisionRifle')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'SemiAutomaticGun'
    data.rightForceTrigger = '(2)(5)(8)'

    local freq = 0

    if (not isPerfectCharged) then
        isPerfectChargedTimes = 0
    end

    if (name == 'w_rifle_precision_rostovic_kolac') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(7)(8)'

        if (state ~= 'Shoot') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 20, dilated, false)

            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(6)'

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Normal'

                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(1)(8)'
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_rifle_precision_militech_achilles') then
        data.canUseNoAmmoWeaponEffect = false

        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(2)(5)(1)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(6)(3)(1)'

        -- * Modded Weapon: Game.AddToInventory("Items.Achilles_Noxious")	https://www.nexusmods.com/cyberpunk2077/mods/13628?tab=description
        local isAchillesNoxious = FindInString(itemName, 'Achilles_Noxious')
        -- * Modded Weapon: Game.AddToInventory("Items.Achilles_Blackwall")   https://www.nexusmods.com/cyberpunk2077/mods/15838
        local isAchillesBlackwall = FindInString(itemName, 'Achilles_Blackwall')

        local isWidowMaker = FindInString(itemName, 'Nash')

        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(1)'
        end

        if (triggerType == 'SemiAuto') then
            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(6)(3)(4)'

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8semi_auto', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(2)(6)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end

        if (triggerType == 'Charge') then
            if (state ~= 'Shoot' and not isPerfectCharged) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Charging') then
                data.leftTriggerType = 'Galloping'
                data.leftForceTrigger = '(3)(9)(1)(2)(3)'

                freq = GetChargeTrigger(name, dilated, false, 0.3, 3, 35)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(3)(6)('.. freq ..')'

                if (isPerfectCharged) then
                    local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(-10), dilated, false)

                    if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(3)(9)(5)(5)('.. freq ..')(0)'

                        if (isAchillesBlackwall) then
                            data.rightForceTrigger = '(3)(9)(6)(6)('.. freq ..')(0)'
                        end

                        isPerfectChargedTimes = isPerfectChargedTimes + 1
                    end
                end
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (isWidowMaker or isAchillesNoxious or isAchillesBlackwall) then
                if (state == 'Shoot') then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8widow_maker', 25, dilated, false)

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(2)(8)'

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        freq = GetFrequency(8, dilated, name)

                        data.leftTriggerType = 'Machine'
                        data.leftForceTrigger = '(1)(9)(2)(3)('.. freq ..')(0)'

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            else
                if (state == 'Shoot') then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 15, dilated, false)

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(2)(8)'

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        data.rightTriggerType = 'Normal'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            end
        end

        if (triggerType == 'Burst') then
            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(8, dilated, name, false, 'Burst')

                    data.leftTriggerType = 'AutomaticGun'
                    data.leftForceTrigger = '(4)(1)('.. freq ..')'

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    elseif (name == 'w_rifle_precision_midnight_sor22') then
        data.canUseNoAmmoWeaponEffect = false

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(8)(6)'

        if (state ~= 'Shoot' or state ~= 'NoAmmo') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 25, dilated, false)

            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(6)'

            if (afterShootTimes < shootTriggerActiveForTimes) then
                if (isAiming) then
                    data.leftTriggerType = 'Normal'
                else
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(1)(7)'
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_rifle_assault_arasaka_masamune') then
        -- * Modded Weapon: Game.AddToInventory("Items.aa_masamune_02",1)	https://www.nexusmods.com/cyberpunk2077/mods/2335?tab=description
        local isOpportunity = FindInString(itemName, 'aa_masamune_02')

        if (isOpportunity) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(4)(4)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(7)(8)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(5)(3)'
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 15, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(attackSpeed * 2.5, dilated, name)

                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(3)(7)'

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(4)(4)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    end

    return data
end

return Weapon
