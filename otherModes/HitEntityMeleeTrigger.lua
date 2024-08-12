local savedTimes = 0

local function HitEntityMeleeTrigger(data, config)
    if (not config.meleeEntityHitTrigger) then return data end

    local activeTimesMax = CalcTimeIndex(28)
    local halfMaxSavedTimes = activeTimesMax / 2

    if (savedTimes >= activeTimesMax) then
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
