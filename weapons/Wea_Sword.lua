local afterShootTimes = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-Items-Item Type-Wea_Sword')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    if (name == 'w_melee_katana') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(4)(1)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(4)(1)'

        if (state ~= 'BlockAttack' and state ~= 'FinalAttack' and state ~= 'JumpAttack' and state ~= 'SprintAttack') then
            CalcFixedTimeIndex(name, 0, dilated, true)
            afterShootTimes = 0
        else
            afterShootTimes = afterShootTimes + 1
        end

        if (isAiming) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(3)(1)'
        end

        if (state == 'ChargedHold' or state == 'StrongAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(6)(3)(6)'
        end

        if (state == 'JumpAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'12', 30, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(2)(4)'
            end

            afterShootTimes = afterShootTimes + 1
        end

        if (state == 'Deflect') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(3)'
        end

        if (state == 'ComboAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(3)(1)'
        end

        if (state == 'FinalAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'12', 20, dilated, false)

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(4)(4)'

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(2)(4)'
            end
        end

        if (state == 'BlockAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'15', 20, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(0)(4)'
            end

            afterShootTimes = afterShootTimes + 1
        end

        if (state == 'SprintAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'15', 20, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(0)(4)'
            end

            afterShootTimes = afterShootTimes + 1
        end

        if (state == 'DeflectAttack') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(6)'
        end

        if (IsBlockedBullet) then
            data = UseBulletBlockTrigger(data, config)
        end
    end

    return data
end

return Weapon
