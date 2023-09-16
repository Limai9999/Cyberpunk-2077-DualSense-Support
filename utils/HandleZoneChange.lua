local savedZone = ''
local startedHandlingChangeDate = 0

local function HandleZoneChange()
    local currentZone = EnumValueToString('gamePSMZones', GetState('Zones'))

    if (currentZone == 'Any' or currentZone == 'Default') then return false end

    if (currentZone == savedZone) then
        local nowTime = os.time()
        if (nowTime - startedHandlingChangeDate > 4) then return false end
    end

    if (currentZone ~= savedZone) then
        savedZone = currentZone
        startedHandlingChangeDate = os.time()
    end

    if (currentZone == 'Public') then
        local r, g, b = PulseLED('ZonePublic', 10, 0, 191, 255, 30)
        return '('..r..')'..'('..g..')'..'('..b..')'
    elseif (currentZone == 'Restricted' or currentZone == 'Dangerous') then
        local r, g, b = PulseLED('ZoneRestricted', 15, 255, 10, 5, 3)
        return '('..r..')'..'('..g..')'..'('..b..')'
    end
end

return HandleZoneChange