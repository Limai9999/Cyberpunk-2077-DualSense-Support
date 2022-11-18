local function Weapon(data, name, isAiming)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_NanoWires')

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(3)(5)(5)'

    local stamina = GetState('Stamina')

    if (stamina == 1) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(5)'
        data.rightForceTrigger = '(0)(3)(8)(8)'
    end

    if (isAiming) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(7)(7)'
        if (stamina == 1) then data.rightForceTrigger = '(0)(3)(8)(8)' end
    end

    return data
end

return Weapon
