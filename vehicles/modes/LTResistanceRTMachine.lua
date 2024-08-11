local function VehicleMode(data, vehicle, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeResLoc = GetText('Mod-DualSense-NS-TriggerType-Resistance')
    local typeMachLoc = GetText('Mod-DualSense-NS-TriggerType-Machine')
    data.description = 'L2 - ' .. typeResLoc .. '; ' .. 'R2 - ' .. typeMachLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 6
    -- data.vehicleModeDefault = true
    data.vehicleUseTwitchingCollisionTrigger = false
    if (nUI or not vehicle) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(vehicle, gearBoxValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local resistance = gearBoxValue
    local useWeakMachineTrigger = math.floor(rpm) % 5 == 0

    resistance = GetResistanceTrigger(rpm, resistance, maxResistance)
    resistance = tostring(resistance)
    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(0)(' .. resistance .. ')'

    local maxMachine = config.vehicleMachineValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (7500 / maxMachine))
    dividedRpmA = GetFrequency(dividedRpmA, dilated, vehicle:GetDisplayName() .. data.description)

    if (dividedRpmA > maxMachine) then dividedRpmA = maxMachine end
    frequency = tostring(dividedRpmA)
    data.rightTriggerType = 'Machine'
    data.rightForceTrigger = '(1)(9)(2)(2)(' .. frequency .. ')(0)'

    if (hasFlatTire) then
        data.leftTriggerType = 'Machine'
        data.leftForceTrigger = '(1)(9)(1)(1)(' .. frequency .. ')(0)'
        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(1)(9)(4)(4)(' .. frequency .. ')(0)'

        if (useWeakMachineTrigger) then
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(1)(2)(' .. frequency .. ')(0)'
        end
    end

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
