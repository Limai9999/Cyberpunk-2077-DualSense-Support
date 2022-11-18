local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_SniperRifle')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(4)'
    data.rightTriggerType = 'SemiAutomaticGun'
    data.rightForceTrigger = '(2)(5)(8)'

    local freq = 0

    if (name == 'w_rifle_sniper_tsunami_ashura') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(5)(5)'
    elseif (name == 'w_rifle_sniper_tsunami_nekomata') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(8)(8)(8)'
        if (state == 1) then
            freq = GetFrequency(15, dilated)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'
        elseif (state == 8) then
            freq = GetFrequency(2, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(8)('.. freq ..')'
        end
    elseif (name == 'w_rifle_sniper_techtronika_grad') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(8)(6)'
        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(8)'
            -- data.rightTriggerType = 'Normal'
            data.rightForceTrigger = '(7)(8)(8)(8)'
        end
    end

    return data
end

return Weapon
