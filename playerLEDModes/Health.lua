local function PlayerLEDMode(data, nUI)
    data.LEDName = GetText('Mod-DualSense-LEDName-Health')
    data.value = 1

    if nUI then return data end
    if not (data.overwritePlayerLED) then return data end
    
    local playerId = GetPlayer():GetEntityID()
    local fullHealthValue = Game.GetStatsSystem():GetStatValue(playerId, 'Health')
    local healthValue = Game.GetStatPoolsSystem():GetStatPoolValue(playerId, Enum.new('gamedataStatPoolType', 'Health'), false);

    local healthPercentage = healthValue / fullHealthValue

    if healthPercentage <= 0.01 then
        data.playerLED = '(False)(False)(False)(False)(False)'
        data.playerLEDNewRevision = '(AllOff)'
    elseif healthPercentage <= 0.20 then
        data.playerLED = '(False)(False)(True)(False)(False)'
        data.playerLEDNewRevision = '(One)'
    elseif healthPercentage <= 0.40 then
        data.playerLED = '(True)(False)(False)(False)(True)'
        data.playerLEDNewRevision = '(Two)'
    elseif healthPercentage <= 0.60 then
        data.playerLED = '(True)(False)(True)(False)(True)'
        data.playerLEDNewRevision = '(Three)'
    elseif healthPercentage <= 0.80 then
        data.playerLED = '(True)(True)(False)(True)(True)'
        data.playerLEDNewRevision = '(Four)'
    elseif healthPercentage <= 1 then
        data.playerLED = '(True)(True)(True)(True)(True)'
        data.playerLEDNewRevision = '(Five)'
    else
        data.playerLED = '(True)(True)(True)(True)(True)'
        data.playerLEDNewRevision = '(Five)'
    end

    -- print(data.playerLED)

    return data
end

return PlayerLEDMode