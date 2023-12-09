local savedTimes = 0
local maxSavedTimes = 8
local halfMaxSavedTimes = maxSavedTimes / 2

local function HitEntityMeleeTrigger(data, config)
    if (not config.meleeEntityHitTrigger) then return data end

    if (savedTimes >= maxSavedTimes) then
        savedTimes = 0
        IsPlayerHitEntity = false
        IsPlayerHitEntityStrong = false
    end

    if (not IsPlayerHitEntity and savedTimes == 0) then return data end
    
    if (savedTimes < halfMaxSavedTimes - 1) then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(6)(8)(8)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(6)(8)(8)(4)'

        if (IsPlayerHitEntityStrong) then
            data.leftForceTrigger = '(6)(8)(8)(8)'
            data.rightForceTrigger = '(6)(8)(8)(8)'
        end
    else
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(4)(8)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(4)'

        if (IsPlayerHitEntityStrong) then
            data.leftForceTrigger = '(0)(4)(8)(8)'
            data.rightForceTrigger = '(0)(4)(8)(8)'
        end
    end

    savedTimes = savedTimes + 1

    return data
end

return HitEntityMeleeTrigger
