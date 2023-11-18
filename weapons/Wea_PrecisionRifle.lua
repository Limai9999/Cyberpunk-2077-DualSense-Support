local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_PrecisionRifle')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'SemiAutomaticGun'
    data.rightForceTrigger = '(2)(5)(8)'

    local freq = 0

    if (name == 'w_rifle_precision_rostovic_kolac') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(7)(8)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(1)(7)(7)(8)'
        end
    elseif (name == 'w_rifle_precision_militech_achilles') then
        data.canUseWeaponReloadEffect = false
        data.canUseNoAmmoWeaponEffect = false

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(6)(3)(1)'

        if (triggerType == 'Burst' and state == 8) then
            freq = GetFrequency(attackSpeed, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(2)(9)(7)(7)('.. freq ..')(0)'
        end

        if (triggerType == 'Charge') then
            if (state == 1) then
                data.leftTriggerType = 'Galloping'
                data.leftForceTrigger = '(3)(9)(3)(7)(3)'

                freq = GetChargeTrigger(name, dilated, false, 0.3, 3, 35)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name)
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
            end
        end
    elseif (name == 'w_rifle_precision_midnight_sor22') then
        data.canUseNoAmmoWeaponEffect = false

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(8)(6)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(3)(7)(8)(6)'
        end
    end

    return data
end

return Weapon
