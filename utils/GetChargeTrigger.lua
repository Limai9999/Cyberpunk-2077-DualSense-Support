local savedWeaponName = ''
local savedFrequency = 0
local maxFrequency = 50
local initComplete = false

local function resetSaved()
    savedFrequency = 0
    initComplete = false
end

local function GetChargeTrigger(weaponName, isTimeDilated, reset, stepValue, initValue, maxValue)
    if (savedWeaponName ~= weaponName) then resetSaved() end
    if (reset) then resetSaved() return 0 end

    if (initValue and savedFrequency <= 0 and not initComplete) then
        savedFrequency = initValue
        initComplete = true
    end

    savedWeaponName = weaponName
    savedFrequency = savedFrequency + stepValue

    if (maxValue) then
        if (savedFrequency > maxValue) then savedFrequency = maxValue end
    else
        if (savedFrequency > maxFrequency) then savedFrequency = maxFrequency end
    end

    if (savedFrequency < 0) then savedFrequency = 0 end

    local freq = GetFrequency(math.floor(savedFrequency), isTimeDilated, weaponName)

    return freq
end

return GetChargeTrigger