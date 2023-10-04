local function Weapon(data, name, isAiming, _, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Knife')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Choppy'

    local state = GetState('MeleeWeapon')

    if (state == 7 or state == 13) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(5)(5)(5)'
    elseif (state == 6) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(6)(3)'
    elseif (state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(7)(8)'
    elseif (state == 19) then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    elseif (state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon