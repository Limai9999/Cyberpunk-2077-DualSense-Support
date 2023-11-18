local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Hammer')

    local state = GetState('MeleeWeapon')
    local stamina = GetState('Stamina')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(2)(8)(4)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(7)(3)'

    if (isAiming) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(5)(6)'
    end

    if (state == 8) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(3)'
    end

    if (state == 10) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(0)(5)'
    end

    if (state == 7 or state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(5)(7)'
    end

    if (state == 15) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(6)'
    end

    if (state == 19 or state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(8)'
    end

    return data
end

return Weapon
