local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, _, usingWeapon)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_StrongArms')

    local canPerformRelicAttack = CanPerformRelicAttack(usingWeapon)

    local stamina = GetState('Stamina', 'gamePSMStamina')
    local state = GetState('MeleeWeapon', 'gamePSMMeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(2)(3)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(2)(6)(6)'

    if (isAiming) then
        data.rightForceTrigger = '(0)(2)(4)(6)'
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(2)(6)(8)' end
    end

    if (stamina == 'Exhausted') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(2)(5)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(8)(8)'
    end

    if (state == 'Hold') then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(2)(4)'
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(2)(6)' end
    end

    if (state == 'ChargedHold') then
        if (canPerformRelicAttack) then
            local freq = GetChargeTrigger(name, false, false, 0.3, 10, 30)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(4)('.. freq ..')'
        else
            local freq = GetChargeTrigger(name, false, false, 0.12, 2, 30)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
        end
    else
        GetChargeTrigger(name, false, true)
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

        if (canPerformRelicAttack) then
            local freq = GetChargeTrigger(name, false, false, 0.3, 8, 20)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
        end
    end

    if (state == 'FinalAttack' or state == 'SafeAttack' or (state == 'StrongAttack' and canPerformRelicAttack)) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(8)(1)(8)'
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(8)(3)(8)' end
    end

    if (state == 'BlockAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(4)'
    end

    if (state == 'DeflectAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
