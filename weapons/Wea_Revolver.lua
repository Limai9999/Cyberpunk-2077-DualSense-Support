local function Weapon(data, name, isAiming, state, dilated, triggerType)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Revolver')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(2)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(4)(6)(7)'

    local freq = 0

    if (name == 'w_revolver_malorian_overture') then
        if (isAiming) then
            if (state == 8) then
                data.leftForceTrigger = '(1)(4)'
            end
        end

        if (triggerType == 'Charge') then
            if (state == 1) then
                data.rightTriggerType = 'Galloping'

                if (dilated) then
                    freq = GetFrequency(8, dilated)
                    data.rightForceTrigger = '(3)(9)(1)(3)('.. freq ..')'
                else
                    freq = GetFrequency(10, dilated)
                    data.rightForceTrigger = '(3)(9)(1)(4)('.. freq ..')'
                end
            end

            if (state == 8) then
                freq = GetFrequency(2, dilated)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(4)(9)(1)(1)('.. freq ..')(1)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(1)'
            end
        end
    elseif (name == 'w_revolver_darra_quasar') then
        if (isAiming) then
            if (state == 1) then
                freq = GetFrequency(12, dilated)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(5)(7)('.. freq ..')'
            elseif (state == 8) then
                if (dilated) then
                    freq = GetFrequency(7, dilated)
                else
                    freq = GetFrequency(6, dilated)
                end
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            end
        end
    elseif (name == 'w_revolver_darra_nova') then
        if (isAiming and state == 8) then
            data.leftForceTrigger = '(1)(3)'
        end
    elseif (name == 'w_revolver_techtronika_burya') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(7)(7)'

        if (state == 2 or state == 4 or state == 8) then
            data.leftForceTrigger = '(1)(4)'
        end

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(0)(7)(7)(7)'
        end

        data.canUseWeaponReloadEffect = false
        data.canUseNoAmmoWeaponEffect = false
    end

    return data
end

return Weapon
