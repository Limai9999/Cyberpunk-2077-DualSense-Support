local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Hardest')
    local NALoc = GetText('Mod-DualSense-NotAdaptive')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc .. ' (' .. NALoc .. ')'
    data.isHiddenMode = false
    data.vehicleModeIndex = 3
    if (nUI) then return data end

    data.leftTriggerType = 'Hardest'
    data.rightTriggerType = 'Hardest'

    data.frequency = 'Hardest'

    return data
end

return VehicleMode
