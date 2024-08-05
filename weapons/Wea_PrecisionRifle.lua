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

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(1)(7)(7)(8)'
        end
    elseif (name == 'w_rifle_precision_militech_achilles') then
        data.canUseNoAmmoWeaponEffect = false

        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(2)(5)(1)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(6)(3)(1)'

        local isWidowMaker = FindInString(itemName, 'Nash')

        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(1)'
        end

        if (triggerType == 'SemiAuto') then
            if (state ~= 8) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(6)(3)(4)'

            if (state == 8) then
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
            if (state ~= 8 and not isPerfectCharged) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 1) then
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
    
                        isPerfectChargedTimes = isPerfectChargedTimes + 1
                    end
                end
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (isWidowMaker) then
                if (state == 8) then
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
                if (state == 8) then
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
            if (state ~= 8) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 8) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(8, dilated, name)
                    
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

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(3)(7)(8)(6)'
        end
    end

    return data
end

return Weapon
