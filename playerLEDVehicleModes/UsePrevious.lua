local function VehiclePlayerLEDMode(data, nUI, vehicle, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    data.LEDName = GetText('Mod-DualSense-VehiclePlayerLEDName-UsePrevious')
    data.value = 1

    if nUI then return data end

    return data
end

return VehiclePlayerLEDMode