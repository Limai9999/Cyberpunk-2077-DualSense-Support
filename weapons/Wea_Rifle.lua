local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName, isSecondaryMode)
    data.type = GetText('Story-base-journal-quests-main_quest-prologue-q000_tutorial-01a_pick_weapon_Rifle_mappin')

    local freq = 0

    if (isWeaponGlitched and triggerType ~= 'SemiAuto' and triggerType ~= 'Charge') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(6)(6)'

        if (state == 8) then
            freq = GetFrequency(3, dilated, name)
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
        end

        return data
    end

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(3)(1)(2)'
    data.rightTriggerType = 'Machine'

    if (name == 'w_rifle_assault_militech_ajax') then
        -- * Modded Weapon: Game.AddToInventory("Items.Kyubi_FullAuto")	https://www.nexusmods.com/cyberpunk2077/mods/13853
        local isFullAutoKyubi = FindInString(itemName, 'Kyubi_FullAuto')

        -- * Modded Weapon: Game.AddToInventory("Items.sp0rifle0101", 1) https://www.nexusmods.com/cyberpunk2077/mods/11369
        local isSp0AssaultRifle1 = FindInString(itemName, 'sp0rifle01')
        local isSp0AssaultRifle2 = FindInString(itemName, 'sp0rifle02')

        if (isFullAutoKyubi) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(8)(8)'

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(3)(9)(7)(7)('.. freq ..')(0)'
            end
        elseif (isSp0AssaultRifle1) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(2)(5)(2)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(4)(4)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(2)(2)'
            end

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
            end
        elseif (isSp0AssaultRifle2) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(2)(7)(2)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(5)(4)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(2)(3)'
            end

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            end
        else
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(6)'

            if (triggerType == 'FullAuto') then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(4)(2)'

                if (state == 8) then
                    freq = GetFrequency(attackSpeed, dilated, name, true)
                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(3)(9)(7)(7)('.. freq ..')(0)'
                end
            elseif (triggerType == 'SemiAuto') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(3)(8)(8)'

                if (state == 8) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(3)(3)'
                end

                if (isAiming) then
                    data.leftTriggerType = 'Normal'

                    if (state == 8) then
                        data.leftTriggerType = 'Resistance'
                        data.leftForceTrigger = '(3)(3)'
                    end
                else
                    if (state ~= 8) then
                        CalcFixedTimeIndex(name, 0, dilated, true)
                    end

                    if (state == 8) then
                        local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 13, dilated, false)

                        if (afterShootTimes < shootTriggerActiveForTimes) then
                            data.rightTriggerType = 'Resistance'
                            data.rightForceTrigger = '(2)(4)'
                        end

                        afterShootTimes = afterShootTimes + 1
                    else
                        afterShootTimes = 0
                    end
                end
            end
        end
    elseif (name == 'w_rifle_assault_arasaka_masamune') then
        -- * Modded Weapon: Game.AddToInventory("Items.aa_masamune_03",1)	https://www.nexusmods.com/cyberpunk2077/mods/2335?tab=description
        local isCertainty = FindInString(itemName, 'aa_masamune_03')

        -- * Modded Weapon: Game.AddToInventory("Items.SJ_Mercy")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isMercy = FindInString(itemName, 'Mercy')

        if (isCertainty) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(5)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(5)(3)'
            end

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(5)(6)('.. freq ..')(0)'
            end
        elseif (isMercy) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(5)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(5)(3)'
            end

            if (isSecondaryMode) then
                if (state ~= 8) then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (state == 8) then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 25, dilated, false)
    
                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        freq = GetFrequency(attackSpeed * 2.5, dilated, name)
    
                        data.leftTriggerType = 'Machine'
                        data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(6)(6)('.. freq ..')(0)'
                    end
    
                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            else
                if (state ~= 8) then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (state == 8) then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 10, dilated, false)

                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(4)'

                    if (afterShootTimes > shootTriggerActiveForTimes) then
                        data.rightTriggerType = 'Resistance'
                        data.rightForceTrigger = '(0)(6)'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            end
        else
            -- Original

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(5)(5)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(5)(3)'
            end

            if (state ~= 8) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 8) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 25, dilated, false)

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    freq = GetFrequency(attackSpeed * 2.5, dilated, name)

                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    elseif (name == 'w_rifle_assault_nokota_sidewinder') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(5)(4)(6)'

        if (state == 8) then
            freq = GetFrequency(attackSpeed, dilated, name, true)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(5)(9)(6)(6)('.. freq ..')(0)'
        end
    elseif (name == 'w_rifle_assault_nokota_copperhead') then
        -- * Modded Weapon: Game.AddToInventory("Items.Scar_Night_City_Special",1)	https://www.nexusmods.com/cyberpunk2077/mods/15016?tab=description
        local isScar = FindInString(itemName, 'Scar')

        if (isScar) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(3)(2)(2)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(6)(2)'

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(3)(1)'
            end

            if (triggerType == 'Charge') then
                if (state == 1) then
                    freq = GetChargeTrigger(name, dilated, false, 0.4, 2, 15)

                    data.rightTriggerType = 'Galloping'
                    data.rightForceTrigger = '(3)(9)(1)(2)('.. freq ..')'
                else
                    GetChargeTrigger(name, dilated, true)
                end

                if (state ~= 8) then
                    CalcFixedTimeIndex(name, 0, dilated, true)
                end

                if (state == 8) then
                    local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 10, dilated, false)

                    if (afterShootTimes < shootTriggerActiveForTimes) then
                        data.leftTriggerType = 'Resistance'
                        data.leftForceTrigger = '(3)(5)'

                        data.rightTriggerType = 'Resistance'
                        data.rightForceTrigger = '(3)(8)'
                    end

                    afterShootTimes = afterShootTimes + 1
                else
                    afterShootTimes = 0
                end
            end

            if (triggerType == 'FullAuto') then
                if (state == 8) then
                    freq = GetFrequency(attackSpeed, dilated, name, true)

                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
                end
            end
        else
            -- Orignal

            local isPsalm = FindInString(itemName, 'genesis')
            local isUmbra = FindInString(itemName, 'umbra')
            local isCarmenUmbra = isUmbra and FindInString(itemName, 'bebe')

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(4)(5)'
            if (isUmbra) then data.rightForceTrigger = '(1)(3)(4)(5)' end
            if (isCarmenUmbra) then data.rightForceTrigger = '(1)(3)(3)(4)' end

            if (isAiming) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(3)(2)'

                if (isCarmenUmbra) then data.leftForceTrigger = '(4)(1)' end
            end

            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'

                if (isPsalm) then
                    data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                    data.rightForceTrigger = '(4)(9)(6)(7)('.. freq ..')(0)'
                end
                if (isUmbra) then data.rightForceTrigger = '(4)(9)(4)(5)('.. freq ..')(0)' end
                if (isCarmenUmbra) then
                    data.leftForceTrigger = '(1)(9)(1)(1)('.. freq ..')(0)'
                    data.rightForceTrigger = '(4)(9)(4)(4)('.. freq ..')(0)'
                end
            end
        end
    elseif (name == 'w_special__militech_hercules') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(6)(5)'

        if (isAiming) then
            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            end
        else
            if (state == 8) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
            end
        end
    else
        freq = GetFrequency(11, dilated, name)

        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(4)(9)(6)(6)('.. freq ..')(0)'
    end

    return data
end

return Weapon