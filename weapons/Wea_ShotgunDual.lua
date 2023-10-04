local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_ShotgunDual')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(4)(8)(8)'

    local freq = 0

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    if (name == 'w_shotgun_dual_rostovic_igla') then
        data.leftForceTrigger = '(1)(1)'
        data.rightForceTrigger = '(1)(4)(7)(7)'

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(4)'
            data.rightForceTrigger = '(1)(6)(7)(7)'
        end
    elseif (name == 'w_2020_shotgun_blunderbuss') then
      data.rightTriggerType = 'Bow'
      data.rightForceTrigger = '(0)(3)(6)(8)'

        if (state == 1) then
            freq = GetFrequency(14, dilated)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(6)(7)('.. freq ..')'
        end

        -- if (state == 5) then
        --     data.rightTriggerType = 'Resistance'
        --     data.rightForceTrigger = '(3)(5)'
        -- end

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(5)'
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(3)(8)'
        end
    elseif (name == 'w_shotgun_dual_rostovic_testera') then
        data.leftForceTrigger = '(1)(2)'
        data.rightForceTrigger = '(0)(4)(6)(7)'

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(5)'
        end
    elseif (name == 'w_shotgun_dual_rostovic_palica') then
        data.leftForceTrigger = '(1)(1)'
        data.rightForceTrigger = '(0)(4)(5)(6)'

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(4)'
        end
    end

    return data
end

return Weapon
