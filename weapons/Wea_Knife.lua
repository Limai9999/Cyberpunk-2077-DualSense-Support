local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Knife')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Choppy'

    local meleeState = GetState('MeleeWeapon')

    if (meleeState == 7) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(7)(1)'
    elseif (meleeState == 6) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(6)(3)'
    elseif (meleeState == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(7)(8)'
    elseif (meleeState == 18) then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    elseif (meleeState == 19) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon