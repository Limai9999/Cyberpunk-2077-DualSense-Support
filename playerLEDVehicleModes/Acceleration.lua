local function VehiclePlayerLEDMode(data, nUI, vehicle, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    data.LEDName = GetText('Mod-DualSense-VehiclePlayerLEDName-Acceleration')
    data.value = 3

    if nUI then return data end

    local rpm = GetVehicleSpeed(gbValue, false, isGearboxEmulationEnabled)

    data.playerLED = '(False)(False)(False)(False)(False)'
    data.playerLEDNewRevision = '(AllOff)'

    if (rpm >= 500) then
        data.playerLED = '(True)(False)(False)(False)(False)'
        data.playerLEDNewRevision = '(One)'
    end
    if (rpm >= 1500) then
        data.playerLED = '(True)(True)(False)(False)(False)'
        data.playerLEDNewRevision = '(Two)'
    end
    if (rpm >= 3000) then
        data.playerLED = '(True)(True)(True)(False)(False)'
        data.playerLEDNewRevision = '(Three)'
    end
    if (rpm >= 4500) then
        data.playerLED = '(True)(True)(True)(True)(False)'
        data.playerLEDNewRevision = '(Four)'
    end
    if (rpm >= 6200) then
        data.playerLED = '(True)(True)(True)(True)(True)'
        data.playerLEDNewRevision = '(Five)'
    end

    return data
end

return VehiclePlayerLEDMode