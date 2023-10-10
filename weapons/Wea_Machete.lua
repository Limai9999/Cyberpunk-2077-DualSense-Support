local function Weapon(data, name, isAiming, _, dilated)
    data.type = GetText('Gameplay-Items-Item Type-Wea_Machete')

    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(3)(4)'

    if (state == 8) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(6)(1)'
    end

    if (state == 10) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(2)'
    end
    if (state == 7) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(5)(3)'
    elseif (state == 6) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(5)(5)'
    elseif (state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(5)(2)'
    elseif (state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(5)(6)'
    elseif (state == 18) then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    elseif (state == 19 or state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon