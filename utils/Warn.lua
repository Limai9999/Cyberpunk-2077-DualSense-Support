local function Warn(message, isDebug)
    if (IsScene) then return end

    local settings = ManageSettings.openFile()
    if (not settings.debugLogs and isDebug) then return end
    if (not settings.showNotifications) then return end

    Game.GetPlayer():SetWarningMessage(message)
    print(ModName .. ' ' .. message)
end

return Warn