local function GearChangeMode(data, nUI, config)
    data.name = GetText('Mod-DualSense-NS-GearChangeMode-Twitching')
    data.value = 1

    if nUI then return data end

    local gearChangeForce = config.gearChangeForce

    data.leftTriggerType = 'Machine'
    data.leftForceTrigger = '(1)(9)(' .. gearChangeForce .. ')(' .. gearChangeForce .. ')(' .. 100 .. ')(0)'
    data.rightTriggerType = 'Machine'
    data.rightForceTrigger = '(1)(9)(' .. gearChangeForce .. ')(' .. gearChangeForce .. ')(' .. 100 .. ')(0)'

    return data
end

return GearChangeMode