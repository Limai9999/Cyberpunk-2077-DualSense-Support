local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-Weapons-Melee-DisplayName-Preset_Machete')

    local stamina = GetState('Stamina')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(4)'
    data.rightTriggerType = 'Medium'

    if (stamina == 2) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(5)'
        data.rightTriggerType = 'Hardest'
    end

    if (isAiming) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(4)(4)'
        if (stamina == 2) then
            data.rightForceTrigger = '(0)(3)(8)(8)'
        end
    end

    if (IsBlockedBullet) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(3)(3)'
    end

    return data
end

return Weapon
