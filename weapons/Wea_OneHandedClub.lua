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

    if (stamina == 'Exhausted') then
        data.leftForceTrigger = '(1)(4)(8)(8)'
        data.rightForceTrigger = '(0)(1)(8)(8)'
    end

    if (isAiming) then
        data.rightTriggerType = 'Hard'
        if (stamina == 'Exhausted') then data.rightTriggerType = 'Hardest' end
    end

    local state = GetState('MeleeWeapon')

    local freq = 0

    if (name == 'w_melee_baton') then
        if (state == 'Hold' or state == 'ChargedHold') then
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
            if (stamina == 'Exhausted') then data.rightForceTrigger = '(0)(2)(8)(8)' end
        end
    elseif (name == 'w_melee_one_hand_blunt') then
        -- * Modded Weapon: Game.AddToInventory("Items.Kyubi_FullAuto")	https://www.nexusmods.com/cyberpunk2077/mods/13853
        local isMjolnir = FindInString(itemName, 'Gleipnir') or FindInString(itemName, 'Mjolnir')

        if (isMjolnir) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(4)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(6)(6)'

            if (state ~= 'Targeting') then
                flipTriggerActive = false
                savedFlipTriggerTimes = 0
            end

            if (state ~= 'Targeting' and state ~= 'ThrowAttack') then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 'ChargedHold' or state == 'StrongAttack') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(2)(7)(2)(6)'
            end

            if (state == 'Targeting') then
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

            if (state == 'ComboAttack') then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(0)(3)'
            end

            if (state == 'FinalAttack') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(4)(8)(6)'
            end

            if (state == 'ThrowAttack') then
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

            if (state == 'Hold' or state == 'ChargedHold') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(6)(3)(5)'
            elseif (state == 'Block') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(2)(3)(4)'
            elseif (state == 'StrongAttack') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(6)(3)(5)'
            elseif (state == 'SafeAttack') then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(4)(3)(6)'
            elseif (state == 'JumpAttack') then
                data.leftTriggerType = 'Choppy'
                data.rightTriggerType = 'Normal'
            end

            if (isDildo) then
                if (state == 'Block' or state == 'Deflect' or state == 'ChargedHold' or state == 'BlockAttack' or state == 'ComboAttack') then
                    if (state == 'ChargedHold') then
                        freq = GetChargeTrigger(name..'7', dilated, false, 0.6, 5, 30)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    elseif (state == 'BlockAttack' or state == 'ComboAttack') then
                        freq = GetChargeTrigger(name..'1511', dilated, false, -1.2, 40, 40)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                    elseif (state == 'Block' or state == 'Deflect') then
                        freq = GetChargeTrigger(name..'810', dilated, false, 0.1, 2, 10)

                        data.leftTriggerType = 'Machine'
                        data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    end
                else
                    GetChargeTrigger(name, dilated, true)
                end
            end

            if (isTinkerBell) then
                if (state == 'ChargedHold') then
                    if (state == 'ChargedHold') then
                        freq = GetChargeTrigger(name..'7', dilated, false, 0.6, 5, 20)

                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                    end
                else
                    GetChargeTrigger(name, dilated, true)
                end

                if (state == 'StrongAttack') then
                    data.rightTriggerType = 'Bow'
                    data.rightForceTrigger = '(0)(3)(3)(7)'
                end
            end
        end
    end

    if (state == 'DeflectAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(6)'
    end

    return data
end

return Weapon
