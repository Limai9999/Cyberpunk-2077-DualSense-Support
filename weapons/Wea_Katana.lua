local function Weapon(data, name, isAiming, _, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Katana')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(2)(3)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(2)(1)'

    if (isAiming) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(1)(1)'
    end

    if (state == 7 or state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(2)(6)'
    end

    -- if (state == 8) then
    --     data.leftTriggerType = 'Resistance'
    --     data.leftForceTrigger = '(6)(1)'
    -- end

    if (state == 10) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(3)'
    end

    if (state == 11) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(2)(1)'
    end

    if (state == 12) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(2)(5)'
    end

    if (state == 15) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(4)'
    end

    if (state == 19 or state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    if (IsBlockedBullet) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(3)(2)'
    end

    return data
end

return Weapon
