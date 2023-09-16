local function GetRandomPlayerLED()
    listOfPlayerLED = {
        '(True)(False)(False)(False)(False)',
        '(False)(True)(False)(False)(False)',
        '(False)(False)(True)(False)(False)',
        '(False)(False)(False)(True)(False)',
        '(False)(False)(False)(False)(True)',
        '(True)(False)(True)(False)(True)',
        '(False)(True)(False)(True)(False)',
    }

    listOfPlayerLEDNevRevision = {
        '(One)',
        '(Two)',
        '(Three)',
        '(Four)',
        '(Five)',
    }

    local PlayerLED = listOfPlayerLED[math.random(#listOfPlayerLED)]
    local PlayerLEDNewRevision = listOfPlayerLEDNevRevision[math.random(#listOfPlayerLEDNevRevision)]

    return {
        playerLED = PlayerLED,
        playerLEDNewRevision = PlayerLEDNewRevision
    }
end

return GetRandomPlayerLED