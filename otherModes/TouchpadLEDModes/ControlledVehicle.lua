local function ControlledVehicleTouchpadLEDMode(data, controlledVehicle)
    local maxRangeFromPlayer = TweakDB:GetFlat("player.vehicleQuickHacks.maxRange")
    local currentSignalStrength = 1.00 - MinF(SqrtF(controlledVehicle:GetDistanceToPlayerSquared()) / maxRangeFromPlayer, 1.00);

    local LEDFlickeringSpeed = math.floor(5 * (1 / currentSignalStrength))
    local LEDMinBrightness = math.floor(currentSignalStrength * 100)
    local LEDMaxStopSkipValue = math.floor(currentSignalStrength * 20)

    if (LEDFlickeringSpeed > 60) then LEDFlickeringSpeed = 60 end

    local r, g, b = PulseLED('controlledVehicle', LEDFlickeringSpeed, 43, 255, 255, LEDMinBrightness, LEDMaxStopSkipValue)
    data.touchpadLED = '('..r..')('..g..')('..b..')'
    data.overwriteRGB = false

    return data
end

return ControlledVehicleTouchpadLEDMode