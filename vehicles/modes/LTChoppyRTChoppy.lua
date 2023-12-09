local function VehicleMode(data, veh, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Choppy')
    local NALoc = GetText('Mod-DualSense-NotAdaptive')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc .. ' (' .. NALoc .. ')'
    data.isHiddenMode = false
    data.vehicleModeIndex = 1
    data.vehicleUseTwitchingCollisionTrigger = true
    if (nUI or not veh) then return data end

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Choppy'

    data.frequency = 'Choppy'

    return data
end

return VehicleMode
