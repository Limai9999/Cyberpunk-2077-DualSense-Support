local timesAfterThrow = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Knife')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(2)(2)(1)'
    data.rightTriggerType = 'Choppy'

    local state = GetState('MeleeWeapon')

    if (state ~= 19) then
        CalcFixedTimeIndex(name, 0, true)
    end

    if (state == 7 or state == 13 or state == 18) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(4)(4)'
    elseif (state == 6) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(3)'
    elseif (state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(6)'
    elseif (state == 17) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(4)(6)'
    elseif (state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(6)'
    end

    if (state == 19) then
        local throwTriggerActiveForTimes = CalcFixedTimeIndex(name..'19', 40, false)

        if (timesAfterThrow < throwTriggerActiveForTimes) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(2)'
        else
            data.leftTriggerType = 'Normal'
            data.rightTriggerType = 'Normal'
        end

        timesAfterThrow = timesAfterThrow + 1
    else
        timesAfterThrow = 0
    end

    return data
end

return Weapon