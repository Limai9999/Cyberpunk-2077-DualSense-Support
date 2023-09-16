local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_ShotgunDual')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(7)(7)'

    local freq = 0

    if (name == 'w_shotgun_dual_rostovic_igla') then
        data.leftForceTrigger = '(1)(1)'
        data.rightForceTrigger = '(1)(4)(7)(7)'
    elseif (name == 'w_2020_shotgun_blunderbuss') then
        if (state == 1) then
            freq = GetFrequency(14, dilated)

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(6)(7)('.. freq ..')'
        end

        if (state == 8) then
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(3)(6)'
        end
    end

    return data
end

return Weapon
