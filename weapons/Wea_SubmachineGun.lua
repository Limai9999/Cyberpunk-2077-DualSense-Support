local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_SubmachineGun')

    local freq = 0

    if (isWeaponGlitched and triggerType ~= 'SemiAuto' and triggerType ~= 'Charge') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(6)'

        if (state == 8) then
            freq = GetFrequency(4, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
        end

        return data
    end

    data.leftTriggerType = 'Choppy'

    if (name == 'w_submachinegun_militech_saratoga') then
        -- * Modded Weapon: Game.AddToInventory("Items.SJ_DangerRoom")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isDangerRoom = FindInString(itemName, 'DangerRoom')

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(4)(4)'

        local isFenrir = FindInString(itemName, 'Maelstrom')

        if (state == 8) then
            if (isDangerRoom and dilated) then attackSpeed = attackSpeed + 1 end

            freq = GetFrequency(attackSpeed, dilated, name, true)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(2)(9)(4)(5)('.. freq ..')(0)'

            if (isDangerRoom) then
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(5)(9)(1)(1)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(2)(9)(5)(6)('.. freq ..')(0)'
            end

            if (not isFenrir and not HasSentQuickHackUsingWeapon) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (isFenrir and HasSentQuickHackUsingWeapon) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'HasSentQuickHackUsingWeapon', 8, dilated, false)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(2)(9)(7)(7)('.. freq * 2 ..')(0)'

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(2)(8)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end

        if (isAiming) then
            if (state == 8) then
                local freqHalf = math.floor(freq / 2)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(4)(9)(1)(2)('.. freqHalf ..')(0)'
            end
        end
    elseif (name == 'w_submachinegun_arasaka_shingen') then
        -- * Modded Weapon: Game.AddToInventory("Items.SJ_Tzijimura")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isTzijimura = FindInString(itemName, 'Tzijimura')

        if (isTzijimura) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(4)'

            local canUseFireTrigger = true
            local initialFrequency = 10

            local usedFireTriggerTimesStart = CalcTimeIndex(21, false, dilated)
            local usedFireTriggerTimesEnd = CalcTimeIndex(33, false, dilated)

            if (afterShootTimes >= usedFireTriggerTimesStart and afterShootTimes <= usedFireTriggerTimesEnd) then
                canUseFireTrigger = false
            end

            if (afterShootTimes > usedFireTriggerTimesEnd) then
                afterShootTimes = 0
            end

            if (state == 8) then
                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end

            if (state == 8 and canUseFireTrigger) then
                if (dilated) then
                    freq = GetFrequency(initialFrequency + 6, dilated, name)
                else
                    freq = GetFrequency(initialFrequency, dilated, name)
                end

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
            end
        else
            data.rightTriggerType = 'SemiAutomaticGun'
            data.rightForceTrigger = '(2)(4)(6)'

            if (state ~= 8) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 8) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 18, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(attackSpeed * 1.6, dilated, name)

                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(5)(9)(1)(1)('.. freq ..')(0)'

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    elseif (name == 'w_submachinegun_arasaka_senkoh') then
        data.rightTriggerType = 'SemiAutomaticGun'
        data.rightForceTrigger = '(2)(4)(4)'

        local isRaiju = FindInString(itemName, 'prototype')

        if (triggerType == 'Burst') then
            if (state == 8) then
                if (isRaiju) then
                    freq = GetFrequency(attackSpeed * 1.8, dilated, name)
                else
                    freq = GetFrequency(attackSpeed * 1.3, dilated, name)
                end

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(3)(6)('.. freq ..')(0)'
            end
        elseif (triggerType == 'Charge') then
            if (state == 1) then
                freq = GetChargeTrigger(name, dilated, false, 0.5, 6, 23)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(2)(3)('.. freq ..')(0)'
            else
                GetChargeTrigger(name, dilated, true)
            end

            local initialFrequency = attackSpeed
            local canUseFireTrigger = true

            local usedFireTriggerTimesStart = CalcTimeIndex(30)
            local usedFireTriggerTimesEnd = CalcTimeIndex(34)

            if (afterShootTimes >= usedFireTriggerTimesStart and afterShootTimes <= usedFireTriggerTimesEnd) then
                canUseFireTrigger = false
            end

            if (afterShootTimes > usedFireTriggerTimesEnd) then
                afterShootTimes = 0
            end

            if (state == 8) then
                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end

            if (state == 8 and canUseFireTrigger) then
                freq = GetFrequency(initialFrequency, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(1)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(4)(6)('.. freq ..')(0)'
            end
        end
    elseif (name == 'w_special_kangtao_dian') then
        freq = GetFrequency(attackSpeed - 1, dilated, name, true)
        data.rightTriggerType = 'SemiAutomaticGun'
        data.rightForceTrigger = '(2)(4)(4)'

        if (state == 8) then
            local freqHalf = math.floor(freq / 2)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(5)(9)(1)(1)('.. freqHalf ..')(0)'

            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(6)('.. freq ..')'
        end
    elseif (name == 'w_submachinegun_darra_pulsar') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(4)(4)'

        if (state == 8) then
            freq = GetFrequency(attackSpeed, dilated, name, true)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(3)(9)(1)(1)('.. freq ..')(0)'

            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(6)('.. freq ..')'
        end
    elseif (name == 'w_submachinegun_krausser_warden') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(4)(4)'

        local isPizdets = FindInString(itemName, 'Boris')

        if (triggerType == 'FullAuto') then
            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(6)(6)('.. freq ..')(0)'
            end
        end

        if (isPizdets) then
            if (triggerType == 'Burst') then
                if (state ~= 8) then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (state == 8) then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 25, dilated, false)

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        freq = GetFrequency(attackSpeed * 4, dilated, name)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            end
        end
    elseif (name == 'w_smg_midnight_borg') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(6)'

        if (state == 8) then
            freq = GetFrequency(attackSpeed, dilated, name)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(5)(9)(1)(1)('.. freq ..')(0)'

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
        end
    else
        freq = GetFrequency(15, dilated, name)
        data.rightTriggerType = 'AutomaticGun'
        data.rightForceTrigger = '(4)(8)('.. freq ..')'
    end

    return data
end

return Weapon
