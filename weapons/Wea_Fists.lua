local function Weapon(data, name, isAiming)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Fists')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(3)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(1)(5)(6)'

    if (isAiming) then
        data.rightForceTrigger = '(0)(1)(4)(6)'
        if (stamina == 1) then data.rightForceTrigger = '(0)(1)(6)(8)' end
    end

    if (stamina == 1) then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(5)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(7)(8)'
    end

    if (state == 6) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(2)(6)'
        if (stamina == 1) then data.rightForceTrigger = '(2)(8)' end
    end

    if (state == 12 or state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(6)(8)'
        if (stamina == 1) then data.rightForceTrigger = '(0)(7)(8)(8)' end
    end

    return data
end

return Weapon
