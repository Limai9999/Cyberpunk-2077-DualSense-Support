local savedWeaponName = ''
local resistanceEnabled = true
local resistanceTimes = 0
local maxResistanceTimes = 10

local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
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
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(8)'
            data.rightForceTrigger = '(0)(7)(8)(8)'
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
        data.rightForceTrigger = '(1)(3)(8)(8)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(1)(6)(8)(8)'
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
            CalcFixedTimeIndex(name, 0, true)
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
