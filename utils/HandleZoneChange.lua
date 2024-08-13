local savedZone = ''
local startedHandlingChangeDate = 0

local function HandleZoneChange()
    local currentZone = GetState('Zones', 'gamePSMZones')

    if (currentZone == 'Any' or currentZone == 'Default') then return false end

    if (currentZone == 'Public') then
        local securityZoneData = FromVariant(Game.GetBlackboardSystem():GetLocalInstanced(GetPlayer():GetEntityID(), Game.GetAllBlackboardDefs().PlayerStateMachine):GetVariant(Game.GetAllBlackboardDefs().PlayerStateMachine.SecurityZoneData))
        if (securityZoneData ~= nil) then
            local securityAreaType = EnumValueToString('ESecurityAreaType', EnumInt(securityZoneData.securityAreaType))

            if (securityAreaType == 'SAFE') then currentZone = 'Safe' end
        end
    end

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
    elseif (currentZone == 'Safe') then
        local r, g, b = PulseLED('ZoneSafe', 10, 50, 255, 30, 20, 15)
        return '('..r..')'..'('..g..')'..'('..b..')'
    end
end

return HandleZoneChange