local afterShootTimes = 0
local isPerfectChargedTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Revolver')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(2)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(1)(4)(6)(7)'
    data.canUseNoAmmoWeaponEffect = false

    local freq = 0

    if (not isPerfectCharged) then
        isPerfectChargedTimes = 0
    end

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
                freq = GetFrequency(attackSpeed, dilated, name)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(4)(9)(1)(1)('.. freq ..')(1)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(1)'
            end
        end
    elseif (name == 'w_revolver_darra_quasar') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(1)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(5)(4)'

        if (state == 8) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(7)(3)(4)'
        end

        if (isAiming) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(3)(2)(2)'

            if (state == 1) then
                freq = GetChargeTrigger(name, dilated, false, 0.35, 2, 24)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(5)(7)('.. freq ..')'
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            end
        end
    elseif (name == 'w_revolver_darra_nova') then
        local isDoomDoom = FindInString(itemName, 'Doom_Doom') or itemName == 'Items.VHard_50_BodyCool_Weapon11'

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(1)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(7)'

        if (isDoomDoom) then
            data.rightForceTrigger = '(0)(3)(6)(7)'
        end

        if (state ~= 8) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 8) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 20, dilated, false)

            if (isDoomDoom) then
                data.leftForceTrigger = '(2)(3)'
            end

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Normal'

                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(2)(5)'

                if (isDoomDoom) then
                    data.rightForceTrigger = '(2)(6)'
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_revolver_techtronika_burya') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(7)(7)'

        if (state == 2 or state == 4 or state == 8) then
            data.leftForceTrigger = '(1)(4)'
        end

        if (triggerType == 'SemiAuto') then
            if (state == 8) then
                data.leftForceTrigger = '(1)(6)'
                data.rightForceTrigger = '(0)(8)(7)(7)'
            end
        elseif (triggerType == 'Charge') then
            if (not isPerfectCharged) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 1) then
                freq = GetChargeTrigger(name, dilated, false, 2, 3, 50)

                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(5)(7)('.. freq ..')'
    
                if (isPerfectCharged) then
                    local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(), dilated, false)
    
                    if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(3)(9)(4)(4)('.. freq ..')(0)'
    
                        isPerfectChargedTimes = isPerfectChargedTimes + 1
                    end
                end
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state ~= 8 and state ~= 4) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 2) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(1)(2)(7)(1)'
            end

            if (state == 4 or state == 8) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 15, dilated, false)

                data.leftForceTrigger = '(1)(6)'

                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(0)(8)'

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.rightTriggerType = 'Normal'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end

        data.canUseWeaponReloadEffect = false
        data.canUseNoAmmoWeaponEffect = false
    elseif (name == 'w_revolver_techtronika_metel') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(2)'

        local isBaldEagle = FindInString(itemName, 'Kurt')

        if (isAiming) then
            data.leftTriggerType = 'Normal'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(8)'
        else
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(4)(6)'
        end

        if (state ~= 8 and state ~= 4) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 8) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 25, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(3)'

                if (isBaldEagle) then data.leftForceTrigger = '(1)(4)' end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    end

    if (isWeaponGlitched and triggerType ~= 'SemiAuto') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(6)(6)'

        if (state == 8) then
            freq = GetFrequency(1, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(6)(6)('.. freq ..')(0)'
        end

        return data
    end

    return data
end

return Weapon
