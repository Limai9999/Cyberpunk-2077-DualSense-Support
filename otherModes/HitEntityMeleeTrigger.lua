local savedTimes = 0
local maxSavedTimes = 8
local halfMaxSavedTimes = maxSavedTimes / 2

local function HitEntityMeleeTrigger(data, config)
    if (not config.meleeEntityHitTrigger) then return data end

    if (savedTimes >= maxSavedTimes) then
        savedTimes = 0
        IsPlayerHitEntity = false
    end

    if (not IsPlayerHitEntity and savedTimes == 0) then return data end
    
    if (savedTimes < halfMaxSavedTimes - 1) then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(7)(8)(8)(8)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(7)(8)(8)(8)'
    else
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(3)(8)(8)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(8)'
    end

    savedTimes = savedTimes + 1

    return data
end

return HitEntityMeleeTrigger
