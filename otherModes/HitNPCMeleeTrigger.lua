local savedTimes = 0
local maxSavedTimes = 8
local halfMaxSavedTimes = maxSavedTimes / 2

local function HitNPCMeleeTrigger(data)
    if (savedTimes > maxSavedTimes) then
        savedTimes = 0
        IsPlayerHitNPC = false
    end

    if (not IsPlayerHitNPC and savedTimes == 0) then return data end

    data.rightTriggerType = 'Machine'

    local freq = GetFrequency(80, isTimeDilated, 'hitNPC')
    data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
    data.rightForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'

    savedTimes = savedTimes + 1

    return data
end

return HitNPCMeleeTrigger
