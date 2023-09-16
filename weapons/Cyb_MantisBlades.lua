local function Weapon(data, name, isAiming)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_MantisBlades')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(5)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(3)(5)(3)'

    if (state == 0) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(1)'
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(1)(1)'
    end

    if (stamina == 1) then
        data.leftForceTrigger = '(0)(1)(8)(8)'
        data.rightForceTrigger = '(1)(5)(8)(8)'
    end

    if (state == 5 or state == 6) then
        data.rightForceTrigger = '(1)(5)(5)(6)'
        if (stamina == 1) then data.rightForceTrigger = '(1)(6)(8)(8)' end
    end

    if (isAiming) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(5)(1)'
        if (stamina == 1) then data.leftForceTrigger = '(5)(3)' end

        data.rightTriggerType = 'Choppy'
        if (stamina == 1) then data.rightTriggerType = 'Rigid' end

        if (state == 14) then
            data.leftForceTrigger = '(5)(5)'

            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(5)(3)'

            if (stamina == 1) then
                data.leftForceTrigger = '(5)(8)'
                data.rightForceTrigger = '(5)(5)'
            end
        end
    end

    return data
end

return Weapon
