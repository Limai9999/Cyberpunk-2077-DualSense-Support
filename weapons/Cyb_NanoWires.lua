local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, _, usingWeapon)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_NanoWires')

    local canPerformRelicAttack = CanPerformRelicAttack(usingWeapon)
    local hasRelicPerk = RPGManager.HasStatFlag(GetPlayer(), gamedataStatType.CanUseNewMeleewareAttackSpyTree)
    local hasMonoWireQuickHack = not not RPGManager.GetMonoWireQuickhackRecord(usingWeapon)

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(3)(4)(5)'

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon');

    if (state ~= 'Hold' and state ~= 'Deflect' and state ~= 'BlockAttack' and state ~= 'ChargedHold' and state ~= 'StrongAttack') then GetChargeTrigger(name, false, true) end

    if (stamina == 'Exhausted') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightForceTrigger = '(0)(3)(7)(8)'
    end

    if (state == 'Hold') then
        if (hasRelicPerk and hasMonoWireQuickHack) then
            local freq = GetChargeTrigger(name, false, false, 0.3, 8, 30)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(2)(9)(2)(3)('.. freq ..')'
        else
            local freq = GetChargeTrigger(name, false, false, 0.1, 1, 3)

            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(1)('.. freq ..')'
        end
    end

    if (state == 'ChargedHold' or state == 'StrongAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(7)(2)(7)'

        if (canPerformRelicAttack and state == 'ChargedHold') then
            local freq = GetChargeTrigger(name, false, false, 0.3, 5, 35)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(2)(9)(3)(4)('.. freq ..')'
        end

        if (canPerformRelicAttack and state == 'StrongAttack') then
            local freq = GetChargeTrigger(name, false, false, -0.5, 35, 35)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(1)(9)(3)(4)('.. freq ..')'
        end
    end

    if (state == 'Deflect') then
        local freq = GetChargeTrigger(name, false, false, 0.3, 4)

        data.leftTriggerType = 'Galloping'
        data.leftForceTrigger = '(2)(9)(1)(2)('.. freq ..')'
    end

    if (state == 'Block') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(6)(7)'
        if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(3)(7)(8)' end
    end

    if (state == 'ComboAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(1)(4)'
    end

    if (state == 'FinalAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(2)(8)'
    end

    if (state == 'BlockAttack') then
        local freq = GetChargeTrigger(name, false, false, 0.5, 20)

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(3)(1)'

        data.rightTriggerType = 'Galloping'
        data.rightForceTrigger = '(4)(9)(2)(3)('.. freq ..')'
    end

    if (state == 'DeflectAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
