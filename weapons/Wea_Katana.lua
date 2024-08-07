local afterShootTimes = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Katana')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(3)(1)'

    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(2)(3)(1)'

    if (state ~= 15 and state ~= 12 and state ~= 18 and state ~= 16) then
        CalcFixedTimeIndex(name, 0, dilated, true)
        afterShootTimes = 0
    else
        afterShootTimes = afterShootTimes + 1
    end

    if (isAiming) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(2)(1)'
    end

    if (state == 7 or state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(2)(6)'
    end

    if (state == 18) then
        local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'12', 30, dilated, false)

        if (afterShootTimes < shootTriggerActiveForTimes) then
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(2)(3)'
        end

        afterShootTimes = afterShootTimes + 1
    end

    if (state == 10) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(2)'
    end

    if (state == 11) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(2)(1)'
    end

    if (state == 12) then
        local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'12', 20, dilated, false)

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(3)(4)'

        if (afterShootTimes < shootTriggerActiveForTimes) then
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(2)(3)'
        end
    end

    if (state == 15) then
        local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'15', 20, dilated, false)

        if (afterShootTimes < shootTriggerActiveForTimes) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(3)'
        end

        afterShootTimes = afterShootTimes + 1
    end

    if (state == 16) then
        local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'15', 20, dilated, false)

        if (afterShootTimes < shootTriggerActiveForTimes) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(3)'
        end

        afterShootTimes = afterShootTimes + 1
    end

    if (state == 19 or state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(5)'
    end

    if (IsBlockedBullet) then
        data = UseBulletBlockTrigger(data, config)
    end

    return data
end

return Weapon
