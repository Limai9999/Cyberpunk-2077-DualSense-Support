local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Resistance')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 7
    if (nUI) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(gbValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local resistance = gbValue

    resistance = GetResistanceTrigger(rpm, resistance, maxResistance)

    if (data.overwriteRGB) then
        local blue = math.floor(resistance * 31.8)
        
        local r, g, b = CheckRGB(0, 0, blue)

        data.touchpadLED = '(0)'..'(255)'..'('..b..')'
    end

    resistance = tostring(resistance)

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(' .. resistance .. ')'
    data.rightTriggerType = 'Resistance'
    data.rightForceTrigger = '(1)(' .. resistance .. ')'

    data.frequency = resistance

    return data
end

return VehicleMode
