local function Weapon(data, name, isAiming, _, dilated)
    data.type = 'Chainsword'

    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(5)(5)'

    if (state == 8 or state == 10) then
        local freq = GetChargeTrigger(name, dilated, false, 0.1, 2, 10)

        data.leftTriggerType = 'Machine'
        data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
    else
        GetChargeTrigger(name, dilated, true)
    end

    if (state == 7) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(7)(3)'
    elseif (state == 6) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(7)(7)'
    elseif (state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(7)(3)'
    elseif (state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(7)(8)'
    elseif (state == 18) then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    end

    return data
end

return Weapon