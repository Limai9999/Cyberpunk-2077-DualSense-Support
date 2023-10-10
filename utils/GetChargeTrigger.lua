local savedWeaponName = ''
local savedFrequency = 0
local maxFrequency = 50

local function GetChargeTrigger(weaponName, isTimeDilated, reset, stepValue, initValue, maxValue)
    if (savedWeaponName ~= weaponName) then savedFrequency = 0 end
    if (reset) then savedFrequency = 0 return 0 end

    if (initValue and savedFrequency <= 0) then savedFrequency = initValue end

    savedWeaponName = weaponName
    savedFrequency = savedFrequency + stepValue

    if (maxValue) then
        if (savedFrequency > maxValue) then savedFrequency = maxValue end
    else
        if (savedFrequency > maxFrequency) then savedFrequency = maxFrequency end
    end

    local freq = GetFrequency(math.floor(savedFrequency), isTimeDilated)

    return freq
end

return GetChargeTrigger