local function PlayerLEDMode(data, nUI)
    data.LEDName = GetText('Mod-DualSense-LEDName-WantedLevel')
    data.value = 2

    if nUI then return data end
    if not (data.overwritePlayerLED) then return data end

    local wantedLevel = GetWantedLevel()

    if wantedLevel == 0 then
        data.playerLED = '(False)(False)(False)(False)(False)'
        data.playerLEDNewRevision = '(AllOff)'
    elseif wantedLevel == 1 then
        data.playerLED = '(False)(False)(True)(False)(False)'
        data.playerLEDNewRevision = '(One)'
    elseif wantedLevel == 2 then
        data.playerLED = '(False)(True)(False)(True)(False)'
        data.playerLEDNewRevision = '(Two)'
    elseif wantedLevel == 3 then
        data.playerLED = '(True)(False)(True)(False)(True)'
        data.playerLEDNewRevision = '(Three)'
    elseif wantedLevel == 4 then
        data.playerLED = '(True)(True)(False)(True)(True)'
        data.playerLEDNewRevision = '(Four)'
    else
        data.playerLED = '(True)(True)(True)(True)(True)'
        data.playerLEDNewRevision = '(Five)'
    end

    return data
end

return PlayerLEDMode