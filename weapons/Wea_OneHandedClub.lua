local function Weapon(data, name, isAiming, _, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_OneHandedClub')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(1)(4)(2)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(2)(8)(5)'

    local stamina = GetState('Stamina')

    if (stamina == 1) then
        data.leftForceTrigger = '(1)(4)(8)(8)'
        data.rightForceTrigger = '(0)(2)(8)(8)'
    end

    if (isAiming) then
        data.rightTriggerType = 'Hard'
        if (stamina == 1) then data.rightTriggerType = 'Hardest' end
    end

    local state = GetState('MeleeWeapon')

    local freq = 0

    if (name == 'w_melee_baton') then
        if (state == 6) then
            if (isAiming) then
                freq = GetFrequency(7, dilated)
            else
                freq = GetFrequency(10, dilated)
            end

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(7)('.. freq ..')'

            if (isAiming) then
                data.leftTriggerType = 'Galloping'
                data.leftForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(2)(4)(8)(5)'
                if (stamina == 1) then data.rightForceTrigger = '(2)(4)(8)(8)' end
            end
        end
    end

    if (state == 19) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
