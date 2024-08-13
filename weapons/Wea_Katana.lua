local afterShootTimes = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Katana')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    if (name == 'w_melee_katana') then
        -- * Modded Weapon: Game.AddToInventory("Items.MilitaryBlackwall")	https://www.nexusmods.com/cyberpunk2077/mods/10511
        local isMilitaryBlackwall = FindInString(itemName, 'MilitaryBlackwall')

        -- * Modded Weapon: Game.AddToInventory("Items.SJ_GhostBlade")	https://www.nexusmods.com/cyberpunk2077/mods/15889
        local isGhostBlade = FindInString(itemName, 'GhostBlade')

        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(3)(1)'

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(3)(1)'

        if (isGhostBlade) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(0)(1)(1)(1)'

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(1)(1)'
        end

        if (state ~= 'BlockAttack' and state ~= 'FinalAttack' and state ~= 'JumpAttack' and state ~= 'SprintAttack') then
            CalcFixedTimeIndex(name, 0, dilated, true)
            afterShootTimes = 0
        else
            afterShootTimes = afterShootTimes + 1
        end

        if (isAiming) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(2)(1)'

            if (isGhostBlade) then data.rightForceTrigger = '(0)(4)(1)(1)' end
        end

        if (state == 'ChargedHold' or state == 'StrongAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(6)(2)(6)'

            if (isGhostBlade) then data.rightForceTrigger = '(0)(6)(1)(4)' end
        end

        if (state == 'JumpAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'12', 30, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(2)(3)'

                if (isGhostBlade) then data.rightForceTrigger = '(2)(1)' end
            end

            afterShootTimes = afterShootTimes + 1
        end

        if (state == 'Deflect') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(0)(2)'

            if (isGhostBlade) then data.leftForceTrigger = '(0)(1)' end
        end

        if (state == 'ComboAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(2)(1)'

            if (isGhostBlade) then data.rightForceTrigger = '(0)(2)(3)(1)' end
        end

        if (state == 'FinalAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'12', 20, dilated, false)

            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(3)(4)'

            if (isGhostBlade) then data.rightForceTrigger = '(0)(2)(2)(3)' end

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(2)(3)'

                if (isGhostBlade) then data.rightForceTrigger = '(2)(1)' end
            end
        end

        if (state == 'BlockAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'15', 20, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(0)(3)'

                if (isGhostBlade) then data.leftTriggerType = 'Normal' end
            end

            afterShootTimes = afterShootTimes + 1
        end

        if (state == 'SprintAttack') then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'15', 20, dilated, false)

            if (afterShootTimes < shootTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(0)(3)'

                if (isGhostBlade) then data.leftForceTrigger = '(0)(1)' end
            end

            afterShootTimes = afterShootTimes + 1
        end

        if (state == 'DeflectAttack') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(6)'

            if (isGhostBlade) then data.leftForceTrigger = '(2)(2)' end
        end

        if (IsBlockedBullet) then
            data = UseBulletBlockTrigger(data, config)
        end

        if (IsPlayerHitEntity and isMilitaryBlackwall) then
            data.canUseDefaultEntityHitTrigger = false

            local freq = GetChargeTrigger(name, false, false, 0.3, 7, 20)

            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(1)(9)(3)(4)('.. freq ..')'

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(1)(9)(3)(4)('.. freq ..')'

            if (IsPlayerHitEntityStrong) then
                data.leftTriggerType = 'Galloping'
                data.leftForceTrigger = '(1)(9)(5)(6)('.. freq ..')'

                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(1)(9)(5)(6)('.. freq ..')'
            end
        end
    end

    return data
end

return Weapon
