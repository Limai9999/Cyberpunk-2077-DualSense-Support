local function ShowBatteryLevel()
    if (IsOldDSXLaunched) then return end
    if (true) then return end

    if (BatteryLevel == 0) then
        Warn(GetText('Mod-DualSense-Battery-0') .. ' ' .. GetText('Mod-DualSense-NS-BatteryLevel') .. ': ' .. BatteryLevel .. '%', false, true)
    elseif (BatteryLevel < 10) then
        local str = string.format(GetText('Mod-DualSense-Battery-Less10'), BatteryLevel)
        Warn(str, false, true)
    elseif (BatteryLevel < 20) then
        Warn(GetText('Mod-DualSense-Battery-Less20') .. ' ' .. GetText('Mod-DualSense-NS-BatteryLevel') .. ': ' .. BatteryLevel .. '%', false, false)
    elseif (BatteryLevel < 100) then
        Warn(GetText('Mod-DualSense-Battery-Less100') .. ' ' .. BatteryLevel .. '%', false, false)
    elseif (BatteryLevel == 100) then
        Warn(GetText('Mod-DualSense-Battery-100'), false, false)
    end
end

return ShowBatteryLevel