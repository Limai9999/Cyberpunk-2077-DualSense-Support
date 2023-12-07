local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeResLoc = GetText('Mod-DualSense-NS-TriggerType-Resistance')
    local typeMachLoc = GetText('Mod-DualSense-NS-TriggerType-Machine')
    data.description = 'L2 - ' .. typeResLoc .. '; ' .. 'R2 - ' .. typeMachLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 6
    data.vehicleModeDefault = true
    data.vehicleUseTwitchingCollisionTrigger = false
    if (nUI or not veh) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(gbValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local resistance = gbValue

    resistance = GetResistanceTrigger(rpm, resistance, maxResistance)
    resistance = tostring(resistance)
    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(0)(' .. resistance .. ')'

    local maxMachine = config.vehicleMachineValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (7500 / maxMachine))
    dividedRpmA = GetFrequency(dividedRpmA, dilated, veh:GetDisplayName() .. data.description)

    if (dividedRpmA > maxMachine) then dividedRpmA = maxMachine end
    frequency = tostring(dividedRpmA)
    data.rightTriggerType = 'Machine'
    data.rightForceTrigger = '(1)(9)(2)(2)(' .. frequency .. ')(0)'

    if (data.overwriteRGB) then
        local red = math.floor(dividedRpmA * (255 / maxMachine))
        local green = 255 - red

        local r, g, b = CheckRGB(red, green, 0)

        data.touchpadLED = '('..r..')'..'('..g..')'..'(0)'
    end

    local lowSpeedResistanceValue = tostring(math.ceil(maxResistance / 2))

    if (rpm < 150) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(0)(' .. lowSpeedResistanceValue .. ')'
    end

    if (isFlying) then
        data.leftTriggerType = data.rightTriggerType
        data.leftForceTrigger = data.rightForceTrigger
    end

    data.frequency = frequency

    return data
end

return VehicleMode
