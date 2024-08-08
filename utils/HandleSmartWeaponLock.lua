local activeTimes = 0

local function HandleSmartWeaponLock()
    if (not HasLockedOnEnemyUsingSmartWeapon) then return end

    local activeTimesMax = CalcTimeIndex(10)

    if (activeTimes < activeTimesMax) then
        activeTimes = activeTimes + 1
        HasLockedOnEnemyUsingSmartWeapon = true
    else
        activeTimes = 0
        HasLockedOnEnemyUsingSmartWeapon = false
    end
end

return HandleSmartWeaponLock