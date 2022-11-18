local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeGalLoc = GetText('Mod-DualSense-NS-TriggerType-Galloping')
    data.description = 'L2 - ' .. typeGalLoc .. '; ' .. 'R2 - ' .. typeGalLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 2
    if (nUI) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(gbValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local maxGalloping = config.vehicleGallopingValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (9500 / maxGalloping))
    dividedRpmA = GetFrequency(dividedRpmA, dilated)

    if (dividedRpmA > maxGalloping) then dividedRpmA = maxGalloping end
    frequency = tostring(dividedRpmA)
    data.rightTriggerType = 'Galloping'
    data.rightForceTrigger = '(0)(9)(0)(7)(' .. frequency .. ')'
    data.leftTriggerType = 'Galloping'
    data.leftForceTrigger = '(0)(9)(0)(7)(' .. frequency .. ')'

    if (data.overwriteRGB) then
        local red = math.floor(dividedRpmA * (255 / (maxGalloping / 1.3)))
        local green = 255 - red

        local r, g, b = CheckRGB(red, green, 0)

        data.touchpadLED = '('..r..')'..'('..g..')'..'(0)'
    end

    local lowSpeedResistanceValue = tostring(maxResistance)

    if (rpm < 150) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(0)(' .. lowSpeedResistanceValue .. ')'
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(' .. lowSpeedResistanceValue .. ')'
    end

    data.frequency = frequency

    return data
end

return VehicleMode
