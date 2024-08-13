local flipTriggerActive = false
local savedFlipTriggerTimes = 0

local timesAfterThrow = 0

local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-Items-Item Type-Wea_Axe')

    local stamina = GetState('Stamina', 'gamePSMStamina')
    local state = GetState('MeleeWeapon', 'gamePSMMeleeWeapon')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(0)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(4)(4)'

    if (state ~= 'Targeting') then
        flipTriggerActive = false
        savedFlipTriggerTimes = 0
    end

    if (name == 'w_melee_one_hand_blunt') then
        if (state ~= 'Targeting' and state ~= 'ThrowAttack') then
            CalcFixedTimeIndex(name, 0, dilated, true)
        end
        
        if (state == 'ChargedHold' or state == 'StrongAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(2)(7)(1)(6)'
        end

        if (state == 'Targeting') then
            local maxFlipTriggerTimes = CalcFixedTimeIndex(name..'9', 30, dilated, false)

            if (not flipTriggerActive) then flipTriggerActive = true end

            if (flipTriggerActive and savedFlipTriggerTimes <= maxFlipTriggerTimes) then
                if (savedFlipTriggerTimes >= maxFlipTriggerTimes / 2) then
                    data.leftTriggerType = 'Normal'
                else
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(0)(5)'
                end

                savedFlipTriggerTimes = savedFlipTriggerTimes + 1
            else
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(0)(2)'
            end
        end

        if (state == 'ComboAttack') then
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(0)(2)'
        end

        if (state == 'FinalAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(6)(6)'
        end

        if (state == 'ThrowAttack') then
            local throwTriggerActiveForTimes = CalcFixedTimeIndex(name..'19', 40, dilated, false)

            if (timesAfterThrow < throwTriggerActiveForTimes) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(2)(5)'
            else
                data.leftTriggerType = 'Normal'
                data.rightTriggerType = 'Normal'
            end

            timesAfterThrow = timesAfterThrow + 1
        else
            timesAfterThrow = 0
        end
    end

    return data
end

return Weapon
