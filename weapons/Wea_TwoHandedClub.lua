local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_TwoHandedClub')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(1)(4)(3)(3)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(1)(7)(5)'

    if (state == 6 or state == 7) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(4)(5)'
    elseif (state == 8) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(4)(4)'
    elseif (state == 12) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(5)'
    elseif (state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(4)(7)'
    elseif (state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(4)(6)'
    elseif (state == 15) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(2)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(4)(4)'
    elseif (state == 18) then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    end

    if (state == 19) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(6)'
    end

    return data
end

return Weapon
