local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, _, usingWeapon)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_MantisBlades')

    local canPerformRelicAttack = CanPerformRelicAttack(usingWeapon)

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(5)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(3)(6)(3)'

    if (not canPerformRelicAttack) then GetChargeTrigger(name, false, true) end

    if (state == 0) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(1)'
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(1)(1)'
    end

    if (stamina == 2) then
        data.leftForceTrigger = '(0)(1)(8)(8)'
        data.rightForceTrigger = '(1)(3)(7)(8)'
    end

    if (state == 5 or state == 6 or state == 7 or state == 13) then
        data.rightForceTrigger = '(1)(5)(4)(6)'
        if (stamina == 2) then data.rightForceTrigger = '(1)(6)(7)(8)' end

        if (canPerformRelicAttack and (state == 5 or state == 6 or state == 7)) then
            local freq = GetChargeTrigger(name, false, false, 0.4, 5, 30)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(2)(3)('.. freq ..')'
        end
    end

    if (state == 10) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(5)(1)'

        if (stamina == 2) then data.leftForceTrigger = '(5)(3)' end
    end

    if (state == 11 or state == 18) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(1)(5)'

        if (stamina == 2) then data.rightForceTrigger = '(0)(7)(2)(7)' end

        if (canPerformRelicAttack) then
            local freq = GetChargeTrigger(name, false, false, 0.3, 7, 20)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(3)(4)('.. freq ..')'
        end
    end

    if (state == 13) then
        if (canPerformRelicAttack) then
            local freq = GetChargeTrigger(name, false, false, 0.4, 10, 30)

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(3)(3)('.. freq ..')(0)'
        end
    end

    if (isAiming) then
        data.rightTriggerType = 'Choppy'
        if (stamina == 2) then data.rightTriggerType = 'Rigid' end
    end

    if (state == 14 or state == 15) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(5)(3)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(7)(2)(6)'

        if (stamina == 2) then
            data.leftForceTrigger = '(5)(5)'
            data.rightForceTrigger = '(5)(5)'
        end
    end

    if (state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    if (IsBlockedBullet) then
        data = UseBulletBlockTrigger(data, config)
    end

    return data
end

return Weapon
