local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-Items-Item Type-Wea_HeavyMachineGun')

    local freq = 0

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(4)(5)(4)'

    if (state == 7) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(8)'
        freq = GetFrequency(25, dilated)
        data.rightTriggerType = 'Galloping'
        data.rightForceTrigger = '(4)(9)(3)(4)('.. freq ..')'
    end

    if (state == 8) then
        data.leftTriggerType = 'Galloping'
        data.leftForceTrigger = '(4)(9)(2)(3)(2)'

        freq = GetFrequency(6, dilated)
        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
    end

    return data
end

return Weapon
