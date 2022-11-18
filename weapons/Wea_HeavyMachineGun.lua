local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-Items-Item Type-Wea_HeavyMachineGun')

    local freq = 0

    if (state ~= 7) then
        freq = GetFrequency(6, dilated)
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
    else
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(8)'
        freq = GetFrequency(25, dilated)
        data.rightTriggerType = 'Galloping'
        data.rightForceTrigger = '(4)(9)(3)(4)('.. freq ..')'
    end

    if (state == 8) then
        freq = GetFrequency(2, dilated)
        data.leftTriggerType = 'Galloping'
        data.leftForceTrigger = '(4)(9)(6)(7)('.. freq ..')'
    end

    return data
end

return Weapon
