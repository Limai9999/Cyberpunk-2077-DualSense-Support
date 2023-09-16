local function Weapon(data, name, isAiming, state, dilated)
    data.type = GetText('Gameplay-RPG-Skills-GunslingerName')

    local freq = 0

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(7)(3)'

    if (name == 'w_handgun_militech_lexington') then
        if (state == 8) then
            freq = GetFrequency(8, dilated)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'    
        end

        if (isAiming) then
            if (state == 8) then
                local freqHalf = math.floor(freq / 2)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(5)(9)(1)(1)('.. freqHalf ..')(0)'
            end
        end
    elseif (name == 'w_handgun_arasaka_yukimura') then
        if (isAiming) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(3)(4)(3)(4)'

            if (state == 8) then
                freq = GetFrequency(10, dilated)
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(5)(8)('.. freq ..')'
            end
        else
            freq = GetFrequency(7, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(5)(8)('.. freq ..')'
        end
    elseif (name == 'w_handgun_kangtao_chao') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(3)(4)'
        if (state == 8) then
            freq = GetFrequency(6, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(3)(8)('.. freq ..')'
        end
    elseif (name == 'w_handgun_malorian_silverhand') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(8)'

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(5)'
        end
    elseif (name == 'w_handgun_arasaka_kenshin') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(4)(8)'
        if (state == 1) then
            freq = GetFrequency(10, dilated)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(4)('.. freq ..')'
        elseif (state == 8) then
            freq = GetFrequency(7, dilated)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
        end
    elseif (name == 'w_handgun_militech_omaha') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(7)(4)'
        if (state == 1) then
            freq = GetFrequency(13, dilated)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(3)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
        elseif (isAiming and state == 8) then
            freq = GetFrequency(20, dilated)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(3)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
        end
    elseif (name == 'w_handgun_constitutional_liberty') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(6)'
    elseif (name == 'w_handgun_budget_slaughtomatic') then
        freq = GetFrequency(7, dilated)
        data.rightTriggerType = 'AutomaticGun'
        data.rightForceTrigger = '(4)(8)('.. freq ..')'
    end

    return data
end

return Weapon
