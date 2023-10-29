local activeTimes = 0

local function HandleBlockingBullet()
    if (not IsBlockedBullet) then return end

    if (activeTimes < 10) then
        activeTimes = activeTimes + 1
        IsBlockedBullet = true
    else
        activeTimes = 0
        IsBlockedBullet = false
    end
end

return HandleBlockingBullet