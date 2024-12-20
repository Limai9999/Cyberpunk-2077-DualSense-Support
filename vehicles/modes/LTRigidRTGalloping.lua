local function VehicleMode(data, vehicle, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeRigidLoc = GetText('Mod-DualSense-NS-TriggerType-Rigid')
    local typeGallopingLoc = GetText('Mod-DualSense-NS-TriggerType-Galloping')
    data.description = 'L2 - ' .. typeRigidLoc .. '; ' .. 'R2 - ' .. typeGallopingLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 10
    data.vehicleUseTwitchingCollisionTrigger = false
    if (nUI or not vehicle) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(vehicle, gearBoxValue, false, isGearboxEmulationEnabled)

    data.leftTriggerType = 'Rigid'

    local maxGalloping = config.vehicleGallopingValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (9500 / maxGalloping))
    dividedRpmA = GetFrequency(dividedRpmA, dilated, vehicle:GetDisplayName() .. data.description)

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

    if (rpm < 150) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(0)(2)'
    end

    if (isFlying) then
        data.leftTriggerType = data.rightTriggerType
        data.leftForceTrigger = data.rightForceTrigger
    end

    data.frequency = frequency

    return data
end

return VehicleMode