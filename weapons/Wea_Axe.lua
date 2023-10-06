local flipTriggerActive = false
local savedFlipTriggerTimes = 0
local maxFlipTriggerTimes = 20

local function Weapon(data, name, isAiming, _, dilated)
    data.type = 'Axe'

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(0)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(4)(4)'

    if (state ~= 9) then
        flipTriggerActive = false
        savedFlipTriggerTimes = 0
    end

    if (name == 'w_melee_one_hand_blunt') then
        if (state == 7 or state == 13) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(3)(8)(1)(3)'
        end

        if (state == 9) then
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

        if (state == 11) then
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(0)(2)'
        end

        if (state == 12) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(6)(6)'
        end

        if (state == 19) then
            data.leftTriggerType = 'Bow'
            data.leftForceTrigger = '(1)(8)(1)(8)'

            data.rightTriggerType = 'Normal'
        end
    end

    return data
end

return Weapon
