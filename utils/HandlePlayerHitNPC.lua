local activeTimes = 0

local function HandleBlockingBullet()
    if (not IsPlayerHitNPC) then return end

    if (activeTimes < 15) then
        activeTimes = activeTimes + 1
        IsPlayerHitNPC = true
    else
        activeTimes = 0
        IsPlayerHitNPC = false
    end
end

return HandleBlockingBullet