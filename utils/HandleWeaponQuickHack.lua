local activeTimes = 0

local function HandleWeaponQuickHack()
    if (not HasSentQuickHackUsingWeapon) then return end

    local activeTimesMax = CalcTimeIndex(32)

    if (activeTimes < activeTimesMax) then
        activeTimes = activeTimes + 1
        HasSentQuickHackUsingWeapon = true
    else
        activeTimes = 0
        HasSentQuickHackUsingWeapon = false
    end
end

return HandleWeaponQuickHack