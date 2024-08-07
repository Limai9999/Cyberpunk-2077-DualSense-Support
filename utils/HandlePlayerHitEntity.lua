local activeTimes = 0

local function HandlePlayerHitEntity()
    if (not IsPlayerHitEntity) then return end

    local activeTimesMax = CalcTimeIndex(15)

    if (activeTimes < activeTimesMax) then
        activeTimes = activeTimes + 1
        IsPlayerHitEntity = true
    else
        activeTimes = 0
        IsPlayerHitEntity = false
        IsPlayerHitEntityStrong = false
    end
end

return HandlePlayerHitEntity