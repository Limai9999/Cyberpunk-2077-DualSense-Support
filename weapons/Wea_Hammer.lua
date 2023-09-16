local function Weapon(data, name, isAiming, _, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Hammer')

    data.leftTriggerType = 'Hardest'
    data.rightTriggerType = 'VeryHard'

    local state = GetState('MeleeWeapon')
    local stamina = GetState('Stamina')

    if (state == 0) then
        data.leftTriggerType = 'Normal'
        data.rightTriggerType = 'Normal'
    elseif (state == 6 or state == 7) then
        data.rightTriggerType = 'Hard'
    elseif (state == 4 or (state >= 10 and state <= 20)) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(6)(8)(8)'
    end

    if (stamina == 1) then
        data.rightTriggerType = 'Hardest'
    end

    if (state == 19) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
