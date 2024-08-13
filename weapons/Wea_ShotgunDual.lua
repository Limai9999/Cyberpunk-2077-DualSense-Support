local afterShootTimes = 0
local isPerfectChargedTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_ShotgunDual')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(4)(8)(8)'

    local freq = 0

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    if (not isPerfectCharged) then
        isPerfectChargedTimes = 0
    end

    if (name == 'w_shotgun_dual_rostovic_igla') then
        data.leftForceTrigger = '(1)(1)'
        data.rightForceTrigger = '(1)(4)(7)(7)'

        if (state == 'Shoot' or state == 'NoAmmo') then
            data.leftForceTrigger = '(1)(4)'
            data.rightForceTrigger = '(1)(6)(7)(7)'
        end
    elseif (name == 'w_2020_shotgun_blunderbuss') then
        if (state ~= 'Shoot' and state ~= 'NoAmmo' and not isPerfectCharged) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(2)(3)(2)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(6)(8)'

        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(3)'
        end

        if (state == 'Charging') then
            freq = GetChargeTrigger(name, dilated, false, 0.5, 3, 40)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(6)(7)('.. freq ..')'

            if (isPerfectCharged) then
                local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(), dilated, false)

                if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'

                    isPerfectChargedTimes = isPerfectChargedTimes + 1
                end
            end
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 23, dilated, false)

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
        data.skipDefaultState = false

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(2)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(7)'

        if (state ~= 'Shoot' and state ~= 'NoAmmo' and state ~= 'Default') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo' or state == 'Default') then
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

        if (state ~= 'Shoot' and state ~= 'NoAmmo') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 10, dilated, false)

            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(3)'

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(2)(7)'
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    end

    return data
end

return Weapon
