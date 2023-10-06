local savedWeaponName = ''
local savedFrequency = 0
local maxFrequency = 50

local function GetChargeTrigger(weaponName, isTimeDilated, reset, initValue)
    if (savedWeaponName ~= weaponName) then savedFrequency = 0 end
    if (reset) then savedFrequency = 0 return 0 end

    if (initValue and savedFrequency <= 0) then savedFrequency = initValue end

    savedWeaponName = weaponName
    savedFrequency = savedFrequency + 0.3

    if (savedFrequency > maxFrequency) then savedFrequency = maxFrequency end

    local freq = GetFrequency(math.floor(savedFrequency), isTimeDilated)

    return freq
end

return GetChargeTrigger