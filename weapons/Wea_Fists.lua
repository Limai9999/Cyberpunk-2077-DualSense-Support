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
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(1)(6)(8)' end
    end

    if (stamina == 'Exhausted') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(5)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(7)(8)'
    end

    if (state == 'Hold' or state == 'ChargedHold') then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(2)(4)'
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(2)(6)' end
    end

    if (state == 'StrongAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(1)(7)'

        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(2)(3)(8)' end
    end

    if (state == 'ComboAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(2)(3)'

        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(6)(4)(5)' end
    end

    if (state == 'FinalAttack' or state == 'SafeAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(3)(8)'
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(7)(5)(8)' end
    end

    if (state == 'BlockAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(4)'
    end

    if (state == 'DeflectAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
