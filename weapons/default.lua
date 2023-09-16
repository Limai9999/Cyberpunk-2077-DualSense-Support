local function Weapon(data, name, isAiming, _, dilated)
    data.type = GetText('Mod-DualSense-VehicleType-Default')

    data.leftTriggerType = 'Normal'
    data.rightTriggerType = 'Normal'

    local state = GetState('MeleeWeapon')

    if (name == 'w_melee_one_hand_blunt') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(1)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(5)'

        if (state == 9 or state == 7) then
            local freq = GetFrequency(8, dilated)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
        end

        if (state == 7) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(7)(1)'
        elseif (state == 6) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(6)(7)(7)'
        elseif (state == 14) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(7)(8)'
        elseif (state == 18) then
            data.leftTriggerType = 'Choppy'
            data.rightTriggerType = 'Normal'
        end

        data.overrideDefault = false
    end

    return data
end

return Weapon