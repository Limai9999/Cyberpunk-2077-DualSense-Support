local function Weapon(data, name, isAiming, state, dilated, triggerType)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Shotgun')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(8)(4)'

    local freq = 0

    if (name == 'w_shotgun_budget_carnage') then
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(8)(8)'

        if (state == 8) then
            if (isAiming) then data.leftForceTrigger = '(1)(8)' end
            data.rightForceTrigger = '(1)(8)(8)(8)'
        end
    elseif (name == 'w_revolver_militech_crusher') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(5)'    

        if (state == 8) then
            freq = GetFrequency(2, dilated)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(2)(9)(7)(7)('.. freq ..')(0)' 
        end
    elseif (name == 'w_shotgun_zhuo') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(8)(8)'
    elseif (name == 'w_rifle_precision__techtronika_pozhar') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(2)(6)(6)'

        freq = GetFrequency(4, dilated)
        -- local freqLeft = GetFrequency(1, dilated)

        if (state == 8) then
            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(2)(9)(0)(1)(1)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
        end
    end

    data.canUseWeaponReloadEffect = false

    return data
end

return Weapon
