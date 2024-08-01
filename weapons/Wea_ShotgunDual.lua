local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
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
        if (state ~= 8 and state ~= 4) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(3)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(6)(8)'

        if (state == 1) then
            freq = GetChargeTrigger(name, dilated, false, 0.5, 3, 40)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(6)(7)('.. freq ..')'
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 8 or state == 4) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 25, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Normal'
            else
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(3)(8)'
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_shotgun_dual_rostovic_testera') then
        data.skipZeroState = false

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(2)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(7)'

        if (state ~= 8 and state ~= 4 and state ~= 0) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 8 or state == 4 or state == 0) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 25, dilated, false)

            data.leftTriggerType = 'Normal' 

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(5)'

                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(3)(8)'
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_shotgun_dual_rostovic_palica') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(4)(1)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(3)(5)'

        if (state == 8 or state == 4) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(3)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(8)(3)(5)'
        end
    end

    return data
end

return Weapon
