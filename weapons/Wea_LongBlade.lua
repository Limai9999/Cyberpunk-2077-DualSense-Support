local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-Weapons-Melee-DisplayName-Preset_Machete')

    local stamina = GetState('Stamina', 'gamePSMStamina')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(4)'
    data.rightTriggerType = 'Medium'

    if (stamina == 'Exhausted') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(5)'
        data.rightTriggerType = 'Hardest'
    end

    if (isAiming) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(4)(4)'
        if (stamina == 'Exhausted') then
            data.rightForceTrigger = '(0)(3)(8)(8)'
        end
    end

    if (IsBlockedBullet) then
        data = UseBulletBlockTrigger(data, config)
    end

    return data
end

return Weapon
