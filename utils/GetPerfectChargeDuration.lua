local function GetPerfectChargeDuration(varyValue)
    if (not varyValue) then varyValue = 0 end

    local hasInternalClockPerk = PlayerDevelopmentSystem.GetData(GetPlayer()):IsNewPerkBought(gamedataNewPerkType.Tech_Right_Perk_3_2) > 0

    if (hasInternalClockPerk) then return 50 + varyValue end

    return 35 + varyValue
end

return GetPerfectChargeDuration