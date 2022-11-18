local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeMachLoc = GetText('Mod-DualSense-NS-TriggerType-Machine')
    data.description = 'L2 - ' .. typeMachLoc .. '; ' .. 'R2 - ' .. typeMachLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 4
    if (nUI) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(gbValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local maxMachine = config.vehicleMachineValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (9500 / maxMachine))
    dividedRpmA = GetFrequency(dividedRpmA, dilated)

    if (dividedRpmA > maxMachine) then dividedRpmA = maxMachine end
    frequency = tostring(dividedRpmA)
    data.rightTriggerType = 'Galloping'
    data.rightForceTrigger = '(0)(9)(0)(7)(' .. frequency .. ')'
    data.leftTriggerType = 'Galloping'
    data.leftForceTrigger = '(0)(9)(0)(7)(' .. frequency .. ')'

    if (data.overwriteRGB) then
        local red = math.floor(dividedRpmA * (255 / maxMachine))
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
