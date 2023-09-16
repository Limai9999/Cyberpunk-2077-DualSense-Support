local function Weapon(data, name, isAiming)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Katana')

    local stamina = GetState('Stamina')
    local meleeState = GetState('MeleeWeapon')

    -- print(meleeState)

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Choppy'
    -- data.rightForceTrigger = '(1)(1)'

    if (stamina == 1) then
        data.leftForceTrigger = '(1)(5)'
        data.rightForceTrigger = '(1)(5)'
    end

    if (meleeState == 6) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(2)(4)'
        if (stamina == 1) then data.rightForceTrigger = '(2)(7)' end
    end

    if (isAiming) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(1)(5)'
        if (stamina == 1) then data.rightForceTrigger = '(1)(8)' end
    end

    if (meleeState == 19) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
