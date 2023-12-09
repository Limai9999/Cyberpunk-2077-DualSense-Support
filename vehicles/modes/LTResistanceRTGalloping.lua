

local function VehicleMode(data, veh, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeResLoc = GetText('Mod-DualSense-NS-TriggerType-Resistance')
    local typeGalLoc = GetText('Mod-DualSense-NS-TriggerType-Galloping')
    data.description = 'L2 - ' .. typeResLoc .. '; ' .. 'R2 - ' .. typeGalLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 5
    data.vehicleUseTwitchingCollisionTrigger = true
    if (nUI or not veh) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(gearBoxValue, false, isGearboxEmulationEnabled)

    local maxResistance = config.vehicleResistanceValue
    local resistance = gearBoxValue

    resistance = GetResistanceTrigger(rpm, resistance, maxResistance)
    resistance = tostring(resistance)
    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(0)(' .. resistance .. ')'

    local maxGalloping = config.vehicleGallopingValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (9500 / maxGalloping))
    dividedRpmA = GetFrequency(dividedRpmA, dilated, veh:GetDisplayName() .. data.description)

    local useMachineTrigger = math.floor(rpm) % 11 == 0

    if (dividedRpmA > maxGalloping) then dividedRpmA = maxGalloping end
    frequency = tostring(dividedRpmA)
    data.rightTriggerType = 'Galloping'
    data.rightForceTrigger = '(0)(9)(0)(7)(' .. frequency .. ')'

    if (hasFlatTire) then
        if (useMachineTrigger) then
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(5)(5)(' .. frequency .. ')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(8)(8)(' .. frequency .. ')(0)'
        end
    end

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
    end

    if (isFlying) then
        data.leftTriggerType = data.rightTriggerType
        data.leftForceTrigger = data.rightForceTrigger
    end

    data.frequency = frequency

    return data
end

return VehicleMode
