local chaoUsedFireTriggerTimes = 0

local afterShootTimes = 0
local afterShootTimes2 = 0
local isPerfectChargedTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName, isSecondaryMode)
    data.type = GetText('Gameplay-RPG-Skills-GunslingerName')

    local freq = 0

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(4)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(2)(4)(6)(4)'

    if (not isPerfectCharged) then
        isPerfectChargedTimes = 0
    end

    if (name == 'w_handgun_constitutional_unity') then
        -- * Modded Weapon: Game.AddToInventory("Items.Hand_Of_Midas")	https://www.nexusmods.com/cyberpunk2077/mods/11800
        local isHandOfMidas = FindInString(itemName, 'Hand_Of_Midas')

        if (isHandOfMidas) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(6)(3)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(5)(6)'

            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 16, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(2)'

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(1)(4)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        else
            -- Original

            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(4)(3)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(3)(6)'

            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 16, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(1)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    elseif (name == 'w_handgun_tsunami_nue') then
        -- * Modded Weapon: Game.AddToInventory("Items.Desert_Eagle",1)	https://www.nexusmods.com/cyberpunk2077/mods/14904
        local isDesertEagle = FindInString(itemName, 'Desert_Eagle')

        -- * Modded Weapon: Game.AddToInventory("Items.SJ_DesertSnake")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isDesertSnake = FindInString(itemName, 'DesertSnake')

        if (isDesertEagle) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(5)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(5)(4)'

            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 15, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(4)'

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(1)(6)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        else
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(4)(1)'
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(2)(4)(6)(4)'

            local isRiskit = FindInString(itemName, 'Bree')
            local isDeathAndTaxes = FindInString(itemName, 'Maiko')

            if (isRiskit) then
                local playerId = GetPlayer():GetEntityID()
                local fullHealthValue = Game.GetStatsSystem():GetStatValue(playerId, 'Health')
                local healthValue = Game.GetStatPoolsSystem():GetStatPoolValue(playerId, Enum.new('gamedataStatPoolType', 'Health'), false);
                local healthPercentage = healthValue / fullHealthValue

                -- https://cyberpunk.fandom.com/wiki/Riskit
                if (healthPercentage < 0.40) then
                    data.leftTriggerType = 'Bow'
                    data.leftForceTrigger = '(0)(1)(2)(1)'
                    data.rightTriggerType = 'Bow'
                    data.rightForceTrigger = '(1)(4)(3)(2)'

                    if (state == 'Shoot') then
                        data.leftTriggerType = 'Normal'
                        data.rightTriggerType = 'Bow'
                        data.rightForceTrigger = '(1)(5)(4)(3)'
                    end
                end
            elseif (isDeathAndTaxes) then
                if (state ~= 'Shoot') then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (state == 'Shoot') then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84burst', 20, dilated, false)

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        if (dilated) then
                            freq = GetFrequency(9, dilated, name)
                        else
                            freq = GetFrequency(7, dilated, name)
                        end

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(6)(6)('.. freq ..')(0)'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            else
                if (state ~= 'Shoot' or state ~= 'NoAmmo') then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (state == 'Shoot' or state == 'NoAmmo') then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 20, dilated, false)

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        if (isAiming) then
                            data.leftTriggerType = 'Resistance'
                            data.leftForceTrigger = '(1)(2)'

                            if (isDesertSnake and isSecondaryMode) then
                                freq = GetFrequency(30, dilated, name)

                                data.leftTriggerType = 'Machine'
                                data.leftForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                            end
                        else
                            data.rightTriggerType = 'Resistance'
                            data.rightForceTrigger = '(1)(3)'

                            if (isDesertSnake and isSecondaryMode) then
                                freq = GetFrequency(40, dilated, name)

                                data.rightTriggerType = 'Machine'
                                data.rightForceTrigger = '(1)(9)(3)(3)('.. freq ..')(0)'
                            end
                        end
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            end
        end
    elseif (name == 'w_handgun_militech_lexington') then
        -- * Modded Weapon: Game.AddToInventory("Items.SJ_Dice")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isDice = FindInString(itemName, 'Dice')

        local isARRaygun = FindInString(itemName, 'Toygun')

        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(4)(1)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(6)(4)'

        if (isDice) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(5)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(5)(4)'
        end

        if (isARRaygun) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(2)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(3)(2)'
        end

        if (triggerType == 'Charge') then
            if (state == 'Charging') then
                freq = GetChargeTrigger(name, dilated, false, 0.4, 2, 15)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(1)'

                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(1)(4)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end

        if (triggerType == 'FullAuto') then
            if (state == 'Shoot') then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(5)(9)(1)(1)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(3)(4)('.. freq ..')(0)'

                if (isDice) then
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(4)(9)(4)(5)('.. freq ..')(0)'
                end

                if (isARRaygun) then
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(4)(9)(2)(3)('.. freq ..')(0)'
                end
            end
        end
    elseif (name == 'w_handgun_arasaka_yukimura') then
        local isCrimestopper = FindInString(itemName, 'George')

        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(7)(1)'
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(2)(4)(1)(3)'

            if (state == 'Shoot') then
                if (triggerType == 'Burst') then
                    freq = GetFrequency(attackSpeed - 1, dilated, name)
                else
                    freq = GetFrequency(attackSpeed, dilated, name, true)
                end

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(4)(9)(1)(1)('.. freq ..')(0)'

                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(3)(5)('.. freq ..')'

                if (not isCrimestopper and not HasSentQuickHackUsingWeapon) then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (isCrimestopper and HasSentQuickHackUsingWeapon) then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'HasSentQuickHackUsingWeapon', 8, dilated, false)

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(2)(9)(6)(6)('.. freq * 2 ..')(0)'

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        data.rightTriggerType = 'Resistance'
                        data.rightForceTrigger = '(2)(6)'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            end
        else
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(1)(4)(7)(5)'

            if (state == 'Shoot') then
                freq = GetFrequency(attackSpeed, dilated, name)
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(5)(6)('.. freq ..')'
            end
        end
    elseif (name == 'w_handgun_kangtao_chao') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(3)(4)'

        local canUseShootTrigger = true
        local initialFrequency = 0

        local isVooDoo = FindInString(itemName, 'VooDoo')

        if (isVooDoo) then
            initialFrequency = 4

            local chaoUsedFireTriggerTimesStart = CalcTimeIndex(30)
            local chaoUsedFireTriggerTimesEnd = CalcTimeIndex(55)

            if (chaoUsedFireTriggerTimes >= chaoUsedFireTriggerTimesStart and chaoUsedFireTriggerTimes <= chaoUsedFireTriggerTimesEnd) then
                canUseShootTrigger = false
            end

            if (chaoUsedFireTriggerTimes > chaoUsedFireTriggerTimesEnd) then
                chaoUsedFireTriggerTimes = 0
            end
        else
            initialFrequency = 7

            local chaoUsedFireTriggerTimesStart = CalcTimeIndex(40)
            local chaoUsedFireTriggerTimesEnd = CalcTimeIndex(70)

            if (chaoUsedFireTriggerTimes >= chaoUsedFireTriggerTimesStart and chaoUsedFireTriggerTimes <= chaoUsedFireTriggerTimesEnd) then
                canUseShootTrigger = false
            end

            if (chaoUsedFireTriggerTimes > chaoUsedFireTriggerTimesEnd) then
                chaoUsedFireTriggerTimes = 0
            end
        end

        if (state == 'Shoot') then
            chaoUsedFireTriggerTimes = chaoUsedFireTriggerTimes + 1
        else
            chaoUsedFireTriggerTimes = 0
        end

        if (state == 'Shoot' and canUseShootTrigger) then
            if (dilated) then
                freq = GetFrequency(initialFrequency + 2, dilated, name)
            else
                freq = GetFrequency(initialFrequency, dilated, name)
            end

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
        end
    elseif (name == 'w_handgun_malorian_silverhand') then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(3)(5)(5)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(8)'

        if (state == 'Charging') then
            freq = GetChargeTrigger(name, dilated, false, 0.4, 2, 15)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 'Shoot') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(5)'

            data.rightForceTrigger = '(0)(5)(6)(8)'
        end
    elseif (name == 'w_handgun_arasaka_kenshin') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(4)(8)'

        -- https://cyberpunk.fandom.com/wiki/Apparition
        local isApparition = FindInString(itemName, 'Frank')
        local isAmbition = FindInString(itemName, 'Spy')

        local playerId = GetPlayer():GetEntityID()
        local fullHealthValue = Game.GetStatsSystem():GetStatValue(playerId, 'Health')
        local healthValue = Game.GetStatPoolsSystem():GetStatPoolValue(playerId, Enum.new('gamedataStatPoolType', 'Health'), false);
        local healthPercentage = healthValue / fullHealthValue
        local isLowHealth = healthPercentage < 0.25

        if (not isPerfectCharged and state ~= 'Shoot' and state ~= 'NoAmmo' and not isAmbition and not HasSentQuickHackUsingWeapon) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Charging') then
            data.rightTriggerType = 'Galloping'

            if (dilated) then
                freq = GetChargeTrigger(name, dilated, false, 0.2, 1, 10)
                data.rightForceTrigger = '(3)(9)(2)(5)('.. freq ..')'
            else
                freq = GetChargeTrigger(name, dilated, false, 0.3, 1, 12)
                data.rightForceTrigger = '(3)(9)(3)(4)('.. freq ..')'
            end

            if (isPerfectCharged) then
                local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(), dilated, false)

                if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                    data.rightTriggerType = 'Normal'

                    isPerfectChargedTimes = isPerfectChargedTimes + 1
                end
            end
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 'Shoot' or state == 'NoAmmo') then
            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(4)(1)'
            end

            if (triggerType == 'Charge') then
                local initialTimeIndex = 40
                if (isApparition and isLowHealth) then initialTimeIndex = initialTimeIndex / 1.4 end

                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84charge', initialTimeIndex, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    if (isApparition and isLowHealth) then
                        freq = GetFrequency(8 * 1.4, dilated, name)
                    else
                        freq = GetFrequency(8, dilated, name)
                    end
                    data.leftTriggerType = 'AutomaticGun'
                    data.leftForceTrigger = '(4)(1)('.. freq ..')'

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
                end

                afterShootTimes = afterShootTimes + 1
            end

            if (triggerType == 'Burst') then
                local initialTimeIndex = 20
                if (isApparition and isLowHealth) then initialTimeIndex = initialTimeIndex / 1.4 end

                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84burst', initialTimeIndex, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    if (isApparition and isLowHealth) then
                        if (dilated) then
                            freq = GetFrequency(9 * 1.4, dilated, name)
                        else
                            freq = GetFrequency(7 * 1.4, dilated, name)
                        end
                    else
                        if (dilated) then
                            freq = GetFrequency(9, dilated, name)
                        else
                            freq = GetFrequency(7, dilated, name)
                        end
                    end

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                end

                afterShootTimes = afterShootTimes + 1

                data.canUseWeaponReloadEffect = false
                data.canUseNoAmmoWeaponEffect = false
            end
        else
            afterShootTimes = 0
        end

        if (isAmbition and HasSentQuickHackUsingWeapon) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'HasSentQuickHackUsingWeapon', 4, dilated, false)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(2)(9)(5)(5)('.. freq * 3 ..')(0)'

            if (afterShootTimes2 < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Normal'
            end

            afterShootTimes2 = afterShootTimes2 + 1
        else
            afterShootTimes2 = 0
        end
    elseif (name == 'w_handgun_militech_omaha') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(7)(5)'
        if (state == 'Charging') then
            freq = GetChargeTrigger(name, dilated, false, 0.1, 4, 20)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(3)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
        else
            GetChargeTrigger(name, dilated, true)
        end

        if (state == 'Shoot') then
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
        local isKongou = FindInString(itemName, 'Yorinobu')

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(4)(6)'

        if (isKongou) then data.rightForceTrigger = '(2)(4)(4)(4)' end

        if (state ~= 'Shoot') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 'Shoot') then
            if (isKongou) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 12, false, false)

                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(2)(5)(4)(3)'

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(7)(1)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(5)(1)'
                data.rightForceTrigger = '(2)(5)(6)(6)'
            end
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_handgun_budget_slaughtomatic') then
        freq = GetFrequency(7, dilated, name, true)

        data.rightTriggerType = 'AutomaticGun'
        data.rightForceTrigger = '(4)(5)('.. freq ..')'
    elseif (name == 'w_handgun_krauser_grit') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(6)(5)'

        if (triggerType == 'SemiAuto') then
            if (state == 'Shoot') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(4)(8)(2)(4)'
            end
        end

        if (triggerType == 'Charge' or triggerType == 'FullAuto') then
            if (state == 'Charging') then
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

            if (state == 'Shoot') then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(3)(9)(5)(5)('.. freq ..')(1)'
            end
        end
    elseif (name == 'w_handgun_militech_ticon') then
        if (triggerType == 'Burst') then
            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 35, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(9, dilated, name)

                    data.rightTriggerType = 'AutomaticGun'
                    data.rightForceTrigger = '(3)(5)('.. freq ..')'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        elseif (triggerType == 'Charge') then
            if (state ~= 'Shoot') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'Charging') then
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

            if (state == 'Shoot') then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(3)(1)'

                freq = GetFrequency(2, dilated, name)
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(3)(8)('.. freq ..')'
            end

            if (state == 'Shoot') then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 20, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(3)(1)'

                    data.rightTriggerType = 'Normal'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    end

    if (isWeaponGlitched and triggerType ~= 'SemiAuto') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(4)(6)(6)'

        if (state == 'Shoot') then
            freq = GetFrequency(3, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
        end

        return data
    end

    return data
end

return Weapon
