local function Weapon(data, name, isAiming, state, dilated, triggerType)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Revolver')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(2)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(4)(6)(7)'
    data.canUseNoAmmoWeaponEffect = false

    local freq = 0

    if (name == 'w_revolver_malorian_overture') then
        if (isAiming) then
            if (state == 8) then
                data.leftForceTrigger = '(1)(4)'
            end
        end

        if (triggerType == 'Charge' or triggerType == 'FullAuto') then
            if (state == 1) then
                data.rightTriggerType = 'Galloping'

                if (dilated) then
                    freq = GetChargeTrigger(name, dilated, false, 0.3, 2, 10)
                    data.rightForceTrigger = '(3)(9)(1)(3)('.. freq ..')'
                else
                    freq = GetChargeTrigger(name, dilated, false, 0.3, 2, 12)
                    data.rightForceTrigger = '(3)(9)(1)(4)('.. freq ..')'
                end
            else
                GetChargeTrigger(name, dilated, true)
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
                freq = GetChargeTrigger(name, dilated, false, 0.35, 2, 24)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(5)(7)('.. freq ..')'
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 8) then
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

        if (triggerType == 'SemiAuto') then
            if (state == 8) then
                data.leftForceTrigger = '(1)(6)'
                data.rightForceTrigger = '(0)(8)(7)(7)'
            end
        elseif (triggerType == 'Charge') then
            if (state == 1) then
                freq = GetChargeTrigger(name, dilated, false, 2, 3, 50)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(5)(7)('.. freq ..')'
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 2 or state == 4 or state == 8) then
                data.leftForceTrigger = '(1)(6)'

                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(8)(8)(8)'
            end
        end

        data.canUseWeaponReloadEffect = false
        data.canUseNoAmmoWeaponEffect = false
    elseif (name == 'w_revolver_techtronika_metel') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(1)'

        if (isAiming) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(8)'
        else
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(4)(6)'
        end

        if (state == 8) then
            data.leftForceTrigger = '(1)(4)'
        end
    end

    return data
end

return Weapon
