local function Warn(message, isDebug, isNegative)
    if (IsScene) then return end

    local isInMenu = GameUI.IsMenu()
    if (isInMenu) then return end

    local settings = ManageSettings.openFile()
    if (not settings.debugLogs and isDebug) then return end
    if (not settings.showNotifications) then return end

    if (isNegative) then
        Game.GetPlayer():SetWarningMessage(message)
    else
        Game.GetPlayer():SetWarningMessage(message, 2)
    end

    print(ModName .. ' ' .. message)
end

return Warn