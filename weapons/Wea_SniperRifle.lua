local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_SniperRifle')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'SemiAutomaticGun'
    data.rightForceTrigger = '(2)(5)(8)'

    local freq = 0

    if (name == 'w_rifle_sniper_tsunami_ashura') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(7)'

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(7)'
            data.rightForceTrigger = '(7)(8)(8)(8)'
        end

        if (state == 2 or state == 4) then
            data.rightForceTrigger = '(4)(8)(8)(8)'
        end
    elseif (name == 'w_rifle_sniper_tsunami_nekomata') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(8)'

        if (state == 1) then
            freq = GetFrequency(15, dilated)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'
        elseif (state == 8) then
            freq = GetFrequency(2, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(8)('.. freq ..')'
        end

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(7)'
        end
    elseif (name == 'w_rifle_sniper_techtronika_grad') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'
        if (state == 8 or state == 4) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(8)'
            data.rightForceTrigger = '(0)(8)(8)(8)'
        end
    end

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    return data
end

return Weapon
