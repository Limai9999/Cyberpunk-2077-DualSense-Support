local afterShootTimes = 0
local isPerfectChargedTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName, isSecondaryMode)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_LightMachineGun')

    local freq = 0

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'AutomaticGun'
    data.rightForceTrigger = '(4)(8)(8)'

    if (name == 'w_lmg_constitutional_defender') then
        local isWildDog = FindInString(itemName, 'Kurt')

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(7)(7)'

        if (isWildDog) then
            data.rightForceTrigger = '(0)(4)(8)(8)'
        end

        if (state ~= 8) then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end

        if (state == 8) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 15, dilated, false)

            if (afterShootTimes > shootTriggerActiveForTimes) then
                freq = GetFrequency(attackSpeed, dilated, name, true)

                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(4)(8)('.. freq ..')'

                if (isAiming) then
                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(4)(9)(3)(4)('.. freq ..')(0)'

                    data.rightTriggerType = 'AutomaticGun'
                    data.rightForceTrigger = '(4)(7)('.. freq ..')'

                    if (isWildDog) then data.rightForceTrigger = '(4)(8)('.. freq ..')' end
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    elseif (name == 'w_rifle_sniper_tsunami_nekomata') then
        -- * Modded Weapon: Game.AddToInventory("Items.SJ_Thunderstrike")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isThunderstrike = FindInString(itemName, 'Thunderstrike')

        if (isThunderstrike) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(8)(8)'

            if (state ~= 8 and state ~= 4 and not isPerfectCharged) then
                CalcFixedTimeIndex(name, 0, dilated, true)
            end

            if (state == 1) then
                freq = GetChargeTrigger(name, dilated, false, 2, 10, 35)

                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'

                if (isSecondaryMode) then
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(3)(9)(4)(4)('.. freq ..')(0)'
                end

                if (isPerfectCharged) then
                    local perfectChargeTriggerActiveForTimes = CalcFixedTimeIndex(name..'perfect_charge', GetPerfectChargeDuration(), dilated, false)

                    if (isPerfectChargedTimes < perfectChargeTriggerActiveForTimes) then
                        data.rightTriggerType = 'Machine'
                        data.rightForceTrigger = '(3)(9)(6)(6)('.. freq * 2 ..')(0)'

                        isPerfectChargedTimes = isPerfectChargedTimes + 1
                    end
                end
            else
                GetChargeTrigger(name, dilated, true)
            end

            if (state == 8 or state == 4) then
                local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'84', 20, false, false)

                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(6)'

                data.rightTriggerType = 'Normal'

                if (afterShootTimes < shootTriggerActiveForTimes) then
                    data.rightTriggerType = 'Resistance'
                    data.rightForceTrigger = '(4)(8)'
                end

                afterShootTimes = afterShootTimes + 1
            else
                afterShootTimes = 0
            end
        end
    end

    return data
end

return Weapon
