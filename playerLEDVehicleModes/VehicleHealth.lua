local function VehiclePlayerLEDMode(data, nUI, vehicle, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    data.LEDName = GetText('Mod-DualSense-VehiclePlayerLEDName-VehicleHealth')
    data.value = 2

    if nUI then return data end

    local vehicleComponent = vehicle.vehicleComponent
    local damageLevel = vehicleComponent.damageLevel

    if (damageLevel == 0) then
        data.playerLED = '(True)(False)(True)(False)(True)'
        data.playerLEDNewRevision = '(Three)'
    elseif (damageLevel == 1) then
        data.playerLED = '(False)(True)(False)(True)(False)'
        data.playerLEDNewRevision = '(Two)'
    elseif (damageLevel == 2) then
        data.playerLED = '(False)(False)(True)(False)(False)'
        data.playerLEDNewRevision = '(One)'
    else
        data.playerLED = '(False)(False)(False)(False)(False)'
        data.playerLEDNewRevision = '(AllOff)'
    end

    return data
end

return VehiclePlayerLEDMode