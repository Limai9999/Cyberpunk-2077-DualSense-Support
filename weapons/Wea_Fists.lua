local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Fists')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(3)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(1)(5)(6)'

    if (isAiming) then
        data.rightForceTrigger = '(0)(1)(4)(6)'
        if (stamina == 2) then data.rightForceTrigger = '(0)(1)(6)(8)' end
    end

    if (stamina == 2) then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(5)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(7)(8)'
    end

    if (state == 6 or state == 7) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(2)(4)'
        if (stamina == 2) then data.rightForceTrigger = '(2)(6)' end
    end

    if (state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(1)(7)'

        if (stamina == 2) then data.rightForceTrigger = '(0)(2)(3)(8)' end
    end

    if (state == 11) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(2)(3)'

        if (stamina == 2) then data.rightForceTrigger = '(0)(6)(4)(5)' end
    end

    if (state == 12 or state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(3)(8)'
        if (stamina == 2) then data.rightForceTrigger = '(0)(7)(5)(8)' end
    end

    if (state == 15) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(4)'
    end

    if (state == 19 or state == 20) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
