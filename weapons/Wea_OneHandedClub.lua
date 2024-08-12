local flipTriggerActive = false
local savedFlipTriggerTimes = 0

local timesAfterThrow = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_OneHandedClub')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(1)(4)(2)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(1)(8)(5)'

    local stamina = GetState('Stamina')

    if (stamina == 2) then
        data.leftForceTrigger = '(1)(4)(8)(8)'
        data.rightForceTrigger = '(0)(1)(8)(8)'
    end

    if (isAiming) then
        data.rightTriggerType = 'Hard'
        if (stamina == 2) then data.rightTriggerType = 'Hardest' end
    end

    local state = GetState('MeleeWeapon')

    local freq = 0

    if (name == 'w_melee_baton') then
        if (state == 6 or state == 7) then
            if (isAiming) then
                freq = GetFrequency(7, dilated, name)
            else
                freq = GetFrequency(10, dilated, name)
            end

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
        end

        if (isAiming) then
            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(8)(5)'
            if (stamina == 2) then data.rightForceTrigger = '(0)(2)(8)(8)' end
        end
    elseif (name == 'w_melee_one_hand_blunt') then
        -- * Modded Weapon: Game.AddToInventory("Items.Kyubi_FullAuto")	https://www.nexusmods.com/cyberpunk2077/mods/13853
        local isMjolnir = FindInString(itemName, 'Gleipnir') or FindInString(itemName, 'Mjolnir')

        if (isMjolnir) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(4)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(6)(6)'

            if (state ~= 9) then
                flipTriggerActive = false
                savedFlipTriggerTimes = 0
            end

            if (state ~= 9 and state ~= 19) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 7 or state == 13) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(2)(7)(2)(6)'
            end

            if (state == 9) then
                local maxFlipTriggerTimes = CalcFixedTimeIndex(name..'9', 30, dilated, false)

                if (not flipTriggerActive) then flipTriggerActive = true end

                if (flipTriggerActive and savedFlipTriggerTimes <= maxFlipTriggerTimes) then
                    if (savedFlipTriggerTimes >= maxFlipTriggerTimes / 2) then
                        data.leftTriggerType = 'Normal'
                    else
                        data.leftTriggerType = 'Resistance'
                        data.leftForceTrigger = '(0)(6)'
                    end

                    savedFlipTriggerTimes = savedFlipTriggerTimes + 1
                else
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(0)(3)'
                end
            end

            if (state == 11) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(0)(3)'
            end

            if (state == 12) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(4)(8)(6)'
            end

            if (state == 19) then
                local throwTriggerActiveForTimes = CalcFixedTimeIndex(name..'19', 40, dilated, false)

                if (timesAfterThrow < throwTriggerActiveForTimes) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(2)(8)'
                else
                    data.leftTriggerType = 'Normal'
                    data.rightTriggerType = 'Normal'
                end

                timesAfterThrow = timesAfterThrow + 1
            else
                timesAfterThrow = 0
            end
        else
            local isDildo = FindInString(itemName, 'dildo') or itemName == 'Items.VHard_50_RefTech_Weapon15'
            local isTinkerBell = FindInString(itemName, 'Tinker_Bell') or itemName == 'Items.sq021_peter_pan_baton'

            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(1)(4)(2)(2)'
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(1)(6)(5)'

            if (state == 6 or state == 7) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(6)(3)(5)'
            elseif (state == 8) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(2)(3)(4)'
            elseif (state == 13) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(6)(3)(5)'
            elseif (state == 14) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(4)(3)(6)'
            elseif (state == 18) then
                data.leftTriggerType = 'Choppy'
                data.rightTriggerType = 'Normal'
            end

            if (isDildo) then
                if (state == 8 or state == 10 or state == 7 or state == 15 or state == 11) then
                    if (state == 7) then
                        freq = GetChargeTrigger(name..'7', dilated, false, 0.6, 5, 30)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    elseif (state == 15 or state == 11) then
                        freq = GetChargeTrigger(name..'1511', dilated, false, -1.2, 40, 40)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                    elseif (state == 8 or state == 10) then
                        freq = GetChargeTrigger(name..'810', dilated, false, 0.1, 2, 10)

                        data.leftTriggerType = 'Machine'
                        data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    end
                else
                    GetChargeTrigger(name, dilated, true)
                end
            end

            if (isTinkerBell) then
                if (state == 7) then
                    if (state == 7) then
                        freq = GetChargeTrigger(name..'7', dilated, false, 0.6, 5, 20)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    end
                else
                    GetChargeTrigger(name, dilated, true)
                end

                if (state == 13) then
                    data.rightTriggerType = 'Bow'
                    data.rightForceTrigger = '(0)(3)(3)(7)'
                end
            end
        end
    end

    if (state == 20) then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(6)'
    end

    return data
end

return Weapon
