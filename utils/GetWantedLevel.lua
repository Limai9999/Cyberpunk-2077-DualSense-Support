local function GetWantedLevel()
    local wantedLevel = Game.GetQuestsSystem():GetFactStr("wanted_level")
    return wantedLevel
end

return GetWantedLevel
