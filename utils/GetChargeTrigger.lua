local savedWeaponName = ''
local savedFrequency = 0
local maxFrequency = 50

local function GetChargeTrigger(weaponName, isTimeDilated, reset)
    if (savedWeaponName ~= weaponName) then savedFrequency = 0 end
    if (reset) then savedFrequency = 0 return 0 end

    savedWeaponName = weaponName
    savedFrequency = savedFrequency + 0.2

    if (savedFrequency > maxFrequency) then savedFrequency = maxFrequency end

    local freq = GetFrequency(math.floor(savedFrequency), isTimeDilated)

    return freq
end

return GetChargeTrigger