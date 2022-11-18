local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Revolver')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(4)(8)(8)'

    local freq = 0

    if (name == 'w_revolver_malorian_overture') then
        if (isAiming) then
            if (state == 8) then
                data.leftForceTrigger = '(1)(6)'
            end
        end
    elseif (name == 'w_revolver_darra_quasar') then
        if (isAiming) then
            if (state == 1) then
                freq = GetFrequency(12, dilated)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(5)(7)('.. freq ..')'
            elseif (state == 8) then
                freq = GetFrequency(6, dilated)
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            end
        end
    elseif (name == 'w_revolver_darra_nova') then
        if (isAiming and state == 8) then
            data.leftForceTrigger = '(1)(4)'
        end
    elseif (name == 'w_revolver_techtronika_burya') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(6)'
        end
    end

    return data
end

return Weapon
