local function VehicleMode(data, vehicle, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Resistance')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 7
    data.vehicleUseTwitchingCollisionTrigger = true
    if (nUI or not vehicle) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(vehicle, gearBoxValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local resistance = gearBoxValue

    local flatTirefrequency = 2 * gearBoxValue
    if (flatTirefrequency < 0) then flatTirefrequency = flatTirefrequency * -1 end

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

    if (hasFlatTire) then
        data.leftTriggerType = 'Machine'
        data.leftForceTrigger = '(1)(9)(2)(3)(' .. flatTirefrequency .. ')(0)'
        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(1)(9)(2)(3)(' .. flatTirefrequency .. ')(0)'
    end

    data.frequency = resistance

    return data
end

return VehicleMode
