local timesAfterThrow = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Knife')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(2)(2)(1)'
    data.rightTriggerType = 'Choppy'

    local state = GetState('MeleeWeapon')

    if (name == 'w_melee_knife') then
        if (state ~= 'ThrowAttack') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'ChargedHold' or state == 'StrongAttack' or state == 'JumpAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(5)(4)(4)'
        elseif (state == 'Hold') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(3)'
        elseif (state == 'SafeAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(6)(6)'
        elseif (state == 'CrouchAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(5)(4)(6)'
        elseif (state == 'DeflectAttack') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(6)'
        end

        if (state == 'ThrowAttack') then
            local throwTriggerActiveForTimes = CalcFixedTimeIndex(name..'19', 40, dilated, false)

            if (timesAfterThrow < throwTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(2)(2)'
            else
                data.leftTriggerType = 'Normal'
                data.rightTriggerType = 'Normal'
            end

            timesAfterThrow = timesAfterThrow + 1
        else
            timesAfterThrow = 0
        end
    end

    return data
end

return Weapon