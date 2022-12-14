local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeLoc = GetText('Mod-DualSense-Disabled')
    local NALoc = GetText('Mod-DualSense-NotAdaptive')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc .. ' (' .. NALoc .. ')'
    data.isHiddenMode = false
    data.vehicleModeIndex = 0
    if (nUI) then return data end

    data.leftTriggerType = 'Normal'
    data.rightTriggerType = 'Normal'

    data.frequency = 'Normal'

    return data
end

return VehicleMode
