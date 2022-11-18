local function Weapon(data, name, isAiming, state, dilated)
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
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(6)(6)(6)'
        if (state == 1) then
            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(3)(9)(3)(7)(3)'
            freq = GetFrequency(18, dilated)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
        elseif (isAiming and state == 8) then
            freq = GetFrequency(2, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(8)('.. freq ..')'
        end
    elseif (name == 'w_rifle_precision_midnight_sor22') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(6)'
    end

    return data
end

return Weapon
