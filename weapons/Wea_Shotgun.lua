local savedWeaponName = ''
local resistanceEnabled = true
local resistanceTimes = 0
local maxResistanceTimes = 10

local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Shotgun')

    if (state == 4 or state == 0 or state == 6) then return data end

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(8)(4)'

    local freq = 0

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    if (savedWeaponName ~= name or state ~= 8) then
        resistanceEnabled = true
        resistanceTimes = 0
    end

    savedWeaponName = name

    if (name == 'w_shotgun_budget_carnage') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        local isMox = FindInString(itemName, 'Mox')
        local isGuts = FindInString(itemName, 'Edgerunners')

        if (state ~= 8 and state ~= 4) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (isMox) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(2)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(6)(6)'
        end

        if (isGuts) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(2)'
        end

        if (state == 8 or state == 4) then
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
    
                if (isGuts) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(8)'
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_revolver_militech_crusher') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(5)'

        if (state == 8) then
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

        if (state ~= 8 and state ~= 4) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(1)(6)(8)(8)'

            if (isBaXingChong) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 25, dilated, false)

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
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(2)(6)(6)'

        if (state == 8) then
            if (dilated) then
                freq = GetFrequency(attackSpeed + 1, dilated, name)
            else
                freq = GetFrequency(attackSpeed, dilated, name)
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

        if (state ~= 8 and state ~= 4) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 8 or state == 4) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 30, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Normal'
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    end

    return data
end

return Weapon
