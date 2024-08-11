local function VehicleMode(data, vehicle, nUI, gearBoxValue, dilated, onRoad, onPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire)
    local typeLoc = GetText('Mod-DualSense-NS-TriggerType-Hardest')
    local NALoc = GetText('Mod-DualSense-NotAdaptive')
    data.description = 'L2 - ' .. typeLoc .. '; ' .. 'R2 - ' .. typeLoc .. ' (' .. NALoc .. ')'
    data.isHiddenMode = false
    data.vehicleModeIndex = 3
    data.vehicleUseTwitchingCollisionTrigger = true
    if (nUI or not vehicle) then return data end

    data.leftTriggerType = 'Hardest'
    data.rightTriggerType = 'Hardest'

    data.frequency = 'Hardest'

    return data
end

return VehicleMode
