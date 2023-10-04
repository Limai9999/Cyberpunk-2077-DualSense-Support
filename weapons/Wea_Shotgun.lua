local function Weapon(data, name, isAiming, state, dilated, triggerType)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Shotgun')

    if (state == 4 or state == 0 or state == 6) then return data end

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(8)(4)'

    local freq = 0

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    if (name == 'w_shotgun_budget_carnage') then
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(8)'
            data.rightForceTrigger = '(0)(7)(8)(8)'
        end
    elseif (name == 'w_revolver_militech_crusher') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(5)'

        if (state == 8) then
            freq = GetFrequency(2, dilated)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(2)(9)(2)(2)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(2)(9)(7)(7)('.. freq ..')(0)'
        end
    elseif (name == 'w_shotgun_zhuo') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(3)(8)(8)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(6)'
            data.rightForceTrigger = '(1)(6)(8)(8)'
        end

        -- data.canUseWeaponReloadEffect = true
        -- data.canUseNoAmmoWeaponEffect = false
    elseif (name == 'w_rifle_precision__techtronika_pozhar') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(2)(6)(6)'

        if (dilated) then
          freq = GetFrequency(5, dilated)
        else
          freq = GetFrequency(4, dilated)
        end

        if (state == 8) then
            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(2)(9)(0)(1)(1)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
        end
    elseif (name == 'w_shotgun_constitutional_tactician') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(1)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(8)(4)'

        if (state == 8) then
            data.leftForceTrigger = '(1)(4)'
            data.rightForceTrigger = '(0)(5)(8)(6)'
        end
    end

    return data
end

return Weapon
