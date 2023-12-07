local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Rigid')
    local NALoc = GetText('Mod-DualSense-NotAdaptive')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc .. ' (' .. NALoc .. ')'
    data.isHiddenMode = false
    data.vehicleModeIndex = 8
    data.vehicleUseTwitchingCollisionTrigger = true
    if (nUI or not veh) then return data end

    data.leftTriggerType = 'Rigid'
    data.rightTriggerType = 'Rigid'

    data.frequency = 'Rigid'

    return data
end

return VehicleMode
