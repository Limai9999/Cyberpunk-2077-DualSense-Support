local function VehicleMode(data, veh, nUI, gbValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Choppy')
    local NALoc = GetText('Mod-DualSense-NotAdaptive')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc .. ' (' .. NALoc .. ')'
    data.isHiddenMode = false
    data.vehicleModeIndex = 1
    if (nUI) then return data end

    data.leftTriggerType = 'Choppy'
    data.rightTriggerType = 'Choppy'

    data.frequency = 'Choppy'

    return data
end

return VehicleMode
