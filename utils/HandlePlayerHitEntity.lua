local activeTimes = 0

local function HandleBlockingBullet()
    if (not IsPlayerHitEntity) then return end

    if (activeTimes < 15) then
        activeTimes = activeTimes + 1
        IsPlayerHitEntity = true
    else
        activeTimes = 0
        IsPlayerHitEntity = false
        IsPlayerHitEntityStrong = false
    end
end

return HandleBlockingBullet