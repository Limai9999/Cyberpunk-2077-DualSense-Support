local function VehicleMode(data, veh, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeRigidLoc = GetText('Mod-DualSense-NS-TriggerType-Rigid')
    local typeMachLoc = GetText('Mod-DualSense-NS-TriggerType-Machine')
    data.description = 'L2 - ' .. typeRigidLoc .. '; ' .. 'R2 - ' .. typeMachLoc
    data.isHiddenMode = false
    data.vehicleModeIndex = 9
    data.vehicleUseTwitchingCollisionTrigger = false
    if (nUI or not veh) then return data end

    local config = ManageSettings.openFile()

    local rpm = GetVehicleSpeed(gearBoxValue, false, isGearboxEmulationEnabled)

    local useWeakMachineTrigger = math.floor(rpm) % 5 == 0

    data.leftTriggerType = 'Rigid'

    local maxMachine = config.vehicleMachineValue
    local frequency = '1'

    local dividedRpmA = math.floor(rpm / (7500 / maxMachine))
    dividedRpmA = GetFrequency(dividedRpmA, dilated, veh:GetDisplayName() .. data.description)

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

    if (rpm < 150) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(0)(1)'
    end

    if (isFlying) then
        data.leftTriggerType = data.rightTriggerType
        data.leftForceTrigger = data.rightForceTrigger
    end

    data.frequency = frequency

    return data
end

return VehicleMode
