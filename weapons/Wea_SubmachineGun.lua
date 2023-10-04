local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_SubmachineGun')

    local freq = 0

    data.leftTriggerType = 'Choppy'

    if (name == 'w_submachinegun_militech_saratoga') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(4)(4)'

        if (state == 8) then
            freq = GetFrequency(14, dilated)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(5)(6)('.. freq ..')(0)'
        end

        if (isAiming) then
            if (state == 8) then
                local freqHalf = math.floor(freq / 2)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(5)(9)(1)(2)('.. freqHalf ..')(0)'
            end
        end
    elseif (name == 'w_submachinegun_arasaka_shingen') then
        data.rightTriggerType = 'SemiAutomaticGun'
        data.rightForceTrigger = '(2)(4)(4)'
        if (state == 8) then
            freq = GetFrequency(10, dilated)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(5)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
        end
    elseif (name == 'w_submachinegun_arasaka_senkoh') then
        data.rightTriggerType = 'SemiAutomaticGun'
        data.rightForceTrigger = '(2)(4)(4)'

        if (state == 8) then
            freq = GetFrequency(10, dilated)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(4)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(4)(7)('.. freq ..')(0)'
        elseif (state == 1) then
            freq = GetFrequency(14, dilated)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(2)(3)('.. freq ..')(0)'
        end
    elseif (name == 'w_special_kangtao_dian') then
        freq = GetFrequency(13, dilated)
        data.rightTriggerType = 'SemiAutomaticGun'
        data.rightForceTrigger = '(2)(4)(4)'

        if (state == 8) then
            local freqHalf = math.floor(freq / 2)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(5)(9)(1)(1)('.. freqHalf ..')(0)'

            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(8)('.. freq ..')'
        end
    elseif (name == 'w_submachinegun_darra_pulsar') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(3)(4)(5)(4)'
        if (state == 8) then
            freq = GetFrequency(15, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(6)('.. freq ..')'
        end
    else
        freq = GetFrequency(15, dilated)
        data.rightTriggerType = 'AutomaticGun'
        data.rightForceTrigger = '(4)(8)('.. freq ..')'
    end

    return data
end

return Weapon
