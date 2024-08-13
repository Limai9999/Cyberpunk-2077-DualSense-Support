local savedZone = ''
local startedHandlingChangeDate = 0

local function HandleZoneChange()
    -- ! TODO: HELP: SOS: I'm unable to find a way to check if player is in SAFE zone. Now: Safe = Public

    local currentZone = GetState('Zones', 'gamePSMZones')

    if (currentZone == 'Any' or currentZone == 'Default') then return false end

    if (currentZone == savedZone) then
        local nowTime = os.time()
        if (nowTime - startedHandlingChangeDate > 3) then return false end
    end

    if (currentZone ~= savedZone) then
        savedZone = currentZone
        startedHandlingChangeDate = os.time()
    end

    if (currentZone == 'Public') then
        local r, g, b = PulseLED('ZonePublic', 10, 0, 191, 255, 20, 15)
        return '('..r..')'..'('..g..')'..'('..b..')'
    elseif (currentZone == 'Restricted' or currentZone == 'Dangerous') then
        local r, g, b = PulseLED('ZoneRestricted', 10, 255, 10, 5, 20, 15)
        return '('..r..')'..'('..g..')'..'('..b..')'
    end
end

return HandleZoneChange