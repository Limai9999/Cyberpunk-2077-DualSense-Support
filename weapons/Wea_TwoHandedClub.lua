local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_TwoHandedClub')

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Resistance'
    data.rightForceTrigger = '(1)(4)'

    local stamina = GetState('Stamina')

    if (stamina == 2) then data.rightForceTrigger = '(1)(8)' end

    if (isAiming) then
        data.rightTriggerType = 'Medium'
        if (stamina == 2) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(6)'
            data.rightTriggerType = 'Hardest'
        end
    end

    return data
end

return Weapon
