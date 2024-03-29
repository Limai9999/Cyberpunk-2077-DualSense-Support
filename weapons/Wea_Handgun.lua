local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-RPG-Skills-GunslingerName')

    local freq = 0

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(6)(4)'

    if (name == 'w_handgun_constitutional_unity') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(2)(3)(3)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(3)(6)'

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(7)(2)(6)'
        end
    elseif (name == 'w_handgun_tsunami_nue') then
        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(6)(6)(5)'
        end
    elseif (name == 'w_handgun_militech_lexington') then
        if (state == 8) then
            -- if (dilated) then
            --     freq = GetFrequency(11, dilated, name)
            -- else
            --     freq = GetFrequency(10, dilated, name)
            -- end

            freq = GetFrequency(attackSpeed, dilated, name)

            local freqHalf = math.floor(freq / 2)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(5)(9)(1)(1)('.. freqHalf ..')(0)'

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
        end
    elseif (name == 'w_handgun_arasaka_yukimura') then
        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(7)(1)'
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(2)(4)(3)(4)'

            if (state == 8) then
                if (triggerType == 'Burst') then
                    if (dilated) then
                        freq = GetFrequency(attackSpeed - 1, dilated, name)
                    else
                        freq = GetFrequency(attackSpeed, dilated, name)
                    end
                else
                    freq = GetFrequency(attackSpeed, dilated, name)
                end

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(4)(9)(1)(1)('.. freq ..')(0)'
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(5)(6)('.. freq ..')'
            end
        else
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(7)(5)'

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name)
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(5)(6)('.. freq ..')'
            end
        end
    elseif (name == 'w_handgun_kangtao_chao') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(3)(4)'
        if (state == 8) then
            if (dilated) then
                freq = GetFrequency(5, dilated, name)
            else
                freq = GetFrequency(7, dilated, name)
            end
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(3)(5)('.. freq ..')'
        end
    elseif (name == 'w_handgun_malorian_silverhand') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(3)(5)(5)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(8)'

        if (state == 1) then
            freq = GetChargeTrigger(name, dilated, false, 0.4, 2, 15)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(5)'

            data.rightForceTrigger = '(0)(5)(6)(8)'
        end
    elseif (name == 'w_handgun_arasaka_kenshin') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(4)(8)'
        if (state == 1) then
            data.rightTriggerType = 'Galloping'

            if (dilated) then
                freq = GetChargeTrigger(name, dilated, false, 0.2, 1, 10)
                data.rightForceTrigger = '(3)(9)(2)(5)('.. freq ..')'
            else
                freq = GetChargeTrigger(name, dilated, false, 0.3, 1, 12)
                data.rightForceTrigger = '(3)(9)(3)(4)('.. freq ..')'
            end
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 8 or state == 4) then
            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(4)(1)'
            end

            if (triggerType == 'Charge') then
                freq = GetFrequency(7, dilated, name)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(4)(9)(1)(1)('.. freq ..')(0)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
            end

            if (triggerType == 'Burst') then
                if (dilated) then
                    freq = GetFrequency(7, dilated, name)
                else
                    if (state == 8) then
                        freq = GetFrequency(4, dilated, name)
                    else
                        freq = GetFrequency(3, dilated, name)
                    end
                end
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'

                data.canUseWeaponReloadEffect = false
                data.canUseNoAmmoWeaponEffect = false
            end
        end
    elseif (name == 'w_handgun_militech_omaha') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(7)(5)'
        if (state == 1) then
            freq = GetChargeTrigger(name, dilated, false, 0.1, 4, 20)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(3)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 8) then
            if (triggerType == 'Charge') then
                freq = GetFrequency(20, dilated, name)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(3)(9)(1)(1)('.. freq ..')(0)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            else
                data.rightForceTrigger = '(1)(5)(7)(5)'
            end
        end
    elseif (name == 'w_handgun_constitutional_liberty') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(6)'

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(5)(1)'
            data.rightForceTrigger = '(1)(5)(6)(6)'
        end
    elseif (name == 'w_handgun_budget_slaughtomatic') then
        freq = GetFrequency(7, dilated, name)
        data.rightTriggerType = 'AutomaticGun'
        data.rightForceTrigger = '(4)(8)('.. freq ..')'
    elseif (name == 'w_handgun_krauser_grit') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(5)'

        if (triggerType == 'SemiAuto') then
            if (state == 8) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(1)(8)(2)(4)'
            end
        end

        if (triggerType == 'Charge' or triggerType == 'FullAuto') then
            if (state == 1) then
                data.rightTriggerType = 'Galloping'

                if (dilated) then
                    freq = GetChargeTrigger(name, dilated, false, 0.3, 2, 20)
                    data.rightForceTrigger = '(3)(9)(1)(3)('.. freq ..')'
                else
                    freq = GetChargeTrigger(name, dilated, false, 0.3, 2, 25)
                    data.rightForceTrigger = '(3)(9)(1)(4)('.. freq ..')'
                end
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 8) then
                freq = GetFrequency(6, dilated, name)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(3)(9)(5)(5)('.. freq ..')(1)'
            end
        end
    elseif (name == 'w_handgun_militech_ticon') then
        if (triggerType == 'Burst') then
            if (state == 8) then
                freq = GetFrequency(9, dilated, name)

                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(3)(5)('.. freq ..')'
            end
        elseif (triggerType == 'Charge') then
            if (state == 1) then
                data.rightTriggerType = 'Galloping'
            
                if (dilated) then
                    freq = GetChargeTrigger(name, dilated, false, 0.4, 2, 30)
                    data.rightForceTrigger = '(3)(9)(1)(3)('.. freq ..')'
                else
                    freq = GetChargeTrigger(name, dilated, false, 0.5, 2, 35)
                    data.rightForceTrigger = '(3)(9)(1)(4)('.. freq ..')'
                end
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 8) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(3)(1)'

                freq = GetFrequency(2, dilated, name)
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(3)(8)('.. freq ..')'
            end
        end
    end

    if (isWeaponGlitched and triggerType ~= 'SemiAuto' and triggerType ~= 'Charge') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(6)(6)'

        if (state == 8) then
            freq = GetFrequency(3, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
        end

        return data
    end

    return data
end

return Weapon
