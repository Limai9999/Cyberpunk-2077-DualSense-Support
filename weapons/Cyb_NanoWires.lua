local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_NanoWires')

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(3)(4)(5)'

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon');

    if (state ~= 6 and state ~= 10 and state ~= 15) then GetChargeTrigger(name, false, true) end

    if (stamina == 2) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightForceTrigger = '(0)(3)(7)(8)'
    end

    if (state == 6) then
        local freq = GetChargeTrigger(name, false, false, 1, 8)

        data.rightTriggerType = 'Galloping'
        data.rightForceTrigger = '(2)(9)(2)(3)('.. freq ..')'
    end

    if (state == 7 or state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(7)(2)(7)'
    end

    if (state == 10) then
        local freq = GetChargeTrigger(name, false, false, 0.3, 4)

        data.leftTriggerType = 'Galloping'
        data.leftForceTrigger = '(2)(9)(1)(2)('.. freq ..')'
    end

    if (state == 8) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(6)(7)'
        if (stamina == 2) then data.rightForceTrigger = '(0)(3)(7)(8)' end
    end

    if (state == 11) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(1)(4)'
    end

    if (state == 12) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(2)(8)'
    end

    if (state == 15) then
        local freq = GetChargeTrigger(name, false, false, 0.5, 20)

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(3)(1)'

        data.rightTriggerType = 'Galloping'
        data.rightForceTrigger = '(4)(9)(2)(3)('.. freq ..')'
    end

    -- if (state == 6) then
    --   data.rightTriggerType = 'Bow'
    --   data.rightForceTrigger = '(1)(5)(7)(7)'
    -- end

    if (state == 19) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
