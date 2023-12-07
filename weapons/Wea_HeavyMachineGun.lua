local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-Items-Item Type-Wea_HeavyMachineGun')

    local freq = 0

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(4)(5)(4)'

    if (state == 7) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(8)'
        freq = GetFrequency(25, dilated, name)
        data.rightTriggerType = 'Galloping'
        data.rightForceTrigger = '(4)(9)(3)(4)('.. freq ..')'
    end

    if (state == 8 or state == 'turretShooting') then
        if (state == 8) then
            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(4)(9)(2)(3)(2)'
        end

        freq = GetFrequency(attackSpeed, dilated, name)
        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
    end

    if (isWeaponGlitched and triggerType ~= 'SemiAuto' and triggerType ~= 'Charge') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(6)(6)'

        if (state == 8) then
            freq = GetFrequency(2, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
        end

        return data
    end

    return data
end

return Weapon
